[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {589828,0,"V(base)@1-1.745"} {589829,0,"V(base)@2-1.745"}
      Text: "V" 1 (0.002,0.0345) ;V(base)@1, 4.7u bypass: 37.0 mV p-p.  V(base)@2, 100u bypass: 26.0 mV p-p
      Text: "V" 1 (0.002,0.0285) ;Drawn 10 mV per division as Alan sets channel 1, where his screen reads 18 mV
      X: ('m',1,0,0.0004,0.004)
      Y[0]: ('m',2,-0.04,0.01,0.04)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.04,0.01,0.04)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {589826,0,"V(collector)@2-4.634"} {589830,0,"V(collector)@1-4.634"}
      Text: "V" 2 (0.002,3.75) ;V(collector)@2, 100u bypass: 6.43 V p-p, gain 247, and Alan's scope math reads 250
      Text: "V" 6 (0.002,3.40) ;V(collector)@1, 4.7u bypass: 5.66 V p-p, gain 153, and shifted in phase by the capacitor reactance
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',2,-4,0.5,4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-4,0.5,4)
      Log: 0 0 0
      GridStyle: 1
   }
}
