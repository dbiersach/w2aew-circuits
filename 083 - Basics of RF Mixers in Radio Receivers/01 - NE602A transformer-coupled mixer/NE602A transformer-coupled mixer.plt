[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {589828,0,"V(rf_src)"}
      Text: "V" 1 (2.5e-07,0.026) ;RF generator, 28.4 MHz at 20 mV peak open circuit, which is -30 dBm into a matched 50 ohm load
      X: ('n',0,0,5e-08,5e-07)
      Y[0]: (' ',0,-0.03,0.01,0.03)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.03,0.01,0.03)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589830,0,"V(lo_src)"}
      Text: "V" 1 (2.5e-07,0.7) ;LO generator, 17.7 MHz at 0.632 V peak open circuit, which is 0 dBm into a matched 50 ohm load
      X: ('n',0,0,5e-08,5e-07)
      Y[0]: (' ',0,-0.8,0.2,0.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.8,0.2,0.8)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(if_raw)"}
      Text: "V" 1 (2.5e-07,0.125) ;Raw IF output across the 1 kohm load: every mixing product at once, before any IF filter
      X: ('n',0,0,5e-08,5e-07)
      Y[0]: (' ',0,-0.14,0.04,0.14)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.14,0.04,0.14)
      Log: 0 0 0
      GridStyle: 1
   }
}
