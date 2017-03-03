# Sadri - May - 10 - 2015 - Updated! 

# This simple tcl script performs a test on the operation of axi dma in sg mode 

# Author : Mohammad S. Sadri


# This script is provided for educational purposes only 
# For commercial use please contact the author directly at mamsadegh@green-electrons.com

####################################
#
# Init xmd and program PL
#
####################################
#connect arm hw

#fpga -f ../project_1/project_1.runs/impl_2/design_1_wrapper.bit

#source ../project_1/project_1.sdk/design_1_wrapper_hw_platform_0/ps7_init.tcl

#ps7_init
#ps7_post_config 

####################################
#
# Constants 
#
####################################
set transferSize [expr 31] ;# In bytes
set transferWords [expr $transferSize/4+3]

####################################
#
# Reset DMA and Init
#
####################################
# configure MM2S 
# no cyclic bd for now 
# reset MM2S
mwr 0x40400000 0x0101dfe6
mwr 0x40400000 0x0101dfe2

# configure S2MM
# Reset S2MM
mwr 0x40400030 0x0101dfe6
mwr 0x40400030 0x0101dfe2 

####################################
#
# Write Descriptors
#
####################################
# write descriptors to bram 
# this we use as the mm2s descriptor. one descriptor transfers one complete packet. (both of sof and eof are set)
mwr 0x40000000 0x40000000 ;# Indicator of next descriptor, 32 lower bits of address. It is currently pointing to itself
mwr 0x40000004 0x00000000 ;# Indicator of next descriptor, 32 higher bits of address
mwr 0x40000008 0x00a00000 ;# Physical address in DRAM, from where we are going to READ data and send them to IP
mwr 0x4000000c 0x00000000
mwr 0x40000010 0x00000000
mwr 0x40000014 0x00000000
mwr 0x40000018 [expr 0x0c000000+$transferSize] ;# Control field
mwr 0x4000001c 0x00000000 
mwr 0x40000020 0x00000000
mwr 0x40000024 0x00000000
mwr 0x40000028 0x00000000
mwr 0x4000002c 0x00000000
mwr 0x40000030 0x00000000

# descriptor for s2mm , these descriptors begin from 0x1000 offset in the block memory. 
mwr 0x40001000 0x40001000
mwr 0x40001004 0x00000000 
mwr 0x40001008 0x00b00000 ;# Physical address in DRAM, to where we are going to WRITE data resulting from the IP
mwr 0x4000100c 0x00000000
mwr 0x40001010 0x00000000
mwr 0x40001014 0x00000000
mwr 0x40001018 [expr 0x0c000000+$transferSize] ;# Control field
mwr 0x4000101c 0x00000000 
mwr 0x40001020 0x00000000
mwr 0x40001024 0x00000000
mwr 0x40001028 0x00000000
mwr 0x4000102c 0x00000000
mwr 0x40001030 0x00000000

####################################
#
# Initialize DRAM 
#
####################################
# initialize memory which is read by mm2s
# WARNING ! If the transferSize is a big number, this code takes a long while to be executed in XMD. 

for {set i 0} {$i < $transferWords} {incr i 1} {
	mwr [expr 0x00a00000+$i*4] [expr 0xFFFFFFF5+$i]
	#mwr 0x00a00004 0xa0000001
	#mwr 0x00a00008 0xa0000002
	#mwr 0x00a0000c 0xa0000003
	#mwr 0x00a00010 0xa0000004
	# .       .			.
	# .       .			.
	# .       .			.
	# .       .			.
}

# initializing memory which is being written to by s2mm 
for {set i 0} {$i < $transferWords} {incr i 1} {
	mwr [expr 0x00b00000+$i*4] 0xbbbbbbbb
}

####################################
#
# start S2MM
#
####################################
# for s2mm write the current descriptor pointer 
mwr 0x4040003c 0x00000000
mwr 0x40400038 0x40001000

# start s2mm engine 
mwr 0x40400030 0x0101dfe3

# for s2mm write tail descriptor pointer 
mwr 0x40400044 0x00000000
mwr 0x40400040 0x40001000 

####################################
#
# Start MM2S
#
####################################
# for mm2s write the value of current descriptor and tail descriptor 
mwr 0x4040000c 0x00000000
mwr 0x40400008 0x40000000

# enable mm2s
mwr 0x40400000 0x0101dfe3

# # mm2s tail desc pointer. write msb first. 
mwr 0x40400014 0x00000000
mwr 0x40400010 0x40000000

####################################
#
# Start Packet Generator
#
####################################
# now start the sample generator 
mwr 0x43c00004 $transferSize 
mwr 0x43c00000 0x01 

# wait for a short while 
exec sleep 1

####################################
#
# Results
#
####################################

puts "########## Results ############"

puts "DMA Status:"
puts [mrd 0x40400004]
puts [mrd 0x40400034]

puts "FSME input data:"
puts [mrd 0x00a00000 10]

puts "FSME output data:"
puts [mrd 0x00b00000 10]


#puts [mrd 0x43c00010]
#puts [mrd 0x43c00014]

#puts [mrd 0x43c00018]
#puts [mrd 0x43c0001c]

