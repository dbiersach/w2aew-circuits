[Transient Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {268959747,0,"V(ctrl)"}
      Text: "V" 1 (0.0006,3.3) ;VTUNE ramps from 1.5 V to 3.5 V over 2 ms, standing in for the bench supply being turned up
      X: ('m',1,0,0.0002,0.002)
      Y[0]: (' ',1,1,0.5,4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,1,0.5,4)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {268959746,0,"V(vco)"}
      Text: "V" 1 (0.001,6.1) ;VCO output: the cycles get shorter from left to right as the control voltage below rises
      X: ('m',1,0,0.0002,0.002)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
