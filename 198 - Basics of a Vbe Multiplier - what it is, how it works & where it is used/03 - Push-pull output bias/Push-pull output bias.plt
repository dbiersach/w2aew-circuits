[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(load_out)"}
      Text: "V" 1 (0.0035,0.42) ;Too little bias leaves a flat notch at every zero crossing
      X: ('m',1,0,0.0005,0.005)
      Y[0]: ('m',2,-0.3,0.1,0.45)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.3,0.1,0.45)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00035,0.44)
   },
   {
      traces: 1 {524291,0,"V(upper_base,lower_base)"}
      Text: "V" 2 (0.0035,2.0) ;The multiplier sets the voltage held across both output base-emitter junctions
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,0.5,0.2,2.1)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0.5,0.2,2.1)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00035,2.05)
   }
}
