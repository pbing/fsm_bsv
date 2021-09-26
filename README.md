# Description

Compare finite state machine (FSM) coding styles in Bluespec SystemVerilog (BSV) in comparition to SystemVerilog.

## Quickstart

### Create an environment for BSC
```shell
source env.sh
```

### Bluespec simulation
```shell
bsc -sim -u ./test/Tb1.bsv
bsc -sim -e mkTb
./bsim -V
```

### Create RTL
```shell
bsc -verilog -u ./test/Tb1.bsv
```

### Lint
```shell
verilator -Wall --lint-only -f verilator.f ./test/top.sv
```

### SystemVerilog simulation
```shell
verilator -Wall -f verilator.f --cc --exe --build ./test/top.sv sim_main.cpp
```

## References
* [Clifford E. Cummings, Heath Chambers, "Finite State Machine (FSM) Design & Synthesis using SystemVerilog - Part I"](http://www.sunburst-design.com/papers/CummingsSNUG2019SV_FSM1.pdf)
