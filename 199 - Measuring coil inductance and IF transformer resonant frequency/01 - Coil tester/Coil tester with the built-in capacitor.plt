[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524291,0,"V(output)"}
      X: ('u',1,0.000148,5e-07,0.00015)
      Y[0]: (' ',1,-1,2,9)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-1,2,9)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.000149,8.2) ;At the output jack, 5.86 Vpp: the half sine waves the article calls rich in harmonics.
   }
   {
      traces: 1 {524290,0,"V(tank)"}
      X: ('u',1,0.000148,5e-07,0.00015)
      Y[0]: (' ',1,-10,2,10)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-10,2,10)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.000149,8.8) ;Tank voltage, 13.84 Vpp at 7.0717 MHz with the 3.3 uH coil and the built-in 150 pF.
   }
}
