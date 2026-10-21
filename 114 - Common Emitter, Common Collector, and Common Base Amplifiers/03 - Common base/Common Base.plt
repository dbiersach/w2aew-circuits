[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(e_in)"}
      X: ('u',1,0.0001,5e-06,0.00013)
      Y[0]: (' ',2,1.843,0.005,1.876)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,1.843,0.005,1.876)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.000115,1.8735) ;Emitter drive after the coupling capacitor, 19.8 mV p-p
   },
   {
      traces: 1 {589828,0,"V(out)"}
      X: ('u',1,0.0001,5e-06,0.00013)
      Y[0]: (' ',2,3.2,0.2,4.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3.2,0.2,4.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 2 (0.000115,4.4) ;Collector output, in phase, 919 mV p-p
   }
}
