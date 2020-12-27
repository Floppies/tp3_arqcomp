`timescale 10ns / 10ns

module alu   #(
    parameter   E_BITS      =   16
)
(
    input   wire                    i_op    ,
    input   wire    [E_BITS-1:0]    op_1    ,
    input   wire    [E_BITS-1:0]    op_2    ,
    output  reg     [E_BITS-1:0]    o_res
);

always @(*)
    begin
        if  (i_op)
            o_res   <=  op_1    -   op_2    ;
        else
            o_res   <=  op_1    +   op_2    ;
    end
endmodule