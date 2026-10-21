[DC transfer characteristic]
{
   Npanes: 1
   {
      traces: 1 {34603011,0,"I(Rsense)"}
      Text: "A" 1 (6.6,0.0625) ;Below about 1.5 V the channel acts as a resistor; above it each gate curve flattens
      Text: "A" 1 (6.6,0.0585) ;Most current flows at 0 V gate bias; -4 V pinches the channel off
      X: (' ',1,0,1,10)
      Y[0]: ('m',2,0,0.005,0.065)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,0,0.005,0.065)
      Log: 0 0 0
      GridStyle: 1
      StepLegend: (0.4,0.0635)
   }
}
