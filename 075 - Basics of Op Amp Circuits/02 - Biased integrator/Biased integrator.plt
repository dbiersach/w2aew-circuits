[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(vin)"}
      Text: "V" 1 (0.0001,6.55) ;Input: 10 kHz square wave, 4 V to 6 V, balanced about the 5 V reference
      X: ('u',0,0,2e-05,0.0002)
      Y[0]: (' ',0,3.5,0.5,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,3.5,0.5,7)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(vout)"}
      Text: "V" 1 (0.0001,5.26) ;Output: a 354 mV triangle. Input above 5 V ramps it down, below 5 V ramps it up
      X: ('u',0,0,2e-05,0.0002)
      Y[0]: (' ',0,4.6,0.1,5.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,4.6,0.1,5.4)
      Log: 0 0 0
      GridStyle: 1
   }
}
