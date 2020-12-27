`timescale 10ns / 10ns

module control_top  #(
    parameter   BITS    =   16              ,
    parameter   DTBITS  =   BITS - 5        ,
    parameter   OPBITS  =   BITS - DTBITS
)
(
    input   wire        i_clk   ,   i_rst   ,
    input   wire    [BITS-1:0]      i_Data  ,
    output  wire    [DTBITS-1:0]    o_Data  ,
    output  wire    [DTBITS-1:0]    o_Addr  ,
    output  wire    [1:0]           sel_A   ,
    output  wire        sel_B   ,   o_op    ,
    output  wire    w_acc,  w_ram,  r_ram
);

wire    [DTBITS-1:0]                pc_line ;
wire    [DTBITS-1:0]                inc_line;
wire    [OPBITS-1:0]                op_line ;
wire                                w_pc    ;


assign  o_Data  =   i_Data[DTBITS-1:0]      ;
assign  op_line =   i_Data[BITS-1:DTBITS]   ;
assign  o_Addr  =                   pc_line ;

incrementer
#(
    .MSB        (DTBITS)
)   INC
(
    .i_addr     (pc_line)       ,
    .o_inc      (inc_line)
);

program_counter
#(
    .MSB        (DTBITS)
)    PC
(
    .i_rst      (i_rst)         ,
    .i_clk      (i_clk)         ,
    .enable     (w_pc)          ,
    .i_inc      (inc_line)      ,
    .o_pc       (pc_line)
);

decoder
#(
    .OPBTS      (OPBITS)
)    DEC
(
    .i_rst      (i_rst)         ,
    .i_clk      (i_clk)         ,
    .op_code    (op_line)       ,
    .sel_A      (sel_A)         ,
    .sel_B      (sel_B)         ,
    .w_acc      (w_acc)         ,
    .w_ram      (w_ram)         ,
    .o_op       (o_op)          ,
    .r_ram      (r_ram)         ,
    .w_pc       (w_pc)
);

endmodule
