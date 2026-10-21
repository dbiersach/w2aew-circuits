[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(vin)@1"} {524291,0,"V(vout)@1"}
      Text: "V" 1 (0.002,0.33) ;Drop the level to 0.5 V p-p and the plain diode detector reads nothing at all
      X: ('m',0,0,0.0005,0.004)
      Y[0]: (' ',0,-0.4,0.1,0.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.4,0.1,0.4)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {524290,0,"V(vin)@2"} {524291,0,"V(vout)@2"}
      Text: "V" 1 (0.002,1.62) ;C1 charges near each positive peak, then bleeds off through R1 until the next one
      Text: "V" 1 (0.0029,0.62) ;held output: 0.79 V peak, drooping 0.31 V between peaks
      X: ('m',0,0,0.0005,0.004)
      Y[0]: (' ',0,-1.8,0.5,1.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1.8,0.5,1.8)
      Log: 0 0 0
      GridStyle: 1
   }
}
