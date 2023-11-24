module testbench;
	reg clk;
	reg reset;
	wire [31:0] WriteData;
	wire [31:0] DataAdr;
	wire  MemWrite;
	top dut(
		.clk(clk),
		.reset(reset),
		.WriteData(WriteData),
		.Adr(DataAdr),
		.MemWrite(MemWrite)
	);
	initial begin
	  $dumpfile("multi_tb.vcd");
	  $dumpvars(0, testbench);
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
	always @(negedge clk) begin
		if (MemWrite)
			if (DataAdr === 100 & WriteData === 20) begin
				$display("Simulation succeeded");
				$stop;
				end
			else if (WriteData !== 20) begin
				$display("Simulation failed");
				$display("DataAdr: %b, WriteData: %b, MemWrite: %b", DataAdr, WriteData, MemWrite);
				$stop;
			end

	end
endmodule


