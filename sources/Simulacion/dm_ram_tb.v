`timescale 10ns / 10ns

module dm_ram_tb();

localparam  MEM_SIZE        =   9   ;
localparam  WORD_WIDTH      =   16  ;
localparam  ADDR_LENGTH     =   11  ;
localparam  DATA_LENGTH     =   16  ;

//  Inputs
reg     [ADDR_LENGTH-1:0]   i_Addr  ;
reg     [DATA_LENGTH-1:0]   i_Data  ;
reg                 Wr,     Rd      ;

//  Output
wire    [DATA_LENGTH-1:0]   o_Data  ;

initial
    begin
        Wr          =       1'b0    ;
        Rd          =       1'b0    ;
        i_Addr      =       11'b0   ;
        i_Data      =       16'h34  ;
        
        //  Leo la posicion 1 de memoria
        #10
        i_Addr      =       11'b1   ;
        Rd          =       1'b1    ;
        
        //  Actualizo la pos 2 en la memoria
        #10
        i_Addr      =       11'b10  ;
        Rd          =       1'b0    ;
        Wr          =       1'b1    ;
        
        //  Leo la posicion 2 de memoria
        #10
        i_Addr      =       11'b10  ;
        Wr          =       1'b0    ;
        Rd          =       1'b1    ;
        
    end

dm_ram  #(
    .MEM_SIZE       (MEM_SIZE)      ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)   RAMRAM
(

    .i_Addr         (i_Addr)        ,
    .i_Data         (i_Data)        ,
    .Wr             (Wr)            ,
    .Rd             (Rd)            ,
    .o_Data         (o_Data)
);

endmodule
