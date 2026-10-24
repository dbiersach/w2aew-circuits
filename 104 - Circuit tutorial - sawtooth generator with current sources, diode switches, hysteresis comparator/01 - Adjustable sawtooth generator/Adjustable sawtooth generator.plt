[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524290,0,"V(ctrl)"}
      X: ('m',1,0.002,0.0003,0.0035)
      Y[0]: (' ',0,-1,2,13)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,2,13)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00275,11.6) ;V(CTRL), the comparator output that throws the diode bridge: a square wave whose duty cycle follows the slope ratio
   }
   {
      traces: 2 {524291,0,"V(ramp)"} {524292,0,"V(out)"}
      X: ('m',1,0.002,0.0003,0.0035)
      Y[0]: (' ',0,2.5,0.5,7.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,2.5,0.5,7.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00275,7.3) ;V(RAMP) on the timing capacitor and V(OUT) from the buffer, 2.98 V to 6.02 V at 1651 Hz
      Text: "V" 1 (0.00275,6.8) ;with both adjustments centered the rise and fall slopes match at about 10 kV/s
   }
}
