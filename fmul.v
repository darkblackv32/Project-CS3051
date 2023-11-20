module fmul (
    input [7:0] A,
    input [7:0] B,
    output reg [7:0] result
);

    // Formato de los operandos en punto flotante de 8 bits
    parameter SIGN_SIZE = 1;
    parameter EXPONENT_SIZE = 4; 
    parameter MANTISSA_SIZE = 3;

    reg [SIGN_SIZE-1:0] sign_a, sign_b;
    reg [EXPONENT_SIZE-1:0] exponent_a, exponent_b, exponent_result;
    reg [MANTISSA_SIZE-1:0] mantissa_a, mantissa_b, mantissa_result;
    
    reg [7:0] m1, m2;
    reg [10:0] temp_mantisa;
    reg [9:0] mantisa;

    parameter ONE = 8'h7E; // Ajustado a 8 bits

    always @* begin
        // Extraer el signo, el exponente y la mantisa de los operandos
        sign_a = A[7];
        sign_b = B[7];
        exponent_a = A[6:3];
        exponent_b = B[6:3];
        mantissa_a = A[2:0];
        mantissa_b = B[2:0];

        // Inicializar el resultado
        result = 8'h0;

        // Resultado de la multiplicación
        if (A[7:3] == 3'b0 || B[7:3] == 3'b0) begin
            result = 8'h0;
        end else if (A[7:0] == ONE) begin
            result = B;
            result[7] = A[7] ^ B[7]; //  Set sign
        end else if (B[7:0] == ONE) begin
            result = A;
            result[7] = A[7] ^ B[7]; //  Set sign
        end else begin
            // Continuación de la implementación de la multiplicación y normalización
            exponent_result = exponent_a + exponent_b - 4'b1111;
            m1 = {1'b1, mantissa_a};
            m2 = {1'b1, mantissa_b};

            // Multiplicación
            temp_mantisa = m1 * m2;

            // Normalización
            mantissa_result = temp_mantisa[10:2];
            if (mantissa_result[7] == 1) begin
                mantissa_result = mantissa_result + 2;
            end

            // Asignamos el resultado final
            result[7] = sign_a ^ sign_b;
            result[6:3] = exponent_result;
            result[2:0] = mantissa_result;
        end
    end
endmodule
