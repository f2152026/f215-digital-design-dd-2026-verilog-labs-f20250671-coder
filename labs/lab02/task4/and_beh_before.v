// and_beh_before.v
// Behavioral style with delay evaluated BEFORE the assignment

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  always @(a or b) begin
    #5 y = a & b;
  end

endmodule