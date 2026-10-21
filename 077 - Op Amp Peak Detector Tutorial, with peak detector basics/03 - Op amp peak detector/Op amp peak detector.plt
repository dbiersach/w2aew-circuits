[Transient Analysis]
{
   Npanes: 2
   {
      traces: 2 {524290,0,"V(vin)@1"} {524291,0,"V(vout)@1"}
      Text: "V" 1 (0.002,0.33) ;Same 0.5 V p-p input the plain diode could not see: this one still reads a 0.29 V peak
      X: ('m',0,0,0.0005,0.004)
      Y[0]: (' ',0,-0.4,0.1,0.4)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-0.4,0.1,0.4)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 2 {524290,0,"V(vin)@2"} {524291,0,"V(vout)@2"}
      Text: "V" 1 (0.002,1.62) ;The output now reaches 1.43 V against a 1.50 V input peak: the diode drop has gone
      Text: "V" 1 (0.0029,0.72) ;feedback is taken after the diode, so the op amp supplies the extra 0.7 V itself
      X: ('m',0,0,0.0005,0.004)
      Y[0]: (' ',0,-1.8,0.5,1.8)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,-1.8,0.5,1.8)
      Log: 0 0 0
      GridStyle: 1
   }
}
