[AC Analysis]
{
   Npanes: 3
   {
      traces: 1 {524290,0,"V(OUT_L,OUT_R)@3"}
      X: ('K',0,10,0,1e+006)
      Y[0]: (' ',1,10,5,100)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Log: 1 2 0
      GridStyle: 1
      PltMag: 1
      Text: "V" 1 (3000,78) ;VCM = 5.61 V: 34.34 dB at 5 kHz
   },
   {
      traces: 1 {524290,0,"V(OUT_L,OUT_R)@2"}
      X: ('K',0,10,0,1e+006)
      Y[0]: (' ',1,10,5,100)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Log: 1 2 0
      GridStyle: 1
      PltMag: 1
      Text: "V" 1 (3000,78) ;VCM = 4.05 V: 32.51 dB at 5 kHz
   },
   {
      traces: 1 {524290,0,"V(OUT_L,OUT_R)@1"}
      X: ('K',0,10,0,1e+006)
      Y[0]: (' ',1,10,5,100)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Log: 1 2 0
      GridStyle: 1
      PltMag: 1
      Text: "V" 1 (3000,78) ;VCM = 3.54 V: 31.62 dB at 5 kHz
      Text: "V" 1 (3000,60) ;Differential gain of the 3.9k tail, one pane per common-mode setting: it climbs 2.7 dB from top to bottom
   }
}