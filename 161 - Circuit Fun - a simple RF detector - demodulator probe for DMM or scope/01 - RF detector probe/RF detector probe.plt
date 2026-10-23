[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524293,0,"V(clamped)@6"}
      X: ('u',1,0,2e-06,1e-05)
      Y[0]: ('_',1,-0.5,0.5,2.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,-0.5,0.5,2.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-06,2.35) ;The probe tip at 1.0 Vrms drive: DCLAMP holds the troughs near zero so the peaks reach 2.31 V
   },
   {
      traces: 3 {524290,0,"V(detected)@2"} {524291,0,"V(detected)@4"} {524292,0,"V(detected)@6"}
      X: ('u',1,0,2e-06,1e-05)
      Y[0]: ('_',1,0,0.5,2.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,0.5,2.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-06,2.3) ;Detected DC at three of the seven drive levels, each carrying the sawtooth of C2 reloading once per cycle
      Text: "V" 1 (2.2e-06,2.15) ;1.0 Vrms in, 1.99 V out
      Text: "V" 1 (2.2e-06,1.24) ;0.6 Vrms in, 1.07 V out
      Text: "V" 1 (2.2e-06,0.39) ;0.2 Vrms in, 0.21 V out
   }
}
