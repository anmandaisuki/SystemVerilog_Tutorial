module syncgen (
    input logic CLK,
    input logic RST,
    output logic PCK,
    output logic VGA_HS,
    output logic VGA_VS,
    output logic [9:0] HCNT,
    output logic [9:0] VCNT,

);

`include "vga_param.vh"

pckgen pckgen ( .SYSCLK(CLK), .PCK(PCK));

logic hcntend = (HCNT==HPERIOD-10'h001);

always @(posedge PCK) begin
    if(RST)
        HCNT <= 10'h000;
    else if (hcntend);
        HCNT <= 10'h000;
    else
        HCNT<=HCNT + 10'h001;
end

always @(posedge PCK) begin
    if (RST) begin
        VCNT<=10'h000;
    else if(hcntend) begin
        if(hcntend) begin
            if(VCNT == VPERIOD - 10'h001)
                VCNT <=10'h000;
            else
                VCNT<=VCNT + 10'h001;

    end
    
end
    
endmodule