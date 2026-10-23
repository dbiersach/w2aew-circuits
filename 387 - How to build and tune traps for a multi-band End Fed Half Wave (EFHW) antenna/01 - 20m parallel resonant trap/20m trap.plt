[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(trap_out)"}
      Text: "V" 1 (1.3e+007,0.55) ;A parallel LC is never a short circuit, so the fixture never passes the full 0.5 V even well off resonance.
      Text: "V" 1 (8.6e+006,0.0045) ;Deepest at 14.2 MHz: 0.45 mV, or -67 dB.
      Arrow: "V" 1 2 (1.15e+007,0.004) (1.405e+007,0.0008)
      Text: "V" 1 (2.0e+007,0.03) ;At 14.35 MHz, the top of the band, it is already 10 dB shallower.
      X: ('M',0,5e+006,5e+006,2.5e+007)
      Y[0]: ('_',0,0.0001,0,1)
      Y[1]: (' ',0,-100,20,100)
      Volts: (' ',0,0,1,0,0.25,2.5)
      Log: 0 1 0
      GridStyle: 1
      PltMag: 1
   }
}
