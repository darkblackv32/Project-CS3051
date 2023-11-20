`timescale 1ns/1ps

module tb_alu;

    // Inputs
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] ALUControl;

    // Outputs
    wire [7:0] Result;
    wire [3:0] ALUFlags;

    // Instantiate the alu module
    alu uut (
        .a(A),
        .b(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .ALUFlags(ALUFlags)
    );

    // Initial block for testbench
    initial begin
        // Test case 1: multiplication operation
        A = 8'b00010010; 
        B = 8'b00011001;
        ALUControl = 3'b111; // floating point multiplication
        #10;
        $display("Test Case 1: A = %b, B = %b, Result = %b, Flags = %b", A, B, Result, ALUFlags);

    end

endmodule
