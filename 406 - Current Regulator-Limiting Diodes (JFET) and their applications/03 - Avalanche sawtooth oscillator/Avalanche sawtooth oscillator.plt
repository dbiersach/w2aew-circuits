[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"I(C1)"}
      X: (' ',1,0.001,0.00025,0.003)
      Y[0]: ('m',1,-0.055,0.01,0.02)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.055,0.01,0.02)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,0.0145) ;A steady 1.0 mA charge, interrupted by 48 mA discharge pulses through the snapback switch
   },
   {
      traces: 1 {589826,0,"V(RAMP)"}
      X: (' ',1,0.001,0.00025,0.003)
      Y[0]: (' ',1,3.6,1,9)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3.6,1,9)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,8.5) ;Charge at constant current, then a fast discharge: 7.248 V down to 4.415 V at 3.47 kHz
      Text: "V" 1 (0.0024,7.9) ;Alan's scope reads 3.317 kHz for the same circuit
   }
}