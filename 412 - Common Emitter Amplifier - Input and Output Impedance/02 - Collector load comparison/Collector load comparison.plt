[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {589828,0,"V(base)@2-1.745"} {589829,0,"V(base)@1-1.745"}
      Text: "V" 1 (0.002,0.70) ;V(base)@1 and V(base)@2 lie on top of each other at 694 mV p-p
      Text: "V" 1 (0.002,0.52) ;A load on the collector does nothing to the signal arriving at the input
      X: ('m',1,0,0.0004,0.004)
      Y[0]: ('m',2,-0.8,0.2,0.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.8,0.2,0.8)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {589826,0,"V(collector)@2-4.634"} {589830,0,"V(collector)@1-4.632"}
      Text: "V" 2 (0.002,2.88) ;V(collector)@2, output open: 4.54 V p-p, gain 6.54
      Text: "V" 2 (0.002,2.58) ;V(collector)@1, Alan's 10k load: 2.72 V p-p, gain 3.92, and his scope reads 3.94
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',2,-3,0.5,3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-3,0.5,3)
      Log: 0 0 0
      GridStyle: 1
   }
}
