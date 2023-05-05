module shift_tb (
);
    
    reg [4:0] shift;
    reg [1:0] S;
    reg IRL;
    reg [31:0] B;
    wire [31:0] H_right, H_left, H_shifter;
    integer index;
    shift_right sr(.IR(IRL), .shift(shift), .B(B), .H(H_right));
    shift_left sl(.IL(IRL), .shift(shift), .B(B), .H(H_left));
    shifter s(.S(S),.shift(shift), .B(B), .H(H_shifter));

    initial begin
        B = 32'd10;
        S = 2'b00;
        IRL = 0;
        for (index = 0  ;index < 6 ; index = index + 1 ) begin
            shift = index;
            #20;
        end
        S = 2'b10;
        IRL = 0;
                for (index = 0  ;index < 6 ; index = index + 1 ) begin
            shift = index;
            #20;
        end
        S= 2'b11;
        IRL = B[31];
     for (index = 0  ;index < 6 ; index = index + 1 ) begin
            shift = index;
            #20;
        end
        $finish;     
    end
    /*
    reg [1:0] shift;
    reg IRL = 0;
    reg [3:0] B;
    wire [3:0] H_right, H_left;
    integer index;
    //shift_right sr(.IR(IRL), .shift(shift), .B(B), .H(H_right));
    shift_left #(.data_length(4)) sl(.IL(IRL), .shift(shift), .B(B), .H(H_left));

    initial begin
        B = 4'd5;
        
        for (index = 0  ;index < 4; index = index + 1 ) begin
            shift = index;
            #20;
        end
    end*/
endmodule