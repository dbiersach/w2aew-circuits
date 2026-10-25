[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {589828,0,"V(scope)@1"}
      X: ('u',1,0,1e-07,4e-07)
      Y[0]: (' ',0,-3.5,1,3.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3.5,1,3.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2e-07,3) ;0.70 mA bias: the stored charge no longer outlasts the RF cycle, and the diode starts to rectify
   },
   {
      traces: 1 {589830,0,"V(scope)@2"}
      X: ('u',1,0,1e-07,4e-07)
      Y[0]: (' ',0,-3.5,1,3.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3.5,1,3.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2e-07,3) ;2.01 mA bias, the current Alan reads at 8:32: the sine is clean again
   },
   {
      traces: 1 {589826,0,"V(scope)@3"}
      X: ('u',1,0,1e-07,4e-07)
      Y[0]: (' ',0,-3.5,1,3.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-3.5,1,3.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2e-07,3) ;4.15 mA bias: well above the RF charge swing, so the PIN passes 10 MHz undistorted
   }
}
