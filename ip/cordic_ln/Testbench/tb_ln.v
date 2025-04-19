`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2
module tb_ln();

	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_data;
	wire signed [31:0] o_ln;
	wire o_done;
	wire signed [31:0] o_alpha;
    wire signed [31:0] o_y;
	wire signed [31:0] o_x ; 
	
	cordic_ln uut 
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_data(i_data),
		.o_done(o_done),
        .o_ln(o_ln),
		.o_alpha( o_alpha ),
		.o_y( o_y ),
		.o_x( o_x ) 
	);
	
	reg [7:0]i;
        real  o_lndiv65536;
	real  o_lntoreal;
	
	
	initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_in,"ACMTF");
       $dumpfile("tb_ln.vcd");
       $dumpvars(0, tb_ln);
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
	   0: // 1.3498588
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  o_lntoreal = $itor (o_ln);
	   	  o_lndiv65536 = o_lntoreal/65536;
	   	  $display("time=%0t i_data=%d( 1.3498588) o_ln=%d(%f)", $time, i_data, o_ln, o_lndiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 1.3498588 * 65536; 
	   end			 
	   1: // 1.64872127
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  o_lntoreal = $itor (o_ln);
	   	  o_lndiv65536 = o_lntoreal/65536;
	   	  $display("time=%0t i_data=%d(1.64872127) o_ln=%d(%f)", $time, i_data, o_ln, o_lndiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1;
	   	  i_data <= 1.64872127 * 65536; 
	   end			 
	   2: // 2.22554092
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  o_lntoreal = $itor (o_ln);
	   	  o_lndiv65536 = o_lntoreal/65536;
	   	  $display("time=%0t i_data=%d(2.22554092) o_ln=%d(%f)", $time, i_data, o_ln, o_lndiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 2.22554092 * 65536; 
	   end			 
	   3: // 99.142
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  o_lntoreal = $itor (o_ln);
	   	  o_lndiv65536 = o_lntoreal/65536;
	   	  $display("time=%0t i_data=%d(    99.142) o_ln=%d(%f)", $time, i_data, o_ln, o_lndiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 99.142 * 65536; 
	   end			 
	   4: // 30000
	   if( o_done ) 
	   begin 
	   	  i_call <= 1'b0; 
	   	  i <= i + 1'b1;
	   	  o_lntoreal = $itor (o_ln);
	   	  o_lndiv65536 = o_lntoreal/65536;
	   	  $display("time=%0t i_data=%d(     30000) o_ln=%d(%f)", $time, i_data, o_ln, o_lndiv65536);
	   end
	   else 
	   begin 
	   	  i_call <= 1'b1; 
	   	  i_data <= 30000 * 65536; 
	   end
	   5:
	   begin
		  i <= i;
		  $display("---PASSED---");
		  $finish;
	   end		
    endcase
	
endmodule

