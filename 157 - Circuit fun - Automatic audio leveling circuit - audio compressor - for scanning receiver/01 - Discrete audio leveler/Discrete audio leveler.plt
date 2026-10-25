[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {589828,0,"V(ins)@1"} {589829,0,"V(ins)@4"}
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',1,-2.6,0.5,2.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-2.6,0.5,2.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0025,2.3) ;V(INS): the two extremes of the drive, 0.200 V and 4.00 V peak to peak, a twenty to one range
   },
   {
      traces: 2 {589826,0,"V(out)@1"} {589830,0,"V(out)@4"}
      X: ('m',1,0,0.0005,0.005)
      Y[0]: ('m',1,-0.045,0.01,0.045)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.045,0.01,0.045)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0025,0.04) ;V(OUT) for those same two drives: 36.4 mV and 38.4 mV peak to peak, barely five percent apart
   }
}
