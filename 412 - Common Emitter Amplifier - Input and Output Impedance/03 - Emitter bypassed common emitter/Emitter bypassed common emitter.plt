[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(output)"}
      Text: "V" 1 (0.00195,1.68) ;The same 19.7 mV at the base now drives 1.85 V p-p at the output
      X: ('m',1,0,0.0005,0.003)
      Y[0]: (' ',2,-1.2,0.4,1.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.2,0.4,1.8)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0002,1.75)
   },
   {
      traces: 1 {524291,0,"V(base)"}
      Text: "V" 2 (0.00195,1.776) ;Bypassed, only 4.7 k is needed to halve the base signal: the input impedance has fallen
      X: ('m',1,0,0.0005,0.003)
      Y[0]: (' ',2,1.725,0.01,1.785)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,1.725,0.01,1.785)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0002,1.782)
   }
}
