[Transient Analysis]
{
   Npanes: 1
   {
      traces: 3 {524290,0,"V(ch3)"} {524291,0,"V(ch2)"} {524292,0,"V(ch1)"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,10.4) ;LM741 at a 5 V reference: output 2.07 V to 7.93 V, the full swing the 1.47 gain asks for
      Text: "V" 1 (0.0006,-0.5) ;The 0 V and 10 V supply rails are the top and bottom of the room this amplifier has
   }
}