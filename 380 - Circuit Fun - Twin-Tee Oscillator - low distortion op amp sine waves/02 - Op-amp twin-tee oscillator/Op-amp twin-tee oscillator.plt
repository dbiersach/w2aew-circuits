[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524290,0,"V(out)@3"}
      X: ('m',1,0.01,0.0005,0.014)
      Y[0]: (' ',1,0,0.5,5.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.012,5.3) ;Trim 380 ohm: a clean sine on its way out, 2.53 V peak to peak here and 0.15 mV left by 300 ms
   },
   {
      traces: 1 {524290,0,"V(out)@2"}
      X: ('m',1,0.01,0.0005,0.014)
      Y[0]: (' ',1,0,0.5,5.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.012,5.3) ;Trim 330 ohm: still a sine, 4.17 V peak to peak here, but decaying to 0.15 V by 300 ms
   },
   {
      traces: 1 {524290,0,"V(out)@1"}
      X: ('m',1,0.01,0.0005,0.014)
      Y[0]: (' ',1,0,0.5,5.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.012,5.3) ;Trim 300 ohm: already hard against both rails, flat topped at 4.99 V peak to peak and staying there
   }
}
