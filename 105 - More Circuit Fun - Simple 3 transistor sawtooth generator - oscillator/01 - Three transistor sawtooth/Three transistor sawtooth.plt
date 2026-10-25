[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {589830,0,"V(thresh)"} {589828,0,"V(drive)"}
      X: ('m',1,0.005,0.001,0.01)
      Y[0]: (' ',0,-1,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,7)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0075,6.5) ;V(THRESH) collapses and V(DRIVE) pulses at each reset: the regenerative pair firing
   }
   {
      traces: 1 {589826,0,"V(ramp)"}
      X: ('m',1,0.005,0.001,0.01)
      Y[0]: (' ',0,0,1,6.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,6.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0075,6.2) ;V(RAMP) on the 10 nF: 0.666 V to 4.950 V at 599 Hz, charging at 2570 V/s
   }
}
