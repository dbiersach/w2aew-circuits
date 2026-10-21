[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(vcc)"}
      Text: "V" 1 (0.0065,13.2) ;The supply is stepped 8 V to 12 V during each run
      X: ('m',1,0,0.001,0.01)
      Y[0]: (' ',2,7.5,0.5,13.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,7.5,0.5,13.5)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524291,0,"V(vx)"}
      Text: "V" 2 (0.0065,2.0) ;A 4 V supply change barely moves the multiplier drop
      X: ('m',1,0,0.001,0.01)
      Y[0]: (' ',2,0.5,0.2,2.1)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0.5,0.2,2.1)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0005,2.05)
   }
}
