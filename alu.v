module alu (
    input [7:0] a,
    input [7:0] b,
    input [2:0] ALUControl,
    output reg [7:0] Result,
    output wire [3:0] ALUFlags
);

    wire negative, zero, carry, overflow; // define wire for each flag (n, z, c, v)
    wire [8:0] sum;
    wire [7:0] multiplier_result;

    // Instantiate the fmul module
    fmul uut_mult (
        .A(a),
        .B(b),
        .result(multiplier_result)
    );

    // ALU and multiplier functionality
    always @* begin
        case (ALUControl[2:0])
            3'b000: Result = a + (ALUControl[0] ? ~b : b) + ALUControl[0]; // ADDER: two's complement
            3'b111: Result = multiplier_result[7:0]; // Assuming you want the lower 8 bits of the multiplier result
            3'b010: Result = a & b;
            3'b011: Result = a | b;
            3'b100: Result = a << b; // LSL
            3'b101: Result = a >> b; // LSR 
            default: Result = 8'b0;
        endcase
    end

    // Flags: result -> negative, zero
    assign negative = Result[7];
    assign zero = (Result == 8'b0);

    // Flags: additional logic -> v, c
    assign carry = (ALUControl[1] == 1'b0) & sum[8];
    assign overflow = (ALUControl[1] == 1'b0) & ~(a[7] ^ b[7] ^ ALUControl[0]) & (a[7] ^ sum[7]);

    assign ALUFlags = {negative, zero, carry, overflow};

endmodule
