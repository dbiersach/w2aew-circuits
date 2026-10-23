[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {34603011,0,"I(D1)"}
      X: (' ',1,-5,1,1)
      Y[0]: ('m',2,-0.01,0.02,0.09)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.01,0.02,0.09)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (-2.3,0.062) ;Over the whole 5 V sweep the curve is a flat line and a hard knee. That is the shape the X-Y display draws.
   }
   {
      traces: 1 {34603011,0,"I(D1)"}
      X: (' ',1,0.4,0.05,0.85)
      Y[0]: ('m',2,-0.01,0.01,0.09)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.01,0.01,0.09)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.565,0.0825) ;Forward region: the knee near 0.6 V, and 69.7 mA at 0.816 V
      Arrow: "A" 1 2 (0.70,0.0815) (0.808,0.0725)
   }
}
