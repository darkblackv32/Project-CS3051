// ADD CODE BELOW
// Complete the datapath module below for Lab 11.
// You do not need to complete this module for Lab 10.
// The datapath unit is a structural SystemVerilog module. That is,
// it is composed of instances of its sub-modules. For example,
// the instruction register is instantiated as a 32-bit flopenr.
// The other submodules are likewise instantiated. 
module datapath (
	clk,
	reset,
	Adr,
	WriteData,
	ReadData,
	Instr,
	ALUFlags,
	PCWrite,
	RegWrite,
	IRWrite,
	AdrSrc,
	RegSrc,
	ALUSrcA,
	ALUSrcB,
	ResultSrc,
	ImmSrc,
	ALUControl
);
	input wire clk;
	input wire reset;
	output wire [31:0] Adr;
	output wire [31:0] WriteData;
	input wire [31:0] ReadData;
	output wire [31:0] Instr;
	output wire [3:0] ALUFlags;
	input wire PCWrite;
	input wire RegWrite;
	input wire IRWrite;
	input wire AdrSrc;
	input wire [1:0] RegSrc;
	input wire [1:0] ALUSrcA;
	input wire [1:0] ALUSrcB;
	input wire [1:0] ResultSrc;
	input wire [1:0] ImmSrc;
	input wire [2:0] ALUControl;
	wire [31:0] PCNext;
	wire [31:0] PC;
	wire [31:0] ExtImm;
	wire [31:0] SrcA;
	wire [31:0] SrcB;
	wire [31:0] toMuxB;
	wire [31:0] Result;
	wire [31:0] Data;
	wire [31:0] RD1;
	wire [31:0] RD2;
	wire [31:0] A;
	wire [31:0] ALUResult;
	wire [31:0] ALUOut;
	wire [3:0] RA1;
	wire [3:0] RA2;

	// Your datapath hardware goes below. Instantiate each of the 
	// submodules that you need. Remember that you can reuse hardware
	// from previous labs. Be sure to give your instantiated modules 
	// applicable names such as pcreg (PC register), adrmux 
	// (Address Mux), etc. so that your code is easier to understand.


  //Registers
  flopenr #(32) pcreg(clk, reset, PCWrite, PCNext, PC);
  flopenr #(32) instrreg(clk, reset, IRWrite, ReadData, Instr);
  flopr #(32)   datareg(clk, reset, ReadData, Data);
  flopr #(32)   rd1reg(clk, reset, RD1, A);
  flopr #(32)   rd2reg(clk, reset, RD2, WriteData);
  flopr #(32)   alureg(clk, reset, ALUResult, ALUOut);
  
  //Multiplexers
  mux2 #(32)    adrmux(PC, Result, AdrSrc, Adr);
  mux2 #(4)     ra1mux(Instr[19:16], 4'b1111, RegSrc[0], RA1);
  mux2 #(4)     ra2mux(Instr[3:0], Instr[15:12], RegSrc[1], RA2);  
  mux3 #(32)    srcAmux(A, PC, ALUOut, ALUSrcA, SrcA);
  mux3 #(32)    srcBmux(WriteData, ExtImm, 32'h0000_0004, ALUSrcB, SrcB);
  mux3 #(32)    alumux(ALUOut, Data, ALUResult, ResultSrc, Result);
  
  //Register File
  regfile  rf(clk, RegWrite, RA1, RA2, Instr[15:12], Result, Result, RD1, RD2); 
  
  //Extend
  extend   ext(Instr[23:0], ImmSrc, ExtImm);

  //Shifter
  shifter shft(WriteData, Instr[11:7],Instr[6:5], toMuxB);
  
  //ALU
  alu      alu(SrcA, SrcB, ALUControl, ALUResult, ALUFlags);

  assign PCNext = Result;
endmodule

