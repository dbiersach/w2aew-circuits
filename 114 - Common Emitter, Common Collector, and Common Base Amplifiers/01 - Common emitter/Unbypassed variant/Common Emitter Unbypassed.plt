[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(in)"}
      X: ('u',1,0.0001,5e-06,0.00013)
      Y[0]: ('m',2,-0.08,0.02,0.09)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.08,0.02,0.09)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.000115,0.082) ;Base drive, 100 mV p-p
   },
   {
      traces: 1 {589828,0,"V(out)"}
      X: ('u',1,0.0001,5e-06,0.00013)
      Y[0]: (' ',2,2.2,0.1,2.9)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2.2,0.1,2.9)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 2 (0.000115,2.84) ;Collector output, inverted, 360 mV p-p
   }
}
