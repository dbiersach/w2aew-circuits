[Transient Analysis]
{
   Npanes: 4
   {
      traces: 2 {589829,0,"V(sense)@1"} {589827,0,"V(br_ret)@1"}
      X: ('u',1,0,5e-06,3e-05)
      Y[0]: ('m',1,-0.01,0.02,0.11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.01,0.02,0.11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.5e-05,0.1) ;The two bridge arms at the lowest resistance: the 3 ohm arm with the capacitor on it, and the 30 ohm reference arm
   },
   {
      traces: 1 {589828,0,"I(R22)@15"}
      X: ('u',1,0,5e-06,3e-05)
      Y[0]: ('u',1,0,1e-05,7e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('u',0,0,1,0,1e-05,7e-05)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.5e-05,6.3e-05) ;A 20 ohm series resistance: 1.20 uA, essentially no deflection
   },
   {
      traces: 1 {589830,0,"I(R22)@7"}
      X: ('u',1,0,5e-06,3e-05)
      Y[0]: ('u',1,0,1e-05,7e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('u',0,0,1,0,1e-05,7e-05)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.5e-05,6.3e-05) ;A 4 ohm series resistance: 16.31 uA, about a quarter of full deflection
   },
   {
      traces: 1 {589826,0,"I(R22)@1"}
      X: ('u',1,0,5e-06,3e-05)
      Y[0]: ('u',1,0,1e-05,7e-05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('u',0,0,1,0,1e-05,7e-05)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.5e-05,6.3e-05) ;A 0.0001 ohm series resistance: the meter branch averages 60.44 uA, the top of the scale
   }
}
