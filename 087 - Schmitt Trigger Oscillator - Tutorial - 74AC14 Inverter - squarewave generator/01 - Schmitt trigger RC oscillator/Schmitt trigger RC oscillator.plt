[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(rc)"}
      X: ('m',1,0.001,0.0003,0.0025)
      Y[0]: (' ',0,0,1,6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00175,5.6) ;V(RC): the timing capacitor ramping between the proxy's 1.8 V and 3.2 V thresholds
   }
   {
      traces: 1 {589826,0,"V(out)"}
      X: ('m',1,0.001,0.0003,0.0025)
      Y[0]: (' ',0,-0.5,1,6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.5,1,6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00175,5.6) ;V(OUT): the square wave, one edge each time V(RC) reaches a threshold, 367.8 us per cycle
   }
}
