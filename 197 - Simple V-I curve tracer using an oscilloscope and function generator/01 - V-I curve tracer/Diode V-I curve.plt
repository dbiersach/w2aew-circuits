[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {34668546,0,"I(D1)"}
      X: (' ',1,-5,1,1)
      Y[0]: ('m',2,-0.002,0.004,0.024)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.002,0.004,0.024)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (-2.3,0.0205) ;Over the whole sweep the curve is a flat line and a hard knee. That is the shape the X-Y display draws
   }
   {
      traces: 1 {34668546,0,"I(D1)"}
      X: (' ',1,0.3,0.05,0.75)
      Y[0]: ('m',2,-0.002,0.002,0.024)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,-0.002,0.002,0.024)
      Log: 0 0 0
      GridStyle: 1
      Text: "A" 1 (0.47,0.0225) ;Forward region: the knee near 0.55 V, and 21.1 mA at 0.734 V
   }
}
