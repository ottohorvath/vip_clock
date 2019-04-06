`ifndef VIP_CLOCK_PKG_SV
`define VIP_CLOCK_PKG_SV

package vip_clock_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "vip_clock_defines.sv"

    `include "vip_clock_types.sv"

    `include "seq/vip_clock_seq_item.sv"
    `include "seq/vip_clock_sequence.sv"

    `include "uvc/vip_clock_agent_configuration.sv"
    `include "uvc/vip_clock_driver.sv"
    `include "uvc/vip_clock_sequencer.sv"
    `include "uvc/vip_clock_agent.sv"

    `include "vip_clock_undefines.sv"
endpackage
`endif//VIP_CLOCK_PKG_SV