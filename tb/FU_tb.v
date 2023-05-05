module FU_tb ();

    reg [31:0] A, B;
    reg [3:0] FS;
    wire [31:0] S;
    wire  [3:0] ZCNVFlags;
    
    integer index = 0;
    
    FunctionUnit fu(.A(A), .B(B), .FS(FS), .S(S), .ZCNVFlags(ZCNVFlags));


    parameter 
    ADD = 4'b0000,
    SUB = 4'b0001,
    SLL = 4'b0010,
    SLT = 4'b0100,
    SLTU = 4'b0110,
    XOR = 4'b1000,
    SRL = 4'b1010,
    SRA = 4'b1011,
    OR = 4'b1100,
    AND = 4'b1110;

    initial begin
    A = 32'h00000007;
    B = 32'h1;
    gobrrr(ADD);
    gobrrr(SUB);
    gobrrr(SLL);
    gobrrr(SLTU);
    gobrrr(XOR);
    gobrrr(SRL);
    gobrrr(SRA);
    gobrrr(OR);
    gobrrr(AND);
    A = 32'h7FFFFFFF;
    B = 32'h1;
    gobrrr(ADD);
    gobrrr(SUB);
    gobrrr(SLL);
    gobrrr(SLTU);
    gobrrr(XOR);
    gobrrr(SRL);
    gobrrr(SRA);
    gobrrr(OR);
    gobrrr(AND);
    A = 32'hFFFFFFFF;
    B = 32'hFFFFFFFF;
    gobrrr(ADD);
    gobrrr(SUB);
    gobrrr(SLL);
    gobrrr(SLTU);
    gobrrr(XOR);
    gobrrr(SRL);
    gobrrr(SRA);
    gobrrr(OR);
    gobrrr(AND);


    /*
    
    repeat(100) begin
        Cin = index %2;
        A = $random % 100;
        B = $random % 100;
        #1700;
        index = index + 1;
        $display("A = %0d, B = %0d, Sum= %0d, index = %0d", A, B, S, index);
        if(A + B != S)
        $display("Error");
        


    end
    */
    
    $finish;
    end

    task gobrrr;
    input [3:0] instr;
    begin
    FS = instr;
    #30;
    end
    endtask
endmodule