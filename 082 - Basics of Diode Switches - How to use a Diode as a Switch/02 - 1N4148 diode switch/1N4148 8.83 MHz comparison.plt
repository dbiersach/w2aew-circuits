[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {524290,0,"V(vin)"}
      Text: "V" 1 (1e-06,0.03) ;Generator at the input coupling capacitor: 50.0 mV p-p, 8.83 MHz
      X: ('µ',0,0,2e-07,2e-06)
      Y[0]: ('m',0,-0.035,0.005,0.035)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.035,0.005,0.035)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(vout)@1"}
      Text: "V" 1 (1e-06,0.03) ;Bias off: only 4.3 mV p-p, six times better isolation than the 1N4007
      X: ('µ',0,0,2e-07,2e-06)
      Y[0]: ('m',0,-0.035,0.005,0.035)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.035,0.005,0.035)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(vout)@2"}
      Text: "V" 1 (1e-06,0.03) ;Bias on (V2 = 2.3 V): 48.8 mV p-p reaches the scope
      X: ('µ',0,0,2e-07,2e-06)
      Y[0]: ('m',0,-0.035,0.005,0.035)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.035,0.005,0.035)
      Log: 0 0 0
      GridStyle: 1
   }
}
