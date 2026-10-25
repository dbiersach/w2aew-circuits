[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(base)-1.745"}
      Text: "V" 1 (0.002,0.70) ;CH1 at the base, 694 mV p-p, drawn 200 mV per division as Alan sets channel 1
      Text: "V" 1 (0.002,0.52) ;The 1.745 V divider bias is subtracted, which is what his AC-coupled channel does
      X: ('m',1,0,0.0004,0.004)
      Y[0]: ('m',2,-0.8,0.2,0.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.8,0.2,0.8)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(collector)-4.634"}
      Text: "V" 2 (0.002,2.88) ;CH2 at the collector, 4.54 V p-p, drawn 500 mV per division as Alan sets channel 2
      Text: "V" 2 (0.002,2.58) ;CH2 over CH1 is 6.54; his scope math trace reads 6.7 and RC/RE predicts 6.8
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',2,-3,0.5,3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-3,0.5,3)
      Log: 0 0 0
      GridStyle: 1
   }
}
