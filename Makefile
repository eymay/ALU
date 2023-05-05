V_SOURCES := $(wildcard src/*.v)
SV_SOURCES := $(wildcard src/*.sv)

OUT_VVP := $(patsubst src/%.v, vvp/%.out,$(V_SOURCES)) \
		   $(patsubst src/%.sv, vvp/%.out,$(SV_SOURCES))

OUT_VCD := $(patsubst src/%.v, waveform/%.vcd,$(V_SOURCES)) \
		   $(patsubst src/%.sv, waveform/%.vcd,$(SV_SOURCES))

OUT_SV2V := $(patsubst src/%.sv, synth/%_sv2v.v,$(SV_SOURCES))

FA = full_adder_LL_nodelay.v
Adder = ripple_carry_adder_subtractor.v

LU = logical_unit.v

ALU = ALU_LL.v

Mux = mux_2to1.v
ShRight = shift_right.v
Shifter = shifter.v

FU = FunctionUnit.v

all:  waveform/FU.vcd

waveform/%.vcd: vvp/%.out
	vvp $^

vvp/%.out: tb/%_tb.v
	iverilog -o $@ -g2005-sv src/* $^

vvp/$(FA:.v=.out):  
	iverilog -o $@ $^

vvp/$(Adder:.v=.out): src/$(FA) 
	iverilog -o $@ $^ $<

vvp/$(LU:.v=.out): 
	iverilog -o $@ src/$(LU)

vvp/$(ALU:.v=.out): src/$(LU) src/$(Adder) 
	iverilog -o $@ $^

vvp/$(Mux:.v=.out):
	iverilog -o $@ $^

vvp/$(ShRight:.v=.out): src/$(Mux)
	iverilog -o $@ -g2005-sv $^ 

vvp/$(Shifter:.v=.out): src/$(Mux)
	iverilog -o $@ -g2005-sv $^

vvp/$(FU:.v=.out): src/$(ALU) src/$(Shifter)
	iverilog -o $@ -g2005-sv $^
