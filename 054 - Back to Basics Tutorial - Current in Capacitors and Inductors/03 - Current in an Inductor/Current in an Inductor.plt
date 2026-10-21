[Transient Analysis]
{
   Npanes: 1
   {
      traces: 2 {524290,0,"V(ch1)"} {524291,0,"V(ch2)*10"}
      Text: "V" 1 (1.75e-05,1.45) ;Inductor: the current peaks 0.32 us AFTER the voltage, so the current LAGS by 84 degrees
      Text: "V" 1 (1.7521e-05,1.15) ;voltage peak
      Arrow: "V" 1 2 (1.7671e-05,1.1) (1.7871e-05,0.88)
      Text: "V" 1 (1.8537e-05,1.15) ;current peak
      Arrow: "V" 1 2 (1.8387e-05,1.1) (1.8187e-05,0.86)
      Text: "V" 1 (1.5847e-05,-1.13) ;CH1 = applied voltage at the top of L1
      Arrow: "V" 1 2 (1.5847e-05,-1.08) (1.5847e-05,-0.88)
      Text: "V" 1 (1.8862e-05,-1.3) ;CH2 x10 = current through L1 (drop across the 100 ohm sense resistor, scaled x10)
      Arrow: "V" 1 2 (1.8862e-05,-1.25) (1.8862e-05,-0.88)
      X: ('µ',1,1.5e-05,5e-07,2e-05)
      Y[0]: (' ',1,-1.4,0.2,1.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1.4,0.2,1.6)
      Log: 0 0 0
      GridStyle: 1
   }
}
