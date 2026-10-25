[AC Analysis]
{
 Npanes: 2
 {
  traces: 2 {589828,0,"V(antenna)@1"} {589829,0,"V(antenna)@2"}
  X: ('M',1,1e+06,0,1e+08)
  Y[0]: (' ',1,0.001,10,2)
  Y[1]: ('_',0,1e+308,0,-1e+308)
  Log: 1 2 0
  GridStyle: 1
  PltMag: 1
  PltPhi: 0
  Text: "V" 1 (6e+06,1.5) ;V(ANTENNA): -6.00 dB driven from the antenna on receive, -6.68 dB driven from the transmitter
 }
 {
  traces: 2 {589826,0,"V(rx_out)@1"} {589830,0,"V(rx_out)@2"}
  X: ('M',1,1e+06,0,1e+08)
  Y[0]: (' ',1,0.001,10,2)
  Y[1]: ('_',0,1e+308,0,-1e+308)
  Log: 1 2 0
  GridStyle: 1
  PltMag: 1
  PltPhi: 0
  Text: "V" 1 (6e+06,1.5) ;V(RX_OUT): -6.02 dB on receive, -32.60 dB on transmit, which is 25.9 dB below the antenna at 10.1 MHz
 }
}
