# Video 281: Bipolar transistor switching time

Source: Alan Wolke (W2AEW), [#281: Bipolar Transistor Switching Time Measurement](https://www.youtube.com/watch?v=XgSKLsWAWGs). His three pages of notes are kept here as [W2AEW Video Notes - bipolar_transistor_switching_time.pdf](<W2AEW Video Notes - bipolar_transistor_switching_time.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=20s) | "The Good, the Bad, the Ugly". The good is that the question is simple: how long does the transistor take to get between cutoff and saturation. The bad is that there is no standard test circuit and no standard test conditions, so methods vary by manufacturer and by device. The ugly is that the answer depends on those conditions and takes four numbers, sometimes six. |
| [4:20](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=260s) | The drive levels. V_H has to be high enough to saturate the device, with base current roughly a tenth or a twentieth of collector current. V_L turns it off, and is sometimes 0 V and sometimes negative; some datasheets even use different drive conditions for turn-on and turn-off, or a clamp diode. |
| [6:20](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=380s) | The four definitions, all referred to collector current: delay time until it starts to rise, rise time from 10% to 90%, storage time until it starts to fall, and fall time from 90% back to 10%. The combined t_ON and t_OFF are less common because their definitions are not consistent. |
| [9:10](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=550s) | The test circuit, reproduced in [01 - Transistor switching-time test fixture](#01---transistor-switching-time-test-fixture). |
| [10:20](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=620s) | The circuit built on the bench, with the probes on the three points. |
| [13:56](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=836s) | All four traces on a Tektronix MDO4104C: generator, base, collector and base current. The base current trace makes the mechanism visible, because it goes sharply negative at turn-off while the stored charge is swept out. |
| [20:56](https://www.youtube.com/watch?v=XgSKLsWAWGs&t=1256s) | The scope's automatic measurements on the collector trace: a fall time of 16.58 ns and a rise time of 28.34 ns. |

## What the lesson establishes

The reason a saturated transistor is slow to turn off, and fast to turn on, is charge. Driving the base hard enough to saturate the device floods the base region with more carriers than the collector current needs. Turning the drive off does not turn the transistor off: the excess charge has to leave first, and until it does, the collector current does not even begin to fall. That interval is the storage time, and it is usually far larger than any of the other three.

Alan's framing matters as much as the definitions. Because there is no standard fixture, a switching time on a datasheet is only meaningful alongside the conditions it was taken under. Two numbers for the same part number can differ by a large factor simply because one manufacturer used a negative turn-off drive and the other used ground, or because the overdrive factor differed.

## 01 - Transistor switching-time test fixture

[01 - Transistor switching-time test fixture/Transistor switching-time test fixture.asc](<01 - Transistor switching-time test fixture/Transistor switching-time test fixture.asc>) is the circuit on page 3 of his notes, with the shortcut [Video 281 - 01 - Transistor switching-time test fixture.url](<01 - Transistor switching-time test fixture/Video 281 - 01 - Transistor switching-time test fixture.url>) opening the video there.

![LTspice schematic of the switching-time test fixture](<01 - Transistor switching-time test fixture/Transistor switching-time test fixture schematic.png>)

| Part | Value | Role |
| --- | ---: | --- |
| `Vsupply` | 5 V | Collector supply |
| `Cbulk` / `Clocal` | 2.2 µF / 1 nF | Supply decoupling, as drawn |
| `Rcollector` | 220 Ω | Sets the saturated collector current |
| `Rtermination` | 50 Ω | Terminates the generator |
| `Rbase` | 1.2 kΩ | Sets the base drive current |
| `Qdut` | 2N3904 | The device under test |

The three probe points are named for the channels on Alan's drawing: `CH1_COLLECTOR`, `CH2_DRIVE` at the generator, and `CH3_BASE` at the base itself.

Two things are simulation choices, because Alan's drawing marks them as adjustable rather than fixed. He does not name the device under test, so the LTspice 2N3904 stands in. And he gives the drive only as V_H and V_L, so the pulse here runs from -1 V to +5 V. The edges are 2 ns, which follows his stated test condition on page 2 that the input rise and fall should be under 10 ns and are typically 1 to 2 ns.

### What the simulation shows

![Collector, collector current, drive and base traces](<01 - Transistor switching-time test fixture/Transistor switching-time test fixture LTspice plot.png>)

If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Transistor switching-time test fixture.plt](<01 - Transistor switching-time test fixture/Transistor switching-time test fixture.plt>).

The top pane is what Alan's CH1 sees. The middle pane is the collector current, because that is what the four definitions are actually about. The bottom pane is the drive and the base.

The drive goes low at 2.5 µs. Nothing happens at the collector for more than a microsecond. The base sits at about 0.8 V, still forward biased, because the stored charge is holding it there, and only once that charge is gone does the base fall to -1 V, the collector current collapse and the collector voltage jump to 5 V.

The `.meas` directives implement Alan's four definitions directly, triggering on the 50% point of the drive and on the 10% and 90% levels of collector current:

| Measurement | Result | Alan's definition |
| --- | ---: | --- |
| `IC_ON` | 22.554 mA | Saturated collector current, which fixes the 10% and 90% levels at 2.2554 mA and 20.299 mA |
| `IB_ON` | 3.481 mA | Base current while on |
| `OVERDRIVE` | 6.48 | `IC_ON` over `IB_ON` |
| `VCESAT` | 38.0 mV | Collector voltage while saturated |
| `TD` | 4.93 ns | Delay: drive edge to 10% of collector current |
| `TR` | 5.37 ns | Rise: 10% to 90% |
| `TS` | **1073 ns** | Storage: drive edge to 90% on the way down |
| `TF` | 12.83 ns | Fall: 90% to 10% |
| `TON` | 10.30 ns | `TD` + `TR` |
| `TOFF` | 1086 ns | `TS` + `TF` |

Storage time is a hundred times everything else. Turn-on takes 10 ns; turn-off takes 1.09 µs, and 1.07 µs of that is spent doing nothing visible while charge drains out of the base. That one number is the lesson, and it is why a saturated switch is a poor choice where speed matters, and why Schottky clamping and non-saturating logic exist.

`OVERDRIVE` is the knob that controls it. Alan says the base current should be about a tenth or a twentieth of the collector current; here it is a sixth, so the device is driven harder into saturation than he suggests, and the storage time is correspondingly worse. Raising `Rbase` would cut the stored charge and the storage time with it, at the cost of a higher `VCESAT` and a slower turn-on.

### Simulation against Alan's bench

His scope's automatic measurements on the collector trace read a fall time of 16.58 ns and a rise time of 28.34 ns. The collector voltage is inverted relative to collector current, so a falling collector edge is collector current rising: his 16.58 ns corresponds to Alan's t_R and his 28.34 ns to t_F. The simulation gives 5.37 ns and 12.83 ns for those, roughly two to three times faster.

That direction is the expected one and does not need explaining away. The simulated circuit has no probe capacitance, no breadboard inductance and no lead length, and its transistor is a model rather than a particular device. What the two agree on is the shape of the answer: turn-on edges of tens of nanoseconds, turn-off dominated by a storage interval far larger than any edge.

The numbers here belong to this model under this drive. They are not a switching specification for any manufacturer's 2N3904, and Alan's whole first section is about why quoting them as one would be wrong.
