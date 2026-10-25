[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {34668548,0,"I(D1)"}
      X: ('m',1,0,0.0004,0.004)
      Y[0]: ('m',1,-0.002,0.002,0.026)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.002,0.002,0.026)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.002,0.0252) ;Diode current, peaking at 21.1 mA. Channel 2 reads this as 0.211 V across the 10 ohm shunt
      Text: "A" 1 (0.002,0.0236) ;Alan has channel 2 at 20.0 mV per division, which is 2 mA per division here
   }
   {
      traces: 2 {589826,0,"V(scope_x)"} {589830,0,"V(scope_x)-V(scope_y)"}
      X: ('m',1,0,0.0004,0.004)
      Y[0]: (' ',1,-0.2,0.2,1.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.2,0.2,1.4)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.002,1.32) ;V(scope_x) is what channel 1 shows: 0.945 V at the peak of the ramp
      Text: "V" 1 (0.002,1.16) ;V(scope_x)-V(scope_y) is the diode itself: 0.734 V. The 0.211 V between them is the shunt
   }
}
