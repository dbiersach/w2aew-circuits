[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(vin)@1"} {524291,0,"V(vout)@1"}
      Text: "V" 1 (0.002,0.52) ;At 1 V p-p the diode barely conducts: the input peaks at 0.50 V and only 16 mV reaches the load
      X: ('m',0,0,0.0005,0.004)
      Y[0]: (' ',0,-0.6,0.2,0.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.6,0.2,0.6)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {524290,0,"V(vin)@2"} {524291,0,"V(vout)@2"}
      Text: "V" 1 (0.002,2.6) ;At 3 V p-p the diode conducts: 1.50 V input peak, 0.83 V at the load
      Text: "V" 1 (0.00285,2.0) ;the 665 mV gap is the diode drop, close to the 680 mV Alan measures
      Arrow: "V" 1 2 (0.00285,1.93) (0.0025,1.2)
      X: ('m',0,0,0.0005,0.004)
      Y[0]: (' ',0,-1.9,1,2.9)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1.9,1,2.9)
      Log: 0 0 0
      GridStyle: 1
   }
}
