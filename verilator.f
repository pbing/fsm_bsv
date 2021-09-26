--top-module top
--assert
--trace
--timescale 1ns/1ns
+libext+.v+.sv
-y rtl
-y verilog
-Wno-STMTDLY
-Wno-REALCVT
-Wno-DECLFILENAME
-Wno-BLKSEQ
-Wno-SYNCASYNCNET
-CFLAGS -DVL_TIME_CONTEXT
rtl/fsm1_pkg_a.sv
//rtl/fsm1_pkg_b.sv