module alu (
    input [15:0] a,
    input [15:0] b,
    input [2:0] ALUControl,
    output reg [15:0] Result,
    output wire [3:0] ALUFlags   
);

    wire negative, zero, carry, overflow; // define wire for each flag (n,z,c,v)
    wire [1:0] condinvb;
    wire [16:0] sum;

    assign condinvb = ALUControl[0] ? ~b : b;
    assign sum = a + condinvb + ALUControl[0];
    wire[15:0] multiplier_result;

    // Instantiate the fmul module
    fmul uut_mult (
        .A(a),
        .B(b),
        .result(multiplier_result)
    );

    // ALU and multiplier functionality
    always @* begin
        casex (ALUControl[2:0])
            3'b00?: Result = a + (ALUControl[0] ? ~b : b) + ALUControl[0]; // ADDER: two's complement
            3'b010: Result = a & b;
            3'b011: Result = a | b;
            3'b100: Result = a << b; // LSL
            3'b101: Result = a >> b; // LSR 
            3'b111: Result = multiplier_result; // Assuming you want the lower 8 bits of the multiplier result
            default: Result = 16'b0;
        endcase
    end

    // Flags: result -> negative, zero
    assign negative = Result[15];
    assign zero = (Result == 16'b0);
    // Flags: additional logic -> v, c
    assign carry = (ALUControl[1] == 1'b0) & sum[16];
    assign overflow = (ALUControl[1] == 1'b0) & ~(a[15] ^ b[15] ^ ALUControl[0]) & (a[15] ^ sum[15]);
    assign ALUFlags = {negative, zero, carry, overflow};

endmodule