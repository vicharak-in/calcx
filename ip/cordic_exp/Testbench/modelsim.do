onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_exp.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_exp.v
vsim -t ns work.tb_exp
run -all
