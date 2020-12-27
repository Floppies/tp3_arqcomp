`timescale 10ns / 10ns

module pm_rom_tb();

localparam  MEM_SIZE        =   9   ;
localparam  WORD_WIDTH      =   16  ;
localparam  ADDR_LENGTH     =   11  ;
localparam  DATA_LENGTH     =   16  ;

//  Input
reg     [ADDR_LENGTH-1:0]   i_Addr  ;
//  Output
wire    [ADDR_LENGTH-1:0]   o_Data  ;

initial
    begin
    
        i_Addr      =   11'b00      ;
        
        #10
        i_Addr      =   11'b01      ;
        
        #10
        i_Addr      =   11'b10      ;
        
        #10
        i_Addr      =   11'b11      ;
        
        #10
        i_Addr      =   11'b00      ;
    end

pm_rom  #(
    .MEM_SIZE       (MEM_SIZE)      ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)   ROMROM
(
    .i_Addr         (i_Addr)        ,
    .o_Data         (o_Data)
);

endmodule
