[Transient Analysis]
{
   Npanes: 1
   {
      traces: 1 {524290,0,"V(Y)"}
      Parametric: "V(X)"
      X: (' ',1,-1,1,9)
      Y[0]: (' ',1,-0.2,0.2,2)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.2,0.2,2)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (4.5,1.85) ;Collector curves: sense voltage V(Y) against collector voltage V(X), one trace per base-current step
   }
}
