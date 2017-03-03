for {set i 0} {$i < 16} {incr i 1} {
	for {set j 0} {$j < 8} {incr j 1} {
		add wave -group ROW$i \
		sim:/britney_tb/uut/SADUNIT/PE/R$i/RP0/P$j/RBR;
		radix signal sim:/britney_tb/uut/SADUNIT/PE/R$i/RP0/P$j/RBR -hex
	}
	for {set k 0} {$k < 8} {incr k 1} {
		add wave -group ROW$i \
		sim:/britney_tb/uut/SADUNIT/PE/R$i/RP1/P$k/RBR;
		radix signal sim:/britney_tb/uut/SADUNIT/PE/R$i/RP1/P$k/RBR -hex
	}
}
