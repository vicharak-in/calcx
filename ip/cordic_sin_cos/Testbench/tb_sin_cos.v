`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2

module tb_sin_cos();

	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_data; 
	wire signed [31:0] o_cos;
	wire signed [31:0] o_sin;
	wire o_done;
	wire signed [31:0] o_deg;
	wire signed [31:0] o_y;
	wire signed [31:0] o_x;

	
	 
	cordic_sin_cos uut
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_data(i_data),
		.o_done(o_done),	
		.o_cos(o_cos),
		.o_sin(o_sin),
		.o_deg( o_deg ),
		.o_y( o_y ),
		.o_x( o_x ) 
	);
	
	reg [7:0]i;
	real o_cos_div65536;
	real o_sin_div65536;
	real r_sin;
	real r_cos;

    initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_sin_cos,"ACMTF");
       $dumpfile("tb_sin_cos.vcd");
       $dumpvars(0, tb_sin_cos);
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
	   0: // 0 degree
	   if( o_done ) 
	   begin 
		  i_call <= 1'b0; 
		  i <= i + 1'b1;
		  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
		  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
		  i_call <= 1'b1; 
		  i_data <= 32'd0; 
	   end		 
	   1: // z <= 30
	   if( o_done ) 
	   begin 
		  i_call <= 1'b0; 
		  i <= i + 1'b1; 
		  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
		  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
		  i_call <= 1'b1; 
		  i_data <= 32'd30; 
	   end			 
	   2: // z <= 45
	   if( o_done ) 
	   begin 
		  i_call <= 1'b0; 
		  i <= i + 1'b1;
		  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
		  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
		  i_call <= 1'b1; 
		  i_data <= 32'd45; 
	   end			 
	   3: // z <= 60
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
	   	  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 32'd60;
	   end
	   4: // z <= 135
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
	   	  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 32'd135;
	   end
	   5: // z <= 180
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
	   	  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 32'd180;
	   end
	   6: // z <= 255
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
	   	  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 32'd255;
	   end
	   7: // z <= 300
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
	   	  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 32'd300;
	   end
	   8: // z <= 330
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sin = $itor(o_sin);
		  r_cos = $itor(o_cos);
	   	  o_sin_div65536 = r_sin/65536;
		  o_cos_div65536 = r_cos/65536;
		  $display("time<=%0t i_data<=%d o_cos<=%d(%f) o_sin<=%d(%f)", $time,i_data,o_cos,o_cos_div65536,o_sin,o_sin_div65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 32'd330;
	   end
	   9:
	   begin
	   	  i <= i;
	   	  $display("---PASSED---");
	   	  $finish;
	   end	 
			                    
				
    endcase // case ( i )
		 	
endmodule

