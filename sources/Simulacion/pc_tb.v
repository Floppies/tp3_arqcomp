`timescale 10ns / 10ns

module pc_tb();

localparam      MSB     =   11      ;

reg             rst,    clk,    en  ;
reg     [MSB-1:0]       i_inc       ;
wire    [MSB-1:0]       o_pc        ;

initial begin
    
    en          =       1'b0        ;
    rst         =       1'b1        ;
    clk         =       1'b1        ;
    i_inc       =       11'b1010    ;
    
    #10
    rst         =       1'b0        ;
    
    #10
    en          =       1'b1        ;
    
    #10
    en          =       1'b0        ;
    
    #100
    clk         =       1'b1        ;
    
    $finish;
end

always begin
    #1
    clk = ~clk;
end

program_counter
#(
    .MSB        (MSB)
)    PCPC
(
    .i_rst      (rst)           ,
    .i_clk      (clk)           ,
    .enable     (en)            ,
    .i_inc      (i_inc)         ,
    .o_pc       (o_pc)
);
endmodule
