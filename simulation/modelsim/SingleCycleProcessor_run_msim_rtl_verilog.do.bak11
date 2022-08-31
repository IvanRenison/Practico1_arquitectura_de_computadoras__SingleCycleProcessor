transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/ivan/Desktop/SingleCycleProcessor {/home/ivan/Desktop/SingleCycleProcessor/imem.sv}

vlog -sv -work work +incdir+/home/ivan/Desktop/SingleCycleProcessor {/home/ivan/Desktop/SingleCycleProcessor/imem_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  imem_tb

add wave *
view structure
view signals
run -all
