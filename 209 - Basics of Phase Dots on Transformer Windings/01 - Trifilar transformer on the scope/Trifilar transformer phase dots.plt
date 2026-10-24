[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(ch1)"} {524292,0,"V(ch3)"}
      X: ('n',1,1e-07,4e-08,5e-07)
      Y[0]: (' ',1,-1.5,0.5,1.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.5,0.5,1.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (3e-07,1.3) ;CH3 is probed at its undotted end: the same amplitude, opposite sign
   }
   {
      traces: 2 {524290,0,"V(ch1)"} {524291,0,"V(ch2)"}
      X: ('n',1,1e-07,4e-08,5e-07)
      Y[0]: (' ',1,-1.5,0.5,1.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.5,0.5,1.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (3e-07,1.3) ;CH2 is probed at its dotted end: in phase with the primary. 40 ns per division, as Alan has it
   }
}
