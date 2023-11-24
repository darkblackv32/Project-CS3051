//8-bit ALU for FPGA
module alu(input [31:0] a, b,
    input [2:0] ALUControl,
    output reg [31:0] Result,
    output wire [3:0] ALUFlags);

    wire neg, zero, carry, overflow;
    wire [31:0] condinvb;
    wire [32:0] sum;
    wire [15:0] multiplier;

    assign condinvb = ALUControl[0] ? ~b : b;
    assign sum = a + condinvb + ALUControl[0];

    fmul u1_fmul(
        .A(a[15:0]),
        .B(b[15:0]),
        .result(multiplier));

    always @(*) begin
        casex (ALUControl[2:0])
            3'b00?: Result = sum;
            3'b010: Result = a & b;
            3'b011: Result = a | b;
            3'b100: Result = {16'b0, multiplier};
            default: Result = sum;
        endcase
    end

    assign neg = Result[31] || (ALUControl == 3'b100 & multiplier[15]);
    assign zero = (Result == 32'b0);
    assign carry = (ALUControl[2:1] == 2'b00) & sum[32];
    assign overflow = (ALUControl[2:1] == 2'b00) & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);
    assign ALUFlags = {neg, zero, carry, overflow};
endmodule
