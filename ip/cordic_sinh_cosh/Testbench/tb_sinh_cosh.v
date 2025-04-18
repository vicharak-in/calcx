`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2
module tb_sinh_cosh();

	reg clk;
	reg reset_n;
	reg i_call;
	reg  signed [31:0] i_data;
	wire signed [31:0] o_cosh;
	wire signed [31:0] o_sinh;
	wire o_done;
	wire signed [31:0] o_alpha;
	wire signed [31:0] o_y;
	wire signed [31:0] o_x;
	 
	cordic_sinh_cosh uut 
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_data(i_data),
		.o_done(o_done),
        .o_cosh(o_cosh),
        .o_sinh(o_sinh),
		.o_alpha( o_alpha ),
		.o_y( o_y ),
		.o_x( o_x )
	);
	
	reg [7:0]i;
	real o_coshdiv65536, o_sinhdiv65536;
	real r_cosh, r_sinh;
	
	initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_sinh_cosh,"ACMTF");
       $dumpfile("tb_sinh_cosh.vcd");
       $dumpvars(0, tb_sinh_cosh);
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
		   0: // α = -3.142 (min)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1;
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d(-3.142) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= -3.142 * 65536; 
		   end		 
		   1: // α = -2.55 (second negative)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1; 
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d( -2.55) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= -2.55 * 65536; 
		   end		 
		   2: // α = -1 (Third negative)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1;
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d(    -1) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= -1 * 65536; 
		   end
		   3: // α = 0 (zero)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1;
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d(     0) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= 0 * 65536; 
		   end 
		   4: // α =0.8 (second positive)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1;
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d(   0.8) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= 0.8 * 65536; 
		   end	
		   5: // α =2.33 (third positive)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1;
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d(  2.33) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= 2.33 * 65536; 
		   end	
		   6: // α =3.142 (max)
		   if( o_done ) 
		   begin 
		   	  i_call <= 1'b0; 
		   	  i <= i + 1'b1;
		   	  r_cosh = $itor(o_cosh);
		   	  r_sinh = $itor(o_sinh);
		   	  o_coshdiv65536 = r_cosh/65536;
		   	  o_sinhdiv65536 = r_sinh/65536;
		   	  $display("time=%0t i_data=%d( 3.142) o_cosh=%d(%f) o_sinh=%d(%f)", $time, i_data, o_cosh, o_coshdiv65536, o_sinh, o_sinhdiv65536);
		   end
		   else 
		   begin 
		   	  i_call <= 1'b1; 
		   	  i_data <= 3.142 * 65536; 
		   end	
		   7:
		   begin
			  i <= i;
			  $display("---PASSED---");
			  $finish;
		   end
		endcase
	
endmodule

