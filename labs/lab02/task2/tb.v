// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // Declare the inputs and outputs matching the lut.v parameters
  // DEPTH=4 means sel is 2 bits ($clog2(4)-1:0). WIDTH=8 means dout is 8 bits.
  reg  [1:0] t_sel;
  wire [7:0] t_dout;

  // Instantiate the lut module. 
  // Name the instance DUT so $dumpvars below can bind to it.
  lut DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // Apply all 4 input combinations for a DEPTH=4 ROM
    t_sel = 2'd0; #5;
    t_sel = 2'd1; #5;
    t_sel = 2'd2; #5;
    t_sel = 2'd3; #5;
    $finish;
  end

  // Monitor updated to track sel and dout in decimal format
  initial
    $monitor($time, " sel=%d | dout=%d", t_sel, t_dout);

endmodule