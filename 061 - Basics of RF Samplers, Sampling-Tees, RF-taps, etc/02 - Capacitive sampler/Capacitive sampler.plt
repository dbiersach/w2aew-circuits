[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589828,0,"V(SAMPLE_OUT)"}
      X: ('u',0,0,1e-07,1e-06)
      Y[0]: ('m',0,-0.009,0.0025,0.0135)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.009,0.0025,0.0135)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,0.0119) ;V(SAMPLE_OUT), the tap: about 5.6 mV RMS, set by the 5 pF against the 50 ohm load
   }
   {
      traces: 1 {524290,0,"V(RF_THROUGH)"}
      X: ('u',0,0,1e-07,1e-06)
      Y[0]: (' ',0,-0.55,0.1,0.75)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.55,0.1,0.75)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,0.65) ;V(RF_THROUGH), the main path: about 353 mV RMS, loaded even less than by the resistive tap
   }
}
