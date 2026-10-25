[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(gate)"}
      X: (' ',1,0,2.5,30)
      Y[0]: (' ',1,0,1,6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (17,5.6) ;The LM10 output drives the gate through 5.59 V, where the 5.1 V zener clamps it and the 2N7000 turns on
   },
   {
      traces: 1 {589826,0,"I(RMETER)"}
      X: (' ',1,0,2.5,30)
      Y[0]: ('u',1,0,2e-05,0.0002)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('u',0,0,1,0,2e-05,0.0002)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (17,0.00019) ;Meter current: exactly 100.0 uA at 5 V, then the shunt switches in and the needle restarts at a third of scale
   }
}