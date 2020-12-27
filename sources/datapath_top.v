`timescale 10ns / 10ns

module datapath_top #(
    parameter   E_BITS      =   16  ,
    parameter   D_BITS      =   11  ,
    parameter   S_BITS      =   2
)
(
    input   wire    [D_BITS-1:0]    i_Data      ,
    input   wire    [E_BITS-1:0]    i_Data_ram  ,
    input   wire    [S_BITS-1:0]    sel_A       ,
    input   wire    i_op,   w_acc,  sel_B       ,
    //input   wire    i_clock ,       i_reset     ,
    output  wire    [D_BITS-1:0]    o_Addr_ram  ,
    output  wire    [E_BITS-1:0]    o_Data_ram
);

wire    [E_BITS-1:0]        alu_to_selA     ;
wire    [E_BITS-1:0]        selA_to_acc     ;
wire    [E_BITS-1:0]        extended_signal ;
wire    [E_BITS-1:0]        selB_to_alu     ;
wire    [E_BITS-1:0]        o_acc ;

assign  o_Addr_ram  =   i_Data      ;
assign  o_Data_ram  =   o_acc       ;

signal_extension
#(
    .DTBITS     (D_BITS)    ,
    .EXTBITS    (E_BITS)
)   EXT
(
    .i_ext      (i_Data)    ,
    .o_ext      (extended_signal)
);

selector_a
#(
    .E_BITS     (E_BITS)    ,
    .S_BITS     (S_BITS)
)   SELA
(
    .i_ext      (extended_signal)   ,
    .i_Ram      (i_Data_ram)        ,
    .i_alu      (alu_to_selA)       ,
    .sel_A      (sel_A)             ,
    .o_mux      (selA_to_acc)
);

selector_b
#(
    .E_BITS     (E_BITS)
)   SELB
(
    .i_ext      (extended_signal)   ,
    .i_Ram      (i_Data_ram)        ,
    .sel_B      (sel_B)             ,
    .o_mux      (selB_to_alu)
);

alu
#(
    .E_BITS     (E_BITS)
)   ALU
(
    .op_1       (o_acc)             ,
    .op_2       (selB_to_alu)       ,
    .i_op       (i_op)              ,
    .o_res      (alu_to_selA)
);

accumulator
#(
    .E_BITS     (E_BITS)
)   ACC
(
    //.i_clock    (i_clock)           ,
    //.i_reset    (i_reset)           ,
    .enable     (w_acc)             ,
    .i_mux      (selA_to_acc)       ,
    .o_acc      (o_acc)
);

endmodule
