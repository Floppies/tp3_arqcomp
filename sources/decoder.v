`timescale 10ns / 10ns

module decoder  #(
    parameter       OPBTS   =   5
)
(
    input   wire    i_rst   ,   i_clk   ,
    input   wire    [OPBTS-1:0] op_code ,   //  Codigo de la instruccion que viene en los bits mas significativos
    output  reg     [1:0]       sel_A   ,   //  Elige el valor del acumulador en el DATAPATH
    output  reg                 sel_B   ,   //  Elige el valor de la segunda entrada de la ALU en el DATAPATH
    output  reg                 w_acc   ,   //  Habilita la escritura el acumulador en el DATAPATH
    output  reg                 w_ram   ,   //  Habilita la escritura en la memoria de datos (RAM)
    output  reg                 w_pc    ,   //  Habilita la escritura del PC
    //output  reg                 r_pc    ,   //  Resetea al PC
    output  reg                 h_flg   ,
    output  reg                 r_ram   ,   //  Habilita la lectura de la memoria de datos (RAM)
    output  reg                 o_op        //  Operacion que se va a realizar en la ALU
);

//  Codigo de Operacion
localparam  [4:0]
    HLT         =       5'b00000    ,   //  Halt
    STO         =       5'b00001    ,   //  Store Variable
    LD          =       5'b00010    ,   //  Load Variable
    LDI         =       5'b00011    ,   //  Load Immediate
    ADD         =       5'b00100    ,   //  Add Variable
    ADDI        =       5'b00101    ,   //  Add Immediate
    SUB         =       5'b00110    ,   //  Substract Variable
    SUBI        =       5'b00111    ;   //  Substract Immediate
    
//reg         halt_flag       ;   //  Bandera que para el decodificador despues de una instruccion de HALT


//  Modulo para modificar sel_A
always  @(op_code)
begin
    case    (op_code)
        LD:
            sel_A       <=      2'b0    ;
        LDI:
            sel_A       <=      2'b1    ;
        ADD:
            sel_A       <=      2'b10   ;
        ADDI:
            sel_A       <=      2'b10   ;
        SUB:
            sel_A       <=      2'b10   ;
        SUBI:
            sel_A       <=      2'b10   ;
        default:
            sel_A       <=      2'b0    ;
    endcase
end
        
//  Modulo para modificar sel_B
always  @(op_code)
begin
    sel_B       <=      1'b0    ;
    case    (op_code)
        ADDI:
            sel_B       <=      1'b1    ;
        SUBI:
            sel_B       <=      1'b1    ;
        default:
            sel_B       <=      1'b0    ;
    endcase       
end

//  Modulo para modificar o_op
always  @(op_code)
begin
    case    (op_code)
        SUB:
            o_op        <=      1'b1    ;
        SUBI:
            o_op        <=      1'b1    ;
        default:
            o_op        <=      1'b0    ;
    endcase
end

//  Modulo para habilitar la lectura de la ram
always  @(i_clk, op_code)
begin
    if  (~i_clk)
        r_ram       <=      1'b0    ;
    else
        case    (op_code)
            LD:
                r_ram       <=      1'b1    ;
            ADD:
                r_ram       <=      1'b1    ;
            SUB:
                r_ram       <=      1'b1    ;
            default:
                r_ram       <=      1'b0    ;
        endcase
end

//  Modulo para modificar w_acc
always  @(i_clk,    op_code)
begin
    /*if  (i_clk)
        w_acc       <=      1'b0    ;
    else*/
        case    (op_code)
            HLT:
                w_acc       <=      1'b0    ;
            STO:
                w_acc       <=      1'b0    ;
            default:
                w_acc       <=      1'b1    ;
        endcase
end

//  Modulo para modificar w_ram
always  @(i_clk,    op_code)
begin
    if  (i_clk)
        w_ram       <=      1'b0    ;
    else
        case    (op_code)
            STO:
                w_ram       <=      1'b1    ;
            default:
                w_ram       <=      1'b0    ;
        endcase
end

//  Modulo para modificar w_pc
always  @(i_clk,    op_code, h_flg)
begin
    if  (i_clk)
        w_pc        <=      1'b0    ;
    else
    begin
        if  (~h_flg)
        begin
            case    (op_code)
                HLT:
                    w_pc        <=      1'b0    ;
                default:
                    w_pc        <=      1'b1    ;
            endcase
        end
        else
            w_pc        <=      1'b0    ;
    end
end

//  Modificar la bandera de halt
always  @(i_clk, i_rst, op_code)
begin
    if(i_rst)
            h_flg       <=      1'b0    ;
    else if(i_clk   &&  op_code == HLT)
            h_flg       <=      1'b1    ;
end

endmodule