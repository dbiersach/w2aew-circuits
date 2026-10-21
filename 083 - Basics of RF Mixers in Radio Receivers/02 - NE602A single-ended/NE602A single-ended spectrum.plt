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
      Text: "dB" 1 (11000000,0.25) ;10.7 MHz difference product, -30.1 dBV: the wanted IF
      Text: "dB" 1 (44000000,0.07) ;46.1 MHz sum product, -30.9 dBV
      Text: "dB" 1 (35000000,0.009) ;28.4 MHz RF leakage, only 23 dB below the IF
      Arrow: "dB" 1 2 (31500000,0.0072) (28400000,0.0025)
      Text: "dB" 1 (11000000,0.0013) ;17.7 MHz LO leakage, 34 dB below the IF: nothing cancels it here
      Arrow: "dB" 1 2 (15000000,0.00108) (17700000,0.00070)
   }
}
