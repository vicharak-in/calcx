onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_arctan.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_arctan.v
vsim -t ns work.tb_arctan
run -all
