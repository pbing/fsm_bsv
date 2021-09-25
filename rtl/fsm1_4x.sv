/* fsm1_4x - 3-always block style with registered outputs */

module fsm1_4x (output logic rd, ds,
                input  logic go, ws, clk, rst_n);

   logic n_rd, n_ds; // next combinatorial outputs

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
        default:        next = XXX;
       endcase
   end

   always_comb begin
      n_rd = '0;
      n_ds = '0;
      case (state)
        IDLE: if(go) n_rd = '1; // READ
              else ;            // IDLE
        READ :       n_rd = '1; // DLY
        DLY : if(ws) n_rd = '1; // READ
              else   n_ds = '1; // DONE
        DONE : ;                // IDLE
        default:    {n_rd,n_ds} = 'x;
      endcase
   end

   always_ff @(posedge clk, negedge rst_n)
     if (!rst_n) begin
        rd <= '0;
        ds <= '0; end
     else begin
        rd <= n_rd;
        ds <= n_ds;
     end
endmodule
