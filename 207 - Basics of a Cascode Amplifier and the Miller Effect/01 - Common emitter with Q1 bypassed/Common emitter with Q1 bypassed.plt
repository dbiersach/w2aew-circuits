[AC Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(q2_col)"}
      Text: "V" 1 (300000,30) ;Q2's collector swings 6.51 V/V, and its base-collector capacitance sees all of it
      X: ('K',0,10000,0,2e+08)
      Y[0]: (' ',2,0.001,0,100)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0.001,0,100)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
   },
   {
      traces: 1 {589826,0,"V(out)"}
      Text: "V" 2 (300000,30) ;Peak 26.68 dB at 2.40 MHz, 3 dB down by 4.04 MHz
      X: ('K',0,10000,0,2e+08)
      Y[0]: (' ',2,0.001,0,100)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0.001,0,100)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
   }
}
