`timescale 10ns / 10ns

module program_counter  #(
    parameter       MSB     =   11
)
(
    input   wire    i_clk   ,   i_rst   ,
    input   wire    [MSB-1:0]   i_inc   ,   //  Entrada desde el incrementador
    input   wire                enable  ,   //  Entrada que habilita la lectura del PC
    input   wire                h_flag  ,
    output  reg     [MSB-1:0]   o_pc        //  Salida
);

reg             halted      ;       //  Bandera que se;ala que se llego a una instruccion de HALT

always  @(posedge i_clk)
    begin
        if  (i_rst)
        begin
            o_pc        <=      11'b0   ;
            halted      <=      1'b0    ;
        end
        else if (halted)
            o_pc        <=      11'b0   ;
        else if (enable)
            o_pc        <=      i_inc   ;
    end

endmodule
