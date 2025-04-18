onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_sin_cos.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_sin_cos.v
vsim -t ns work.tb_sin_cos
run -all
