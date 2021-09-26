/* Verilator Testbench */

#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vtop.h"

#define MAX_MAIN_TIME 30
vluint64_t main_time = 0;
vluint64_t cycles = 0;

double sc_time_stamp() {
  return main_time;
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
  Verilated::assertOn(false);

  // Set Vtop's input signals
  top->CLK   = 0;
  top->RST_N = 0;
  top->go    = 0;
  top->ws    = 0;
  top->eval();

  for (; main_time < MAX_MAIN_TIME; ++main_time) {
    top->CLK = !top->CLK;
    top->eval();

    if (top->CLK) {
      switch (cycles) {
      case 1:
        top->RST_N = 1;
        break;
      case 2:
        Verilated::assertOn(true);
        break;
      case 3:
        top->go = 1;
        break;
      case 4:
        top->go = 0;
        break;
      case 5:
        top->ws = 1;
        break;
      case 7:
        top->ws = 0;
        break;
      }
      ++cycles;
    }
  }

  top->final();
  return 0;
}
