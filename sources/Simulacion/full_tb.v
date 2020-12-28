`timescale 1ns / 1ns

module full_tb();

localparam  BITS            =   16              ;
localparam  DTBITS          =   BITS - 5        ;
localparam  OPBITS          =   BITS - DTBITS   ;
localparam  S_BITS          =   2               ;
localparam  MEM_SIZE_ROM    =   9               ;
localparam  MEM_SIZE_RAM    =   9               ;
localparam  WORD_WIDTH      =   16              ;
localparam  ADDR_LENGTH     =   11              ;
localparam  DATA_LENGTH     =   16              ;

//  Inputs
reg     i_clock     ,   i_reset     ;

//  Outputs
wire    [BITS-1:0]      o_Data      ;
wire    flag    ,   tx  ,   tx_done ;

initial
    begin
        
        i_reset     =       1'b1    ;
        i_clock     =       1'b1    ;
        
        #20
        i_reset     =       1'b0    ;
        
        #10000000
        i_clock     =       1'b0    ;
    end

always begin
    #20
    i_clock = ~i_clock;
end
full_top    #(
    .BITS           (BITS)          ,
    .DTBITS         (DTBITS)        ,
    .OPBITS         (OPBITS)        ,
    .S_BITS         (S_BITS)        ,
    .MEM_SIZE_ROM   (MEM_SIZE_ROM)  ,
    .MEM_SIZE_RAM   (MEM_SIZE_RAM)  ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)  TOPTOP
(
    .i_clock        (i_clock)       ,
    .i_reset        (i_reset)       ,
    .flag           (flag)          ,
    .tx_done        (tx_done)       ,
    .tx             (tx)            ,
    .o_Data         (o_Data)
);

endmodule
