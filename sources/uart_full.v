`timescale 10ns / 10ns

module uart_full    #(
    parameter   DBIT        =   16           ,
    parameter   SB_TICK     =   16          ,
    parameter   DIV         =   163         ,
    parameter   SIZ         =   8
)
(
    input   wire    i_clock ,   i_reset     ,
    input   wire    [DBIT-1:0]  i_Data      ,
    input   wire                tx_start    ,
    output  wire    tx_done ,   tx
);

wire        baud_gen_line       ;

baud_gen    #(
    .N              (SIZ)                   ,
    .M              (DIV)
)   tickGen     (
    .i_clk          (i_clock)               ,
    .i_reset        (i_reset)               ,
    .o_max_tick     (s_tick)
);

uart_tx         #(
    .DBIT           (DBIT)                  ,
    .SB_TICK        (SB_TICK)
)   transmitter (
    .clk            (i_clock)               ,
    .reset          (i_reset)               ,
    .tx_start       (tx_start)              ,
    .s_tick         (s_tick)                ,
    .din            (i_Data)                ,
    .tx_done        (tx_done)               ,
    .tx             (tx)
);

endmodule
