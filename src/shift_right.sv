module shift_right #(
    data_length = 32
) (
    input IR, input [$clog2(data_length) -1:0] shift, input [data_length - 1:0] B,
    output [data_length - 1:0] H
);
wire[($clog2(data_length)):0][data_length - 1:0] muxconnector;

genvar i, j, k;
generate
    
for (j = 0; j < ($clog2(data_length)) ; j = j + 1) begin
    for (i = 0; i < data_length ; i = i + 1 ) begin
        if(i - 2**j >= 0)
            mux_2to1 mx(.in_mux_x(muxconnector[j][i - 2**j]), .in_mux_y(muxconnector[j][i]), .s(shift[j]), .o_mux(muxconnector[j+ 1][i]));
        else
            mux_2to1 mx(.in_mux_x(IR), .in_mux_y(muxconnector[j][i]), .s(shift[j]), .o_mux(muxconnector[j+ 1][i]));
    end

end
    
endgenerate
assign {<<{muxconnector[0]}} =  B;
assign H = {<<{muxconnector[$clog2(data_length)]}}; 

endmodule