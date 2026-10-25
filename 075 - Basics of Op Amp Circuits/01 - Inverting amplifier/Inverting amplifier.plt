[DC transfer characteristic]
{
   Npanes: 2
   {
      traces: 1 {589830,0,"V(inv_in)"}
      Text: "V" 1 (5.3,5.035) ;The - input: negative feedback holds it at the 5 V reference
      Text: "V" 1 (4.3,4.945) ;it sags only where the output has saturated
      Arrow: "V" 1 2 (3.9,4.95) (3.15,4.935)
      X: (' ',0,3,0.5,7)
      Y[0]: (' ',0,4.9,0.025,5.05)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,4.9,0.025,5.05)
      Log: 0 0 0
      GridStyle: 1
   },
   {
      traces: 1 {589826,0,"V(vout)"}
      Text: "V" 1 (5.3,9.4) ;Output moves twice as far as the input, and in the opposite direction
      Text: "V" 1 (5.1,6.6) ;Alan's worked example: 4 V in gives 7.00 V out
      Arrow: "V" 1 2 (4.5,6.75) (4.02,7.0)
      Text: "V" 1 (4.6,8.3) ;3 V in asks for 9 V, but this LM358 stops at 8.79 V
      Arrow: "V" 1 2 (3.9,8.25) (3.05,8.79)
      X: (' ',0,3,0.5,7)
      Y[0]: (' ',0,0,1,10)
      Y[1]: ('_',0,1e+308,0,-1e+308)
      Volts: (' ',0,0,1,0,1,10)
      Log: 0 0 0
      GridStyle: 1
   }
}
