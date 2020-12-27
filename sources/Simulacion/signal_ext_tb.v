`timescale 10ns / 10ns

module signal_ext_tb();

localparam  DTBITS  =   11  ;
localparam  EXTBITS =   16  ;

// Input
reg [DTBITS-1:0]    i_ext   ;
// Output
wire [EXTBITS-1:0]  o_ext   ;

initial
    begin
        
        i_ext   =   11'b1   ;
        
        #10
        i_ext   =   11'b110 ;
        
        #10
        i_ext   =   11'b101 ;
    end

signal_extension
#(
    .DTBITS     (DTBITS)    ,
    .EXTBITS    (EXTBITS)
)   EXTEXT
(
    .i_ext      (i_ext)     ,
    .o_ext      (o_ext)
);

endmodule
