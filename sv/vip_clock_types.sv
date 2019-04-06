`ifndef VIP_CLOCK_TYPES_SV
`define VIP_CLOCK_TYPES_SV

class vip_clock_types;

    typedef enum bit [1:0]
    {
        STOPPED     ,
        INITIAL_SKEW,
        LOW         ,
        HIGH
    } state_t;

endclass
`endif//VIP_CLOCK_TYPES_SV