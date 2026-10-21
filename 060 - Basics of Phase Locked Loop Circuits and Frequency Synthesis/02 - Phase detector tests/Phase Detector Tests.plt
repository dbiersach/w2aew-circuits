[Transient Analysis]
{
   Npanes: 3
   Active Pane: 1
   {
      traces: 1 {524292,0,"V(pc2)"}
      Text: "V" 1 (0.00425,6.1) ;PC2 (pin 13) rests at 2.5 V between corrections. It pulses up to 5 V while FB lags REF and down to 0 V while FB leads
      X: ('m',2,0.004,5e-05,0.0045)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {524294,0,"V(pc1)"} {524293,0,"V(xoravg)"}
      Text: "V" 1 (0.00425,6.1) ;PC1 (XOR, pin 2) is high while REF and FB differ. XORAVG is its RC average: 2.47 V for either 90 degree offset
      X: ('m',2,0.004,5e-05,0.0045)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {524290,0,"V(ref)"} {524291,0,"V(fb)"}
      Text: "V" 1 (0.00425,6.1) ;REF drives pin 14. FB drives pin 3 and is delayed by DELAY: 0, 25, or 75 us of the 100 us cycle
      X: ('m',2,0.004,5e-05,0.0045)
      Y[0]: (' ',1,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
