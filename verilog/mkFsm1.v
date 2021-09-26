//
// Generated by Bluespec Compiler, version 2021.07 (build 4cac6eb)
//
// On Sun Sep 26 19:34:11 CEST 2021
//
//
// Ports:
// Name                         I/O  size props
// rd                             O     1 reg
// ds                             O     1 reg
// CLK                            I     1 clock
// RST_N                          I     1 reset
// start_go                       I     1
// start_ws                       I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkFsm1(CLK,
	      RST_N,

	      start_go,
	      start_ws,

	      rd,

	      ds);
  input  CLK;
  input  RST_N;

  // action method start
  input  start_go;
  input  start_ws;

  // value method rd
  output rd;

  // value method ds
  output ds;

  // signals for module outputs
  wire ds, rd;

  // register ds_r
  reg ds_r;
  wire ds_r$D_IN, ds_r$EN;

  // register rd_r
  reg rd_r;
  wire rd_r$D_IN, rd_r$EN;

  // register state
  reg [1 : 0] state;
  reg [1 : 0] state$D_IN;
  wire state$EN;

  // declarations used by system tasks
  // synopsys translate_off
  reg [63 : 0] v__h132;
  // synopsys translate_on

  // value method rd
  assign rd = rd_r ;

  // value method ds
  assign ds = ds_r ;

  // register ds_r
  assign ds_r$D_IN = state == 2'd2 && !start_ws ;
  assign ds_r$EN = 1'd1 ;

  // register rd_r
  assign rd_r$D_IN =
	     (state == 2'd0) ?
	       start_go :
	       state == 2'd1 || state == 2'd2 && start_ws ;
  assign rd_r$EN = 1'd1 ;

  // register state
  always@(state or start_go or start_ws)
  begin
    case (state)
      2'd0: state$D_IN = start_go ? 2'd1 : 2'd0;
      2'd1: state$D_IN = 2'd2;
      2'd2: state$D_IN = start_ws ? 2'd1 : 2'd3;
      2'd3: state$D_IN = 2'd0;
    endcase
  end
  assign state$EN = 1'd1 ;

  // handling of inlined registers

  always@(posedge CLK or `BSV_RESET_EDGE RST_N)
  if (RST_N == `BSV_RESET_VALUE)
    begin
      ds_r <= `BSV_ASSIGNMENT_DELAY 1'd0;
      rd_r <= `BSV_ASSIGNMENT_DELAY 1'd0;
      state <= `BSV_ASSIGNMENT_DELAY 2'd0;
    end
  else
    begin
      if (ds_r$EN) ds_r <= `BSV_ASSIGNMENT_DELAY ds_r$D_IN;
      if (rd_r$EN) rd_r <= `BSV_ASSIGNMENT_DELAY rd_r$D_IN;
      if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
    end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    ds_r = 1'h0;
    rd_r = 1'h0;
    state = 2'h2;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      begin
        v__h132 = $time;
	#0;
      end
    if (RST_N != `BSV_RESET_VALUE) $write("%t %m.state=", v__h132);
    if (RST_N != `BSV_RESET_VALUE) if (state == 2'd0) $write("IDLE");
    if (RST_N != `BSV_RESET_VALUE) if (state == 2'd1) $write("READ");
    if (RST_N != `BSV_RESET_VALUE) if (state == 2'd2) $write("DLY");
    if (RST_N != `BSV_RESET_VALUE)
      if (state != 2'd0 && state != 2'd1 && state != 2'd2) $write("DONE");
    if (RST_N != `BSV_RESET_VALUE) $write("\n");
  end
  // synopsys translate_on
endmodule  // mkFsm1

