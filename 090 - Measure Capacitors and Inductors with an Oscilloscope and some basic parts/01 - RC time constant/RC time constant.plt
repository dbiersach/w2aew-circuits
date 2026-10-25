[Transient Analysis]
{
   Npanes: 1
   {
      traces: 2 {589826,0,"V(input)"} {589830,0,"V(cap)"}
      X: ('u',1,5e-06,5e-06,4.5e-05)
      Y[0]: (' ',0,-0.5,1,8.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.5,1,8.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5e-05,8.0) ;V(INPUT) is the fast edge, V(CAP) the capacitor charging through the 1 kohm
      Text: "V" 1 (2.5e-05,7.2) ;at 20 us the capacitor has reached 3.1605 V, 63.2 percent of the 5 V step
      Arrow: "V" 1 2 (2.5e-05,7.05) (2e-05,3.3)
      Text: "V" 1 (2.5e-05,6.4) ;so t = RC = 10 us, and C = t / R = 10.0 nF
   }
}
