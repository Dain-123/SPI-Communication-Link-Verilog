// testbench.sv
module tb_complete_spi;

    reg clk;
    reg reset;
    reg load_data;
    reg [7:0] data_to_send;
    
    wire interconnect_wire; // The single physical line connecting Tx to Rx
    wire [7:0] received_data;

    // Connect Transmitter
    spi_transmitter tx_inst (
        .clk(clk), .reset(reset), .load_data(load_data),
        .parallel_in(data_to_send), .serial_out(interconnect_wire)
    );

    // Connect Receiver directly to Transmitter's output wire
    spi_receiver rx_inst (
        .clk(clk), .reset(reset),
        .serial_in(interconnect_wire), .parallel_out(received_data)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd"); $dumpvars(0, tb_complete_spi);

        clk = 0; reset = 1; load_data = 0; data_to_send = 8'b0;
        #10; reset = 0;
        
        #10;
        data_to_send = 8'hA5; // Send Hex A5 (Binary: 10100101)
        load_data = 1;
        
        #10;
        load_data = 0; // Let the transmission run
        
        #90; // Wait for bits to stream through the single wire
        $finish;
    end
endmodule
