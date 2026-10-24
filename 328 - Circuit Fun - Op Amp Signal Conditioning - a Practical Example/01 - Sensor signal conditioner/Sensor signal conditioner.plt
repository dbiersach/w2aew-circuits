[DC transfer characteristic]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(conditioned_out)"}
      X: (' ',1,0,0.5,3)
      Y[0]: (' ',2,0,0.5,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,0.5,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.1,5.15) ;0.5 V from the sensor gives 4.979 V out, against Alan's target of 5 V.
      Arrow: "V" 1 2 (0.62,5.05) (0.51,4.99)
      Text: "V" 1 (1.75,0.6) ;2.5 V gives 8.9 mV, against his target of 0 V.
      Arrow: "V" 1 2 (2.3,0.5) (2.49,0.06)
      Text: "V" 1 (1.0,1.2) ;The slope is -2.485, which is -82k / 33k rather than exactly -2.5: the price of standard values.
   }
}
