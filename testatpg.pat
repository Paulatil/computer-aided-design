//
//  Tessent FastScan  v9.2
//
//  Design  = netlist.v
//  Created = Sat Nov  3 23:33:31 2018
//
//  Statistics:
//      Test Coverage   =  100.00%
//      Total Faults    =  38
//          DS (det_simulation)    =  38
//      Total            Patterns  =  5
//
//  Settings:
//      Simulation Mode =  combinational, seq_depth = 0
//      Fault Type      =  stuck
//      Fault Mode      =  uncollapsed
//      Pos_Det Credit  =  50%
//      Z external      =  X
//      Z internal      =  X
//      wired_net       =  WIRE
//
//  Warnings:
//

ASCII_PATTERN_FILE_VERSION = 2;


SETUP = 

    declare input bus "PI" = "/A", "/B", "/C", "/D";

    declare output bus "PO" = "/Y";

end;

SCAN_TEST =

    pattern = 0;
    force   "PI" "1011" 0;
    measure "PO" "1" 1;

    pattern = 1;
    force   "PI" "1000" 0;
    measure "PO" "0" 1;

    pattern = 2;
    force   "PI" "0110" 0;
    measure "PO" "1" 1;

    pattern = 3;
    force   "PI" "0011" 0;
    measure "PO" "0" 1;

    pattern = 4;
    force   "PI" "0101" 0;
    measure "PO" "1" 1;

end;

