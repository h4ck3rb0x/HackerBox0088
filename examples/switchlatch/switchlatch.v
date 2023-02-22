module top
(
    input clk,
    input [7:0] switch,
    input [3:0] button,
    output [7:0] LEDrow,
    output [7:0] LEDcol 
);

localparam WAIT_TIME = 400000;
reg [7:0] colBuff = 0;
reg [7:0] row1Buff = 255;
reg [7:0] row2Buff = 255;
reg [7:0] row3Buff = 255;
reg [7:0] row4Buff = 255;
reg [7:0] rowOut = 0;
reg [23:0] clockCounter = 0;

always @(posedge button[0]) begin
    row1Buff <= switch;
end

always @(posedge button[1]) begin
    row2Buff <= switch;
end

always @(posedge button[2]) begin
    row3Buff <= switch;
end

always @(posedge button[3]) begin
    row4Buff <= switch;
end

always @(posedge clk) begin
    clockCounter <= clockCounter + 1;
    if (clockCounter == 100000) begin
        colBuff <= 1;
        rowOut <= row1Buff;
    end
    if (clockCounter == 200000) begin
        colBuff <= 2;
        rowOut <= row2Buff;
    end
    if (clockCounter == 300000) begin
        colBuff <= 4;
        rowOut <= row3Buff;
    end
    if (clockCounter == WAIT_TIME) begin
        clockCounter <= 0;
        colBuff <= 8;
        rowOut <= row4Buff;
    end
end

assign LEDrow[7:0] = ~colBuff;
assign LEDcol[7:0] = rowOut; 
endmodule
