[AC Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {3,0,"V(ch1)/I(C1)"}
      Text: "" 1 (33930,4500) ;Impedance of the C1 + L1 stack, Z = CH1 / I(C1): magnitude (solid, left axis) and phase (dashed, right axis)
      Text: "" 1 (85000,2.2) ;|Z| = 1.0 ohm at f0 = 33.9 kHz (L1's winding resistance)
      Arrow: "" 1 2 (60000,1.9) (35500,1.1)
      Text: "" 1 (11000,25) ;below f0: phase -90 degrees, capacitive
      Text: "" 1 (110000,25) ;above f0: phase +90 degrees, inductive
      X: ('K',0,5000,0,200000)
      Y[0]: ('_',0,0.1,0,10000)
      Y[1]: (' ',0,-100,20,100)
      Volts: (' ',0,0,1,0,0.25,2.5)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      PltPhi: 1 0
   },
   {
      traces: 1 {524290,0,"V(ch1)"}
      Text: "V" 1 (33930,2.38) ;CH1, the voltage across the series stack (generator: 2 V peak behind 50 ohms)
      Text: "V" 1 (90000,0.5) ;dips to 39 mV at f0 = 33.9 kHz: the series LC is nearly a short circuit
      Arrow: "V" 1 2 (60000,0.42) (35000,0.07)
      Text: "V" 1 (10000,1.0) ;below f0: capacitive
      Text: "V" 1 (115000,1.0) ;above f0: inductive
      X: ('K',0,5000,0,200000)
      Y[0]: (' ',2,0,0.25,2.5)
      Y[1]: (' ',0,-80,10,80)
      Volts: (' ',0,0,1,0,0.25,2.5)
      Log: 1 0 0
      GridStyle: 1
      PltMag: 1
   }
}
