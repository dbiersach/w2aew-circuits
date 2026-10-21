[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524290,0,"V(out)"}
      X: ('m',1,0.2,0.05,0.6)
      Y[0]: (' ',0,-3,1,8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3,1,8)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.4,7.2) ;V(OUT): the gain divider and second inverting stage turn that into a rising sweep, -1.01 V to +6.06 V
   },
   {
      traces: 1 {524289,0,"V(inv1)"}
      X: ('m',1,0.2,0.05,0.6)
      Y[0]: (' ',0,-4,1,2)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-4,1,2)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.4,1.4) ;V(INV1): the first LM358 stage inverts the ramp about its 1.71 V reference, +0.43 V down to -2.57 V
   },
   {
      traces: 1 {524288,0,"V(ramp)"}
      X: ('m',1,0.2,0.05,0.6)
      Y[0]: (' ',0,0,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,7)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.4,6.6) ;V(RAMP) on the 22u: the 555 sweeps it between 1/3 and 2/3 of the 9 V rail, 3.00 V to 6.00 V, every 88.0 ms
   }
}
