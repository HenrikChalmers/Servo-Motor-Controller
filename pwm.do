-- MAC_serial_implementation_tb3.do

restart -f -nowave
view signals wave
add wave clk angle PWM debug debugbinary

force clk 0 0ns, 1 1ns -repeat 2ns
force angle 2#1100100 0ns

run 10000000ns
wave zoom full