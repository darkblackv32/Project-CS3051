module fsm_controller(clk,next,dat,result);
    input clk,next;
    input [15:0]dat;
    output [15:0] result;
    reg[1:0] state, nextstate;

    reg[15:0] A,B;
    reg[2:0] operation;
    parameter getOperator = 2'b00;
    parameter setA = 2'b01;
    parameter setB = 2'b10;
    parameter calc = 2'b11;
    
    wire[15:0] buff;

    //INSTANCIATE ALU HERE
    alu aluInstance(A,B,operation,buff);
    
    // state register
    always @ (posedge clk) begin
        state <= nextstate;
    end
    
    always @ (*) begin // next state logic
        case (state)
            getOperator: 
                if (next) begin 
                    nextstate <= setA;
                    operation <= dat[2:0];
                end
                else nextstate <= getOperator;
            setA:
                if (next) begin
                    nextstate <= setB;
                    A <= dat;
                end
                else nextstate <= setA;
            setB:
                if (next) begin
                    nextstate <= calc;
                    B <= dat;
                end
                else nextstate <= setB;
            calc:
                if (next) nextstate <= getOperator;
                else nextstate <= calc;
            default:
                nextstate <= getOperator;
        endcase
     end
             
     assign result = {16{(state == calc)}} && buff; 
endmodule
