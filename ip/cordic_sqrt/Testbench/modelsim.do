onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_sqrt.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_sqrt.v
vsim -t ns work.tb_sqrt
run -all
