[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(out)@1"}
      Text: "V" 1 (1.5e-07,0.62) ;LBEAD stepped to 1 nH, standing in for a plain wire: the 2 ns edge arrives in 1.6 ns
      X: ('n',0,0,5e-08,3e-07)
      Y[0]: (' ',0,-0.1,0.1,0.7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.1,0.1,0.7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(out)@2"}
      Text: "V" 1 (1.5e-07,0.62) ;LBEAD = 1 uH, the bead in place: the same edge now takes 29.9 ns and the square wave rounds off
      X: ('n',0,0,5e-08,3e-07)
      Y[0]: (' ',0,-0.1,0.1,0.7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.1,0.1,0.7)
      Log: 0 0 0
      GridStyle: 1
   }
}
