[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(ch1)"} {524292,0,"V(ch3)"}
      X: ('u',1,3e-06,2.5e-07,5e-06)
      Y[0]: (' ',1,-1.4,0.2,1.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.4,0.2,1.4)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (4e-06,1.25) ;CH3 is probed at its undotted end: the same 1.956 Vpp, opposite sign.
   }
   {
      traces: 2 {524290,0,"V(ch1)"} {524291,0,"V(ch2)"}
      X: ('u',1,3e-06,2.5e-07,5e-06)
      Y[0]: (' ',1,-1.4,0.2,1.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.4,0.2,1.4)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (4e-06,1.25) ;CH2 is probed at its dotted end: 1.956 Vpp against the primary's 1.965 Vpp, in phase.
   }
}
