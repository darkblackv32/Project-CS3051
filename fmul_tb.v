`timescale 1ns/1ps

module testbench;

    // Inputs
    reg [15:0] A;
    reg [15:0] B;

    // Outputs
    wire [15:0] result;

    // Instantiate the fmul module
    fmul uut (
        .A(A),
        .B(B),
        .result(result)
    );

    // Initial block for testbench
    initial begin
        // Test case 1
        A = 16'h4000; // 2.0
        B = 16'h4000; // 2.0
        #10; // Wait for 10 time units
        $display("A = %h, B = %h, Result = %h", A, B, result);

        // Test case 2
        A = 16'hC000; // 1.0
        B = 16'hC000; // -2.0
        #10; // Wait for 10 time units
        $display("A = %h, B = %h, Result = %h", A, B, result);

        $stop; // Stop simulation
    end

endmodule
