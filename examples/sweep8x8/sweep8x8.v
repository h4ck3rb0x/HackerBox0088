module top
(
    input clk,
    output [7:0] LEDrow,
    output [7:0] LEDcol 
);

localparam WAIT_TIME = 800000;
reg [7:0] rowBuff = 1;
reg [7:0] colBuff = 1;
reg [23:0] clockCounter = 0;

always @(posedge clk) begin
    clockCounter <= clockCounter + 1;
    if (clockCounter == WAIT_TIME) begin
        clockCounter <= 0;
        colBuff <= colBuff << 1;
        if (colBuff == 0) begin
            colBuff <= 1;
            rowBuff <= rowBuff << 1;
            if (rowBuff == 0) begin
                rowBuff <= 1;
            end
        end
    end
end

assign LEDrow[7:0] = ~rowBuff;
assign LEDcol[7:0] = colBuff;
endmodule
