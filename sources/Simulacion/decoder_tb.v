`timescale 10ns / 10ns

module decoder_tb();

localparam          OPBTS   =   5   ;

//  Entradas
reg             rst     ,   clk     ;
reg     [OPBTS-1:0]         op_code ;   //  Codigo de la instruccion

//  Salidas
wire    [1:0]               sel_A   ;
wire            w_acc,  w_ram,  w_pc;
wire            o_op,   sel_B       ;

initial begin
    
    rst         =       1'b1        ;
    clk         =       1'b1        ;
    op_code     =       5'b00001    ;   //  Prueba STO
    #10
    rst         =       1'b0        ;   //  Prueba reset
    
    #10
    op_code     =       5'b00000    ;   //  Prueba HLT
    
    #20
    op_code     =       5'b00001    ;   //  Prueba STO
    
    #20
    rst         =       1'b1        ;   //  Prueba reset
    #10
    rst         =       1'b0        ;
    
    #30
    op_code     =       5'b00010    ;   //  Prueba LD
    
    #20
    op_code     =       5'b00011    ;   //  Prueba LDI
    
    #20
    op_code     =       5'b00100    ;   //  Prueba ADD
    
    #20
    op_code     =       5'b00101    ;   //  Prueba ADDI
    
    #20
    op_code     =       5'b00110    ;   //  Prueba SUB
    
    #20
    op_code     =       5'b00111    ;   //  Prueba SUBI
    
    #20
    op_code     =       5'b00000    ;   //  Prueba HLT

    
    #50
    clk         =       1'b1        ;
    
    $finish;
end
    
always begin
    #10
    clk = ~clk;
end

decoder
#(
    .OPBTS      (OPBTS)
)    DECDEC
(
    .i_rst      (rst)           ,
    .i_clk      (clk)           ,
    .op_code    (op_code)       ,
    .sel_A      (sel_A)         ,
    .sel_B      (sel_B)         ,
    .w_acc      (w_acc)         ,
    .w_ram      (w_ram)         ,
    .o_op       (o_op)          ,
    .r_ram      (r_ram)         ,
    .w_pc       (w_pc)
);

endmodule
