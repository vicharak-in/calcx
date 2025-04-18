onerror {quit -f}
vlib work
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./tb_arcsin_arccos.v
vlog +define+SIM+SIM_MODE+EFX_SIM -sv ./cordic_arcsin_arccos.v
vsim -t ns work.tb_arcsin_arccos
run -all
