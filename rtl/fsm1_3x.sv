/* fsm1_3x - 3-always block style with registered outputs */

module fsm1_3x (output logic rd, ds,
                input  logic go, ws, clk, rst_n);

   import fsm1_pkg::*;
   state_e state, next;

   always_ff @(posedge clk, negedge rst_n)
     if (!rst_n) state <= IDLE;
     else        state <= next;

   always_comb begin
      next = XXX;       //@LB next = state;
      case (state)
        IDLE : if (go)  next = READ;
               else     next = IDLE; //@ LB
        READ :          next = DLY;
        DLY  : if (!ws) next = DONE;
               else     next = READ;
        DONE :          next = IDLE;
          default:      next = XXX;
          endcase
   end

   always_ff @(posedge clk, negedge rst_n)
     if (!rst_n) begin
        rd <= '0;
        ds <= '0;
     end
     else begin
        rd <= '0;
        ds <= '0;
        case (next)
          IDLE : ;
          READ : rd <= '1;
          DLY  : rd <= '1;
          DONE : ds <= '1;
          default: {rd,ds} <= 'x;
        endcase
     end
endmodule
