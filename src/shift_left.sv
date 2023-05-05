module shift_left #(
    data_length = 32
) (
    input IL, [$clog2(data_length) -1:0] shift, [data_length - 1:0] B,
    output [data_length - 1:0] H
);
wire[$clog2(data_length):0][data_length - 1:0] muxconnector;


genvar i, j, k;
generate
    
for (j = 0; j < ($clog2(data_length)) ; j = j + 1) begin
    for (i = 0; i < data_length ; i = i + 1 ) begin
        if(i - 2**j >= 0)
            mux_2to1 mx(.in_mux_x(muxconnector[j][i - 2**j]), .in_mux_y(muxconnector[j][i]), .s(shift[j]), .o_mux(muxconnector[j+ 1][i]));
        else
            mux_2to1 mx(.in_mux_x(IL), .in_mux_y(muxconnector[j][i]), .s(shift[j]), .o_mux(muxconnector[j+ 1][i]));
    end

end
    
endgenerate
assign muxconnector[0] = B ;
assign H = muxconnector[$clog2(data_length)]; 

/*
mux_2to1 mx01(.in_mux_x(IL),               .in_mux_y(muxconnector[0][0]), .s(shift[0]), .o_mux(muxconnector[1][0]));
mux_2to1 mx02(.in_mux_x(muxconnector[0][0]), .in_mux_y(muxconnector[0][1]), .s(shift[0]), .o_mux(muxconnector[1][1]));
mux_2to1 mx03(.in_mux_x(muxconnector[0][1]), .in_mux_y(muxconnector[0][2]), .s(shift[0]), .o_mux(muxconnector[1][2]));
mux_2to1 mx04(.in_mux_x(muxconnector[0][2]), .in_mux_y(muxconnector[0][3]), .s(shift[0]), .o_mux(muxconnector[1][3]));

mux_2to1 mx11(.in_mux_x(IL),               .in_mux_y(muxconnector[1][0]), .s(shift[1]), .o_mux(muxconnector[2][0]));
mux_2to1 mx12(.in_mux_x(IL),               .in_mux_y(muxconnector[1][1]), .s(shift[1]), .o_mux(muxconnector[2][1]));
mux_2to1 mx13(.in_mux_x(muxconnector[1][0]), .in_mux_y(muxconnector[1][2]), .s(shift[1]), .o_mux(muxconnector[2][2]));
mux_2to1 mx14(.in_mux_x(muxconnector[1][1]), .in_mux_y(muxconnector[1][3]), .s(shift[1]), .o_mux(muxconnector[2][3]));
assign B = muxconnector[0];
assign H = muxconnector[2]; 
*/
endmodule