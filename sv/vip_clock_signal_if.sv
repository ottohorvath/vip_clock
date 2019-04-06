interface   vip_clock_signal_if(
    output wire logic   clk
);
    bit     agent_is_active;
    logic   clk_drv;

    assign  clk = (agent_is_active) ? (clk_drv) : (1'bz);

    //==========================================================================
    clocking mon_cb @ (posedge clk);
        default input #1step;
        input clk;
    endclocking
    //==========================================================================

    //==========================================================================
    clocking drv_cb @ (clk);
        default input #1step;
        input clk;
    endclocking
    //==========================================================================

    //==========================================================================
    task automatic
    wait_posedge();
        @ (mon_cb);
    endtask
    //==========================================================================

    //==========================================================================
    task automatic
    wait_clock(input int unsigned cyc = 1);
        if (cyc > 0)
        begin
            repeat (cyc) wait_posedge();
        end
    endtask
    //==========================================================================
endinterface