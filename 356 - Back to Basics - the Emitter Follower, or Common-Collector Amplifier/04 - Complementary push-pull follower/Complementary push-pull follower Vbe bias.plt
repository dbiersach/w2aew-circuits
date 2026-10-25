[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(upper_base,lower_base)"}
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',1,1.2,0.1,1.7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,0,1.2,0.1,1.7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(load_out)"}
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',1,-0.3,0.1,0.3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,0,-0.3,0.1,0.3)
      Log: 0 0 0
      GridStyle: 1
   }
}
