# vip_clock

This repository contains a clock generator VIP written in SV2012 and utilizes the UVM 1.1d base class library.
Implemented using Win10 x64 and QuestSim 10.4e.


example/simple:
- This folder contains a simple test to present the capability of the VIP.
- To launch the test a bash script (./examples/simple/run.bash) is provided which controls the compilation and simulation of QuestaSim.


Known issues:
- The generated output clock (clk) is currently delayed by one delta cycle in the vip_clock_signal_if.sv interface.
- It can be fixed by taking the generated clock signal not from 'clk' but from 'clk_drv' internal variable.