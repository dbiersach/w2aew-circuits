[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 2 {34668547,0,"I(R4V7)"} {34668548,0,"I(R6V8)"}
      Text: "A" 1 (3.2,0.0225) ;Current rises as (supply - Vz)/330, so the 4.7 V branch starts earlier and reaches 16.3 mA
      X: (' ',1,0,1,10)
      Y[0]: ('m',2,0,0.0025,0.025)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,2,0,0.0025,0.025)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 3 {524290,0,"V(vsupply)"} {524291,0,"V(vz_4v7)"} {524292,0,"V(vz_6v8)"}
      Text: "V" 2 (3.2,11.4) ;Below breakdown each diode follows the supply; above it the voltage barely moves
      X: (' ',1,0,1,10)
      Y[0]: (' ',2,0,1,12)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,1,12)
      Log: 0 0 0
      GridStyle: 1
   }
}
