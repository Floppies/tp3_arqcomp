`timescale 10ns / 10ns

module incrementer_tb();

localparam      MSB     =   11  ;

//  Input
reg     [MSB-1:0]       i_addr  ;

//  Output
wire    [MSB-1:0]       o_inc   ;

initial
    begin
        
        i_addr  =   11'b1       ;
        
        #10
        i_addr  =   11'b1000    ;
        
        #10
        i_addr  =   11'b1001    ;
        
        #10
        i_addr  =   11'b1010    ;
        
        #10
        i_addr  =   11'b1111    ;
        
    end

incrementer
#(
    .MSB        (MSB)
)   INCINC
(
    .i_addr     (i_addr)        ,
    .o_inc      (o_inc)
);

endmodule
