`timescale 10ns / 10ns

module dm_ram   #(

    parameter       MEM_SIZE        =   9       ,
    parameter       WORD_WIDTH      =   16      ,
    parameter       ADDR_LENGTH     =   11      ,
    parameter       DATA_LENGTH     =   16
)
(
    input   wire    [ADDR_LENGTH-1:0]   i_Addr  ,
    input   wire                        Wr      ,
    input   wire                        Rd      ,
    input   wire    [DATA_LENGTH-1:0]   i_Data  ,
    output  reg     [DATA_LENGTH-1:0]   o_Data
);

reg [WORD_WIDTH-1:0]    RAM_mem[0:MEM_SIZE-1]   ;

initial
    begin
        $readmemb("C:/Users/flopp/TP3/TP3.srcs/sources_1/imports/Escritorio/dataMemory.list", RAM_mem)    ;
    end
/*
always  @(Wr,   i_Addr, i_Data)
    begin
        if  (Wr)
            RAM_mem[i_Addr] <=  i_Data          ;   
    end
    */
    /*
always  @(Wr    or  i_Addr)
    begin
        if  (Wr)
            RAM_mem[i_Addr] <=  i_Data          ;
        o_Data  =   RAM_mem[i_Addr]         ;
    end*/
always  @(posedge   Wr)
begin
    RAM_mem[i_Addr] <=  i_Data          ;
end

always  @(Rd,   i_Addr, RAM_mem[i_Addr])
    begin
        if (Rd)
            o_Data          <=  RAM_mem[i_Addr] ;
        else
            o_Data          <=  0               ;
    end

endmodule