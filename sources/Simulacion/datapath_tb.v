`timescale 10ns / 10ns

module datapath_tb();

localparam      E_BITS      =   16  ;
localparam      D_BITS      =   11  ;
localparam      S_BITS      =   2   ;

//  Entradas
reg             i_clock ,   i_reset ;
reg     [D_BITS-1:0]    i_Data      ;   //  Datos que provienen de la Memoria de Programa (ROM)
reg     [E_BITS-1:0]    i_Data_ram  ;   //  Datos que provienen de la Data Memory (RAM)
reg     [S_BITS-1:0]    sel_A       ;
reg     i_op,   w_acc,  sel_B       ;


//  Salidas
wire    [D_BITS-1:0]    o_Addr_ram  ;   //  Direccion para sacar los datos de la RAM
wire    [E_BITS-1:0]    o_Data_ram  ;   //  Datos que se van a guardar en la RAM

initial begin
    
    i_reset     =       1'b1        ;
    i_clock     =       1'b1        ;
    i_Data      =       11'b0111    ;
    i_Data_ram  =       16'h0001    ;
    sel_A       =       2'b00       ;
    sel_B       =       1'b0        ;
    i_op        =       1'b0        ;
    w_acc       =       1'b0        ;
    
    #10
    i_reset     =       1'b0        ;
    i_clock     =       1'b0        ;
    
    //  STO 2
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b10      ;
    
    #10
    i_clock     =       1'b0        ;
    
    //  LD 2
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b10      ;
    w_acc       =       1'b0        ;
    sel_A       =       2'b0        ;
    
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    //  LDI 3
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b11      ;
    w_acc       =       1'b0        ;
    sel_A       =       2'b1        ;
    
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    //  ADD 1
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b01      ;
    w_acc       =       1'b0        ;
    sel_A       =       2'b10       ;
    
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    //  ADDI 2
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b10      ;
    w_acc       =       1'b0        ;
    sel_B       =       1'b1        ;
    
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    //  SUB 1
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b01      ;
    w_acc       =       1'b0        ;
    sel_B       =       1'b0        ;
    i_op        =       1'b1        ;
    
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    //  SUBI 1
    #10
    i_clock     =       1'b1        ;
    i_Data      =       11'b01      ;
    w_acc       =       1'b0        ;
    sel_B       =       1'b1        ;
    
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    #10
    i_clock     =       1'b1        ;
    #10
    i_clock     =       1'b0        ;
    
    /*
    //  Probando que el ACC no cambia sin el enable
    #10
    i_clock     =       1'b1        ;
    w_acc       =       1'b0        ;
    sel_A       =       2'b10       ;
    i_op        =       1'b0        ;
    sel_B       =       1'b1        ;
    
    #10
    i_clock     =       1'b0        ;
    
    #10
    i_clock     =       1'b1        ;
    
    //  ACC <- i_Data_ram + operand
    #10
    i_clock     =       1'b0        ;
    w_acc       =       1'b1        ;
    
    #50
    i_clock     =       1'b1        ;
    */
    
    $finish;
end

datapath_top
#(
    .E_BITS     (E_BITS)        ,
    .D_BITS     (D_BITS)        ,
    .S_BITS     (S_BITS)
)   DATAPATHT
(
    .i_reset    (i_reset)       ,
    .i_clock    (i_clock)       ,
    .i_Data     (i_Data)        ,
    .i_Data_ram (i_Data_ram)    ,
    .sel_A      (sel_A)         ,
    .sel_B      (sel_B)         ,
    .w_acc      (w_acc)         ,
    .i_op       (i_op)          ,
    .o_Data_ram (o_Data_ram)    ,
    .o_Addr_ram (o_Addr_ram)
);

endmodule
