[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {34668550,0,"I(Rload)"} {34668548,0,"I(Rload)+I(Rdc)"}
      X: ('u',1,0,5e-05,0.0004)
      Y[0]: ('m',1,-0.001,0.0005,0.003)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.001,0.0005,0.003)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.0002,0.00275) ;Rdc keeps the total the op amp sources above 0.66 mA, so it never has to sink.
   }
   {
      traces: 1 {589826,0,"V(ac_out)"}
      X: ('u',1,0,5e-05,0.0004)
      Y[0]: (' ',1,-0.7,0.2,0.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,-0.7,0.2,0.8)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.0002,0.71) ;Same probe, same 1 Vpp, no step at the crossings. THD falls to 0.128 percent.
   }
}
