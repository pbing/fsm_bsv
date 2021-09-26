/* Verilog top level */

module top
  (input wire CLK,
   input wire RST_N,
   input wire go,
   input wire ws);

   wire rd[6];
   wire ds[6];

   mkFsm1 u_fsm1
     (.*,
      .start_go (go),
      .start_ws (ws),
      .rd       (rd[0]),
      .ds       (ds[0]));

   mkFsm1_comb u_fsm1_comb
     (.*,
      .start_go (go),
      .start_ws (ws),
      .rd       (rd[1]),
      .ds       (ds[1]));

   fsm1_1x u_fsm1_1x
     (.*,
      .clk   (CLK),
      .rst_n (RST_N),
      .rd    (rd[2]),
      .ds    (ds[2]));

   fsm1_2x u_fsm1_2x
     (.*,
      .clk   (CLK),
      .rst_n (RST_N),
      .rd    (rd[3]),
      .ds    (ds[3]));

   fsm1_3x u_fsm1_3x
     (.*,
      .clk   (CLK),
      .rst_n (RST_N),
      .rd    (rd[4]),
      .ds    (ds[4]));

   fsm1_4x u_fsm1_4x
     (.*,
      .clk   (CLK),
      .rst_n (RST_N),
      .rd    (rd[5]),
      .ds    (ds[5]));

   always @(posedge CLK) begin
      chk_rd: assert (rd[0] == rd[1] &&
                      rd[0] == rd[2] &&
                      rd[0] == rd[3] &&
                      rd[0] == rd[4] &&
                      rd[0] == rd[5] &&
                      rd[1] == rd[2] &&
                      rd[1] == rd[3] &&
                      rd[1] == rd[4] &&
                      rd[1] == rd[5] &&
                      rd[2] == rd[3] &&
                      rd[2] == rd[4] &&
                      rd[2] == rd[5] &&
                      rd[3] == rd[4] &&
                      rd[3] == rd[5] &&
                      rd[4] == rd[5]);

      chk_ds: assert (ds[0] == ds[1] &&
                      ds[0] == ds[2] &&
                      ds[0] == ds[3] &&
                      ds[0] == ds[4] &&
                      ds[0] == ds[5] &&
                      ds[1] == ds[2] &&
                      ds[1] == ds[3] &&
                      ds[1] == ds[4] &&
                      ds[1] == ds[5] &&
                      ds[2] == ds[3] &&
                      ds[2] == ds[4] &&
                      ds[2] == ds[5] &&
                      ds[3] == ds[4] &&
                      ds[3] == ds[5] &&
                      ds[4] == ds[5]);
   end
endmodule
