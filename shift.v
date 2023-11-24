module Shift(
  input wire clk,
  input wire reset,
  input wire [31:0] data_in_a,
  input wire [31:0] data_in_b,
  input wire shift,
  output wire [31:0] data_out
);

  reg [31:0] shift_reg; // Register to hold the shifted data

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_reg <= 32'b0;
    end 
    else begin
      case (shift)
        1'b0: shift_reg <= data_in_a << data_in_b; // lsl
        1'b1: shift_reg <= data_in >> data_in_b; // lsr
        default: shift_reg <= shift_reg; // No operation
      endcase
    end
  end

  assign data_out = shift_reg;

endmodule
