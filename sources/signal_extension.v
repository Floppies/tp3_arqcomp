`timescale 10ns / 10ns

module signal_extension #(
        parameter   DTBITS  =   11  ,
        parameter   EXTBITS =   16
)
(
        input   wire    [DTBITS-1:0]    i_ext   ,
        output  wire    [EXTBITS-1:0]   o_ext
);

assign  o_ext   =   i_ext   ;

endmodule
