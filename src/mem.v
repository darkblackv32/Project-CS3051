module mem (
	clk,
	we,
	a,
	wd,
	rd
);
	input wire clk;
	input wire we;
	input wire [31:0] a;
	input wire [31:0] wd;
	output wire [31:0] rd;
	// reg [31:0] RAM [0:63];
	// initial $readmemh("memfile.dat", RAM);
	// assign rd = RAM[a[31:0]]; // word aligned
	// always @(posedge clk)
	// 	if (we)
	// 		RAM[a[31:2]] <= wd;

    reg [7:0] RAM [0:1024]; // Memoria byteaddressable
    integer byte_index;

    initial $readmemh("memfile.dat", RAM);

    assign rd = {RAM[a+0], RAM[a+1], RAM[a+2], RAM[a+3]};

    always @(posedge clk)
        if (we) begin
            RAM[a+3] <= wd[7:0];
            RAM[a+2] <= wd[15:8];
            RAM[a+1] <= wd[23:16];
            RAM[a+0] <= wd[31:24];
        end
endmodule

