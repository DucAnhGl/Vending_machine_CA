.PHONY: comp sim run

comp:
	iverilog -g2012 -s vending_machine_tb -o vending_machine_tb.vvp -c Filelist.txt

sim:
	vvp vending_machine_tb.vvp
	gtkwave

run:
	make comp && make sim