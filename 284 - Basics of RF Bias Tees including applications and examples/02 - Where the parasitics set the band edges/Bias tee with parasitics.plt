[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(rf_plus_dc)"}
      Text: "V" 1 (4000000,0.525) ;Still 0.500 V across the middle, so the two parasitics cost nothing inside the band.
      Text: "V" 1 (10000,0.45) ;Half power at 156.8 kHz, set by C1 exactly as before.
      Arrow: "V" 1 2 (10000,0.42) (150000,0.355)
      Text: "V" 1 (25000000,0.155) ;Half power again at 660 MHz, set by the 10 pF across L1.
      Arrow: "V" 1 2 (300000000,0.17) (650000000,0.34)
      X: ('K',0,1000,0,1e+009)
      Y[0]: (' ',2,0,0.05,0.55)
      Y[1]: (' ',0,-80,10,80)
      Volts: (' ',0,0,1,0,0.05,0.55)
      Log: 1 0 0
      GridStyle: 1
      PltMag: 1
   }
}
