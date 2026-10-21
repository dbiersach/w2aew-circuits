[FFT of time domain data]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(if_raw)"}
      X: ('M',0,0,5e+06,5.5e+07)
      Y[0]: (' ',0,1e-07,20,1)
      Y[1]: ('K',0,-50000,10000,100000)
      Log: 0 2 0
      GridStyle: 1
      PltMag: 1
      Text: "dB" 1 (11000000,0.25) ;10.7 MHz difference product, -28.3 dBV: the IF a receiver keeps
      Text: "dB" 1 (44000000,0.055) ;46.1 MHz sum product, -28.7 dBV
      Text: "dB" 1 (20500000,0.02) ;24.7 MHz, the 3 fLO - fRF product Alan also identifies
      Arrow: "dB" 1 2 (22500000,0.016) (24700000,0.0085)
      Text: "dB" 1 (34000000,0.0007) ;28.4 MHz RF leakage, 45 dB below the IF
      Arrow: "dB" 1 2 (31500000,0.00055) (28400000,0.00023)
      Text: "dB" 1 (19000000,2.5e-06) ;17.7 MHz LO leakage, 109 dB below the IF: the balanced mixer cancels it
   }
}
