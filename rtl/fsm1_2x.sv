/* fsm1_2x - 2-always block with combinatorial outputs */

module fsm1_2x (output logic rd, ds,
                input  logic go, ws, clk, rst_n);
   
   import fsm1_pkg::*;
   state_e state, next;
   
   always_ff @(posedge clk, negedge rst_n)
     if (!rst_n) state <= IDLE;
     else        state <= next;

   always_comb begin
      next = XXX;                      //@LB next = state;
      rd   = '0;
      ds   = '0;
      case (state)
        IDLE : if (go)    next = READ;
        else              next = IDLE; //@ LB
        READ : begin
                 rd = '1;
                          next = DLY;
               end
        DLY  : begin
                 rd = '1;
                 if (!ws) next = DONE;
                 else     next = READ;
               end
        DONE : begin
                 ds = '1;
                          next = IDLE;
               end
        default: begin
                 ds = 'x;
                 rd = 'x;
                          next = XXX;
                 end
         endcase
   end
endmodule
