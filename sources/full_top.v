`timescale 10ns / 10ns

module full    #(
    parameter   BITS            =   16              ,
    parameter   DTBITS          =   BITS - 5        ,
    parameter   OPBITS          =   BITS - DTBITS   ,
    parameter   S_BITS          =   2               ,
    parameter   MEM_SIZE_ROM    =   9               ,
    parameter   MEM_SIZE_RAM    =   9               ,
    parameter   WORD_WIDTH      =   16              ,
    parameter   ADDR_LENGTH     =   11              ,
    parameter   DATA_LENGTH     =   16
)
(
    input   wire            i_reset,    i_clock     ,
    output  wire    [BITS-1:0]      i_Data_rom      ,
    output  wire    [BITS-1:0]      o_Data_ram
);

//  Auxiliary wiring
wire        [S_BITS-1:0]        sel_A       ;
wire        sel_B,  enable_acc, op_s        ;
wire        [DTBITS-1:0]        ctrl_to_dtp ;   //  Datos desde el control al datapath
wire                Wr  ,       Rd          ;
wire        [DTBITS-1:0]        Addr_rom    ;
wire        [DTBITS-1:0]        Addr_ram    ;
wire        [BITS-1:0]          i_Data_ram  ;

pm_rom  #(
    .MEM_SIZE       (MEM_SIZE_ROM)  ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)   ROM
(
    .i_Addr         (Addr_rom)      ,
    .o_Data         (i_Data_rom)
);

dm_ram  #(
    .MEM_SIZE       (MEM_SIZE_RAM)  ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)   RAM
(

    .i_Addr         (Addr_ram)      ,
    .i_Data         (o_Data_ram)    ,
    .Wr             (Wr)            ,
    .Rd             (Rd)            ,
    .o_Data         (i_Data_ram)
);

datapath_top    #(
    .E_BITS         (BITS)          ,
    .D_BITS         (DTBITS)        ,
    .S_BITS         (S_BITS)
)   DATA
(
    .i_clock        (i_clock)       ,
    .i_reset        (i_reset)       ,
    .i_Data         (ctrl_to_dtp)   ,
    .i_Data_ram     (i_Data_ram)    ,
    .sel_A          (sel_A)         ,
    .sel_B          (sel_B)         ,
    .w_acc          (enable_acc)    ,
    .i_op           (op_s)          ,
    .o_Addr_ram     (Addr_ram)      ,
    .o_Data_ram     (o_Data_ram)
);


control_top #(
    .BITS       (BITS)      ,
    .DTBITS     (DTBITS)    ,
    .OPBITS     (OPBITS)
)   CON
(
    .i_clk          (i_clock)       ,
    .i_rst          (i_reset)       ,
    .i_Data         (i_Data_rom)    ,
    .o_Data         (ctrl_to_dtp)   ,
    .o_Addr         (Addr_rom)      ,
    .sel_A          (sel_A)         ,
    .sel_B          (sel_B)         ,
    .w_acc          (enable_acc)    ,
    .o_op           (op_s)          ,
    .w_ram          (Wr)            ,
    .r_ram          (Rd)
);

endmodule