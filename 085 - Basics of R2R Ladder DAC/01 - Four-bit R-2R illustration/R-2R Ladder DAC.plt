[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(b0)"}
      Text: "V" 1 (0.002,4.4) ;B0 from the ripple counter: the fastest bit, one step per 100 us clock
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',0,-1,1,5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,5)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(vout)"}
      Text: "V" 1 (0.002,3.8) ;Ladder output: a repeating 16-step staircase, 206 mV per step
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',0,0,0.5,4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,4)
      Log: 0 0 0
      GridStyle: 1
   }
}
