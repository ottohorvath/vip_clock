module simple_tb_top;
    import uvm_pkg::*;
    import simple_pkg::*;

    logic dut_clk;
    bit   free_clk  = 1;

    vip_clock_signal_if     clk_if(.clk(dut_clk));
    simple_dut              u_dut( .clk(dut_clk));

    initial
    begin
        uvm_config_db#(virtual vip_clock_signal_if)::set(null,"*env.clk_agt","vif",clk_if);
        uvm_top.run_test();
    end
endmodule