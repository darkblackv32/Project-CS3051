// //
// `timescale 1ns / 1ps
// module controller_testbench();
//
//   reg         clk;
//   reg         reset;
//   reg [31:12] Instr;
//   reg [3:0]   ALUFlags;
//   wire         PCWrite;
//   wire         MemWrite;
//   wire         RegWrite;
//   wire         IRWrite;
//   wire         AdrSrc;
//   wire [1:0]   RegSrc;
//   wire [1:0]   ALUSrcA;
//   wire [1:0]   ALUSrcB;
//   wire [1:0]   ResultSrc;
//   wire [1:0]   ImmSrc;
//   wire [1:0]   ALUControl;
//   
//
//   // instantiate device to be tested
//   controller dut(.clk(clk),
// 	.reset(reset),
// 	.Instr(Instr),
// 	.ALUFlags(ALUFlags),
// 	.PCWrite(PCWrite),
// 	.MemWrite(MemWrite),
// 	.RegWrite(RegWrite),
// 	.IRWrite(IRWrite),
// 	.AdrSrc(AdrSrc),
// 	.RegSrc(RegSrc),
// 	.ALUSrcA(ALUSrcA),
// 	.ALUSrcB(ALUSrcB),
// 	.ResultSrc(ResultSrc),
// 	.ImmSrc(ImmSrc),
// 	.ALUControl(ALUControl)
// );
//   
//   // initialize test
//   // initial
//   //   begin
//   //     reset <= 1; # 15; reset <= 0;
//   //   end
//   	initial begin
// 	  $dumpfile("controller_testbench.vcd");
// 	  $dumpvars(0, controller_testbench);
// 		// reset <= 1;
// 		// #(22)
// 		// 	;
// 		// reset <= 0;
//      reset <= 1; # 15; reset <= 0;
//
// 		#2000 $finish;
// 	end
//
//
//   // generate clock to sequence tests
//
// 	always begin
// 		clk <= 1;
// 		#(5)
// 			;
// 		clk <= 0;
// 		#(5)
// 			;
// 	end
//
//   //Generate test signals
//   initial
// 	begin
// 	  #10
// 	  Instr = 20'b11100010100000100001; //ADD R1, R2, #2
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;		
// 	  #40;
// 	  Instr = 20'b11100000010000110100; //SUB R4, R3, R5
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;
// 	  #40;
// 	  Instr = 20'b11100000000100100111; //ANDS R7, R2, R3
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;
// 	  #40;
// 	  Instr = 20'b00010011100000010010; //ORNE R2, R1, #5
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;
// 	  #40;
// 	  Instr = 20'b11100101100100010011; //LDR R3, [R1, #10]
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;
// 	  #50;
// 	  Instr = 20'b11100101100000100101; //STR R5, [R2, #2]
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;
// 	  #40;
// 	  Instr = 20'b11101010000000000000; //B
// 	  ALUFlags = 4'b0000; //{neg, zero, carry, overflow} = Flags;
// 	  #40;
// 	end
// endmodule
