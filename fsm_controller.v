module fsm_controller(clk,next,dat,result,flags);
    input clk,next;
    input [15:0]dat;
    output [15:0] result;
    output [3:0]flags;  

    reg [1:0] state, nextstate;

    reg[15:0] A,B;
    reg[2:0] operation;
    parameter getOperator = 2'b00;
    parameter setA = 2'b01;
    parameter setB = 2'b10;
    parameter calc = 2'b11;

    //INSTANCIATE ALU HERE
    alu aluInstance(A,B,operation,result,flags);


    // state register
    always @ (posedge clk)
        state <= nextstate;


    always @ (*) // next state logic
        case (state)
            getOperator: 
                if (next) nextstate = setA;
                else nextstate = getOperator;
            setA:
                if (next) begin
                    nextstate = setB;
                    A = dat;
                end
                else nextstate = setA;
            setB:
                if (next) begin
                    nextstate = calc;
                    B = dat;
                end
                else nextstate = setB;
            calc:
                if (next) nextstate = getOperator;
                else nextstate = calc;

        endcase
        // output logic
        assign result = {16{(state == calc)}} && result ;
endmodule
