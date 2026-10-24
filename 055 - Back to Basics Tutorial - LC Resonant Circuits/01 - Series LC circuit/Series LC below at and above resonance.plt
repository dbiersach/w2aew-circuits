[Transient Analysis]
{
   Npanes: 3
   Active Pane: 2
   {
      traces: 3 {524290,0,"V(ch2)@3"} {524291,0,"V(ch1)@3-V(ch2)@3"} {524292,0,"V(ch1)@3"}
      Text: "V" 1 (5e-05,3.9) ;50 kHz, above resonance: the circuit is inductive.  V(L1) 4.38 V p-p is larger than V(C1) 2.01 V p-p; stack CH1 = 2.36 V p-p
      Text: "V" 1 (6.2e-05,2.9) ;V(L1) = CH2, the larger voltage
      Arrow: "V" 1 2 (6.2e-05,2.75) (6.21e-05,2.25)
      Text: "V" 1 (2.2e-05,2.9) ;CH1 = stack, in step with V(L1)
      Arrow: "V" 1 2 (2.2e-05,2.75) (2.21e-05,1.25)
      Text: "V" 1 (2.2e-05,-3.9) ;V(C1) = CH1 - CH2, opposite to V(L1)
      Arrow: "V" 1 2 (2.2e-05,-3.7) (2.2e-05,-1.08)
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: (' ',0,-4.6,2,4.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-4.6,2,4.6)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 3 {524290,0,"V(ch2)@2"} {524291,0,"V(ch1)@2-V(ch2)@2"} {524292,0,"V(ch1)@2"}
      Text: "V" 1 (5e-05,3.9) ;33.9 kHz, at resonance: V(L1) and V(C1) are equal (3.68 V p-p) and opposite, so they cancel
      Text: "V" 1 (2.1e-05,2.9) ;V(C1) peak
      Arrow: "V" 1 2 (2.1e-05,2.75) (2.1e-05,1.9)
      Text: "V" 1 (2.1e-05,-3.9) ;V(L1) trough at the same instant
      Arrow: "V" 1 2 (2.1e-05,-3.7) (2.1e-05,-1.9)
      Text: "V" 1 (7.2e-05,-3.9) ;CH1 = stack = V(L1) + V(C1): only 78 mV p-p, a near short circuit
      Arrow: "V" 1 2 (7.2e-05,-3.7) (7.2e-05,-0.06)
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: (' ',0,-4.6,2,4.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-4.6,2,4.6)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 3 {524290,0,"V(ch2)@1"} {524291,0,"V(ch1)@1-V(ch2)@1"} {524292,0,"V(ch1)@1"}
      Text: "V" 1 (5e-05,3.9) ;20 kHz, below resonance: the circuit is capacitive.  V(C1) 4.37 V p-p is larger than V(L1) 1.52 V p-p; stack CH1 = 2.85 V p-p
      Text: "V" 1 (8.2e-05,2.9) ;V(C1) = CH1 - CH2, the larger voltage
      Arrow: "V" 1 2 (7.6e-05,2.75) (6.87e-05,2.25)
      Text: "V" 1 (2.7e-05,2.9) ;CH1 = stack, in step with V(C1)
      Arrow: "V" 1 2 (2.3e-05,2.75) (1.86e-05,1.5)
      Text: "V" 1 (1.9e-05,-3.9) ;V(L1) = CH2, opposite to V(C1)
      Arrow: "V" 1 2 (1.9e-05,-3.7) (1.9e-05,-0.82)
      X: ('µ',0,0,1e-05,0.0001)
      Y[0]: (' ',0,-4.6,2,4.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-4.6,2,4.6)
      Log: 0 0 0
      GridStyle: 1
   }
}
