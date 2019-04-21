`ifndef VIP_CLOCK_SEQUENCE_SV
`define VIP_CLOCK_SEQUENCE_SV

class vip_clock_sequence extends uvm_sequence #(vip_clock_seq_item);
    `uvm_object_utils(vip_clock_sequence)

    bit                             enabled     ;
    real                            period      ;
    real                            initial_skew;
    rand byte unsigned              low_ratio   ;
    rand byte unsigned              high_ratio  ;

    //==========================================================================
    function new(string name = "vip_clock_sequence");
        super.new(name);
    endfunction
    //==========================================================================

    //==========================================================================
    task
    body();
        vip_clock_seq_item  t;
        t = vip_clock_seq_item::type_id::create("clock_seq");
        start_item(t);
        t.enabled       = enabled     ;
        t.period        = period      ;
        t.initial_skew  = initial_skew;
        `CHK_RAND(t, with
        {
            t.low_ratio  == low_ratio;
            t.high_ratio == high_ratio;
        })
        finish_item(t);
    endtask
    //==========================================================================
endclass
`endif//VIP_CLOCK_SEQUENCE_SV