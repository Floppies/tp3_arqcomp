`timescale 10ns / 10ns

module sel_a_tb();

localparam  E_BITS      =   16  ;
localparam  S_BITS      =   2   ;

//  Inputs
reg     [E_BITS-1:0]    i_ram   ;
reg     [E_BITS-1:0]    i_ext   ;
reg     [E_BITS-1:0]    i_alu   ;
reg     [S_BITS-1:0]    sel_a   ;

//  Outputs
wire    [E_BITS-1:0]    o_mux   ;

initial
    begin
        i_ram   =   16'b1       ;
        i_ext   =   16'b0       ;
        i_alu   =   16'b10      ;
        sel_a   =   2'b0        ;
        #10
        sel_a   =   2'b1        ;
        #10
        sel_a   =   2'b10       ;
        
    end
    
selector_a
#(
    .E_BITS     (E_BITS)    ,
    .S_BITS     (S_BITS)
)   SELASELA
(
    .i_ext      (i_ext)     ,
    .i_Ram      (i_ram)     ,
    .i_alu      (i_alu)     ,
    .sel_A      (sel_a)     ,
    .o_mux      (o_mux)
);
endmodule
