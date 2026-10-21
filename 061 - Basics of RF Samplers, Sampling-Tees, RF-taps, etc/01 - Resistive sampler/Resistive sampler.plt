[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589828,0,"V(SAMPLE_OUT)"}
      X: ('u',0,0,1e-07,1e-06)
      Y[0]: ('m',0,-0.014,0.005,0.019)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.014,0.005,0.019)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,0.0168) ;V(SAMPLE_OUT), the tap: about 8.5 mV RMS into the 50 ohm sampling load
   }
   {
      traces: 1 {524290,0,"V(RF_THROUGH)"}
      X: ('u',0,0,1e-07,1e-06)
      Y[0]: (' ',0,-0.55,0.1,0.75)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.55,0.1,0.75)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,0.65) ;V(RF_THROUGH), the main path: about 345 mV RMS, barely disturbed by the tap
   }
}
