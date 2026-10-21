[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524291,0,"V(out2)"}
      Text: "V" 1 (0.0032,8.4) ;OUT2 moves opposite to OUT1 and shifts with it
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,6,0.4,8.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,6,0.4,8.6)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00025,8.5)
   },
   {
      traces: 1 {524292,0,"V(out1)"}
      Text: "V" 2 (0.0032,8.4) ;OUT1 average falls 1.05 V across the common-mode sweep
      X: ('m',1,0,0.0005,0.005)
      Y[0]: (' ',2,6,0.4,8.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,6,0.4,8.6)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00025,8.5)
   },
   {
      traces: 1 {524290,0,"V(out1,out2)"}
      Text: "V" 3 (0.0032,0.9) ;Differential swing grows from 0.556 V to 0.897 V
      X: ('m',1,0,0.0005,0.005)
      Y[0]: ('m',2,-0.6,0.2,1)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,2,-0.6,0.2,1)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.00025,0.95)
   }
}
