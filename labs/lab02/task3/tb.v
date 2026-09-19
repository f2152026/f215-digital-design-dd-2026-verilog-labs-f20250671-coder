// tb.v
// Self-checking testbench for 2-bit magnitude comparator (comp2)

module tb;

  // Declare inputs as reg and outputs as wire
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  // Instantiate the DUT
  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Variables for self-checking loops
  integer i, j;
  reg exp_gt, exp_lt, exp_eq;
  integer error_count = 0;

  initial begin
    $display("Starting self-checking testbench...");
    
    // Loop through all 16 possible combinations of A and B
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0];
        t_b = j[1:0];
        #5; // Wait for combinational logic to settle
        
        // Calculate expected behavioral outputs
        exp_eq = (t_a == t_b);
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        
        // Check if DUT outputs match expected outputs
        if ((t_eq !== exp_eq) || (t_gt !== exp_gt) || (t_lt !== exp_lt)) begin
          $display("ERROR at time %0t: A=%d, B=%d | DUT outputs: GT=%b LT=%b EQ=%b | Expected: GT=%b LT=%b EQ=%b", 
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          error_count = error_count + 1;
        end
      end
    end
    
    // Final test report
    if (error_count == 0) begin
      $display("SUCCESS: All 16 test cases passed! The comparator logic is fully correct.");
    end else begin
      $display("FAILED: Testbench completed with %0d errors.", error_count);
    end
    
    $finish;
  end

endmodule