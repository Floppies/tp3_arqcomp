`timescale 10ns / 10ns
module incrementer  #(
    parameter       MSB     =   11
)
(
    input   wire    [MSB-1:0]   i_addr  ,   //  Entrada que proviene de la direccion en la memoria de programa (ROM)
    output  wire    [MSB-1:0]   o_inc       //  Salida que va al PC.
);

assign  o_inc   =   i_addr  +   1'b1    ;   //  Incremento en uno la direccion

endmodule