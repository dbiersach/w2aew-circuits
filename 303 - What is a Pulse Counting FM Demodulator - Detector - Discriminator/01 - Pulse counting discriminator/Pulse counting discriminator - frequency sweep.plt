[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(audio)"}
      Text: "V" 1 (0.00105,4.675) ;Settled AUDIO level for each steady IF frequency (one stepped run): higher IF, lower average voltage
      Text: "V" 1 (0.00105,4.635) ;Equal 25 kHz steps give shrinking drops (183, 132, 101, 80 mV): the output compresses at high IF
      Text: "V" 1 (0.00138,4.56) ;fif = 50 kHz: 4.49 V average
      Text: "V" 1 (0.00138,4.372) ;fif = 75 kHz: 4.31 V average
      Text: "V" 1 (0.00138,4.236) ;fif = 100 kHz: 4.18 V average
      Text: "V" 1 (0.00138,4.13) ;fif = 125 kHz: 4.07 V average
      Text: "V" 1 (0.00138,3.92) ;fif = 150 kHz: 3.99 V average
      Arrow: "V" 1 2 (0.00138,3.935) (0.00134,3.985)
      Text: "V" 1 (0.0008,3.88) ;The sawtooth on each line is the pulse ripple that RLP-CLP leaves behind
      X: ('m',1,0.0006,0.0001,0.0015)
      Y[0]: (' ',2,3.85,0.05,4.7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,3.85,0.05,4.7)
      Log: 0 0 0
      GridStyle: 1
   }
}
