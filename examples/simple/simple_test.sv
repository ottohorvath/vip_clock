`ifndef SIMPLE_TEST_SV
`define SIMPLE_TEST_SV

class simple_test extends uvm_test;
    `uvm_component_utils(simple_test)

    simple_env           env;
    vip_clock_sequence   seq;

    //==========================================================================
    function new(string name="simple_test", uvm_component parent=null);
        super.new(name,parent);
    endfunction
    //==========================================================================

    //==========================================================================
    function void
    build_phase(uvm_phase phase);
        env = simple_env::type_id::create("env",this);
        uvm_top.enable_print_topology = 1;
    endfunction
    //==========================================================================

    //==========================================================================
    task
    run_phase(uvm_phase phase);
        phase.raise_objection(this,"Starting test!");
        #100;

        seq = vip_clock_sequence::type_id::create("clock_seq");

        seq.enabled      = 1;
        seq.period       = 5.1;
        seq.initial_skew = 8.4;

        if (!seq.randomize()) `uvm_fatal(get_type_name(),"Failed to randomize 'seq'!")
        seq.start(env.clk_agt.get_sequencer());

        #100;

        seq.enabled = 0;
        if (!seq.randomize()) `uvm_fatal(get_type_name(),"Failed to randomize 'seq'!")
        seq.start(env.clk_agt.get_sequencer());
        #4000;
        phase.drop_objection(this,"Ending test!");
    endtask
    //==========================================================================
endclass
`endif//SIMPLE_TEST_SV