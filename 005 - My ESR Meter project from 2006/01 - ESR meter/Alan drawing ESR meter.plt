[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(dut_lo)"}
      X: ('m',1,0.001,1e-05,0.00106)
      Y[0]: ('m',1,-0.12,0.04,0.16)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.12,0.04,0.16)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.001028,0.138) ;The sense voltage the capacitor's ESR divides down against the 100 ohm load
   },
   {
      traces: 1 {524290,0,"I(RmeterMovement)"}
      X: ('m',1,0.001,1e-05,0.00106)
      Y[0]: ('u',1,6e-05,2e-05,0.00019)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('u',0,0,2,6e-05,2e-05,0.00019)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.0010465,0.000184)
      Text: "A" 1 (0.0010215,0.000176) ;Settled meter current: 149, 142 and 87 uA for 0.1, 1 and 10 ohm of ESR
   }
}
