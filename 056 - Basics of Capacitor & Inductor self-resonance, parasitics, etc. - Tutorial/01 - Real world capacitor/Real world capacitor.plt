[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(Z)"}
      X: ('M',0,10000,0,1e+009)
      Y[0]: (' ',0,0.01,10,10000)
      Y[1]: (' ',0,-180,90,180)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
      PltPhi: 0 0
      Text: "V" 1 (130000,4500) ;V(Z) reads in ohms: I1 is a 1 A probe
      Text: "V" 1 (330000,1.1) ;capacitive below resonance, Z = 1/(2*pi*f*C) for the 10 nF
      Text: "V" 1 (1600000,0.022) ;series self-resonance near 6.67 MHz, where Z bottoms out at Rs = 0.1 ohm
      Text: "V" 1 (33000000,1800) ;inductive above resonance, set by the 57 nH of lead
   }
}
