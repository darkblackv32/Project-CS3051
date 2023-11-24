module decode (
	clk,
	reset,
	Op,
	Funct,
	Rd,
	FlagW,
	PCS,
	NextPC,
	RegW,
	MemW,
	IRWrite,
	AdrSrc,
	ResultSrc,
	ALUSrcA,
	ALUSrcB,
	ImmSrc,
	RegSrc,
	ALUControl
);
	input wire clk;
	input wire reset;
	input wire [1:0] Op;
	input wire [5:0] Funct;
	input wire [3:0] Rd;
	output reg [1:0] FlagW;
	output wire PCS;
	output wire NextPC;
	output wire RegW;
	output wire MemW;
	output wire IRWrite;
	output wire AdrSrc;
	output wire [1:0] ResultSrc;
	output wire [1:0] ALUSrcA;
	output wire [1:0] ALUSrcB;
	output wire [1:0] ImmSrc;
	output wire [1:0] RegSrc;
	output reg [2:0] ALUControl;
	wire Branch;
	wire ALUOp;

	// Main FSM
	mainfsm fsm(
		.clk(clk),
		.reset(reset),
		.Op(Op),
		.Funct(Funct),
		.IRWrite(IRWrite),
		.AdrSrc(AdrSrc),
		.ALUSrcA(ALUSrcA),
		.ALUSrcB(ALUSrcB),
		.ResultSrc(ResultSrc),
		.NextPC(NextPC),
		.RegW(RegW),
		.MemW(MemW),
		.Branch(Branch),
		.ALUOp(ALUOp)
	);

	// ADD CODE BELOW
	// Add code for the ALU Decoder and PC Logic.
	// Remember, you may reuse code from previous labs.
	// ALU Decoder
	always @(*)
		if (ALUOp) begin // which Data-processing Instr?
			case(Funct[4:1])
				4'b0100: ALUControl = 3'b00?; // ADDER
				4'b0010: ALUControl = 3'b010; // AND
				4'b0000: ALUControl = 3'b011; // ORR
				4'b1100: ALUControl = 3'b100; // LSL
				4'b1110: ALUControl = 3'b101; // LSR
				4'b1011: ALUControl = 3'b110; // MUL
				// MUL DOES NOT USES IMMEDIATES ONLY REGISTERS
				// COND 00 X 1011 S Rn Rd 00000000 Rm
				default: ALUControl = 3'bx; // unimplemented
			endcase
			
			//FMUL does NOT SET FLAGS
			FlagW[1] = Funct[0] & (ALUControl != 3'b001); // update N & Z flags if S bit is set
			FlagW[0] = Funct[0] & (ALUControl == 3'b000 | ALUControl == 3'b001); // update C & V flags if S bit is set
		end else begin
			ALUControl = 3'b000; // add for non data-processing instructions
			FlagW = 3'b000; // don't update Flags
		end

	// PC Logic
 	assign PCS = ((Rd == 4'b1111) & RegW) | Branch;  //PONER LO DEL LABO PASADO

	// Add code for the Instruction Decoder (Instr Decoder) below.
	// Recall that the input to Instr Decoder is Op, and the outputs are
	// ImmSrc and RegSrc. We've completed the ImmSrc logic for you.

	// Instr Decoder
	assign ImmSrc = Op;
	assign RegSrc[0] = (Op == 2'b10); // read PC on Branch
	assign RegSrc[1] = (Op == 2'b01); // read Rd on STR 
endmodule
