[AC Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {3,0,"V(out)/I(Cdut)"}
      Text: "" 1 (40000,4) ;Below resonance the part behaves as a capacitor, |Z| falling as 1/(2 pi f C)
      Text: "" 1 (14000000,4) ;Above it, as an inductor, |Z| rising as 2 pi f L
      Text: "" 1 (280000,1.35) ;|Z| bottoms out at 2.00 ohm, which is Resr and nothing else
      Arrow: "" 1 2 (1100000,1.4) (3100000,1.9)
      X: ('K',0,10000,0,100000000)
      Y[0]: ('_',0,1,0,3000)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
   },
   {
      traces: 1 {524290,0,"V(out)"}
      Text: "V" 1 (250000,0.85) ;0.751 V peak well below resonance: the capacitor barely loads the pad
      Text: "V" 1 (12000000,0.3) ;30 mV peak at 3.262 MHz, the self-resonant frequency
      Arrow: "V" 1 2 (8000000,0.26) (3350000,0.06)
      X: ('K',0,10000,0,100000000)
      Y[0]: (' ',2,0,0.1,0.9)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.1,0.9)
      Log: 1 0 0
      GridStyle: 1
      PltMag: 1
   }
}
