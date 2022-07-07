main:
	iverilog -o out BS_tb.v BS.v dualPortRAM.v ROM.v
	vvp out
	# gtkwave test.vcd