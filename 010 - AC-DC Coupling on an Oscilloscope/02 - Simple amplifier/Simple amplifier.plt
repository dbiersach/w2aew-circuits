[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {589828,0,"V(base)"}
      X: ('m',1,0,0.002,0.01)
      Y[0]: ('_',1,1.6,0.1,2.2)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,1.6,0.1,2.2)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.005,2.15) ;Input at the base: 0.40 Vpp riding on 1.87 V
   },
   {
      traces: 1 {589830,0,"V(scope_ac)"}
      X: ('m',1,0,0.002,0.01)
      Y[0]: ('_',1,-1.5,0.5,1.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,-1.5,0.5,1.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.005,1.3) ;AC coupled: the 5.93 V level is gone, the 1.99 Vpp signal is untouched
   },
   {
      traces: 1 {589826,0,"V(collector)"}
      X: ('m',1,0,0.002,0.01)
      Y[0]: ('_',1,0,2,13)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,2,13)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.005,12.1) ;DC coupled: 1.99 Vpp inverted output sitting on a 5.93 V collector level
   }
}
