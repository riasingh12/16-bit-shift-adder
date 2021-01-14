`timescale 1 ns / 100 ps
module tb;
    reg clk, reset, load; //used in d flip flop
    reg [15:0] a, b, out; //output, input registers

    wire [15:0] op, contents_a, contents_b; //wires carrying the bits
    wire carry; //the carry and sum thingy carry

    shift_adder addr(clk, reset, load, a, b, contents_a, contents_b, op, carry); // the func from main code
    
    initial begin $dumpfile("test.vcd"); $dumpvars(0,tb); end //the test file and gtkwave file we made
    initial begin
        reset = 1'b1; // Resetting all the flip flops in the circuit cause self loop, so og value garbage = 1 bit thingy with value 0
        load = 1'b0; // load data from register signal= 1 bit thingy with value 1
        #5 // change after 5 nano second
        reset = 1'b0; //  1 bit thingy with value 0
        load = 1'b1; // 1 bit thingy with value 1
        a = 16'b0011100010101001; // Loading a number into register a=16 bit number with value
        b = 16'b1011110010011001; // Loading a number into register b=16 bit number with value
        #5 // after 5 nano second
        load = 1'b0; // Enabling shift for the registers
        #160 $finish; // finishes at 160 nano second
    end
    initial clk = 1'b1; always #5 clk =~ clk; // change clk from 0 to 1 & vice versa
endmodule
