package Tb1;

import Fsm1::*;

(* synthesize *)
module mkTb(Empty);
   Reg#(UInt#(32)) cycles <- mkReg(0);
   Reg#(Bool)      go    <- mkReg(False);
   Reg#(Bool)      ds    <- mkReg(False);

   Fsm1_IFC fsm1r <- mkFsm1;
   Fsm1_IFC fsm1c <- mkFsm1_comb;

   rule run;
      case (cycles)
         0: begin
               go <= False;
               ds <= False;
            end
         1: begin
               go <= True;
               ds <= False;
            end
         2: begin
               go <= False;
               ds <= False;
            end
         3: begin
               go <= False;
               ds <= True;
            end
         4: begin
               go <= False;
               ds <= False;
            end
         8: begin
               $finish;
            end
         endcase

      cycles <= cycles + 1;
   endrule

   rule stimulate;
      fsm1r.start(go, ds);
      fsm1c.start(go, ds);
   endrule

   rule compare;
      if (fsm1r.rd != fsm1c.rd)
         $error("%t fsm1r.rd=%b fsm1c.rd=%b", $time, fsm1r.rd, fsm1c.rd);

      if (fsm1r.ds != fsm1c.ds)
         $error("%t fsm1r.ds=%b fsm1c.ds=%b", $time, fsm1r.ds, fsm1c.ds);
   endrule

endmodule

endpackage
