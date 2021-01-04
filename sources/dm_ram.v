`timescale 10ns / 10ns

module dm_ram   #(

    parameter       MEM_SIZE        =   9       ,
    parameter       WORD_WIDTH      =   16      ,
    parameter       ADDR_LENGTH     =   11      ,
    parameter       DATA_LENGTH     =   16
)
(
    input   wire    [ADDR_LENGTH-1:0]   i_Addr  ,
    input   wire                        i_clock ,
    input   wire                        Wr      ,
    input   wire                        Rd      ,
    input   wire    [DATA_LENGTH-1:0]   i_Data  ,
    output  reg     [DATA_LENGTH-1:0]   o_Data
);

reg [WORD_WIDTH-1:0]    RAM_mem[0:MEM_SIZE-1]   ;

always @(negedge i_clock)
begin
    if  (Wr)
        RAM_mem[i_Addr]     <=      i_Data      ;
end

always  @(negedge i_clock)
    begin
        if (Rd)
            o_Data          <=  RAM_mem[i_Addr] ;
        else
            o_Data          <=  0               ;
    end

endmodule