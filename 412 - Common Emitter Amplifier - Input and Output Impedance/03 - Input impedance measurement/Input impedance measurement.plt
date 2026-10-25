[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {589828,0,"V(collector)@1-4.634"} {589829,0,"V(collector)@2-4.634"}
      Text: "V" 1 (0.002,2.88) ;CH2 follows the base down: V(collector)@1 is 4.54 V p-p, V(collector)@2 is 2.32 V p-p
      Text: "V" 1 (0.002,2.58) ;Base-to-collector gain is 6.54 in both runs, so the stage itself has not changed
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',2,-3,0.5,3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-3,0.5,3)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {589826,0,"V(base)@1-1.745"} {589830,0,"V(base)@2-1.745"}
      Text: "V" 2 (0.002,0.70) ;V(base)@1, substitution box at 0: CH1 reads 694 mV p-p
      Text: "V" 2 (0.002,0.52) ;V(base)@2, box at 6.5k: CH1 reads 355 mV p-p, half, so the input impedance is 6.5k
      X: ('m',1,0,0.0004,0.004)
      Y[0]: ('m',2,-0.8,0.2,0.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.8,0.2,0.8)
      Log: 0 0 0
      GridStyle: 1
   }
}
