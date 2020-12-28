`timescale 10ns / 10ns

module full_top #(

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
    input       wire                    i_clock     ,
    input       wire                    i_reset     ,
    output      reg                     flag        ,
    output      wire    [BITS-1:0]      o_Data      ,
    output      wire            tx  ,   tx_done
);

//  Auxiliary wiring
wire    [BITS-1:0]      i_Data_rom, i_Data_ram  ;
wire    [DTBITS-1:0]    o_Addr_rom, o_Addr_ram  ;
wire                    w_ram   ,   r_ram       ;
wire                    clk_out1    ,   locked  ;
wire                    halt_flag               ;

reg                     reset                   ;

always  @(clk_out1)
begin
    if(locked)
        flag    <=   1'b1    ;
    else
        flag    <=   1'b0    ;
end

always  @(clk_out1)
begin
    if(flag)
        reset   <=  1'b0    ;
    else
        reset   <=  clk_out1;
end

processor   #(
    .BITS           (BITS)          ,
    .DTBITS         (DTBITS)        ,
    .OPBITS         (OPBITS)        ,
    .S_BITS         (S_BITS)
)   PROCPROC
(
    .i_clock        (clk_out1)      ,
    .i_reset        (reset)         ,
    .i_Data_rom     (i_Data_rom)    ,
    .i_Data_ram     (i_Data_ram)    ,
    .o_Data_ram     (o_Data)        ,
    .o_Addr_rom     (o_Addr_rom)    ,
    .o_Addr_ram     (o_Addr_ram)    ,
    .halt_flag      (halt_flag)     ,
    .Wr             (w_ram)         ,
    .Rd             (r_ram)
);

pm_rom  #(
    .MEM_SIZE       (MEM_SIZE_ROM)  ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)   PMROM
(
    .i_Addr         (o_Addr_rom)    ,
    .o_Data         (i_Data_rom)
);

dm_ram  #(
    .MEM_SIZE       (MEM_SIZE_RAM)  ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)   DMRAM
(
    .i_Addr         (o_Addr_ram)    ,
    .i_Data         (o_Data)        ,
    .Wr             (w_ram)         ,
    .Rd             (r_ram)         ,
    .o_Data         (i_Data_ram)
);

clk_wiz_0 CLKCLK
(
    // Clock out ports  
    .clk_out1(clk_out1),
    // Status and control signals               
    .reset(i_reset), 
    .locked(locked),
    // Clock in ports
    .clk_in1(i_clock)
);

uart_full   UARTTX
(
    .i_clock        (clk_out1)      ,
    .i_reset        (reset)         ,
    .i_Data         (o_Data)        ,
    .tx_start       (halt_flag)     ,
    .tx_done        (tx_done)       ,
    .tx             (tx)
);
endmodule
