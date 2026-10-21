[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(output)"}
      Text: "V" 1 (0.00195,0.068) ;The output falls in the same proportion, 77.9 mV to 40.0 mV p-p
      X: ('m',1,0,0.0005,0.003)
      Y[0]: ('m',2,-0.05,0.02,0.075)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.05,0.02,0.075)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0002,0.072)
   },
   {
      traces: 1 {524291,0,"V(base)"}
      Text: "V" 2 (0.00195,1.776) ;6.5 k of source resistance halves the base signal, 19.85 mV to 10.18 mV p-p
      X: ('m',1,0,0.0005,0.003)
      Y[0]: (' ',2,1.725,0.01,1.785)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,1.725,0.01,1.785)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0002,1.782)
   }
}
