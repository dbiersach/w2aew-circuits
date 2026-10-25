[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"I(LCOIL)"}
      X: ('m',1,0.01,1e-06,0.010006)
      Y[0]: ('m',1,-0.01,0.01,0.06)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.01,0.01,0.06)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.0100035,0.045) ;The 52.6 mA standing in the coil is gone in about two microseconds
   },
   {
      traces: 1 {589826,0,"V(collector)"}
      X: ('m',1,0.01,1e-06,0.010006)
      Y[0]: ('_',1,0,500,2800)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,500,2800)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0100035,2600) ;Driven to 2585 V, a figure this model permits and a real 300 V MPSA42 never could
   }
}
