// tb.v

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    // Test 1: Basic addition
    t_a = 4'd5; t_b = 4'd3; t_op = 1'b0; #10;
    
    // Test 2: Catch sensitivity bug 
    // Changing only 'op'. If 'op' is missing from the sensitivity list, 
    // the result will incorrectly remain 8 instead of changing to 2.
    t_op = 1'b1; #10; 

    // Test 3: Catch blocking/non-blocking bug
    // If <= is used, intermediate registers will use old values here.
    t_a = 4'd9; t_b = 4'd4; t_op = 1'b1; #10; 
    
    $finish;
  end

  initial
    $monitor($time, " a=%d b=%d op=%b | result=%d", t_a, t_b, t_op, t_result);

endmodule