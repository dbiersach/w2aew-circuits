# Video 118: PIN diodes as RF switches

Source: Alan Wolke (W2AEW), [#118: Basics of PIN diodes and their use in RF switch applications](https://www.youtube.com/watch?v=XpYsCM_Wf50). His two pages of notes for the lesson are kept here as [W2AEW Video Notes - Basics_of_PIN_diodes.pdf](<W2AEW Video Notes - Basics_of_PIN_diodes.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=15s) | The structural difference: a PN junction against a PIN diode with an undoped intrinsic layer between the P and N regions. At DC and low frequencies the two behave the same. |
| [1:45](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=105s) | The consequence of that intrinsic layer: it stores charge, and the diode does not turn off until the stored charge has been removed. |
| [3:15](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=195s) | The headline result. At high frequencies there is not enough time in one cycle to sweep the stored charge out, so the PIN diode stops behaving like a rectifier and behaves like a resistor whose value is set by the DC bias current. |
| [4:45](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=285s) | What that is good for: switches, variable attenuators, modulators and phase shifters. With zero or reverse bias the wide depletion region leaves only a very small capacitance, which is what gives a switch its off state. |
| [5:30](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=330s) | The series SPST switch he builds, reproduced in [01 - Series SPST switch](#01---series-spst-switch). |
| [7:45](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=465s) | The generator settings: a Tektronix AFG3252 sending a 10.000 MHz sine at 5.000 Vpp into 50 ohms. |
| [8:32](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=512s) | 2.003 mA of bias on the meter, and a clean sine of about four divisions at 1 V/div on the scope. |
| [10:47](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=647s) | The bias turned down to 0.367 mA, where the waveform visibly loses its shape. |
| [13:45](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=825s) | Two further configurations drawn but not built: a shunt SPST switch, and a series-shunt SPST that combines both for better isolation. |
| [15:15](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=915s) | A transmit/receive switch, where a quarter-wave line turns the shunt diode's short into an open at the antenna. |

Alan adds a correction in the video description. He says in the video that PIN diodes are not suitable for fast switches; what he meant is that they are unsuitable where fast **turn-off under reverse bias** matters, such as rectifiers, detectors and mixers. As RF switches they are fast enough and are used for exactly that.

## What the lesson establishes

This builds on [video 82](<../082 - Basics of Diode Switches - How to use a Diode as a Switch/CIRCUIT_NOTES.md>), where an ordinary diode is biased on and off to pass or block a small signal. The question 118 answers is what happens when the signal is no longer small.

An ordinary PN junction is a rectifier: its resistance depends on the instantaneous voltage across it, so a signal large enough to swing the junction will be distorted. A PIN diode has an undoped intrinsic region between the P and N layers, and forward bias floods that region with carriers. Those carriers take a while to recombine, and that lifetime is the whole story:

- Over one RF cycle the signal tries to sweep charge out of the intrinsic region and push it back in. The charge it moves is the peak RF current divided by the angular frequency.
- The charge sitting there is the DC bias current multiplied by the carrier lifetime.
- While the stored charge is comfortably larger than the charge the RF moves, the intrinsic region never empties, the junction never gets a chance to turn off, and the device is simply a resistance.
- Lower the bias until the two are comparable and the diode starts turning off within each cycle, which is the distortion Alan shows at 0.367 mA.

That is also why the effect is a high-frequency one. The same diode at a low enough frequency gives the charge plenty of time to leave, and it rectifies like any other diode.

## 01 - Series SPST switch

[01 - Series SPST switch/Series PIN diode switch.asc](<01 - Series SPST switch/Series PIN diode switch.asc>) reproduces the fixture on the second page of Alan's notes, which he draws at [5:30](https://www.youtube.com/watch?v=XpYsCM_Wf50&t=330s). The shortcut [Video 118 - 01 - Series SPST switch.url](<01 - Series SPST switch/Video 118 - 01 - Series SPST switch.url>) opens the video there.

![LTspice schematic of the series PIN diode RF switch](<01 - Series SPST switch/Series PIN diode switch schematic.png>)

| Part | Value | Role |
| --- | ---: | --- |
| `Vrf` / `Rsrc` | 10 MHz, 5 Vpp into 50 ohms | The AFG3252 settings from 7:45, as a 10 Vpp source behind 50 ohms |
| `Cin` / `Cout` | 0.1 µF | Couple RF in and out while blocking the bias |
| `Rbias` | 1 kΩ | Feeds bias current to the anode |
| `Cbypass` | 0.47 µF | Grounds the top of `Rbias` at RF |
| `Dpin` | DPIN | The PIN diode |
| `Rdc` | 680 Ω | Returns the bias current to ground from the cathode |
| `Rscope` | 50 Ω | The terminated scope input |

The bias path runs from the supply through `Rbias`, the diode and `Rdc` to ground, so turning the supply up raises the bias current. At 10 MHz both coupling capacitors are a fraction of an ohm and `Cbypass` grounds the bias feed, so the RF sees a 50 ohm source, a 1 kΩ shunt at the anode, the diode in series, and 680 Ω in parallel with the 50 ohm scope at the cathode.

### The diode model

`DPIN` is an illustrative model, not a named part. Alan does not say which diode he uses, and this collection holds no manufacturer PIN model. The parameters that matter are stated on the schematic:

`.model DPIN D(Is=5e-12 N=2 Rs=1 Cjo=1p Tt=1u Bv=200)`

`Tt` is the transit time, which is how SPICE represents exactly the charge storage Alan describes: the charge held in the diode is `Tt` times the current through it, and that charge has to be removed before the diode can turn off. Setting it to 1 µs puts the device in the range of an ordinary small-signal PIN switch. `Rs` of 1 Ω is the floor the on-resistance approaches at high current, and `Cjo` of 1 pF is the off-state capacitance.

What this model does **not** reproduce is the way a real PIN diode's on-resistance falls smoothly with bias current over tens of ohms, because SPICE has no element for the conductivity of the intrinsic region and `Rs` is a fixed number. The resistance it does show falling with bias, reported below, comes from the diode starting to turn off at low bias rather than from conductivity modulation. Treat the shape of the waveforms as the lesson and the resistance figures as indicative.

### What the simulation shows

The analysis is `.tran 0 2.4u 2u 0.2n`, so only the last 400 ns are saved: four cycles of the 10 MHz signal, long after the DC bias has settled. `.step param VS list 0.95 4.52 8.2` sets three supply voltages, chosen so the resulting bias currents land on the ones Alan reads off his meter.

![Scope-node waveform at three bias currents](<01 - Series SPST switch/Series PIN diode switch waveforms.png>)

If the waveform window opens autoscaled with all three steps overlaid, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Series PIN diode switch.plt](<01 - Series SPST switch/Series PIN diode switch.plt>), which puts one step in each pane.

| Step | `IBIAS` | `VSCOPE_PP` | `VD_PP` | `RD` |
| ---: | ---: | ---: | ---: | ---: |
| 1 | 0.70 mA | 4.65 V | 3.29 V | 33.0 Ω |
| 2 | 2.01 mA | 4.66 V | 0.109 V | 1.09 Ω |
| 3 | 4.15 mA | 4.66 V | 0.102 V | 1.02 Ω |

`RD` is the peak-to-peak voltage across the diode divided by the peak-to-peak current through it, so it is the effective resistance the RF sees.

Steps 2 and 3 are the "on" case. Almost nothing is dropped across the diode, the scope sees 4.66 Vpp, and the two panes are clean sines. The bias current has been doubled between them and the waveform has not changed, which is the point: once there is enough stored charge, more of it changes nothing.

Step 1 is where it breaks down, and the arithmetic says exactly why. `ID_PP` is 100 mA peak to peak in every step, so the RF peak is 50 mA, and the charge it moves in a half cycle is that current divided by the angular frequency, `0.05 / (2π x 10 MHz)`, or 0.80 nC. The charge stored at 0.70 mA of bias is `Tt` times the bias current, 0.70 nC. The RF is asking for slightly more charge than the diode is holding, so the intrinsic region empties partway through each cycle, the diode turns off, and the bottom pane shows the trace breaking away from the sine and collapsing toward zero before conduction resumes. At 2.01 mA the stored charge is 2.0 nC against the same 0.80 nC demand, with room to spare, and the waveform is clean.

### Simulation against Alan's bench

The agreement is good where it can be checked. His scope at 1 V/div shows roughly four divisions peak to peak with the bias on, against a simulated 4.66 Vpp. His clean trace is at 2.003 mA and the simulation is clean at 2.01 mA. His distorted trace is at 0.367 mA and the simulation distorts at 0.70 mA, the same side of the same transition, with the difference falling well inside the carrier lifetime assumed for the model: a diode with twice the lifetime would store twice the charge and would hold out to half the current.

One thing the simulation does not attempt is the off state. With no bias the diode is reduced to its 1 pF junction capacitance, which at 10 MHz is about 16 kΩ of reactance and blocks the signal almost completely. That is the switching action, and it is demonstrated directly in [video 82's chapter](<../082 - Basics of Diode Switches - How to use a Diode as a Switch/CIRCUIT_NOTES.md>) with a small signal, where it can be shown without the large-signal behaviour studied here getting in the way.

## Configurations drawn but not built

Alan's second page also shows three circuits he does not build on the bench, and his drawings give no component values for them, only RF chokes and coupling capacitors marked as such. They are described here rather than reconstructed, because inventing values for them would not be reporting what the video shows.

- **Shunt SPST.** The diode sits from the signal line to ground rather than in series with it, fed through an RF choke from the bias terminal. Forward biased, it shorts the line and blocks transmission; unbiased it is a small capacitance across the line and the signal passes. It is the inverse of the series switch, and it gives better isolation at high frequencies because a diode's residual capacitance shunts the signal to ground instead of leaking it forward.
- **Series-shunt SPST.** A series diode followed by a shunt diode, with chokes feeding both. Driving them so one conducts while the other does not combines the two mechanisms, giving far more isolation in the off state than either alone.
- **Transmit/receive switch.** The series diode passes transmitter power to the antenna when the TX-ENABLE line biases it on, while a shunt diode at the receiver shorts the receiver input to protect it. A quarter-wave line between the antenna and that shunt diode transforms the short into an open at the antenna end, so shorting the receiver does not load the transmitter. On receive both diodes are off and the signal reaches the receiver through the line.
