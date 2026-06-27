// design.sv

// --- 1. TRANSMITTER (Pushes bits out one by one) ---
module spi_transmitter (
    input clk,
    input reset,
    input load_data,
    input [7:0] parallel_in,
    output reg serial_out
);
    reg [7:0] shift_register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_register <= 8'b00000000;
            serial_out     <= 1'b0;
        end 
        else if (load_data) begin
            shift_register <= parallel_in;
        end 
        else begin
            serial_out     <= shift_register[7];
            shift_register <= {shift_register[6:0], 1'b0};
        end
    end
endmodule


// --- 2. RECEIVER (Catches bits and re-assembles them) ---
module spi_receiver (
    input clk,
    input reset,
    input serial_in,            // Wire coming from Transmitter's serial_out
    output reg [7:0] parallel_out // The completely rebuilt 8-bit byte
);
    reg [7:0] recv_register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            recv_register <= 8'b00000000;
            parallel_out  <= 8'b00000000;
        end 
        else begin
            // Shift incoming bit into the rightmost spot, sliding older bits left
            recv_register <= {recv_register[6:0], serial_in};
            parallel_out  <= {recv_register[6:0], serial_in}; 
        end
    end
endmodule
