[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524290,0,"V(PULSE)"}
      X: ('m',1,0,0.005,0.025)
      Y[0]: (' ',1,-1,2,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,2,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0125,10) ;V(PULSE): the slower relaxation oscillator that fires Q1 and Q2 to reset the staircase
   },
   {
      traces: 1 {524290,0,"V(CLOCK)"}
      X: ('m',1,0,0.005,0.025)
      Y[0]: (' ',1,-1,2,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,2,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0125,10) ;V(CLOCK): the 555's narrow pulses, one per step
   },
   {
      traces: 1 {524290,0,"V(OUT)"}
      X: ('m',1,0,0.005,0.025)
      Y[0]: (' ',1,-1,2,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,2,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0125,10) ;V(OUT): one rising step per clock pulse, dropped back to zero by each reset
   }
}
