`ifndef VIP_CLOCK_DEFINES_SV
`define VIP_CLOCK_DEFINES_SV

`define GETTER(type,var)\
function ``type`` get_``var``();\
    return ``var``;\
endfunction

`define SETTER(type,var)\
function void set_``var``(input ``type`` ``var``_);\
    ``var``=``var``_;\
endfunction

`define TESTER(type,var)\
function bit is_``var``(input ``type`` ``var``_);\
    return (``var`` == ``var``_);\
endfunction

`define ACCESSOR(type,var)\
`GETTER(``type``,``var``)\
`SETTER(``type``,``var``)\
`TESTER(``type``,``var``)

`define RAND_CHECKER\
function void check_randomize(input bit succ, input string msg);\
    if (!suc) `uvm_fatal(get_type_name(), msg)\
endfunction

`endif//VIP_CLOCK_DEFINES_SV