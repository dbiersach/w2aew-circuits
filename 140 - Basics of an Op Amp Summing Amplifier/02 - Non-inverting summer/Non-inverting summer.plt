[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(vin1)"} {524291,0,"V(vin2)"}
      X: ('m',1,0,0.001,0.006)
      Y[0]: (' ',2,-0.2,0.2,1.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.2,0.2,1.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0031,1.45) ;V1 steps to 0.5 V at 1 ms, V2 to 1.0 V at 3 ms
   },
   {
      traces: 1 {524292,0,"V(out)"}
      X: ('m',1,0,0.001,0.006)
      Y[0]: (' ',2,-0.2,0.4,2.2)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.2,0.4,2.2)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 2 (0.002,2.0) ;V1 alone: 2 x (0.5 V)(10k/15k) = 0.667 V
      Text: "V" 2 (0.0045,2.0) ;V1 and V2 together: 1.333 V
   }
}
