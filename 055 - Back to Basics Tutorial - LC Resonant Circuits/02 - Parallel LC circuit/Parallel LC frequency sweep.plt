[AC Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {3,0,"-V(ch1)/I(V1)"}
      Text: "" 1 (33930,7000) ;Impedance of the L1 || C1 tank, Z = CH1 / generator current: magnitude (solid, left axis) and phase (dashed, right axis)
      Text: "" 1 (95000,1500) ;|Z| = 2.19 kohm at f0 = 33.9 kHz
      Arrow: "" 1 2 (70000,1700) (36000,2150)
      Text: "" 1 (11000,3) ;below f0: phase +90 degrees, inductive
      Text: "" 1 (110000,3) ;above f0: phase -90 degrees, capacitive
      X: ('K',0,5000,0,200000)
      Y[0]: ('_',0,1,0,10000)
      Y[1]: (' ',0,-100,20,100)
      Volts: (' ',0,0,1,0,0.25,2.5)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      PltPhi: 1 0
   },
   {
      traces: 1 {524290,0,"V(ch1)"}
      Text: "V" 1 (33930,2.38) ;CH1, the voltage across the parallel tank (generator: 2 V peak behind 50 ohms)
      Text: "V" 1 (90000,2.12) ;peaks at 1.96 V at f0 = 33.9 kHz: the tank is nearly an open circuit
      Arrow: "V" 1 2 (62000,2.08) (35000,1.98)
      Text: "V" 1 (10000,1.2) ;below f0: inductive, loads the generator
      Text: "V" 1 (115000,1.2) ;above f0: capacitive, loads the generator
      X: ('K',0,5000,0,200000)
      Y[0]: (' ',2,0,0.25,2.5)
      Y[1]: (' ',0,-80,10,80)
      Volts: (' ',0,0,1,0,0.25,2.5)
      Log: 1 0 0
      GridStyle: 1
      PltMag: 1
   }
}
