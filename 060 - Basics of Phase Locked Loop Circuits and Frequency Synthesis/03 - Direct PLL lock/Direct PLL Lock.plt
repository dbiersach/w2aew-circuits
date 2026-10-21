[Transient Analysis]
{
   Npanes: 4
   Active Pane: 2
   {
      traces: 1 {524293,0,"V(ctrl)"}
      Text: "V" 1 (0.10025,2.50578) ;V(ctrl) drifts down a few tens of microvolts between PC2 pulses as the bias divider pulls it toward 2.5 V
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',5,2.50524,6e-05,2.5059)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,2.50524,6e-05,2.5059)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {268959746,0,"V(pc1)"}
      Text: "V" 1 (0.10025,6.1) ;PC1 (XOR) only spikes during the tiny edge mismatch; at a 90 degree lock it would be a 50 percent square wave
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {268959746,0,"V(pc2)"}
      Text: "V" 1 (0.10025,6.1) ;PC2 is high impedance in lock (it sits at the control voltage) and emits a short pulse only every few cycles
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {268959748,0,"V(ref)"} {268959747,0,"V(vco)"}
      Text: "V" 1 (0.10025,6.1) ;FREF = 10 kHz step: the REF and VCO edges coincide, so the loop is locked at 0 degrees and the red REF trace hides under the blue VCO trace
      X: ('m',2,0.1,5e-05,0.1005)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
