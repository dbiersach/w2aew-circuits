[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(Z)"}
      X: ('M',0,10000,0,1e+009)
      Y[0]: (' ',0,0.1,10,1000000)
      Y[1]: (' ',0,-180,90,180)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      PltPhi: 0 0
      Text: "V" 1 (150000,450000) ;V(Z) reads in ohms: I1 is a 1 A probe
      Text: "V" 1 (400000,2.5) ;inductive below resonance, Z = 2*pi*f*L for the 10 uH
      Text: "V" 1 (1700000,300000) ;parallel self-resonance near 22.5 MHz, where Z peaks near 80 kohm
      Text: "V" 1 (150000000,4000) ;capacitive above resonance, set by the 5 pF between windings
   }
}
