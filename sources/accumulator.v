`timescale 10ns / 10ns

module accumulator  #(
    parameter       E_BITS  =   16
)
(
    input   wire    [E_BITS-1:0]    i_mux   ,
    input   wire        i_clock ,   i_reset ,
    input   wire                    enable  ,
    output  reg     [E_BITS-1:0]    o_acc
);

always  @(negedge i_clock)
    begin
        if(i_reset)
            o_acc       <=      16'b0        ;
        else if  (enable)
            o_acc       <=      i_mux        ;
    end

endmodule