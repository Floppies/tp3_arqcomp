`timescale 10ns / 10ns

module processor_tb #();

localparam  BITS        =   16                  ;
localparam  DTBITS      =   BITS    -   5       ;

//  Inputs
reg                     i_clock ,   i_reset     ;
reg     [BITS-1:0]      i_Data_ram, i_Data_rom  ;

//  Outputs
wire    [BITS-1:0]                  o_Data_ram  ;
wire    [DTBITS-1:0]    o_Addr_rom, o_Addr_ram  ;
wire                    Wr  ,       Rd          ;

initial
    begin
    
        //  Reset
        i_clock         =   1'b1        ;
        i_reset         =   1'b1        ;
        i_Data_ram      =   16'h0001    ;
        i_Data_rom      =   16'h1000    ;
        
        #10
        i_clock         =   1'b0        ;
        i_reset         =   1'b0        ;
        
        //  STO 2
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h0802    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  LD 2
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h1002    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  LDI 3
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h1803    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  ADD 1
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h2001    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  ADDI 2
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h2802    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  SUB 1
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h3001    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  SUBI 1
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h3801    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  HLT
        #10
        i_clock         =   1'b1        ;
        i_Data_rom      =   16'h0000    ;
        
        #10
        i_clock         =   1'b0        ;
        
        //  Ciclo de nada
        #10
        i_clock         =   1'b1        ;
        
        #10
        i_clock         =   1'b0        ;
            
    end

processor   #(
    .BITS           (BITS)          ,
    .DTBITS         (DTBITS)
)   PROCPROC
(
    .i_clock        (i_clock)       ,
    .i_reset        (i_reset)       ,
    .i_Data_rom     (i_Data_rom)    ,
    .i_Data_ram     (i_Data_ram)    ,
    .o_Data_ram     (o_Data_ram)    ,
    .o_Addr_rom     (o_Addr_rom)    ,
    .o_Addr_ram     (o_Addr_ram)    ,
    .Wr             (Wr)            ,
    .Rd             (Rd)
);
  
endmodule
