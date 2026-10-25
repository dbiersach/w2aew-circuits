[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {589829,0,"V(collector)-V(emitter)"}
      X: ('m',1,0,0.001,0.005)
      Y[0]: ('_',1,0,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0025,4.9) ;ADD with INVERT CH2 subtracts: 1.94 Vpp, twice either channel on its own
   },
   {
      traces: 1 {589828,0,"V(collector)+V(emitter)"}
      X: ('m',1,0,0.001,0.005)
      Y[0]: ('_',1,0,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0025,2.6) ;ADD on its own: 0.97 V in each channel cancels to 4.8 mVpp, leaving the two DC levels
   },
   {
      traces: 2 {589826,0,"V(collector)"} {589830,0,"V(emitter)"}
      X: ('m',1,0,0.001,0.005)
      Y[0]: ('_',1,0,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0025,4.95) ;V(collector): 0.97 Vpp riding on 3.99 V
      Text: "V" 1 (0.0025,2.4) ;V(emitter): the same 0.97 Vpp, opposite phase, riding on 1.02 V
   }
}
