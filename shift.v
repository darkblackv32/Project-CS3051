module Shift(
  input wire clk,
  input wire reset,
  input wire [31:0] data_in,
  input wire shift, //De 1 bit para seleccionar entre LSL, LSR
  output wire [31:0] data_out
);

  reg [31:0] shift_reg; //Registro que permite ver el valor de data_in ya desplazado

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_reg <= 32'b0;
    end 
    else begin
      case (shift)
        1'b0: shift_reg <= data_in << 8; // lsl
        1'b1: shift_reg <= data_in >> 8; // lsr
        default: shift_reg <= shift_reg; // No operation
      endcase
    end
  end

  assign data_out = shift_reg;

endmodule
