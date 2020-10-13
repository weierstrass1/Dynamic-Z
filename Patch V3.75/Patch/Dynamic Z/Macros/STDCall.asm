macro AddStack(val)
	TSC
	CLC
	ADC #<val>
	TCS
endmacro

macro SubStack(val)
	TSC
	SEC
	SBC #<val>
	TCS
endmacro

macro PushPar(par)
	LDA <par>
	PHA
endmacro

macro RTIN(n)
	%AddStack(<n>)
RTI
endmacro

macro RTSN(n)
	%AddStack(<n>)
RTS
endmacro

macro RTLN(n)
	%AddStack(<n>)
RTL
endmacro

macro StartFunction(name, n)
<name>:
	%SubStack(<n>)
endmacro

macro CallFunction(name, m)
JSR <name>

%AddStack(<m>)
endmacro

macro CallFunctionLong(name, m)
JSL <name>

%AddStack(<m>)
endmacro