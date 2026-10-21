[Transient Analysis]
{
   Npanes: 4
   Active Pane: 2
   {
      traces: 1 {524294,0,"V(ctrl)"}
      Text: "V" 1 (0.10025,2.73005) ;V(ctrl) sawtooth within a 3 mV band: it drifts down through the bias divider and is stepped back up by each PC2 pulse
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',4,2.7273,0.0003,2.7303)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2.7273,0.0003,2.7303)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {268959751,0,"V(pc1)"}
      Text: "V" 1 (0.10025,6.1) ;PC1 (XOR) spikes only at the edge mismatch
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {268959749,0,"V(pc2)"}
      Text: "V" 1 (0.10025,6.1) ;PC2 emits one short pull-up pulse per reference cycle to replace the charge the bias divider drains
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 3 {268959746,0,"V(ref)"} {268959747,0,"V(fb)"} {268959748,0,"V(vco)"}
      Text: "V" 1 (0.10025,6.1) ;6 kHz REF and the divided FB coincide (locked at 0 degrees, FB hides REF); the VCO runs two cycles per FB cycle, at 12 kHz
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
