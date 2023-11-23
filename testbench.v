module testbench;
	reg clk;
	reg reset;
	wire [31:0] WriteData;
	wire [31:0] Adr;
	wire MemWrite;
	top dut(
		.clk(clk),
		.reset(reset),
		.WriteData(WriteData),
		.Adr(Adr),
		.MemWrite(MemWrite)
	);
	initial begin
		reset <= 1;
		#(22)
			;
		reset <= 0;
	end
	always begin
		clk <= 1;
		#(5)
			;
		clk <= 0;
		#(5)
			;
	end		
	initial begin
		$dumpfile("gang.vcd");
		$dumpvars;
	end
endmodule