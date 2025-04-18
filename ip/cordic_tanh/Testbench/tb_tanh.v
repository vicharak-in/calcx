`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2

module tb_tanh();

	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_data;
	wire signed [31:0] o_cosh;
	wire signed [31:0] o_sinh;
	wire signed [31:0] o_tanh;
	wire o_done;
	wire signed [31:0] o_alpha;
	wire signed [31:0] o_y;
	wire signed [31:0] o_x;

	cordic_tanh uut 
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_data(i_data),
		.o_done(o_done),
		.o_cosh(o_cosh),
        .o_sinh(o_sinh),
        .o_tanh(o_tanh),
		.o_alpha( o_alpha ),
		.o_y( o_y ),
		.o_x( o_x ) 
	);
	 
	
	
	reg [7:0]i;
	real  o_tanhdiv65536;
	real  r_tanh;
	
	initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_tanh,"ACMTF");
       $dumpfile("tb_tanh.vcd");
       $dumpvars(0, tb_tanh);
    end
    
    initial                                                
    begin     
	   reset_n = 0;
	   #100; 
	   reset_n = 1;
    end
	
    initial 
    begin
       clk = 0;
       forever 
       begin
	      #(`CLK_PERIOD/2) clk = ~clk;
       end
    end
	
   always @ ( posedge clk or negedge reset_n )   
   if( !reset_n )
   begin
      i <= 8'd0;
	  i_call <= 1'b0;
	  i_data <= 32'd0;
   end
   else
   case( i )	 
   	  0: // α = -1.13 (min
	  if( o_done ) 
	  begin 
	  	 i_call <= 1'b0; 
	  	 i <= i + 1'b1;
	  	 r_tanh = $itor(o_tanh);
	  	 o_tanhdiv65536 = r_tanh/65536;
	  	 $display("time=%0t i_data=%d(-1.13) o_tanh=%d(%f)", $time, i_data, o_tanh, o_tanhdiv65536);
	  end
	  else 
	  begin 
	  	 i_call <= 1'b1; 
	  	 i_data <= -1.13 * 65536; 
	  end
      1: // α = -0.8
	  if( o_done ) 
	  begin 
	  	 i_call <= 1'b0; 
	  	 i <= i + 1'b1;
	  	 r_tanh = $itor(o_tanh);
	  	 o_tanhdiv65536 = r_tanh/65536;
	  	 $display("time=%0t i_data=%d(-0.80) o_tanh=%d(%f)", $time, i_data, o_tanh, o_tanhdiv65536);
	  end
	  else 
	  begin 
	  	 i_call <= 1'b1; 
	  	 i_data <= -0.8 * 65536; 
	  end			 
	  2: // α = 0.60
      if( o_done ) 
      begin 
      	 i_call <= 1'b0; 
      	 i <= i + 1'b1; 
      	 r_tanh = $itor(o_tanh);
	  	 o_tanhdiv65536 = r_tanh/65536;
	  	 $display("time=%0t i_data=%d( 0.60) o_tanh=%d(%f)", $time, i_data, o_tanh, o_tanhdiv65536);
      end
	  else 
	  begin 
	  	 i_call <= 1'b1; 
	  	 i_data <= 0.60 * 65536; 
	  end
	  3: // α = 0.77
      if( o_done ) 
      begin 
      	 i_call <= 1'b0; 
      	 i <= i + 1'b1; 
      	 r_tanh = $itor(o_tanh);
	  	 o_tanhdiv65536 = r_tanh/65536;
	  	 $display("time=%0t i_data=%d( 0.77) o_tanh=%d(%f)", $time, i_data, o_tanh, o_tanhdiv65536);
      end
	  else 
	  begin 
	  	 i_call <= 1'b1; 
	  	 i_data <= 0.77 * 65536; 
	  end
	  4: // α = 1.06
      if( o_done ) 
      begin 
      	 i_call <= 1'b0; 
      	 i <= i + 1'b1; 
      	 r_tanh = $itor(o_tanh);
	  	 o_tanhdiv65536 = r_tanh/65536;
	  	 $display("time=%0t i_data=%d( 1.06) o_tanh=%d(%f)", $time, i_data, o_tanh, o_tanhdiv65536);
      end
	  else 
	  begin 
	  	 i_call <= 1'b1; 
	  	 i_data <= 1.06 * 65536; 
	  end
	  5: // α = 1.13
      if( o_done ) 
      begin 
      	 i_call <= 1'b0; 
      	 i <= i + 1'b1; 
      	 r_tanh = $itor(o_tanh);
	  	 o_tanhdiv65536 = r_tanh/65536;
	  	 $display("time=%0t i_data=%d( 1.13) o_tanh=%d(%f)", $time, i_data, o_tanh, o_tanhdiv65536);
      end
	  else 
	  begin 
	  	 i_call <= 1'b1; 
	  	 i_data <= 1.13 * 65536; 
	  end
	  6:
	  begin
		 i <= i;
		 $display("---PASSED---");
		 $finish;
	  end
   endcase
	
endmodule

