[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"I(C1)"}
      X: (' ',1,0.001,0.00025,0.003)
      Y[0]: ('m',1,-0.05,0.01,0.01)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,-0.05,0.01,0.01)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,-0.035) ;A steady 1.0 mA charge, interrupted by 48 mA discharge pulses through the snapback switch
   },
   {
      traces: 1 {524290,0,"V(RAMP)"}
      X: (' ',1,0.001,0.00025,0.003)
      Y[0]: (' ',1,4,0.5,8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,4,0.5,8)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,7.75) ;Charge at constant current, then a fast discharge: 7.248 V down to 4.415 V at 3.47 kHz
      Text: "V" 1 (0.0024,4.25) ;Alan's scope reads 3.317 kHz for the same circuit
   }
}