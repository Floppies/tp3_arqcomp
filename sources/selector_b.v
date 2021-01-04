`timescale 10ns / 10ns

module selector_b   #(
    parameter   E_BITS      =   16
)
(
    input   wire                    sel_B   ,   //  Bits que sellecionan la salida del multiplexor
    input   wire    [E_BITS-1:0]    i_Ram   ,   //  Entrada de datos que provienen de la RAM
    input   wire    [E_BITS-1:0]    i_ext   ,   //  Entrada de la salida del externsor de se;al
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
