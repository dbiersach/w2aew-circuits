[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(u_sig)-V(u_ref)"} {524291,0,"V(l_sig)-V(l_ref)"}
      Text: "V" 1 (0.0115,0.085) ;10 kHz upper drive and 500 Hz lower drive, both differential
      X: ('m',0,0,0.002,0.016)
      Y[0]: ('m',2,-0.07,0.02,0.11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.07,0.02,0.11)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524292,0,"V(col_a)-V(col_b)"}
      Text: "V" 2 (0.0115,0.45) ;The 10 kHz output reverses polarity and collapses at every 500 Hz zero crossing
      X: ('m',0,0,0.002,0.016)
      Y[0]: ('m',2,-0.4,0.1,0.55)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.4,0.1,0.55)
      Log: 0 0 0
      GridStyle: 1
   }
}
