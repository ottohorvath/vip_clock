`ifndef VIP_CLOCK_SEQUENCER_SV
`define VIP_CLOCK_SEQUENCER_SV

class vip_clock_sequencer extends uvm_sequencer#(vip_clock_seq_item);
    `uvm_component_utils(vip_clock_sequencer)

    //==========================================================================
    function new(string name = "vip_clock_sequencer", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    //==========================================================================
endclass
`endif//VIP_CLOCK_SEQUENCER_SV