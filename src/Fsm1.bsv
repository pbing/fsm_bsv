package Fsm1;

typedef enum {IDLE,
              READ,
              DLY,
              DONE
   } State deriving (Bits, Eq, FShow);

(* always_enabled, always_ready*)
interface Fsm1_IFC;
   method Action start(Bool go, Bool ws);
   method Bool   rd;
   method Bool   ds;
endinterface

/* registered outputs */
(* synthesize *)
module mkFsm1(Fsm1_IFC);
   Reg#(Bool)  rd_r  <- mkRegA(False);
   Reg#(Bool)  ds_r  <- mkRegA(False);
   Reg#(State) state <- mkRegA(IDLE);

   rule debug (True);
      $display("%t %m.state=", $time, fshow(state));
   endrule

   method Action start(Bool go, Bool ws);
      case (state)
         IDLE:   if (go) begin
                    rd_r  <= True;
                    ds_r  <= False;
                    state <= READ;
                 end
                 else begin
                    rd_r  <= False;
                    ds_r  <= False;
                    state <= IDLE;
                 end
         READ:   begin
                    rd_r  <= True;
                    ds_r  <= False;
                    state <= DLY;
                 end
         DLY:    if (!ws) begin
                    rd_r  <= False;
                    ds_r  <= True;
                    state <= DONE;
                 end
                 else begin
                    rd_r  <= True;
                    ds_r  <= False;
                    state <= READ;
                 end
         DONE:   begin
                    rd_r  <= False;
                    ds_r  <= False;
                    state <= IDLE;
                 end
         default begin
                    rd_r  <= ?;
                    ds_r  <= ?;
                    state <= ?;
                 end
      endcase
   endmethod

   method Bool rd = rd_r;
   method Bool ds = ds_r;
endmodule

/* combinatorial outputs */
(* synthesize *)
module mkFsm1_comb(Fsm1_IFC);
   Reg#(State) state <- mkRegA(IDLE);

   rule debug (True);
      $display("%t %m.state=", $time, fshow(state));
   endrule

   method Action start(Bool go, Bool ws);
      case (state)
         IDLE: if (go)
                  state <= READ;
               else 
                  /* Clock gating will be inferred when the 'else' branch is omitted. */
                  state <= IDLE;
         READ:    state <= DLY;
         DLY:  if (!ws)
                  state <= DONE;
               else
                  state <= READ;
         DONE:    state <= IDLE;
         default  state <= ?;
      endcase
   endmethod

   method Bool rd;
      case (state)
         IDLE:   return False;
         READ:   return True;
         DLY:    return True;
         DONE:   return False;
         default return ?;
      endcase
   endmethod

   method Bool ds;
      case (state)
         IDLE:   return False;
         READ:   return False;
         DLY:    return False;
         DONE:   return True;
         default return ?;
      endcase
   endmethod
endmodule

endpackage
