onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_sinh_cosh.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_sinh_cosh.v
vsim -t ns work.tb_sinh_cosh
run -all
