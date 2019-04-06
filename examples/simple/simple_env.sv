`ifndef SIMPLE_ENV_SV
`define SIMPLE_ENV_SV

class simple_env extends uvm_env;
    `uvm_component_utils(simple_env)

    vip_clock_agent     clk_agt;

    //==========================================================================
    function new(string name="simple_env", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    //==========================================================================

    //==========================================================================
    function void
    build_phase(uvm_phase phase);
        clk_agt = vip_clock_agent::type_id::create("clk_agt",this);
    endfunction
    //==========================================================================
endclass
`endif//SIMPLE_ENV_SV