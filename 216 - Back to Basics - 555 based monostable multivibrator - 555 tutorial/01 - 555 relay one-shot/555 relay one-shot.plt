[Transient Analysis]
{
   Npanes: 3
   {
      traces: 2 {589829,0,"I(Lcoil)"} {589827,0,"I(Dled)"}
      X: (' ',1,0,0.2,1.4)
      Y[0]: ('m',1,0,0.01,0.065)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Amps: ('m',0,0,1,0,0.01,0.065)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.7,0.0605) ;I(Lcoil) and I(Dled): the illustrative coil draws 50 mA and the LED about 10 mA while the contact is closed
   },
   {
      traces: 1 {589828,0,"V(timing)"}
      X: (' ',1,0,0.2,1.4)
      Y[0]: (' ',1,0,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,1,7)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.7,6.3) ;V(TIMING): the 2.2u charges through 470k until it reaches two thirds of 5 V, which ends the pulse
   },
   {
      traces: 2 {589826,0,"V(trig)"} {589830,0,"V(out)"}
      X: (' ',1,0,0.2,1.4)
      Y[0]: (' ',1,0,1,7)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,2,0,1,7)
      Log: 0 0 0
      GridStyle: 1
      Text: "V" 1 (0.7,6.3) ;V(TRIG) dips for 1 ms at 10 ms; V(OUT) then stays high for 1.1376 s, which is 1.1 x 470k x 2.2u
   }
}
