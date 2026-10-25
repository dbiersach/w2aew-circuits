[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"I(Rref)"}
      X: (' ',1,0,1,12)
      Y[0]: ('m',1,0,0.0002,0.0022)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,0,0.0002,0.0022)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (6,0.00205) ;Reference branch: the 1N5305 model settles at 1.975 mA through the 330 ohm resistor
   },
   {
      traces: 1 {589826,0,"I(Vsense)"}
      X: (' ',1,0,1,12)
      Y[0]: ('m',1,0,0.002,0.02)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,0,0.002,0.02)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (6,0.0186) ;Output branch: 17.94 mA at the 12 V rail, 9.08 times the reference rather than the 10:1 resistor ratio
   }
}