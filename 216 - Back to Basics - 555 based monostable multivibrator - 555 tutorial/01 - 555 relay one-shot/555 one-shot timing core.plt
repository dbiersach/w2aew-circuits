[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(timing)"}
      X: (' ',1,0,0.2,1.4)
      Y[0]: (' ',1,0,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.7,5.1) ;V(TIMING) on the 2.2u, charging through 470k toward the 3.33 V threshold that ends the pulse
   },
   {
      traces: 2 {524290,0,"V(trig)"} {524291,0,"V(out)"}
      X: (' ',1,0,0.2,1.4)
      Y[0]: (' ',1,0,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.7,5.1) ;V(TRIG) and V(OUT): the same 1.1376 s pulse with the relay driver taken away
   }
}
