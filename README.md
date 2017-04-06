# BRENDA - A Full Search Motion Estimation Accelerator IP

## A few words for this project

This repo holds all (almost) the job I've done for my diploma thesis, during my studies at University of Western Macedonia - Department of Informatics
and Telecommunications Engineering. The project describes the architectural design of an Accelerator IP for the Full search Motion Estimation Algorithm
(FSME). The VHDL code, among with the necessary testbenches, scripts and docs are included.

The first idea behind this project came up on September 2015, and initially it was designed to target H.265 - HEVC codecs. However, due to lack of:
time, experience with VHDL, experience with theory of video compression, necessary equipment (large FPGAs, logic analyzers, etc) it was decided to stick
with something a lot simpler than that, which could still provide valuable knowledge, and of course a good starting point for any future project. So, a month
later, I started looking for an appropriate architecture in order to begin with. 

At first I tried translating a simple C program into hardware via HLS, but I was quickly disappointed. So after a couple of months researching I found
this paper: "Yasser Ismail, ”A Complete Verification of a Full Search Motion Estimation Engine”, International Journal of Computing and Digital Systems,
University of Bahrain, 1 October 2015" which provided me with an excellent starting point.

The project doesn't end here. Since the initial idea was about a FSME Accelerator IP integrated into an embedded system (e.g. with an ARM processor), 
there is a whole new level of VHDL, testbenches and software implementing the (notorious :P) interconnection of this IP with the rest of a ZYNQ 7000 platform (ARM CPU,
external RAM, etc) over the AXI protocol. These parts are going to be added soon to the repo, as soon as I'm done with the testing.

The file tree includes the following:

* docs : A part of the documentation describing the structure and the design of the system. My thesis document lies here too (unfortunately in Greek for
now).
* scripts : Some of the scripts I used in order to make my life easier during developing-testing phases. Many languages are involved, PHP, TCL, even
MatLAB - I used whatever was more convenient for me.
* testbench : The component testbenches. Using those testbenches you can evaluate any component of the system.
* VHDL : The main src.
* vivado : The necessary files to compile a fully functional project in Vivado
* xise : A Xilinx ISE project for the project :P

Even though everything uploaded here is freely available for use and redistribution, if you decide to use part or whole of my work please consider bying
me a beer. I spent hundreds of hours, liters of coffee (and alcohol) and tons of broken nerves and morale, in order to make this thing work
(at least minimally).
