create_clock -period 18.5185 tx_pixel_clk
create_clock -period 9.2593 tx_vga_clk
create_clock -period 9.2593 tx_esc_clk
create_clock -period 9.2593 mipi_rx_cal_clk
create_clock -period 18.5185 rx_pixel_clk
create_clock -period 1250.0000 isr_clk
create_clock -period 200.0000 divider_clk
create_clock -period 200.0000 cordic_clk
create_clock -period 22.222 f_to_f_clk
create_clock -period 30.303 calc_clk

set_clock_groups -exclusive -group {tx_pixel_clk tx_vga_clk tx_esc_clk} -group {rx_pixel_clk mipi_rx_cal_clk} -group {isr_clk f_to_f_clk} -group {divider_clk cordic_clk} -group {calc_clk}
