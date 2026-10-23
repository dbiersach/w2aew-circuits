[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(out)"}
      X: ('m',1,0,0.0004,0.002)
      Y[0]: ('_',1,0,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.001,5.2) ;Flat at 2.01 V: the stage biases up and never starts, on the same axes as the working version
   }
}
