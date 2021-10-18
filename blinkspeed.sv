module blink (
    input logic CLK,
    input logic RST,
    input logic BTN;
    output logic [2:0] LED_RGB
);

logic btnon;

debounce d0 (
    .CLK,
    .RST,
    .BTNIN(BTN),
    .BTNOUT(btnon)
);

logic [1:0] speed;
always @(posedge CLK) begin
    if(RST)
        speed<=2'h0;
    else if(btnon)
        speed <= speed + 2'h1;
    
end

logic [26:0] cnt27;

always @(posedge CLK) begin
    if(RST)
        cnt27 <= 27h0;
    else
        cnt27 <= cnt27 + 27'h1;
    
end

logic ledcnten;

always begin
    case (speed)
        2'h0: ledcnten = (cnt27 == 27'h7ffffff);
        2'h1: ledcnten = (cnt27[25:0] == 26'h3ffffff);
        2'h2: ledcnten = (cnt27[24:0] == 25'h1ffffff);
        2'h3: ledcnten = (cnt27[23:0] == 24'hffffff);
         

        default: ledcnten = 1'b0;
    endcase
    
end

logic [2:0] cnt3;

always @(posedge CLK) begin
    if(RST)
        cnt3 <= 3'h0;
    else if (ledcnten)
        if(cnt3==3'd4)
            cnt3<=3'h0;
        else
            cnt3<=cnt3 + 3'h1;    
end

always begin 
    case(cnt3)
        3'd0: LED_RGB = 3'b100;
        3'd1: LED_RGB = 3'b010;
        3'd2: LED_RGB = 3'b001;
        3'd3: LED_RGB = 3'b111;
        3'd4: LED_RGB = 3'b000;
        default:LED_RGB = 3'b000;
    endcase

    
end
    
endmodule