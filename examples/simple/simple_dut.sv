module simple_dut #(
    parameter DW = 8
)(
    input   wire logic            clk ,
    output       logic [(DW-1):0] dout
);
    logic [(DW-1):0]    cntr = '0;

    always_ff @ (posedge clk)
    begin
        cntr <= cntr + 1;
    end

    assign dout = cntr;
endmodule