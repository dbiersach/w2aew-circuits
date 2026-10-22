[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"I(Vcprobe)/I(Rb)"}
      X: ('K',0,10000,0,1e+09)
      Y[0]: (' ',1,0.1,20,1000)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Log: 1 2 0
      GridStyle: 1
      PltMag: 1
      Text: "" 1 (7.0e+04,620) ;Flat at 202 up to about 1 MHz: the gain a DC tester reports as hFE
      Text: "" 1 (7.0e+06,150) ;Falling at 20 dB per decade: the stretch Alan marks as the place to measure
      Text: "" 1 (7.0e+05,20) ;Alan takes his two readings at 300 kHz and at 3 MHz
      Text: "" 1 (2.4e+07,2.6) ;Current gain of one at 306 MHz, which is the transition frequency
      Arrow: "" 1 2 (1.1e+08,2.2) (3.0e+08,1.15)
   }
}
