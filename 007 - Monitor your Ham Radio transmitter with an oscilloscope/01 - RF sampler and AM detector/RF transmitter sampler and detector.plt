[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524291,0,"V(demod_out)"}
      X: ('m',1,0,0.0005,0.003)
      Y[0]: (' ',1,0,5,30)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,5,30)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00148,27.2) ;What the diode detector recovers: the same 1 kHz envelope, 6.3 V to 20.6 V on a positive offset
   },
   {
      traces: 1 {524290,0,"V(rf_line)"}
      X: ('m',1,0,0.0005,0.003)
      Y[0]: (' ',1,-200,50,200)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-200,50,200)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00148,180) ;The 7.1 MHz carrier on the line: the cycles merge into a band whose outline is the modulation
   }
}
