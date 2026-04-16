// Seven-segment display decoder for hexadecimal digits.
//
// Parameters:
//  MAX             - maximum integer reached by the counter.
//  WIDTH           - bit_width used by count
//
// Ports:
//  enable          - When low, counter is disabled.
//  up              - When high, the counter increments to MAX before wrapping to 0.
//                    When low, the counter decrements to 0 before wrapping to MAX.
//  count           - current value of the counter.

`timescale 1ns / 1ps

module up_down_counter #(
    parameter int MAX   = 2,
    parameter int WIDTH = 2
) (
    input logic clk,
    input logic enable,
    input logic up,
    output logic [WIDTH-1:0] count
);
  localparam logic [WIDTH-1:0] Max = WIDTH'(MAX);
  initial count = WIDTH'(0);
  logic [WIDTH-1:0] next_count;
  always_ff @(posedge clk) if (enable) count <= next_count;
  always_comb
    if (up) next_count = (count == Max) ? WIDTH'(0) : count + WIDTH'(1);
    else next_count = (count == WIDTH'(0)) ? Max : count - WIDTH'(1);
endmodule
