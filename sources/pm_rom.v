`timescale 10ns / 10ns

module pm_rom   #(

    parameter       MEM_SIZE        =   9       ,
    parameter       WORD_WIDTH      =   16      ,
    parameter       ADDR_LENGTH     =   11      ,
    parameter       DATA_LENGTH     =   16
)
(
    input   wire    [ADDR_LENGTH-1:0]   i_Addr  ,
    output  reg     [DATA_LENGTH-1:0]   o_Data
);

reg [WORD_WIDTH-1:0]    ROM_mem[0:MEM_SIZE-1]   ;

initial
    begin
        $readmemb("C:/Users/flopp/OneDrive/Escritorio/programMemory.list", ROM_mem) ;
        //o_Data      =       ROM_mem[i_Addr]     ;
    end

always  @(i_Addr)
    begin
        o_Data      <=      ROM_mem[i_Addr]     ;
    end
endmodule
