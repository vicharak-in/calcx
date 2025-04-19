`resetall
`timescale 1ns / 1ps
`define CLK_PERIOD 2
module tb_exp();

	reg clk;
	reg reset_n;
	reg i_call;
	reg signed [31:0] i_data;
	wire signed [31:0] o_exp;
	wire o_done;
	wire signed [31:0] o_alpha;
	wire signed [31:0] o_y;
	wire signed [31:0] o_x;

	cordic_exp uut 
	(
		.clk(clk),
		.reset_n(reset_n),
		.i_call(i_call),
		.i_data(i_data),
		.o_done(o_done),
        .o_exp(o_exp),
		.o_alpha( o_alpha ),
		.o_y( o_y ),
		.o_x( o_x ) 
	);
	
	reg [7:0]i;
        real  o_expdiv65536;
	real  o_exptoreal;	
	
    initial 
    begin
       //$shm_open("test.shm");
       //$shm_probe(tb_exp,"ACMTF");
       $dumpfile("tb_exp.vcd");
       $dumpvars(0, tb_exp);
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
	  0: // exp(-10) 
	  if( o_done ) 
	  begin 
	 	 i_call <= 1'b0; 
	 	 i <= i + 1'b1;
	 	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
	 	 $display("time=%0t i_data=%d(-10  ) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
	  end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= -10 * 65536; 
	  end			 
	  1: // exp(-5.5)
	  if( o_done ) 
	  begin 
	 	 i_call <= 1'b0; 
	 	 i <= i + 1'b1;
	 	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
	 	 $display("time=%0t i_data=%d(-5.5 ) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
	  end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= -5.5 * 65536; 
	  end			 
	  2: // exp(-0.5)
	  if( o_done ) 
	  begin 
	 	 i_call <= 1'b0; 
	 	 i <= i + 1'b1;
	 	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
	 	 $display("time=%0t i_data=%d(-0.5 ) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
	  end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= -0.5 * 65536; 
	  end				 
	  3: // exp(0)
      if( o_done ) 
      begin 
     	 i_call <= 1'b0; 
     	 i <= i + 1'b1;
     	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
     	 $display("time=%0t i_data=%d(0    ) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
      end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= 0 * 65536; 
	  end	 
	  4: // exp(3.142)
	  if( o_done ) 
	  begin 
	 	 i_call <= 1'b0; 
	 	 i <= i + 1'b1;
	 	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
	 	 $display("time=%0t i_data=%d(3.142) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
	  end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= 3.142 * 65536; 
	  end
	  5: // exp(7.777)
	  if( o_done ) 
	  begin 
	 	 i_call <= 1'b0; 
	 	 i <= i + 1'b1;
	 	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
	 	 $display("time=%0t i_data=%d(7.777) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
	  end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= 7.777 * 65536; 
	  end
	  6: // exp(10)
	  if( o_done ) 
	  begin 
	 	 i_call <= 1'b0; 
	 	 i <= i + 1'b1;
	 	 o_exptoreal = $itor (o_exp);
         o_expdiv65536 =  o_exptoreal/65536;
	 	 $display("time=%0t i_data=%d(10   ) o_exp=%d(%f)", $time, i_data, o_exp, o_expdiv65536);
	  end
	  else 
	  begin 
	 	 i_call <= 1'b1; 
	 	 i_data <= 10 * 65536; //max for 32 bits is 22 
	  end
	  7:
	  begin
		 i <= i;
		 $display("---PASSED---");
		 $finish;
	  end		
   endcase
	
endmodule

