# Video 200: PIN diode T/R switch with a lumped quarter-wave line

Source: Alan Wolke (W2AEW), [#200: T/R Switch w/ PIN Diodes and Lumped Element Quarter-wavelength transmission line](https://www.youtube.com/watch?v=A1BAq0KxIdc). His notes for the lesson are kept here as [W2AEW Video Notes - TRswitch.pdf](<W2AEW Video Notes - TRswitch.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=15s) | The finished switch on a scrap of copper-clad board. |
| [1:10](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=70s) | The problem: one antenna, a transmitter that puts out watts and a receiver that would be destroyed by a fraction of one, and a switch that has to be fast and silent. |
| [3:10](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=190s) | The two PIN diodes: one in series with the transmit path to pass power to the antenna, one shunting the receiver input to protect it. |
| [6:10](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=370s) | Why a quarter-wave line sits between them. A short circuit at one end of a quarter wave looks like an open at the other, so the shunt diode protects the receiver without loading the transmitter. |
| [8:28](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=508s) | The lumped equivalent and its arithmetic, reproduced in [01 - Two PIN diode T R switch](#01---two-pin-diode-t-r-switch). Setting the reactances equal to the 50 Ω line impedance at 10.1 MHz gives `L = 50/(2*pi*f)`, about 790 nH, and `C = 1/(2*pi*f*50)`, about 315 pF. |
| [10:03](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=603s) | The board itself, labeled "10.1 MHz T/R switch PIN diodes 1/4 wave". |
| [12:06](https://www.youtube.com/watch?v=A1BAq0KxIdc&t=726s) | Measuring it, driven from a function generator at 10.100 MHz and 1.0000 Vpp. |

## What the lesson establishes

A transmit/receive switch has to do two things at once: get the transmitter's power to the antenna, and keep it out of the receiver. A single series switch does the first but not the second, because a diode that is off still has capacitance, and a few watts through a few picofarads is more than enough to destroy a receiver front end.

The answer is to add a second diode that deliberately shorts the receiver input during transmit, and then to stop that short from also shorting the antenna. A quarter-wave line does exactly that: it inverts impedances end to end, so a short at the receiver appears as an open at the antenna. The receiver is protected and the transmitter sees nothing.

Below VHF a quarter wave of coax is inconveniently long, so Alan builds its lumped equivalent, a pi section of shunt capacitor, series inductor and shunt capacitor. Choosing both reactances equal to the line's characteristic impedance makes the section behave as a quarter wave at the design frequency, and the arithmetic for 50 Ω at 10.1 MHz is the two lines he writes at 8:28.

## 01 - Two PIN diode T R switch

[01 - Two PIN diode T R switch/Two PIN diode T R switch.asc](<01 - Two PIN diode T R switch/Two PIN diode T R switch.asc>) follows the final drawing, with the shortcut [Video 200 - 01 - Two PIN diode T R switch.url](<01 - Two PIN diode T R switch/Video 200 - 01 - Two PIN diode T R switch.url>) opening the video there.

![LTspice schematic of the two PIN diode T/R switch](<01 - Two PIN diode T R switch/Two PIN diode T R switch schematic.png>)

| Part | Value | Source |
| --- | ---: | --- |
| `CTX`, `CRX` | 10 nF | Both marked 10nF on his drawing |
| `REN` | 1 kΩ | Marked 1K |
| `C1`, `C2` | 315 pF | His calculation at 8:28 |
| `L1` | 790 nH | His calculation at 8:28 |
| `CANT` | 10 nF | **Assumed.** He draws an antenna coupling capacitor but does not label it; 10 nF matches his other two |
| `DTX`, `DRX` | SMP1320 approximation | **Assumed.** He does not name the PIN diode |
| `VENABLE` | 0 V or 5 V | **Assumed.** He marks only TX_ENABLE |

The topology is his: the transmitter couples in through `CTX` to a node fed with bias through `REN`, the series diode `DTX` passes that to the antenna node, the pi section forms the quarter wave, the shunt diode `DRX` grounds the far end of it, and `CRX` couples what is left to the receiver.

### The diode model

The model, kept with the collection's other unverified files as [`LTspice/Models/Unverified/SMP1320_APN1011_approx.lib`](<../LTspice/Models/Unverified/SMP1320_APN1011_approx.lib>), is **a model built here from Skyworks' published application-note figures**, not a manufacturer LTspice file. It uses `IS=2.4e-10`, `RS=2.6`, `N=1.75`, about 0.45 pF of junction capacitance, and treats the quoted 0.4 µs carrier lifetime as a transit time.

Its limitation is the same one that applies to any ordinary SPICE diode standing in for a PIN: SPICE has no element for the conductivity of the intrinsic region, so the forward resistance does not fall with bias the way a real PIN's does. The figures below therefore demonstrate the network's behavior. They are not a measurement of any particular diode, and they are not Alan's bench numbers.

A search for a manufacturer model found candidates but nothing directly usable: Skyworks' APN1008 gives device parameters inside a Libra IV deck rather than a SPICE netlist, and Infineon's BAR64 page references a SPICE model that is not exposed for download. Two local libraries contain named PIN subcircuits, but neither carries a verified revision or license, so they sit outside this collection's rules on provenance.

### What the simulation shows

The analysis is `.ac dec 101 100k 100Meg`, stepped through the two switch states. In each state the active port is driven with a 1 V source behind 50 Ω and the inactive port's source provides its 50 Ω termination, so the ideal through-path reads -6 dB rather than 0 dB.

![AC response of both switch states](<01 - Two PIN diode T R switch/Two PIN diode T R switch AC response.png>)

If the waveform window opens autoscaled with both steps overlaid, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Two PIN diode T R switch.plt](<01 - Two PIN diode T R switch/Two PIN diode T R switch.plt>).

| At 10.1 MHz | Receive state | Transmit state |
| --- | ---: | ---: |
| `ANT_10M`, antenna node | -5.99 dB | -6.68 dB |
| `RX_10M`, receiver output | -6.02 dB | -32.60 dB |

Three things come out of those four numbers.

**Receive costs almost nothing.** With the diodes off, the receiver sees -6.02 dB against the -5.99 dB at the antenna, so the quarter-wave section and the two off diodes together take 0.03 dB. The pi network is doing its job of looking like a piece of 50 Ω line.

**Transmit reaches the antenna.** -6.68 dB against the ideal -6.00 dB is 0.68 dB of insertion loss through the forward-biased series diode, which is where this model's fixed series resistance shows up.

**The receiver is protected by 25.9 dB.** That is the gap between the antenna node and the receiver output in transmit. On a real build the figure depends on how completely the shunt diode conducts and on how accurately the pi section inverts at the operating frequency, both of which this model only approximates.

The AC sweep linearises about each state's DC operating point, so none of this says anything about how fast the switch changes over, how much transmitter power it can stand, or what distortion it adds. Those are the questions a PIN switch is usually judged on, and they need a large-signal model this one is not.
