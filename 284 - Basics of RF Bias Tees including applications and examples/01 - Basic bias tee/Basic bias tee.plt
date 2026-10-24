[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(rf_plus_dc)"}
      Text: "V" 1 (4000000,0.525) ;Mid-band holds 0.500 V of a 1 V drive: the 50 ohm source and the 50 ohm load halve it.
      Text: "V" 1 (10000,0.45) ;Half power is 0.3536 V, reached at 156.7 kHz against 159.2 kHz from Alan's fL formula.
      Arrow: "V" 1 2 (10000,0.42) (150000,0.355)
      Text: "V" 1 (30000000,0.155) ;With ideal parts the response never falls again, so there is no upper band edge here.
      X: ('K',0,1000,0,1e+009)
      Y[0]: (' ',2,0,0.05,0.55)
      Y[1]: (' ',0,-80,10,80)
      Volts: (' ',0,0,1,0,0.05,0.55)
      Log: 1 0 0
      GridStyle: 1
      PltMag: 1
   }
}
