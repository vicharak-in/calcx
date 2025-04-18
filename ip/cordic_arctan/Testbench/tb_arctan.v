`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2
module tb_arctan();

	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_x;
	reg signed [31:0] i_y;
	wire signed [31:0] o_arctan;
	wire o_done;
	wire signed [31:0] o_deg;
	wire signed [31:0] o_y;
	wire signed [31:0] o_x;
	 
	cordic_arctan uut 
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_x(i_x),
		.i_y(i_y),
		.o_done(o_done),
                .o_arctan(o_arctan),
		.o_deg( o_deg ),
		.o_y( o_y ),
		.o_x( o_x ) 
	);

        assign o_arctandiv65536 = o_arctan / 65536;
	reg [7:0]i;
	
	initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_arctan,"ACMTF");
       $dumpfile("tb_arctan.vcd");
       $dumpvars(0, tb_arctan);
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
	   i_x <= 32'd0;
	   i_y <= 32'd0;
	end
	else
    case( i )		
	   0: //  verified -1 -1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  $display("time=%0t i_x=%d( -1) i_y=%d( -1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= -1 * 65536; 
	   	  i_y <= -1 * 65536;
	   end			 
	   1: // verified 0 -1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  0) i_y=%d( -1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 0 * 65536; 
	   	  i_y <= -1 * 65536; 
	   end			 
	   2: // verified 1 -1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  1) i_y=%d( -1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 1 * 65536; 
	   	  i_y <= -1 * 65536; 
	   end 
	   3: // verified 1 0
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  1) i_y=%d(  0) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 1 * 65536; 
	   	  i_y <= 0 * 65536; 
	   end
	   4: // verified 1 1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  1) i_y=%d(  1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 1 * 65536; 
	   	  i_y <= 1 * 65536; 
	   end
	   5: // verified 0 1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  0) i_y=%d(  1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 0 * 65536; 
	   	  i_y <= 1 * 65536; 
	   end
	   6: // verified -1 1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d( -1) i_y=%d(  1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= -1 * 65536; 
	   	  i_y <= 1 * 65536; 
	   end
	   7: // verified -1 0
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d( -1) i_y=%d(  0) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= -1 * 65536; 
	   	  i_y <= 0 * 65536; 
	   end
	   8: // test 255 1
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(255) i_y=%d(  1) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 255 * 65536; 
	   	  i_y <= 1 * 65536; 
	   end
	   9: // test 1 255
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  1) i_y=%d(255) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 1 * 65536; 
	   	  i_y <= 255 * 65536; 
	   end	   
	   10: // test max 255 255
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(255) i_y=%d(255) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 255 * 65536; 
	   	  i_y <= 255 * 65536; 
	   end
	   11: // test other 3 4
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_x=%d(  3) i_y=%d(  4) o_arctan=%d(%d)", $time, i_x, i_y, o_arctan, o_arctandiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_x <= 3 * 65536; 
	   	  i_y <= 4 * 65536; 
	   end
	   12:
	   begin
 	      i <= i;
 	      $display("---PASSED---");
 	      $finish;
	   end		
    endcase
	
endmodule

