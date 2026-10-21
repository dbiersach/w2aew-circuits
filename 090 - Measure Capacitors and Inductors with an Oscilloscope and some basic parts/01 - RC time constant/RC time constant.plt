[Transient Analysis]
{
   Npanes: 1
   {
      traces: 2 {524290,0,"V(input)"} {524291,0,"V(cap)"}
      X: ('u',1,5e-06,5e-06,4.5e-05)
      Y[0]: (' ',0,-0.5,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.5,1,7)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5e-05,6.6) ;V(INPUT) is the fast edge, V(CAP) the capacitor charging through the 1 kohm
      Text: "V" 1 (2.9e-05,3.9) ;at 20 us the capacitor has reached 3.1605 V, 63.2 percent of the 5 V step
      Text: "V" 1 (2.9e-05,1.6) ;so t = RC = 10 us, and C = t / R = 10.0 nF
   }
}
