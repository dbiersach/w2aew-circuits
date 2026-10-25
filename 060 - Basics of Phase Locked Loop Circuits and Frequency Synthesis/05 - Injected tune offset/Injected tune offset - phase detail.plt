[Transient Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {269025284,0,"V(pc2)"}
      Text: "V" 1 (0.09025,6.1) ;PC2 pulls down to 0 V for that interval every cycle, sinking the injected current through RFILT
      X: ('m',2,0.09,5e-05,0.0905)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {269025282,0,"V(ref)"} {269025286,0,"V(fb)"}
      Text: "V" 1 (0.09025,6.1) ;VOFS = 5 V: FB now rises about 13.5 us before REF, so FB leads by 29 degrees
      X: ('m',2,0.09,5e-05,0.0905)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
