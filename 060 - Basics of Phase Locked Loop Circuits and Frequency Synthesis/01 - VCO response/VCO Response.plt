[Transient Analysis]
{
   Npanes: 3
   Active Pane: 1
   {
      traces: 1 {589828,0,"V(vco)@3"}
      Text: "V" 1 (6.5e-05,5.8) ;VCTRL = 3.5 V: F_VCO = 18.94 kHz, period 53 us
      Arrow: "V" 1 2 (0.00012,5.6) (0.00011,5.05)
      X: ('µ',0,0,5e-05,0.0005)
      Y[0]: (' ',0,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589830,0,"V(vco)@2"}
      Text: "V" 1 (6.5e-05,5.8) ;VCTRL = 2.5 V: F_VCO = 9.94 kHz, period 101 us
      Arrow: "V" 1 2 (0.00012,5.6) (0.000103,5.05)
      X: ('µ',0,0,5e-05,0.0005)
      Y[0]: (' ',0,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(vco)@1"}
      Text: "V" 1 (6.5e-05,5.8) ;VCTRL = 1.5 V: F_VCO = 3.56 kHz, period 281 us
      Arrow: "V" 1 2 (0.00015,5.6) (0.000141,5.05)
      Text: "V" 1 (0.00033,5.8) ;Same VCO, three control voltages: a higher voltage gives a shorter period and a higher frequency
      X: ('µ',0,0,5e-05,0.0005)
      Y[0]: (' ',0,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
   }
}
