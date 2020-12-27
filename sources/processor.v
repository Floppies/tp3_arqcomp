`timescale 10ns / 10ns

module processor    #(
    parameter   BITS    =   16              ,
    parameter   DTBITS  =   BITS - 5        ,
    parameter   OPBITS  =   BITS - DTBITS   ,
    parameter   S_BITS  =   2
)
(
    input   wire        i_reset,    i_clock     ,
    //  Interfaz memoria de programa
    input   wire    [BITS-1:0]      i_Data_rom  ,
    output  wire    [DTBITS-1:0]    o_Addr_rom  ,
    
    //  Interfaz memoria de datos
    input   wire    [BITS-1:0]      i_Data_ram  ,
    output  wire    [BITS-1:0]      o_Data_ram  ,
    output  wire    [DTBITS-1:0]    o_Addr_ram  ,
    output  wire        Wr      ,   Rd
);

//  Auxiliary wiring
wire        [S_BITS-1:0]        sel_A       ;
wire        sel_B,  enable_acc, op_s        ;
wire        [DTBITS-1:0]        ctrl_to_dtp ;   //  Datos desde el control al datapath

datapath_top    #(
    .E_BITS         (BITS)          ,
    .D_BITS         (DTBITS)        ,
    .S_BITS         (S_BITS)
)   DATATOP
(
    //.i_clock        (i_clock)       ,
    //.i_reset        (i_reset)       ,
    .i_Data         (ctrl_to_dtp)   ,
    .i_Data_ram     (i_Data_ram)    ,
    .sel_A          (sel_A)         ,
    .sel_B          (sel_B)         ,
    .w_acc          (enable_acc)    ,
    .i_op           (op_s)          ,
    .o_Addr_ram     (o_Addr_ram)    ,
    .o_Data_ram     (o_Data_ram)
);


control_top #(
    .BITS       (BITS)      ,
    .DTBITS     (DTBITS)    ,
    .OPBITS     (OPBITS)
)   CONTOP
(
    .i_clk          (i_clock)       ,
    .i_rst          (i_reset)       ,
    .i_Data         (i_Data_rom)    ,
    .o_Data         (ctrl_to_dtp)   ,
    .o_Addr         (o_Addr_rom)    ,
    .sel_A          (sel_A)         ,
    .sel_B          (sel_B)         ,
    .w_acc          (enable_acc)    ,
    .o_op           (op_s)          ,
    .w_ram          (Wr)            ,
    .r_ram          (Rd)
);


endmodule
