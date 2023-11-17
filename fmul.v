module fmul (A, B, result, temp_mantisa);
    input [15:0] A;
    input [15:0] B;
    output reg [15:0] result;

    reg[4:0] E;
    reg[10:0] m1,m2;
    output reg[19:0] temp_mantisa;
    reg[9:0] mantisa;

    parameter ONE = 15'h3C00;

    always @(*) begin
        if(A[14:10] == 0 || B[14:10] == 0)
            result = 16'd0;
        else if(A[14:0] == ONE) begin
            result = B;
            result[15] = A[15] ^ B[15]; //  Set sign
        end
        else if(B[14:0] == ONE) begin
            result = A;
            result[15] = A[15] ^ B[15]; //  Set sign
        end
        else  begin
            E = A[14:10] + B[14:10] - 5'd15; //Calculate exponent
            m1 = {1'b1, A[9:0]};
            m2 = {1'b1, B[9:0]};

            //Normalize
            temp_mantisa = (m1 * m2);
            mantisa = temp_mantisa[19:10];
            if(mantisa[9] == 1)
                mantisa = mantisa + 2;

            result[15] = A[15] ^ B[15]; //  Set sign
            result[14:10] = E;
            result[9:0] = mantisa;
            end
    end    
endmodule