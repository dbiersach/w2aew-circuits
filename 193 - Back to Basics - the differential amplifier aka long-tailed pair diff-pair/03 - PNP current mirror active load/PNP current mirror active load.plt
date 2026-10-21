[Transient Analysis]
{
   Npanes: 1
   {
      traces: 2 {524290,0,"V(out2)"} {524291,0,"V(mirror)"}
      Text: "V" 1 (0.0025,10.7) ;OUT2 swings 6.93 V p-p and flattens at both limits: the 50 mV drive overloads this stage
      Text: "V" 1 (0.0025,10.1) ;MIRROR sits at 8.38 V, one PNP base-emitter drop below the 9 V rail
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,1.5,1,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,1.5,1,11)
      Log: 0 0 0
      GridStyle: 1
   }
}
