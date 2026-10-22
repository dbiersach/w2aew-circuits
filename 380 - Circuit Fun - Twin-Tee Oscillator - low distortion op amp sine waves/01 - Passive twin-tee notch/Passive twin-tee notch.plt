[AC Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(out)/V(in)"}
      X: ('K',0,100,0,100000)
      Y[0]: (' ',1,0.0001,20,1)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Log: 1 2 0
      GridStyle: 1
      PltMag: 1
      Text: "V" 1 (3500,0.45) ;Transfer of the passive twin tee: flat either side, with a deep notch where the two paths cancel
      Text: "V" 1 (14000,0.0007) ;A null near 1585 Hz, against 1/(2*pi*R*C) = 1592 Hz for the drawn values. Its depth is set by the sweep, not the circuit
      Arrow: "V" 1 2 (7500,0.00075) (1640,0.00022)
   }
}
