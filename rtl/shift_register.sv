`timescale 1ns / 1ps

module shift_register (
    input  logic clk,
    input  logic in,
    output logic out
);
  initial out = 1'b0;
  always_ff @(posedge clk) out <= in;
endmodule
