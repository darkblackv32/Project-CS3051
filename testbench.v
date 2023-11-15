module testbench;

  reg [31:0] a, b;
  reg [2:0] ALUControl;
  wire [31:0] Result;
  wire [3:0] ALUFlags;
	
//Solo instancie el alu
  alu dut (
    .a(a),
    .b(b),
    .ALUControl(ALUControl),
    .Result(Result),
    .ALUFlags(ALUFlags)
  );

  initial begin
	//LSR Y LSL
	a = 10;
	b = 1;
	ALUControl = 3'b101;
	#10;
	$display("a = %d, b = %d, ALUControl = %b, Result = %h, ALUFlags = %b", a, b, ALUControl, Result, ALUFlags);
	a = 10;
	b = 1;
	ALUControl = 3'b100;
	#10;
	$display("a = %d, b = %d, ALUControl = %b, Result = %h, ALUFlags = %b", a, b, ALUControl, Result, ALUFlags);
    
  end

endmodule
