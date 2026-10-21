[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524294,0,"V(ctrl)"}
      Text: "V" 1 (0.06,2.92) ;FREF = 6 kHz: the VCO must speed up from 9.9 to 12 kHz; V(ctrl) overshoots to 2.94 V, rings, and settles near 2.73 V after about 90 ms
      X: ('m',0,0,0.01,0.12)
      Y[0]: (' ',1,2.4,0.1,3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2.4,0.1,3)
      Log: 0 0 0
      GridStyle: 1
   }
}
