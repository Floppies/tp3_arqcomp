`timescale 10ns / 10ns

module sel_b_tb ();

localparam  E_BITS      =   16  ;

//  Inputs
reg     [E_BITS-1:0]    i_ram   ;
reg     [E_BITS-1:0]    i_ext   ;
reg                     sel_b   ;

//  Output
wire    [E_BITS-1:0]    o_mux   ;

initial
    begin
        i_ram   =   16'b111     ;
        i_ext   =   16'b010     ;
        sel_b   =   1'b0        ;
        
        #50
        sel_b   =   1'b1        ;
    end

selector_b
#(
    .E_BITS     (E_BITS)
)   SELBSELB
(
    .i_ext      (i_ext)     ,
    .i_Ram      (i_ram)     ,
    .sel_B      (sel_b)     ,
    .o_mux      (o_mux)
);

endmodule
