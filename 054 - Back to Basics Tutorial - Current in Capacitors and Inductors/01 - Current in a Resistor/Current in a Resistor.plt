[Transient Analysis]
{
   Npanes: 1
   {
      traces: 2 {589826,0,"V(ch1)"} {589830,0,"V(ch2)*10"}
      Text: "V" 1 (1.75e-05,1.45) ;Resistor: the current (CH2) and the voltage (CH1) rise and fall together; LEAD_DEG = 0
      Text: "V" 1 (1.788e-05,1.15) ;voltage and current peak together
      Arrow: "V" 1 2 (1.788e-05,1.1) (1.788e-05,0.86)
      Text: "V" 1 (1.5855e-05,-1.13) ;CH1 = applied voltage at the top of R1
      Arrow: "V" 1 2 (1.5855e-05,-1.08) (1.5855e-05,-0.88)
      Text: "V" 1 (1.8555e-05,-1.3) ;CH2 x10 = current through R1 (drop across the 100 ohm sense resistor, scaled x10)
      Arrow: "V" 1 2 (1.8555e-05,-1.25) (1.8555e-05,-0.88)
      X: ('µ',1,1.5e-05,5e-07,2e-05)
      Y[0]: (' ',1,-1.4,0.2,1.6)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1.4,0.2,1.6)
      Log: 0 0 0
      GridStyle: 1
   }
}
