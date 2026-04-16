// Outputs the decimal tens and ones digits for a given binary number bin.
//
// Ports:
//  bin       [6:0] - Binary input, 0-99
//  tens      [3:0] - decimal tens digit (BCD)
//  ones      [3:0] - decimal ones digit (BCD)

`timescale 1ns / 1ps

module binary_to_bcd (
    input  logic [6:0] bin,
    output logic [3:0] tens,
    output logic [3:0] ones
);
  assign tens = 4'(bin / 7'd10);
  assign ones = 4'(bin - 7'(tens * 10));
endmodule
