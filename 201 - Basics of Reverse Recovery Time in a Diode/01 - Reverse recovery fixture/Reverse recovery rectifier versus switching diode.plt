[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(pulse_in)"}
      X: ('u',1,3.45e-06,1e-07,4.05e-06)
      Y[0]: (' ',1,-1.5,0.5,1.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.5,0.5,1.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (3.78e-06,1.15) ;The generator reverses here, at 3.505 us, with a 5 ns edge.
   }
   {
      traces: 2 {34603011,0,"I(Dslow)"} {34603012,0,"I(Dfast)"}
      X: ('u',1,3.45e-06,1e-07,4.05e-06)
      Y[0]: ('m',1,-0.02,0.004,0.008)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.02,0.004,0.008)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (3.78e-06,0.0065) ;I(Dslow), the rectifier, holds reverse current for 446 ns. I(Dfast) is back inside -1 mA in 3.3 ns.
      Text: "A" 1 (3.78e-06,-0.0185) ;-16 mA is more than two 50 ohm resistors alone allow: the diode's remaining forward drop adds to the drive.
   }
}
