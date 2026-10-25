[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(output)"}
      X: ('u',1,0.0015,5e-06,0.00152)
      Y[0]: (' ',1,-1,2,9)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1,2,9)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00151,8.2) ;6.42 Vpp at the output jack, the same harmonic-rich shape at a much lower frequency
   }
   {
      traces: 1 {589826,0,"V(tank)"}
      X: ('u',1,0.0015,5e-06,0.00152)
      Y[0]: (' ',1,-10,2,10)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-10,2,10)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.00151,8.8) ;Tank voltage, 14.97 Vpp at 449.37 kHz, set by the can's 698.5 uH and 180 pF. Alan's scope reads 449.25 kHz
   }
}
