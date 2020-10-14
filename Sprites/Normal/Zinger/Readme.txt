Extra bytes:

Extra Byte 1: General Extrabyte of all Dynamic Sprites

Extra Byte 2: Movement Type XXXX YYYY

XXXX Movement for X Axys
YYYY Movement for Y Axys

Possible Movements:
0000 = NoMovement
0001 = Constant
0010 = Follow
0011 = Sin
0100 = Cos
0101 = SinSin
0110 = SinCos
0111 = CosSin
1000 = CosCos

Extra Byte 3: Speed or Max Speed if acceleration is not 0, XXXX YYYY
XXXX = Speed for X Axys
YYYY = Speed for Y Axys

Max Value 8

Extra Byte 4: xxxx yyyy, Acceleration on Follow Movement, 
xxxx = Acceleration For X Axis
yyyy = Acceleration For Y Axis

Extra Byte 5: xxxx xxxx, Phase Angle for Types 3 or more (Min value $00, Max Value $B3) Used only in Trigonometrics movements.

Extra Byte 6: Angle Speed in Trigonometrics movements.

Extra Byte 7: xxxx yyyy, Amplitude in Trigonometrics movements.
xxxx = Amplitude For X Axis
yyyy = Amplitude For Y Axis

Extra Byte 8: xxxx yyyy, Ratio in Trigonometrics movements.
xxxx = Ratio For X Axis
yyyy = Ratio For Y Axis

Extra Byte 9: xxxx yyyy, Ratio Increase in Trigonometrics movements.
xxxx = Ratio For X Axis
yyyy = Ratio For Y Axis