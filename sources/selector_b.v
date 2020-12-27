`timescale 10ns / 10ns

module selector_b   #(
    parameter   E_BITS      =   16
)
(
    input   wire                    sel_B   ,
    input   wire    [E_BITS-1:0]    i_Ram   ,
    input   wire    [E_BITS-1:0]    i_ext   ,
    output  reg     [E_BITS-1:0]    o_mux
);

always @*
    begin
        if  (sel_B)
            o_mux   =   i_ext   ;
        else
            o_mux   =   i_Ram   ;
    end
endmodule
