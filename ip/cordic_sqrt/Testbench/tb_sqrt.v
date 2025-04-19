`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2
module tb_sqrt();
	
	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_data;
	wire signed [31:0] o_sqrt;
	wire o_done;
	wire signed [31:0] o_alpha;
	wire signed [31:0] o_y;
    wire signed [31:0] o_x;
		 
	cordic_sqrt uut 
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_data(i_data),
		.o_done(o_done),
        .o_sqrt(o_sqrt),
		.o_alpha( o_alpha ),
		.o_y( o_y ),
		.o_x( o_x )
	);
	
	reg [7:0]i;
	real  o_sqrtdiv65536;
	real  r_sqrt;
	
	initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_sqrt,"ACMTF");
       $dumpfile("tb_sqrt.vcd");
       $dumpvars(0, tb_sqrt);
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
	   0: // sqrt 4 (make sure it works)
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d(     4) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 4 * 65536; 
	   end			 
	   1: // sqrt 0.3333 (sqrt some floating point)
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d(0.3333) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 0.3333 * 65536; 
	   end			 
	   2: // sqrt 0.855 (sqrt another floating point)
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d( 0.855) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 0.855 * 65536; 
	   end			 
	   3: // sqrt 59
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d(    59) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 59 * 65536; 
	   end		
	   4: // sqrt 590.59
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d(590.59) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 590.59 * 65536; 
	   end
	   5: // sqrt 4098
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d(  4098) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 4098 * 65536; 
	   end
	   6: // sqrt 16400
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d( 16400) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 16400 * 65536; 
	   end
	   7: // sqrt 30000
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  r_sqrt = $itor(o_sqrt);
	   	  o_sqrtdiv65536 = r_sqrt/65536;
	   	  $display("time=%0t i_data=%d( 30000) o_sqrt=%d(%f)", $time, i_data, o_sqrt, o_sqrtdiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 30000 * 65536; 
	   end
	   8:
	   begin
	      i <= i;
	      $display("---PASSED---");
	      $finish;
	   end		
   endcase
	
endmodule

