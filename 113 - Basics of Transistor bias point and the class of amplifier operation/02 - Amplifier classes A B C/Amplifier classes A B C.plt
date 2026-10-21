[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {268959746,0,"V(base)"}
      X: ('µ',0,0,5e-05,0.0003)
      Y[0]: (' ',2,-1.2,0.5,4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.2,0.5,4)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (2e-05,3.9)
      Text: "V" 1 (0.0002,3.75) ;Raising Rtop lowers the quiescent base voltage
   },
   {
      traces: 1 {268959747,0,"V(collector)"}
      X: ('µ',0,0,5e-05,0.0003)
      Y[0]: (' ',2,3,0.25,6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3,0.25,6)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (2e-05,5.95)
      Text: "V" 2 (0.0002,5.8) ;Less of each cycle is conducted as Rtop rises
   }
}
