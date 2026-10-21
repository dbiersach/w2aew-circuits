[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524291,0,"V(base)"}
      Text: "V" 1 (0.00195,1.776) ;The base signal is unchanged: the load acts on the collector, not the input
      X: ('m',1,0,0.0005,0.003)
      Y[0]: (' ',2,1.725,0.01,1.785)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,1.725,0.01,1.785)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0002,1.782)
   },
   {
      traces: 1 {524290,0,"V(output)"}
      Text: "V" 2 (0.00195,0.112) ;Alan's 10 k load cuts the output from 130 mV to 78 mV p-p
      X: ('m',1,0,0.0005,0.003)
      Y[0]: ('m',2,-0.08,0.02,0.12)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.08,0.02,0.12)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0002,0.117)
   }
}
