/* Verilator Testbench */

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vtop.h"

#define MAX_SIM_TIME 30
vluint64_t sim_time = 0;
vluint64_t cycles = 0;

double sc_time_stamp() {
  return sim_time;
}

int main(int argc, char **argv, char **env) {
  // Prevent unused variable warnings
  if (false && argc && argv && env) {}

  const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
  contextp->commandArgs(argc, argv);

  // Construct the Verilated model, from Vtop.h generated from Verilating "top.v".
  // "TOP" will be the hierarchical name of the module.
  const std::unique_ptr<Vtop> top{new Vtop{contextp.get(), "TOP"}};

  Verilated::traceEverOn(true);
  VerilatedVcdC *tfp = new VerilatedVcdC;
  top->trace(tfp, 99);
  tfp->open("waveform.vcd");

  Verilated::assertOn(false);

  // Set Vtop's input signals
  top->CLK   = 0;
  top->RST_N = 1;
  top->go    = 0;
  top->ws    = 0;

  for (; sim_time < MAX_SIM_TIME; ++sim_time) {
    contextp->time(sim_time);

    top->CLK = !top->CLK;
    top->eval();
    tfp->dump(sim_time);

    if (top->CLK) {
      switch (cycles) {
      case 1:
        top->RST_N = 0;
        break;
      case 2:
        top->RST_N = 1;
        break;
      case 3:
        Verilated::assertOn(true);
        break;
      case 5:
        top->go = 1;
        break;
      case 6:
        top->go = 0;
        break;
      case 7:
        top->ws = 1;
        break;
      case 9:
        top->ws = 0;
        break;
      }
      ++cycles;
    }
  }

  top->final();
  tfp->close();
  return 0;
}
