[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(tank)"}
      X: ('u',1,0,3e-07,3e-06)
      Y[0]: ('m',0,-0.06,0.02,0.1)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.06,0.02,0.1)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.5e-06,0.09) ;V(TANK) rings after the fast edge at 100 ns, decaying through the coil's series loss
      Text: "V" 1 (1.7e-06,0.072) ;632 ns per cycle, so 1.582 MHz; with CKNOWN = 1 nF that gives L = 10.1 uH
   }
}
