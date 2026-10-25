[Transient Analysis]
{
   Npanes: 2
   {
      traces: 1 {34668550,0,"I(Rload)"}
      X: ('u',1,0,5e-05,0.0004)
      Y[0]: ('m',1,-0.0008,0.0002,0.0008)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.0008,0.0002,0.0008)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.0002,0.00072) ;Load current reverses through zero twice a cycle, and the notch sits on those crossings.
   }
   {
      traces: 1 {589826,0,"V(ac_out)"}
      X: ('u',1,0,5e-05,0.0004)
      Y[0]: (' ',1,-0.7,0.2,0.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.7,0.2,0.8)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0002,0.71) ;At the scope probe: 0.9999 Vpp with a flat step at each zero crossing. THD is 4.26 percent.
   }
}
