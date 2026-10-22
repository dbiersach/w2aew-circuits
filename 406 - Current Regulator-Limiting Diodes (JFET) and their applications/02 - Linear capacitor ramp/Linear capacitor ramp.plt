[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"I(C1)"}
      X: (' ',1,0,0.0002,0.002)
      Y[0]: ('m',1,-0.0002,0.0002,0.0012)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,-0.0002,0.0002,0.0012)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.001,0.00111) ;Charging current: a steady 1.010 mA from the 1N5297 model once the switch opens
   },
   {
      traces: 1 {524290,0,"V(RAMP)"}
      X: (' ',1,0,0.0002,0.002)
      Y[0]: (' ',1,0,1,11)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,11)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.001,10.3) ;S1 opens at 1 ms and the capacitor voltage climbs at 10.12 kV/s
      Text: "V" 1 (0.00055,6) ;measured between the 0.66 V and 7.94 V levels Alan puts his cursors on
   }
}