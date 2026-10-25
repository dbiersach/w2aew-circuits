[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(in)"}
      X: ('u',1,0.0001,5e-06,0.00013)
      Y[0]: ('m',2,-0.016,0.004,0.018)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.016,0.004,0.018)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.000115,0.0164) ;Base drive, 20 mV p-p
   },
   {
      traces: 1 {589826,0,"V(out)"}
      X: ('u',1,0.0001,5e-06,0.00013)
      Y[0]: (' ',2,0.8,0.4,3.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0.8,0.4,3.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 2 (0.000115,3.5) ;Collector output, inverted, 1.85 V p-p
   }
}
