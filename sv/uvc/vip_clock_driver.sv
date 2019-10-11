`ifndef VIP_CLOCK_DRIVER_SV
`define VIP_CLOCK_DRIVER_SV

class vip_clock_driver extends uvm_driver#(vip_clock_seq_item);
    `uvm_component_utils(vip_clock_driver)

    protected virtual vip_clock_signal_if       intf;
    protected vip_clock_agent_configuration     configuration;
    protected vip_clock_types::state_t          state;
    protected bit                               new_item_rcvd;
    protected logic                             prev_clk;
    protected event                             clock_tick_e;

    //==========================================================================
    function new(string name = "vip_clock_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    //==========================================================================

    //==========================================================================
    function void
    build_phase(uvm_phase phase);
        if (!uvm_config_db#(vip_clock_agent_configuration)::get(this,"","configuration",configuration))
        begin
            `uvm_fatal(get_type_name(), "Cannot access 'configuration'!")
        end
        if (!uvm_config_db#(virtual vip_clock_signal_if)::get(this,"","intf",intf))
        begin
            `uvm_fatal(get_type_name(), "Cannot access 'intf'!")
        end
        intf.agent_is_active = 1'b1;
        state = vip_clock_types::STOPPED;
    endfunction
    //==========================================================================

    //==========================================================================
    task
    run_phase(uvm_phase phase);
        if (configuration.get_start_with_low())
        begin
            intf.clk_drv = 1'b0;
        end else begin
            intf.clk_drv = 1'b1;
        end
        if (configuration.get_start_with_auto_clock())
        begin
            vip_clock_seq_item      auto_clock_item;
            auto_clock_item         = vip_clock_seq_item::type_id::create("auto_clock_item");
            auto_clock_item.enabled         = 1   ;
            auto_clock_item.period          = 10.0;
            auto_clock_item.initial_skew    = 2.0 ;
            `CHK_RAND(auto_clock_item,)
            req = auto_clock_item;
            new_item_rcvd = 1;
        end
        fork
            clock_monitor();
            clock_driver();
            process_incoming_requests();
        join
    endtask
    //==========================================================================

    //==========================================================================
    protected task
    process_incoming_requests();
        forever
        begin
            seq_item_port.get_next_item(req);
            new_item_rcvd = 1;
            wait (new_item_rcvd == 0);
            if (req.enabled)
            begin
                if (!clock_tick_e.triggered)
                begin
                    @ (clock_tick_e);
                end
            end else begin
                wait (state == vip_clock_types::STOPPED);
            end
            seq_item_port.item_done();
        end
    endtask
    //==========================================================================

    //==========================================================================
    protected task
    clock_driver();
        forever
        begin
            case(state)
                vip_clock_types::STOPPED:
                begin
                    wait (new_item_rcvd);
                    new_item_rcvd = 0;
                    if (req.enabled)
                    begin
                        if (req.initial_skew > 0.0)
                        begin
                            state = vip_clock_types::INITIAL_SKEW;
                        end
                        if (prev_clk === 1'b0)
                        begin
                            state = vip_clock_types::LOW;
                        end
                        if (prev_clk === 1'b1)
                        begin
                            state = vip_clock_types::HIGH;
                        end
                    end
                end
                vip_clock_types::INITIAL_SKEW:
                begin
                    # (req.initial_skew);
                    if (prev_clk === 1'b0)
                    begin
                        state = vip_clock_types::LOW;
                    end
                    if (prev_clk === 1'b1)
                    begin
                        state = vip_clock_types::HIGH;
                    end
                end
                vip_clock_types::LOW:
                begin
                    intf.clk_drv = 1'b0;
                    # (req.get_low_delay());

                    check_new_item_in_low_state();
                end
                vip_clock_types::HIGH:
                begin
                    intf.clk_drv = 1'b1;
                    # (req.get_low_delay());

                    check_new_item_in_high_state();
                end
            endcase
        end
    endtask
    //==========================================================================

    //==========================================================================
    protected task
    clock_monitor();
        #1step;
        prev_clk = intf.clk;
        forever
        begin
            @ (intf.drv_cb);
            prev_clk = intf.drv_cb.clk;
            -> clock_tick_e;
        end
    endtask
    //==========================================================================

    //==========================================================================
    protected function void
    check_new_item_in_low_state();
        if (new_item_rcvd)
        begin
            new_item_rcvd = 0;
            if (req.enabled)
            begin
                if (req.initial_skew > 0.0)
                begin
                    state = vip_clock_types::INITIAL_SKEW;
                end else begin
                    state = vip_clock_types::HIGH;
                end
            end else begin
                state = vip_clock_types::STOPPED;
            end
        end else begin
            state = vip_clock_types::HIGH;
        end
    endfunction
    //==========================================================================

    //==========================================================================
    protected function void
    check_new_item_in_high_state();
        if (new_item_rcvd)
        begin
            new_item_rcvd = 0;
            if (req.enabled)
            begin
                if (req.initial_skew > 0.0)
                begin
                    state = vip_clock_types::INITIAL_SKEW;
                end else begin
                    state = vip_clock_types::LOW;
                end
            end else begin
                state = vip_clock_types::STOPPED;
            end
        end else begin
            state = vip_clock_types::LOW;
        end
    endfunction
    //==========================================================================
endclass
`endif//VIP_CLOCK_DRIVER_SV