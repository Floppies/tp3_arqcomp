`timescale 10ns / 10ns

module selector_a   #(
    parameter   E_BITS      =   16  ,
    parameter   S_BITS      =   2
)
(
    input   wire    [S_BITS-1:0]    sel_A   ,   //  Bits que selecciona la salida del multiplexor
    input   wire    [E_BITS-1:0]    i_Ram   ,   //  Entrada de datos que provienen de la RAM
    input   wire    [E_BITS-1:0]    i_ext   ,   //  Entrada que proviene del extensor de se;al (generalmente operando literal en la instruccion)
    input   wire    [E_BITS-1:0]    i_alu   ,   // Entrada que proviene del resultado de la ALU
    output  reg     [E_BITS-1:0]    o_mux
);

always @*
    begin
        case    (sel_A)
            2'b0:
                o_mux   =   i_Ram   ;
            2'b1:
                o_mux   =   i_ext   ;
            2'b10:
                o_mux   =   i_alu   ;
            default
                o_mux   =   0       ;
        endcase
    end
endmodule
