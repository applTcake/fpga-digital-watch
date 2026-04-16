// Modulo counter counting up to N, then wrapping to 0.
//
// Parameters:
//  N               - Maximum integer reached by the counter.
//  WIDTH           - Bit_width of counter.
//
// Ports:
//  rst             - When high, resets counter to 0. (Overrides enable)
//  enable          - When low, counter is disabled.
//  count           - counter value, 0-MAX

`timescale 1ns / 1ps

module mod_n_counter #(
    parameter int N = 4,
    parameter int WIDTH = 2
) (
    input logic clk,
    input logic rst,
    input logic enable,
    output logic [WIDTH-1:0] count
);
  localparam logic [WIDTH-1:0] MaxN = WIDTH'(N);
  initial count = WIDTH'(0);
  logic [WIDTH-1:0] next_count;
  always_ff @(posedge clk)
    if (rst) count <= WIDTH'(0);
    else if (enable) count <= next_count;
  always_comb next_count = (count == MaxN - 1) ? WIDTH'(0) : count + WIDTH'(1);
endmodule
