[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {589830,0,"V(vin1)"} {589828,0,"V(vin2)"}
      X: ('m',1,0,0.001,0.006)
      Y[0]: (' ',2,-0.2,0.2,1.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.2,0.2,1.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0031,1.45) ;V1 steps to 0.5 V at 1 ms, V2 to 1.0 V at 3 ms
   },
   {
      traces: 1 {589826,0,"V(out)"}
      X: ('m',1,0,0.001,0.006)
      Y[0]: (' ',2,-5,1,1)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-5,1,1)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 2 (0.002,-0.6) ;V1 alone: -(0.5 V)(20k/5k) = -2 V
      Text: "V" 2 (0.0045,-0.6) ;V1 and V2 together: -4.00 V
   }
}
