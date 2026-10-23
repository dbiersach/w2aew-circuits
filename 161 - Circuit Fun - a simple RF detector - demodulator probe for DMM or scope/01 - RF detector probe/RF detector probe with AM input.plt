[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {524291,0,"V(detected)"}
      X: ('u',1,0,4e-05,0.0002)
      Y[0]: ('_',1,0,0.5,3.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,0,0.5,3.6)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0001,3.4) ;The recovered baseband: the output follows the envelope from 0.88 V to 3.27 V at 20 kHz
   },
   {
      traces: 1 {524290,0,"V(clamped)"}
      X: ('u',1,0,4e-05,0.0002)
      Y[0]: ('_',1,-0.5,1,4.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: ('_',0,0,2,-0.5,1,4.8)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0001,4.5) ;The modulated carrier at the probe tip, clamped so the troughs sit near zero
   }
}
