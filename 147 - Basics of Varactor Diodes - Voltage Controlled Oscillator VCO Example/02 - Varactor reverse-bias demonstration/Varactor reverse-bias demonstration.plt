[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(out)@4"}
      X: ('u',1,0,2e-07,1e-06)
      Y[0]: ('m',1,-0.016,0.004,0.016)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.016,0.004,0.016)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,0.0145) ;25 V of reverse bias: only 2.68 mV gets through, because the junction capacitance has shrunk
   },
   {
      traces: 1 {524290,0,"V(out)@1"}
      X: ('u',1,0,2e-07,1e-06)
      Y[0]: ('m',1,-0.016,0.004,0.016)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.016,0.004,0.016)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (5e-07,0.0145) ;1 V of reverse bias: 26.15 mV of the 17 MHz test signal couples through the varactor
   }
}
