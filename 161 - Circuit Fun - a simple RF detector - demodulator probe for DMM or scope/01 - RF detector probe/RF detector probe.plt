[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589829,0,"V(clamped)@6"}
      X: ('u',1,0,2e-07,1e-06)
      Y[0]: ('_',1,-0.5,0.5,2.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,-0.5,0.5,2.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,2.35) ;The probe tip at 1.0 Vrms drive: DCLAMP holds the troughs near zero so the peaks reach 2.35 V
   },
   {
      traces: 3 {589826,0,"V(detected)@2"} {589830,0,"V(detected)@4"} {589828,0,"V(detected)@6"}
      X: ('u',1,0,2e-07,1e-06)
      Y[0]: ('_',1,0,0.5,2.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,0.5,2.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,2.3) ;Detected DC at three of the seven drive levels, each carrying the sawtooth of C2 reloading once per cycle
      Text: "V" 1 (2.2e-07,2.15) ;1.0 Vrms in, 2.06 V out
      Text: "V" 1 (2.2e-07,1.27) ;0.6 Vrms in, 1.10 V out
      Text: "V" 1 (2.2e-07,0.39) ;0.2 Vrms in, 0.21 V out
   }
}
