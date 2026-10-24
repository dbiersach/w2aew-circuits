[Transient Analysis]
{
   Npanes: 3
   {
      traces: 2 {524290,0,"V(ch1)@3"} {524291,0,"V(ch2)@3"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,13)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1,1,13)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,11.5) ;VREF = 8 V: the same impossible 10.93 V demand, and this output reaches 9.96 V
   },
   {
      traces: 2 {524290,0,"V(ch1)@2"} {524291,0,"V(ch2)@2"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,13)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1,1,13)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,11.5) ;VREF = 5 V: 2.07 V to 7.93 V, the same as the 741 when nothing is near a rail
   },
   {
      traces: 2 {524290,0,"V(ch1)@1"} {524291,0,"V(ch2)@1"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,13)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1,1,13)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,11.5) ;VREF = 2 V: the same impossible -0.93 V demand, but this output reaches 35 mV above ground
   }
}