`timescale 10ns / 10ns

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
wire    [BITS-1:0]      o_Data_ram  ;
wire    [BITS-1:0]      o_Data_rom  ;

initial
    begin
        
        i_reset     =       1'b0    ;
        i_clock     =       1'b0    ;
        
        #100
        i_reset     =       1'b1    ;
        
        #100
        i_reset     =       1'b0    ;
        
        #100000
        i_clock     =       1'b1    ;
    end
    
always begin
    #100
    i_clock = ~i_clock;
end

full    #(
    .BITS           (BITS)          ,
    .DTBITS         (DTBITS)        ,
    .OPBITS         (OPBITS)        ,
    .S_BITS         (S_BITS)        ,
    .MEM_SIZE_ROM   (MEM_SIZE_ROM)  ,
    .MEM_SIZE_RAM   (MEM_SIZE_RAM)  ,
    .WORD_WIDTH     (WORD_WIDTH)    ,
    .ADDR_LENGTH    (ADDR_LENGTH)   ,
    .DATA_LENGTH    (DATA_LENGTH)
)  TOP
(
    .i_clock        (i_clock)       ,
    .i_reset        (i_reset)       ,
    .o_Data_ram     (o_Data_ram)    ,
    .i_Data_rom     (o_Data_rom)
);

endmodule