`ifndef VIP_CLOCK_SEQ_ITEM_SV
`define VIP_CLOCK_SEQ_ITEM_SV

class vip_clock_seq_item extends uvm_sequence_item;
    `uvm_object_utils(vip_clock_seq_item)

    bit                 enabled     ;
    // HDL simulators don't like to randomize real-s
    real                period      ;
    real                initial_skew;
    rand byte unsigned  low_ratio   ;
    rand byte unsigned  high_ratio  ;

    constraint  default_c
    {
        low_ratio + high_ratio == 100;
        low_ratio  > 0;
        high_ratio > 0;
        low_ratio  < 100;
        high_ratio < 100;
    }

    //==========================================================================
    function new(string name = "vip_clock_seq_item");
        super.new(name);
    endfunction
    //==========================================================================

    //==========================================================================
    function real
    get_low_delay();
        return real'(period * (low_ratio/100.0));
    endfunction
    //==========================================================================

    //==========================================================================
    function real
    get_high_delay();
        return real'(period * (high_ratio/100.0));
    endfunction
    //==========================================================================
endclass
`endif//VIP_CLOCK_SEQ_ITEM_SV