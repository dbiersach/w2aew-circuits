[DC transfer characteristic]
{
   Npanes: 1
   {
      traces: 3 {524288,0,"V(base)"} {524289,0,"V(collector)"} {524290,0,"V(emitter)"}
      X: (' ',1,0,1,12)
      Y[0]: (' ',2,0,0.5,5.5)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,0.5,5.5)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (1.9,3.4) ;Cutoff: collector held at 5 V
      Text: "V" 1 (4.9,0.7) ;Active: collector falls as the base conducts
      Text: "V" 1 (9.6,4.5) ;Saturation: collector and emitter rise together
   }
}
