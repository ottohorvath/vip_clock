interface   vip_clock_signal_if(
    output logic   clk
);
    bit     agent_is_active;
    logic   clk_drv;
    assign  clk = (agent_is_active) ? (clk_drv) : (1'bz);

    //==========================================================================
    clocking drv_cb @ (clk);
        default input #1step;
        input clk;
    endclocking
    //==========================================================================
endinterface