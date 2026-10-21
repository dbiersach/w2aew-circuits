[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524291,0,"V(shift_bottom)"}
      Text: "V" 1 (0.0035,9.1) ;SHIFT_BOTTOM carries the same AC waveform, lower by the multiplier drop
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,4.6,0.5,9.3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,4.6,0.5,9.3)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00035,9.2)
   },
   {
      traces: 1 {524290,0,"V(shift_top)"}
      Text: "V" 2 (0.0035,9.1) ;SHIFT_TOP sits above the multiplier, at the collector resistor
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,4.6,0.5,9.3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,4.6,0.5,9.3)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00035,9.2)
   },
   {
      traces: 1 {524292,0,"V(shift_top,shift_bottom)"}
      Text: "V" 3 (0.0035,2.3) ;The wiper sets the DC step between the two nodes
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,0,0.3,2.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,0.3,2.4)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00035,2.35)
   }
}
