[Transient Analysis]
{
   Npanes: 3
   {
      traces: 1 {589828,0,"V(b0)"}
      Text: "V" 1 (0.00325,4.4) ;B0, the least significant bit: one 100 us code step, so it toggles 32 times across the sweep
      X: ('m',1,0,0.0005,0.0065)
      Y[0]: (' ',0,-1,1,5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,5)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589830,0,"V(b5)"}
      Text: "V" 1 (0.00325,4.4) ;B5, the most significant bit: high for the whole upper half of the count, from 3.2 ms on
      X: ('m',1,0,0.0005,0.0065)
      Y[0]: (' ',0,-1,1,5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1,1,5)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(vout)"}
      Text: "V" 1 (0.00325,3.8) ;Ladder output: 64 equal steps of 51.6 mV, reaching 3.248 V at code 63
      X: ('m',1,0,0.0005,0.0065)
      Y[0]: (' ',0,0,0.5,4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,0.5,4)
      Log: 0 0 0
      GridStyle: 1
   }
}
