`timescale 10ns / 10ns

module alu_tb();

localparam  E_BITS      =   16  ;

//  Inputs
reg     [E_BITS-1:0]    op_1    ;
reg     [E_BITS-1:0]    op_2    ;
reg                     i_op    ;

//  Output
wire    [E_BITS-1:0]    o_res   ;

initial
    begin
        op_1    =   16'b111     ;
        op_2    =   16'b010     ;
        i_op    =   1'b0        ;
        
        #50
        i_op    =   1'b1        ;
    end

alu
#(
    .E_BITS     (E_BITS)
)   ALUALU
(
    .op_1       (op_1)      ,
    .op_2       (op_2)      ,
    .i_op       (i_op)      ,
    .o_res      (o_res)
);

endmodule
