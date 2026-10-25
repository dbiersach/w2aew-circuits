[Transient Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {589830,0,"(100k+50k*cos(360*500*time))/1k"}
      Text: "V" 1 (0.003,170) ;Instantaneous IF frequency in kHz, computed from the VIF settings: 100 kHz +/- 50 kHz, 500 Hz tone
      Text: "V" 1 (0.003,15) ;Alan's pulses are negative-going, so a higher IF frequency gives a LOWER audio voltage
      X: ('m',0,0.001,0.0005,0.005)
      Y[0]: (' ',0,0,25,200)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,25,200)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(audio)"}
      Text: "V" 1 (0.003,4.88) ;AUDIO = RLP-CLP average of the PULSE train: the 500 Hz tone is recovered, 0.50 V p-p
      Text: "V" 1 (0.0019,4.72) ;IF at 50 kHz: fewest pulses, highest average (4.49 V)
      Arrow: "V" 1 2 (0.0015,4.68) (0.00118,4.5)
      Text: "V" 1 (0.0029,3.78) ;IF at 150 kHz: most pulses, lowest average (3.99 V)
      Arrow: "V" 1 2 (0.0025,3.83) (0.00215,3.98)
      X: ('m',0,0.001,0.0005,0.005)
      Y[0]: (' ',1,3.6,0.1,5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,3.6,0.1,5)
      Log: 0 0 0
      GridStyle: 1
   }
}
