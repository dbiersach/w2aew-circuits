[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524293,0,"V(ctrl)"}
      Text: "V" 1 (0.07,2.56) ;FREF = 10 kHz: a small correction; V(ctrl) settles just above 2.5 V within a few milliseconds
      Text: "V" 1 (0.07,2.12) ;FREF = 8 kHz: the VCO must slow down; V(ctrl) rings for about 80 ms and settles near 2.29 V
      X: ('m',0,0,0.01,0.12)
      Y[0]: (' ',1,2,0.1,2.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2,0.1,2.6)
      Log: 0 0 0
      GridStyle: 1
   }
}
