[Transient Analysis]
{
   Npanes: 3
   Active Pane: 2
   {
      traces: 1 {524292,0,"V(if)"}
      Text: "V" 1 (0.004,0.17) ;IF at Q1's input: the 160 mV p-p VIF behind 50 ohms, here at about 150 kHz
      X: ('m',3,0.00398,5e-06,0.00402)
      Y[0]: ('m',0,-0.2,0.05,0.25)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.2,0.05,0.25)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524291,0,"V(lim)"}
      Text: "V" 1 (0.004,6.3) ;LIM: Q1 collector; drops fast when Q1 conducts, then climbs slowly as RC1 recharges CT through D1: only 3.0 V peak at 150 kHz
      X: ('m',3,0.00398,5e-06,0.00402)
      Y[0]: (' ',0,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {524290,0,"V(pulse)"}
      Text: "V" 1 (0.004,6.3) ;PULSE: Q2 collector, a 0.9 us negative pulse (down to -0.6 V) per falling LIM edge: 6 pulses in 40 us, average 4.00 V
      X: ('m',3,0.00398,5e-06,0.00402)
      Y[0]: (' ',0,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
