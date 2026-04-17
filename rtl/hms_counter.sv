// Counter tracking hours, minutes and seconds, wrapping around every 24 hours.
//
// Ports:
//  enable          - When low, counter is disabled.
//  hours           - Hour counter (takes max value and bit-width from parameters N_HOURS and W_HOURS)
//  minutes         - Minute counter (takes max value and bit-width from parameters N_MINUTES and W_MINUTES)
//  seconds         - Second counter (takes max value and bit-width from parameters N_SECONDS and W_SECONDS)

`timescale 1ns / 1ps

module hms_counter #(
    parameter int N_HOURS   = 24,  // number of hours
    parameter int N_MINUTES = 60,  // number of minutes
    parameter int N_SECONDS = 60,  // number of seconds

    //Output port widths
    parameter int W_HOURS   = 5,
    parameter int W_MINUTES = 6,
    parameter int W_SECONDS = 6
) (
    input logic clk,
    input logic enable,
    output logic [W_HOURS-1:0] hours,
    output logic [W_MINUTES-1:0] minutes,
    output logic [W_SECONDS-1:0] seconds
);
  localparam logic [W_MINUTES-1:0] MaxMinutes = W_MINUTES'(N_MINUTES - 1);
  localparam logic [W_SECONDS-1:0] MaxSeconds = W_SECONDS'(N_SECONDS - 1);
  logic minute_rollover, second_rollover;
  logic shifted_minute_rollover, shifted_second_rollover;
  //   logic [  W_HOURS-1:0] next_hour;
  //   logic [W_MINUTES-1:0] next_minute;
  //   logic [W_SECONDS-1:0] next_second;
  //   always_ff @(posedge clk) begin
  //     hours   <= next_hour;
  //     minutes <= next_minute;
  //     seconds <= next_second;
  //   end
  up_down_counter #(
      .MAX  (N_HOURS - 1),
      .WIDTH(W_HOURS)
  ) u_hour (
      .clk(shifted_minute_rollover),
      .enable(enable),
      .up(1'b1),
      .count(hours)
  );
  up_down_counter #(
      .MAX  (N_MINUTES - 1),
      .WIDTH(W_MINUTES)
  ) u_minute (
      .clk(shifted_second_rollover),
      .enable(enable),
      .up(1'b1),
      .count(minutes)
  );
  up_down_counter #(
      .MAX  (N_SECONDS - 1),
      .WIDTH(W_SECONDS)
  ) u_second (
      .clk(clk),
      .enable(enable),
      .up(1'b1),
      .count(seconds)
  );

  shift_register u_minute_rollover (
      .clk(shifted_second_rollover),
      .in (minute_rollover),
      .out(shifted_minute_rollover)
  );
  shift_register u_second_rollover (
      .clk(clk),
      .in (second_rollover),
      .out(shifted_second_rollover)
  );
  assign minute_rollover = (minutes == MaxMinutes && enable);
  assign second_rollover = (seconds == MaxSeconds && enable);
endmodule
