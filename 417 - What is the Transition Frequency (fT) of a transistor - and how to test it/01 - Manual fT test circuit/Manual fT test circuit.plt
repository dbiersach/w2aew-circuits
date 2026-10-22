[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"I(Rb)"}
      X: ('u',1,0,1e-06,1e-05)
      Y[0]: ('u',1,4e-05,4e-06,6e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('u',0,0,2,4e-05,4e-06,6e-05)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (7.9e-06,5.88e-05)
      Text: "A" 1 (3.4e-06,5.82e-05) ;Base current, his CH2: 8.60 uA peak to peak at 300 kHz, but 13.32 uA at 3 MHz
   },
   {
      traces: 1 {524290,0,"I(Vcprobe)"}
      X: ('u',1,0,1e-06,1e-05)
      Y[0]: ('m',1,0.009,0.0004,0.0114)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,0.009,0.0004,0.0114)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (7.9e-06,0.01128)
      Text: "A" 1 (3.2e-06,0.01121) ;Collector current, Alan CH1: 1.71 mA peak to peak at 300 kHz, 1.21 mA at 3 MHz
   }
}
