[Transient Analysis]
{
   Npanes: 3
   {
      traces: 2 {589827,0,"V(ch1)@3"} {589831,0,"V(ch2)@3"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,9.5) ;VREF = 8 V: the output is asked for 10.93 V and flattens at 8.97 V, a volt short of the rail
   },
   {
      traces: 2 {589828,0,"V(ch1)@2"} {589829,0,"V(ch2)@2"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,9.5) ;VREF = 5 V: 2.07 V to 7.93 V, no clipping at either end
   },
   {
      traces: 2 {589826,0,"V(ch1)@1"} {589830,0,"V(ch2)@1"}
      X: (' ',1,0.0002,0.0001,0.001)
      Y[0]: (' ',1,-1,1,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0006,9.5) ;VREF = 2 V: the output is asked for -0.93 V and flattens at 1.03 V, a volt short of ground
   }
}