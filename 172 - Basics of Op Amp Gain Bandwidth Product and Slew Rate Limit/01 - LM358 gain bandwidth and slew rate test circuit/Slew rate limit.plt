[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524291,0,"V(in)"}
      Text: "V" 1 (7e-06,1.28) ;Drive stepped 0.1, 0.4 and 0.8 V peak at 300 kHz
      X: ('u',1,0,2e-06,1e-05)
      Y[0]: (' ',2,-1,0.25,1.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1,0.25,1.5)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (1.3e-06,1.45)
   },
   {
      traces: 1 {524290,0,"V(out)"}
      Text: "V" 1 (7e-06,3.1) ;Doubling the drive barely widens the output: its edges have reached the slew limit
      X: ('u',1,0,2e-06,1e-05)
      Y[0]: (' ',2,2,0.2,3.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2,0.2,3.4)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (1.3e-06,3.37)
   }
}
