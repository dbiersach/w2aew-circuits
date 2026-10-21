[FFT of time domain data]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(out)"}
      X: ('M',0,0,2e+06,1.6e+07)
      Y[0]: (' ',0,1e-07,20,1)
      Y[1]: ('K',0,-50000,10000,100000)
      Log: 0 2 0
      GridStyle: 1
      PltMag: 1
      Text: "dB" 1 (3200000,0.09) ;455 kHz difference product, -47.4 dBV: the classic AM intermediate frequency
      Arrow: "dB" 1 2 (1800000,0.07) (455000,0.0055)
      Text: "dB" 1 (11500000,0.3) ;7.455 MHz LO feedthrough, -35.9 dBV: 11 dB above the wanted IF
      Arrow: "dB" 1 2 (10000000,0.23) (7455000,0.021)
      Text: "dB" 1 (3600000,0.00055) ;7.0 MHz RF feedthrough, -52.2 dBV
      Arrow: "dB" 1 2 (5200000,0.00065) (7000000,0.0021)
   }
}
