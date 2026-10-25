[Transient Analysis]
{
   Npanes: 1
   {
      traces: 2 {589826,0,"V(ch1)"} {589830,0,"V(ch2)*10"}
      Text: "V" 1 (1.75e-05,1.45) ;Capacitor: the current peaks 0.32 us BEFORE the voltage, so the current LEADS by 84 degrees
      Text: "V" 1 (1.7227e-05,1.15) ;current peak
      Arrow: "V" 1 2 (1.7377e-05,1.1) (1.7577e-05,0.9)
      Text: "V" 1 (1.8243e-05,1.15) ;voltage peak
      Arrow: "V" 1 2 (1.8093e-05,1.1) (1.7893e-05,0.88)
      Text: "V" 1 (1.5869e-05,-1.13) ;CH1 = applied voltage at the top of C1
      Arrow: "V" 1 2 (1.5869e-05,-1.08) (1.5869e-05,-0.88)
      Text: "V" 1 (1.8252e-05,-1.3) ;CH2 x10 = current through C1 (drop across the 100 ohm sense resistor, scaled x10)
      Arrow: "V" 1 2 (1.8252e-05,-1.25) (1.8252e-05,-0.88)
      X: ('µ',1,1.5e-05,5e-07,2e-05)
      Y[0]: (' ',1,-1.4,0.2,1.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1.4,0.2,1.6)
      Log: 0 0 0
      GridStyle: 1
   }
}
