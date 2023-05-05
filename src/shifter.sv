module shifter (
    input [1:0] S,
    input [4:0] shift,
    input [31:0] B,
    output reg [31:0] H
);
    parameter 
    SLL = 2'b00,
    SRL = 2'b10,
    SRA = 2'b11;
    logic reg_IR;
    logic [31:0] reg_B, reg_H;
    shift_right #(.data_length(32)
    ) sr(.IR(reg_IR), .shift(shift), .B(reg_B), .H(reg_H));

    always_comb begin : instruction_select;
        case (S)
            SLL: begin
                reg_IR = 1'b0;
                //TODO iverilog does not support this reversing 
                //feature, we can use sv2v to see its verilog alt.
                //or try another way
                reg_B = {<<{B}};
                H = {<<{reg_H}};
            end
            SRL: begin
                reg_IR = 1'b0;
                reg_B = B;
                H = reg_H;
            end
            SRA: begin
                reg_IR = B[31];
                reg_B = B;
                H = reg_H;
            end
                 
        endcase
        
    end
    
endmodule
