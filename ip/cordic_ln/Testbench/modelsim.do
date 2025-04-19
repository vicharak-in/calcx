onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_ln.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_ln.v
vsim -t ns work.tb_ln
run -all
