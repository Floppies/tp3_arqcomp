`timescale 10ns / 10ns

module program_counter  #(
    parameter       MSB     =   11
)
(
    input   wire    i_clk   ,   i_rst   ,
    input   wire    [MSB-1:0]   i_inc   ,   //  Entrada desde el incrementador
    input   wire                enable  ,   //  Entrada que habilita la lectura del PC
    output  reg     [MSB-1:0]   o_pc        //  Salida
);

always  @(posedge i_clk)
    begin
        if  (i_rst)
            o_pc        <=      11'b0   ;
        else if (enable)
            o_pc        <=      i_inc   ;
        else
            o_pc        <=      11'b0   ;
    end

endmodule
