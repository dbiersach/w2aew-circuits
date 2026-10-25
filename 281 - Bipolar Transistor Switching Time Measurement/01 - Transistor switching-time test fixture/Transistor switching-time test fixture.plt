[Transient Analysis]
{
   Npanes: 3
   {
      traces: 2 {589828,0,"V(ch2_drive)"} {589829,0,"V(ch3_base)"}
      X: ('u',1,0,5e-07,5e-06)
      Y[0]: (' ',1,-1.5,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1.5,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5e-06,5) ;V(CH2) drive and V(CH3) base: the base stays forward biased near 0.8 V for 1.07 us after the drive goes low
   },
   {
      traces: 1 {589830,0,"Ic(Qdut)"}
      X: ('u',1,0,5e-07,5e-06)
      Y[0]: ('m',1,-0.005,0.005,0.03)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('m',0,0,1,-0.005,0.005,0.03)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5e-06,0.027) ;Ic: 22.55 mA when on. Alan's four times are measured between its 10 and 90 percent levels
   },
   {
      traces: 1 {589826,0,"V(ch1_collector)"}
      X: ('u',1,0,5e-07,5e-06)
      Y[0]: (' ',1,-0.5,1,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.5,1,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (2.5e-06,5) ;V(CH1) collector: down in 10 ns, but held at 38 mV for 1.07 us after the drive goes low
   }
}
