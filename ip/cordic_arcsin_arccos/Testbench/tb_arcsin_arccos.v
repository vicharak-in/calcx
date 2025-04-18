`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2

module tb_arcsin_arccos();
	
	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_data; 
	wire signed [31:0] o_arccos;
	wire signed [31:0] o_arcsin;
	wire o_done;
	wire signed [31:0] o_deg;
	wire signed [31:0] o_y;
	wire signed [31:0] o_x;

	
	 
	cordic_arcsin_arccos uut
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),		
		.i_data(i_data),
		.o_done(o_done),
		.o_arccos(o_arccos),
        .o_arcsin(o_arcsin),
		.o_deg( o_deg ),
		.o_y( o_y ),
		.o_x( o_x ) 
	);
	
	reg [7:0]i;
	
	wire signed [31:0] o_arccos_deg;
	wire signed [31:0] o_arcsin_deg;	

	assign o_arccos_deg = o_arccos/65536;
	assign o_arcsin_deg = o_arcsin/65536;
	
    initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_arcsin_arccos,"ACMTF");
       $dumpfile("tb_arcsin_arccos.vcd");
       $dumpvars(0, tb_arcsin_arccos);
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
	   0: // verify answer = 0 degree for sin or 90 degree for cos
	   if( o_done ) 
	   begin 
		  i_call <= 1'b0; 
		  i <= i + 1'b1; 
		  $display("time=%0t i_data=%d(0)    o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
		  i_call <= 1'b1; 
		  i_data <= 0*65536;
	   end		 
	   1: // verify answer = 30 degree for sin or 60 degree for cos
	   if( o_done ) 
	   begin 
		  i_call <= 1'b0; 
		  i <= i + 1'b1; 
		  $display("time=%0t i_data=%d(1/2)  o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
		  i_call <= 1'b1; 
		  i_data <= 0.5*65536; 
	   end			 
	   2: // verify answer nearest 45 degree for sin and cos
	   if( o_done ) 
	   begin 
		  i_call <= 1'b0; 
		  i <= i + 1'b1;
		  $display("time=%0t i_data=%d(√3/2) o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
		  i_call <= 1'b1; 
		  i_data <= 0.86602540378*65536;
	   end			 
	   3: // verify answer nearest 60 degree for sin or 30 degree for cos
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_data=%d(√2/2) o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 0.70710678118*65536;
	   end			 
	   4: // verify answer = 90 degree for sin or 0 degree for cos
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_data=%d(1)    o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 1*65536;
	   end
	   5: // test negative work #1
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_data=%d(-0.5) o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= -0.5*65536; 
	   end
	   6: // test negative work #2
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_data=%d(√3/2) o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= -0.86602540378*65536;
	   end
	   7: // test negative work #3
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_data=%d(√2/2) o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= -0.70710678118*65536;
	   end
	   8: // test negative work #5
	   if( o_done ) 
	   begin
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1; 
	   	  $display("time=%0t i_data=%d(-1)   o_arccos=%d(%d) o_arcsin=%d(%d)", $time,i_data,o_arccos,o_arccos_deg,o_arcsin,o_arcsin_deg);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= -1*65536;
	   end
	   9:
	   begin
	   	  i <= i;
	   	  $display("---PASSED---");
	   	  $finish;
	   end	 
			                    
				
    endcase // case ( i )
		 	
endmodule

