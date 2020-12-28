`timescale 1ns / 1ns

module uart_tb();

localparam  DBIT        =   16      ;
localparam  SB_TICK     =   16      ;
localparam  DIV         =   163     ;
localparam  SIZ         =   8       ;

//  Inputs
reg         i_clock ,   i_reset     ;
reg     [DBIT-1:0]      i_Data      ;
reg                     tx_start    ;

//  Outputs
wire         tx_done ,   tx          ;

initial
    begin
        
        i_reset     =       1'b1    ;
        i_clock     =       1'b1    ;
        i_Data      =       16'h0004;
        tx_start    =       1'b0    ;
        
        #10
        i_reset     =       1'b0    ;
        
        #10
        tx_start    =       1'b1    ;
        
        //#10
        //tx_start    =       1'b0    ;
        
        #10000000
        i_clock     =       1'b0    ;
    end

always begin
    #10
    i_clock = ~i_clock;
end


uart_full   #(
    .DBIT           (DBIT)          ,
    .SB_TICK        (SB_TICK)       ,
    .DIV            (DIV)           ,
    .SIZ            (SIZ)

)   UARTTX
(
    .i_clock        (i_clock)       ,
    .i_reset        (i_reset)         ,
    .i_Data         (i_Data)        ,
    .tx_start       (tx_start)      ,
    .tx_done        (tx_done)       ,
    .tx             (tx)
);


endmodule
