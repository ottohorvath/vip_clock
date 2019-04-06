`ifndef VIP_CLOCK_AGENT_SV
`define VIP_CLOCK_AGENT_SV

class vip_clock_agent extends uvm_agent;
    `uvm_component_utils(vip_clock_agent)

    protected vip_clock_agent_configuration     configuration;
    protected vip_clock_driver                  driver;
    protected vip_clock_sequencer               sequencer;
    protected virtual vip_clock_signal_if       vif;
    //==========================================================================
    function new(string name = "vip_clock_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    //==========================================================================

    //==========================================================================
    function void
    build_phase(uvm_phase phase);
        if (!uvm_config_db#(vip_clock_agent_configuration)::get(this,"","configuration",configuration))
        begin
            `uvm_info(get_type_name(),
                "No agent configuration is pushed to config_db, thus using a default one!",UVM_DEBUG)
            configuration = vip_clock_agent_configuration::type_id::create("default_configuration");
        end
        is_active = (configuration.get_active())? UVM_ACTIVE : UVM_PASSIVE;
        if (is_active)
        begin
            if (!uvm_config_db#(virtual vip_clock_signal_if)::get(this,"","vif",vif))
            begin
                `uvm_fatal(get_type_name(),"No VIF is pushed to config_db!")
            end
            driver    = vip_clock_driver   ::type_id::create("driver",   this);
            sequencer = vip_clock_sequencer::type_id::create("sequencer",this);
            uvm_config_db#(virtual vip_clock_signal_if)  ::set(this,"driver","intf",vif);
            uvm_config_db#(vip_clock_agent_configuration)::set(this,"driver","configuration",configuration);
        end
    endfunction
    //==========================================================================

    //==========================================================================
    function void
    connect_phase(uvm_phase phase);
        if (is_active)
        begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction
    //==========================================================================

    `GETTER(vip_clock_agent_configuration, configuration)
    `GETTER(vip_clock_driver, driver)
    `GETTER(vip_clock_sequencer, sequencer)
    `GETTER(virtual vip_clock_signal_if, vif)
endclass
`endif//VIP_CLOCK_AGENT_SV