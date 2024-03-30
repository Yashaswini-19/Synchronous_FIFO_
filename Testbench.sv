`include "test.sv"
`include "inf_fifo.sv"

  module tb_top();
  bit clk;
  bit rst;
  
  fifo_if inf(clk);
  test t1(inf);
    fifo dut(.wdata(inf.wdata),
             .rd_en(inf.rd_en),
             .wr_en(inf.wr_en),
             .full(inf.full),
             .empty(inf.empty),
             .rdata(inf.rdata),
             .clk(clk),
             .rst(inf.rst));
  
  initial begin
    clk =1;
  end
  
  always #5 clk = ~clk;
    
  initial begin
    rst = 1;
    #5 rst =0;
   end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
  
  
