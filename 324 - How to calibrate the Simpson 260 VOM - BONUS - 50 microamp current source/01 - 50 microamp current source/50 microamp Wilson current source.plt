[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"I(Vdut)"}
      X: (' ',1,0,0.5,5)
      Y[0]: ('µ',1,4.997e-05,1e-08,5.002e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('µ',0,0,1,4.997e-05,1e-08,5.002e-05)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5,5.0015e-05) ;The same trace magnified: 50.010 uA at 250 mV falling to 49.978 uA at 5 V, a droop of 32 nA
   },
   {
      traces: 1 {524290,0,"I(Vdut)"}
      X: (' ',1,0,0.5,5)
      Y[0]: ('µ',1,0,1e-05,6e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('µ',0,0,1,0,1e-05,6e-05)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5,5.5e-05) ;I(Vdut) against the voltage across the load: flat at 50.0 uA all the way to 5 V of compliance
   }
}
