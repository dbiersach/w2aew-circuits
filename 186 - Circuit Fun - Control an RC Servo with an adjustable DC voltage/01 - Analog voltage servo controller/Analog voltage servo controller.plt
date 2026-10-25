[Transient Analysis]
{
   Npanes: 3
   {
      traces: 3 {589832,0,"V(ramp)@3"} {589833,0,"V(conditioned)@3"} {589834,0,"V(servo_pwm)@3"}
      X: ('m',1,0,0.001,0.008)
      Y[0]: (' ',1,0,0.5,5.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.004,5.3) ;VCTRL = 5 V: lower still, and the pulse has grown to 2.183 ms. All three repeat every 23.41 ms
   },
   {
      traces: 3 {589829,0,"V(ramp)@2"} {589827,0,"V(conditioned)@2"} {589831,0,"V(servo_pwm)@2"}
      X: ('m',1,0,0.001,0.008)
      Y[0]: (' ',1,0,0.5,5.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.004,5.3) ;VCTRL = 2.5 V: the level has dropped, and the pulse is 1.291 ms, inside the 1 to 2 ms band a servo reads
   },
   {
      traces: 3 {589826,0,"V(ramp)@1"} {589830,0,"V(conditioned)@1"} {589828,0,"V(servo_pwm)@1"}
      X: ('m',1,0,0.001,0.008)
      Y[0]: (' ',1,0,0.5,5.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,5.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.004,5.3) ;VCTRL = 0 V: the conditioned level sits right at the sawtooth peak, so the pulse is only 0.399 ms wide
   }
}
