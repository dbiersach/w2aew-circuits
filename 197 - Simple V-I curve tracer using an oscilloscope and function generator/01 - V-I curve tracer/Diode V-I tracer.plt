[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {34603011,0,"I(D1)"}
      X: ('m',1,0,0.001,0.006)
      Y[0]: ('m',1,-0.01,0.01,0.09)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.01,0.01,0.09)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0030,0.0815) ;Diode current. Y reads this as 0.70 V across the 10 ohm shunt.
   }
   {
      traces: 2 {524290,0,"V(scope_x)"} {524291,0,"V(scope_x)-V(scope_y)"}
      X: ('m',1,0,0.001,0.006)
      Y[0]: (' ',1,-6,1,3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-6,1,3)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0030,2.45) ;Peaks: X reads 1.51 V, the diode is really at 0.82 V.
   }
}
