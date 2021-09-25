# Description

Compare finite state machine (FSM) coding styles in Bluespec SystemVerilog (BSV) in comparition to SystemVerilog.

## Quickstart
Create an environment for BSC
```shell
source env.sh
```

Simulate
```shell
bsc -sim -u ./test/Tb1.bsv
bsc -sim -e mkTb
./bsim -V
```

Create RTL
```shell
bsc -verilog -u ./test/Tb1.bsv
```

## References
* [Clifford E. Cummings, Heath Chambers, "Finite State Machine (FSM) Design & Synthesis using SystemVerilog - Part I"](http://www.sunburst-design.com/papers/CummingsSNUG2019SV_FSM1.pdf)
