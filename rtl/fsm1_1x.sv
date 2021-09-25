/* fsm1_1x - 1-always block with registered outputs */

module fsm1_1x (output logic rd, ds,
                input  logic go, ws, clk, rst_n);

   import fsm1_pkg::*;
   state_e state;

   always_ff @(posedge clk, negedge rst_n)
     if (!rst_n) begin
        state <= IDLE;
        rd    <= '0;
        ds    <= '0;
     end
     else begin
        state <= XXX;                         //@ LB
        rd    <= '0;
        ds    <= '0;
        case (state)
          IDLE : if (go) begin
                   rd <= '1;
                             state <= READ;
                 end
                 else        state <= IDLE; //@ LB
          READ : begin
                   rd <= '1;
                             state <= DLY;
                 end
          DLY  : if (!ws) begin
                   ds <= '1;
                             state <= DONE;
                 end
                 else begin
                   rd <= '1;
                             state <= READ;
                 end
          DONE :             state <= IDLE;
          default: begin
                   ds <= 'x;
                   rd <= 'x;
                             state <= XXX;
                   end
        endcase
     end
endmodule
