`ifndef VIP_CLOCK_AGENT_CONFIGURATION_SV
`define VIP_CLOCK_AGENT_CONFIGURATION_SV

class vip_clock_agent_configuration extends uvm_object;
    `uvm_object_utils(vip_clock_agent_configuration)

    protected bit       active;
    protected bit       start_with_auto_clock;
    protected bit       start_with_low;

    //==========================================================================
    function new(string name = "vip_clock_agent_configuration");
        super.new(name);
        set_default();
    endfunction
    //==========================================================================

    //==========================================================================
    function void
    set_default();
        active                = 1;
        start_with_auto_clock = 1;
        start_with_low        = 1;
    endfunction
    //==========================================================================

    `ACCESSOR(bit, active)
    `ACCESSOR(bit, start_with_auto_clock)
    `ACCESSOR(bit, start_with_low)
endclass
`endif//VIP_CLOCK_AGENT_CONFIGURATION_SV