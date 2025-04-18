onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_tanh.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_tanh.v
vsim -t ns work.tb_tanh
run -all
