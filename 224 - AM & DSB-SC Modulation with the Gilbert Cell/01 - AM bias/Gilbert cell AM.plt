[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(l_sig)-V(l_ref)"}
      X: ('m',1,0.01,0.001,0.014)
      Y[0]: ('m',1,-0.02,0.01,0.045)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.02,0.01,0.045)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.012,0.041) ;Lower-pair drive stays between +9.2 mV and +39.0 mV, so Q5 never hands over to Q6
   },
   {
      traces: 1 {589826,0,"V(col_a)-V(col_b)"}
      X: ('m',1,0.01,0.001,0.014)
      Y[0]: ('m',1,-0.45,0.1,0.45)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.45,0.1,0.45)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.012,0.4) ;Collector difference: the 18 kHz carrier survives the envelope minima, which is AM
   }
}
