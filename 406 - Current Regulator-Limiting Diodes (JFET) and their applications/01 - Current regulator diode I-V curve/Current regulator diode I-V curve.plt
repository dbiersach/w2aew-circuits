[DC transfer characteristic]
{
   Npanes: 1
   {
      traces: 2 {589826,0,"I(Vm5297)"} {589830,0,"I(Vm5305)"}
      X: (' ',1,0,2.5,25)
      Y[0]: ('m',1,0,0.0002,0.0026)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,0,0.0002,0.0026)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (12.5,0.00245) ;Each diode climbs steeply to its limiting voltage, then holds its rated current for the rest of the sweep
      Text: "V" 1 (17,0.00192) ;1N5305 model: 2.009 mA at 1.85 V, 2.067 mA at 25 V
      Text: "V" 1 (17,0.00093) ;1N5297 model: 1.004 mA at 1.35 V, 1.033 mA at 25 V
   }
}