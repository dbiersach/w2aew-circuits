[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(out)"}
      X: ('m',1,0,0.0002,0.002)
      Y[0]: (' ',1,0,1,6.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,1,6.5)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00154,6.4)
      Text: "V" 1 (0.00062,6.15) ;The negative peaks flatten against ground at the three low trim settings
      Text: "V" 1 (0.00072,5.65) ;At 300 ohm the sine is clear of both rails, but it is dying away
   }
}
