[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524290,0,"V(Y)"}
      X: ('m',1,0,0.001,0.0054)
      Y[0]: (' ',1,-0.2,0.4,2)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.2,0.4,2)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0027,1.85) ;V(Y): the mirrored collector current sensed by R19, growing with each base step to 1.59 V, or 5.88 mA
   },
   {
      traces: 1 {524290,0,"V(X)"}
      X: ('m',1,0,0.001,0.0054)
      Y[0]: (' ',1,-1,2,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,2,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0027,10) ;V(X): the collector sweep, one sawtooth per 555 pulse, peaking at 7.80 V
   },
   {
      traces: 1 {524290,0,"V(OUT)"}
      X: ('m',1,0,0.001,0.0054)
      Y[0]: (' ',1,-1,2,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,2,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0027,10) ;V(OUT): the stairstep base drive, reaching 8.99 V, which is 19.1 uA through the 470k base resistor
   }
}
