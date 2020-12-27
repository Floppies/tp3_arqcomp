`timescale 10ns / 10ns

module acc_tb();

localparam      E_BITS  =   16  ;

//  Inputs
reg     [E_BITS-1:0]            i_mux   ;
reg     i_clock ,   i_reset ,   enable  ;

//  Output
wire    [E_BITS-1:0]            o_acc   ;

initial
    begin
        enable      =       16'b0       ;
        i_clock     =       1'b0        ;
        i_reset     =       1'b1        ;
        i_mux       =       16'b101     ;
        
        #5
        i_reset     =       1'b0        ;
        
        #15
        enable      =       1'b1        ;
        
        #10
        enable      =       1'b0        ;
        
        #10
        i_mux       =       16'b1110    ;
        
        #20
        enable      =       1'b1        ;
        
        #10
        enable      =       1'b0        ;
        
    end
    
always begin
    #10
    i_clock = ~i_clock;
end

accumulator
#(
    .E_BITS     (E_BITS)
)   ACCACC
(
    .i_clock    (i_clock)   ,
    .i_reset    (i_reset)   ,
    .enable     (enable)    ,
    .i_mux      (i_mux)     ,
    .o_acc      (o_acc)
);
endmodule
