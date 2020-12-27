`timescale 10ns / 10ns

module control_tb();


localparam      MSB    =   16           ;
localparam      DTBITS  =   MSB - 5     ;

//  Entradas
reg             rst     ,   clk         ;
reg     [MSB-1:0]           i_Data      ;   //  Codigo de la instruccion

//  Salidas
wire    [DTBITS-1:0]    o_Data, o_Addr  ;
wire    [1:0]                   sel_A   ;
wire    w_acc   ,   w_ram   ,   r_ram   ;
wire                o_op    ,   sel_B   ;

initial begin
    
    rst         =       1'b1        ;
    clk         =       1'b1        ;
    i_Data      =       16'h0000    ;   //  Prueba HLT
    #10
    rst         =       1'b0        ;   //  Prueba reset
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h0802    ;   //  Prueba STO
    
    #10
    clk         =       1'b0        ;
    
    /*
    #20
    i_Data      =       16'h0801    ;   //  Prueba STO
    
    #20
    rst         =       1'b1        ;   //  Prueba reset
    #10
    rst         =       1'b0        ;
    */
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h1002    ;   //  Prueba LD
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h1803    ;   //  Prueba LDI
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h2001    ;   //  Prueba ADD
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h2802    ;   //  Prueba ADDI
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h3001    ;   //  Prueba SUB
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h3801    ;   //  Prueba SUBI
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    i_Data      =       16'h0008    ;   //  Prueba HLT
    
    #10
    clk         =       1'b0        ;
    
    #10
    clk         =       1'b1        ;
    
    #10
    clk         =       1'b0        ;

    
    $finish;
end

control_top
#(
    .BITS       (MSB)
)    CONTROLT
(
    .i_rst      (rst)           ,
    .i_clk      (clk)           ,
    .i_Data     (i_Data)        ,
    .o_Data     (o_Data)        ,
    .o_Addr     (o_Addr)        ,
    .sel_A      (sel_A)         ,
    .sel_B      (sel_B)         ,
    .w_acc      (w_acc)         ,
    .w_ram      (w_ram)         ,
    .o_op       (o_op)          ,
    .r_ram      (r_ram)
);

endmodule