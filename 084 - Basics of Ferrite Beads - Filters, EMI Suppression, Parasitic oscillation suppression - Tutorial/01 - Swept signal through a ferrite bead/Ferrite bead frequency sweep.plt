[AC Analysis]
{
   Npanes: 2
   Active Pane: 1
   {
      traces: 1 {3,0,"(V(in)-V(out))/I(RSCOPE)"}
      Text: "" 1 (3000000,700) ;Series impedance of the bead, (V(in)-V(out)) / I(RSCOPE)
      Text: "" 1 (300000,120) ;below 1 MHz the bead impedance stays under 10 ohm, so the signal passes
      Text: "" 1 (20000000,420) ;150 ohm at the peak: the core loss dominates and the bead acts like a resistor
      Arrow: "" 1 2 (30000000,340) (100000000,165)
      X: ('K',0,10000,0,1000000000)
      Y[0]: ('_',0,1,0,1000)
      Y[1]: (' ',0,-100,20,100)
      Log: 1 1 0
      GridStyle: 1
      PltMag: 1
   },
   {
      traces: 1 {589826,0,"V(out)/0.5"}
      Text: "" 1 (3000000,1.2) ;Output relative to the same path without the bead: flat through the low end of Alan's sweep
      Text: "" 1 (150000000,0.78) ;0.44 at 40 MHz, the top of Alan's sweep: 7.1 dB of loss
      Arrow: "" 1 2 (150000000,0.74) (40000000,0.46)
      Text: "" 1 (200000000,0.22) ;above self-resonance CPAR shunts the bead
      X: ('K',0,10000,0,1000000000)
      Y[0]: (' ',2,0,0.2,1.3)
      Y[1]: (' ',0,-100,20,100)
      Log: 1 0 0
      GridStyle: 1
      PltMag: 1
   }
}
