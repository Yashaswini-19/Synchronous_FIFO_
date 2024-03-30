module fifo(clk,rst,wdata,rdata,wr_en,rd_en,full,empty);
  input clk,rst,wr_en,rd_en;
  output full,empty;
  input [7:0] wdata;
  output reg [7:0] rdata;

  reg [$clog2(32):0] wr_ptr;
  reg [$clog2(32):0] rd_ptr;
  reg [7:0]mem[31:0];//32 elements each of 8-bit wide

  
  // Set Default values on reset.
  always@(posedge clk) begin
    if(rst) begin
      wr_ptr <= 0; rd_ptr <= 0;
      rdata <= 0; 
    end
  end
  
// To write data to FIFO
  always@(posedge clk) begin
    if(wr_en & !full)begin
      mem[wr_ptr] <= wdata;
      wr_ptr <= wr_ptr + 1;
    end
  end

 // To read data from FIFO
  always@(posedge clk) begin
    if(rd_en & !empty) begin
      rdata <= mem[rd_ptr];
      rd_ptr <= rd_ptr + 1;
    end
  end
  

assign empty =(rd_ptr==wr_ptr);
assign full=((wr_ptr[4:0]==rd_ptr[4:0])&&(wr_ptr[5]!=rd_ptr[5]));

endmodule
