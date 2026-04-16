// Counter which increments to a specified maximum integer or decrements to 0, before wrapping.
//
// Parameters:
//  MAX             - Maximum integer reached by the counter.
//  WIDTH           - Bit_width of counter.
//
// Ports:
//  enable          - When low, counter is disabled.
//  up              - When high, the counter increments to MAX before wrapping to 0.
//                    When low, the counter decrements to 0 before wrapping to MAX.
//  count           - counter value, 0-MAX

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
