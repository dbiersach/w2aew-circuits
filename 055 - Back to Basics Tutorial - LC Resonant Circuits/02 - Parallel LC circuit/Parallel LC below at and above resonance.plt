[Transient Analysis]
{
   Npanes: 4
   Active Pane: 3
   {
      traces: 3 {34603011,0,"I(L1)@2"} {34603012,0,"I(C1)@2"} {34603013,0,"-I(V1)@2"}
      Text: "A" 1 (5e-05,0.066) ;Branch currents at resonance (33.9 kHz): I(L1) and I(C1) are equal (83 mA p-p) and opposite
      Text: "A" 1 (2.1e-05,0.054) ;I(L1) peak
      Arrow: "A" 1 2 (2.1e-05,0.05) (2.1e-05,0.043)
      Text: "A" 1 (2.1e-05,-0.058) ;I(C1) trough at the same instant
      Arrow: "A" 1 2 (2.1e-05,-0.054) (2.1e-05,-0.043)
      Text: "A" 1 (7.2e-05,-0.058) ;generator current -I(V1): only 1.8 mA p-p
      Arrow: "A" 1 2 (7.2e-05,-0.054) (7.2e-05,-0.002)
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: ('m',0,-0.07,0.02,0.075)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,-0.07,0.02,0.075)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(ch1)@3"}
      Text: "V" 1 (5e-05,2.9) ;50 kHz, above resonance: the tank is capacitive and loads the 50 ohm generator; CH1 = 3.03 V p-p
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: (' ',0,-3,1,3.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3,1,3.5)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(ch1)@2"}
      Text: "V" 1 (5e-05,2.9) ;33.9 kHz, at resonance: the tank is nearly an open circuit; CH1 = 3.91 V p-p, almost the 4 V p-p open-circuit generator voltage
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: (' ',0,-3,1,3.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3,1,3.5)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(ch1)@1"}
      Text: "V" 1 (5e-05,2.9) ;20 kHz, below resonance: the tank is inductive and loads the generator; CH1 = 2.52 V p-p
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: (' ',0,-3,1,3.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3,1,3.5)
      Log: 0 0 0
      GridStyle: 1
   }
}
