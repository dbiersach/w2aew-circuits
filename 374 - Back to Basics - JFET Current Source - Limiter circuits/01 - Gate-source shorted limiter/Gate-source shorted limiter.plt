[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {34668550,0,"Id(J1)"}
      Text: "A" 1 (3.6,0.0456) ;Zoomed: the current is still rising, 797 uA more from 9 V to 10 V
      X: (' ',1,0,1,12)
      Y[0]: ('m',2,0.042,0.0005,0.046)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,0.042,0.0005,0.046)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {34668546,0,"Id(J1)"}
      Text: "A" 2 (6,0.047) ;Below the knee the channel is a resistor; above it the current limits near IDSS
      X: (' ',1,0,1,12)
      Y[0]: ('m',2,0,0.005,0.05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,0,0.005,0.05)
      Log: 0 0 0
      GridStyle: 1
   }
}
