[Transient Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {524291,0,"-I(Rofs)"}
      Text: "A" 1 (0.025,-1.2e-05) ;VOFS = 2.5 V: about 2 uA out
      Text: "A" 1 (0.075,1.5e-05) ;VOFS = 5 V: about 23 uA pushed into the loop filter node
      Text: "A" 1 (0.125,-1.5e-05) ;VOFS = 0 V: about 27 uA pulled out
      X: ('m',0,0,0.01,0.15)
      Y[0]: ('µ',0,-3e-05,1e-05,3e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('µ',0,0,0,-3e-05,1e-05,3e-05)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {268959746,0,"V(ctrl)"}
      Text: "V" 1 (0.075,2.92) ;V(ctrl) is disturbed at each VOFS step but returns to the same 2.73 V, because the reference fixes the frequency; the ripple band grows because PC2 must now pulse every cycle
      X: ('m',0,0,0.01,0.15)
      Y[0]: (' ',1,2.4,0.1,3)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2.4,0.1,3)
      Log: 0 0 0
      GridStyle: 1
   }
}
