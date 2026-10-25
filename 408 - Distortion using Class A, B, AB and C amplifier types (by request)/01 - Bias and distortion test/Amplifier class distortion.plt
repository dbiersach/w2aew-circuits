[Transient Analysis]
{
   Npanes: 4
   {
      traces: 1 {589829,0,"V(collector)@1"}
      X: ('m',1,0,0.0005,0.004)
      Y[0]: (' ',1,3,2,14)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3,2,14)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,13.2) ;Bias 0.45 V, class C: short bursts of conduction, the collector near 12 V the rest of the time. THD 73.5 percent.
   }
   {
      traces: 1 {589828,0,"V(collector)@2"}
      X: ('m',1,0,0.0005,0.004)
      Y[0]: (' ',1,3,2,14)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3,2,14)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,13.2) ;Bias 0.65 V, class B: conducting for roughly half the cycle. THD 30.6 percent.
   }
   {
      traces: 1 {589830,0,"V(collector)@3"}
      X: ('m',1,0,0.0005,0.004)
      Y[0]: (' ',1,3,2,14)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3,2,14)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,13.2) ;Bias 0.70 V, class AB: more than half the cycle but still cutting off. THD 22.4 percent.
   }
   {
      traces: 1 {589826,0,"V(collector)@4"}
      X: ('m',1,0,0.0005,0.004)
      Y[0]: (' ',1,3,2,14)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3,2,14)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,13.2) ;Bias 1.10 V, class A: conducting all the way round, swinging through most of the collector range. THD 0.84 percent.
   }
}
