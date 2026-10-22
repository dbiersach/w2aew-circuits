[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(scope_ac)"}
      X: ('m',1,0,0.002,0.01)
      Y[0]: ('_',1,-0.6,0.2,0.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,-0.6,0.2,0.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.005,0.5) ;AC coupled: the 8.84 V level is gone and the same 0.80 V ripple is centred on zero
   },
   {
      traces: 1 {524290,0,"V(supply)"}
      X: ('m',1,0,0.002,0.01)
      Y[0]: ('_',1,0,2,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,2,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.005,10.3) ;DC coupled: the supply averages 8.84 V with 0.80 V of ripple riding on it
   }
}
