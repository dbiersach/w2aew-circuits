[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524291,0,"I(LCOIL)"}
      X: ('m',1,0.0099,0.0005,0.013)
      Y[0]: ('m',1,-0.01,0.01,0.06)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.01,0.01,0.06)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.01145,0.045) ;The same 52.5 mA keeps flowing, now round through the diode, decaying with L over R
   },
   {
      traces: 1 {524290,0,"V(collector)"}
      X: ('m',1,0.0099,0.0005,0.013)
      Y[0]: ('_',1,0,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,1,7)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.01145,6.5) ;Clamped at 5.79 V, which is the 5 V rail plus one diode drop and nothing more
   }
}
