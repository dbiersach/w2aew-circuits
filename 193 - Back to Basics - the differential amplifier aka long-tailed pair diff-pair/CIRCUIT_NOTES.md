# Video 193: the long-tailed differential pair

Source: Alan Wolke (W2AEW), [Back to Basics: the differential amplifier](https://www.youtube.com/watch?v=mejPNuPAHBY), with his [handwritten notes](W2AEW%20Video%20Notes%20-%20longtailedpair.pdf).

| Time | What Alan shows |
| --- | --- |
| [5:02](https://www.youtube.com/watch?v=mejPNuPAHBY&t=302s) | [01 - Differential pair with a resistor tail](#01---differential-pair-with-a-resistor-tail) |
| [12:26](https://www.youtube.com/watch?v=mejPNuPAHBY&t=746s) | [02 - Differential pair with a transistor tail sink](#02---differential-pair-with-a-transistor-tail-sink) |
| [17:03](https://www.youtube.com/watch?v=mejPNuPAHBY&t=1023s) | [03 - PNP current-mirror active load](#03---pnp-current-mirror-active-load) |

Alan builds a two-transistor differential pair, replaces its shared emitter resistor with a transistor current sink, and then replaces the collector resistors with a PNP current-mirror load. The three schematics follow those stages in order. The LTspice 2N3904 and 2N3906 models and the 50 mV, 1 kHz test signal illustrate the behaviour; the test waveform is not a measured setting from Alan's bench.

All three runs sweep the DC common-mode level with `.step param VCMSET list 2 2.5 3`, keeping the 50 mV differential drive on VIN1 unchanged. Each pane carries its own step legend, because LTspice assigns step colours separately in every pane and the same setting can be a different colour in the pane above. Circuits 01 and 02 use identical vertical scales so their plots can be laid side by side. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - Differential pair with a resistor tail

[Open the schematic](01%20-%20Differential%20pair%20bench%20circuit/Differential%20pair%20bench%20circuit.asc) · [Saved plot settings](01%20-%20Differential%20pair%20bench%20circuit/Differential%20pair%20bench%20circuit.plt) · [Video at 5:02](https://www.youtube.com/watch?v=mejPNuPAHBY&t=302s)

Alan's first drawing uses a 9 V supply, 10 kΩ collector loads, a 4.7 kΩ shared emitter resistor, a 33 kΩ input resistor, and two 3.9 kΩ resistors from the bases to the common-mode source. A differential input steers the shared tail current between Q1 and Q2: when one collector current rises, its collector voltage falls and the other moves the opposite way.

![LTspice differential pair with resistor tail](01%20-%20Differential%20pair%20bench%20circuit/Differential%20pair%20bench%20circuit%20schematic.png)

![Resistor-tail common-mode sweep](01%20-%20Differential%20pair%20bench%20circuit/Differential%20pair%20bench%20circuit%20common-mode%20plot.png)

The top pane is the collector difference `V(OUT1,OUT2)`; below it are `V(OUT1)` and `V(OUT2)` separately. The two collectors do move in opposition: over one quarter cycle OUT1 falls from 7.517 V to 7.375 V while OUT2 rises from 7.527 V to 7.663 V.

What matters here is what the *common-mode* steps do. The three traces in the OUT1 pane sit in three clearly separated bands, and so do the three in the OUT2 pane. Raising the voltage shared by both inputs drags both collectors down with it, which is exactly the response a differential amplifier is supposed to reject. The differential swing changes too, from 0.556 V to 0.897 V, because the tail resistor lets the tail current grow as the common-mode level rises.

![Resistor-tail measurements](01%20-%20Differential%20pair%20bench%20circuit/Differential%20pair%20bench%20circuit%20SPICE%20measurements.png)

## 02 - Differential pair with a transistor tail sink

[Open the schematic](02%20-%20Transistor%20tail%20current%20source/Transistor%20tail%20current%20source.asc) · [Saved plot settings](02%20-%20Transistor%20tail%20current%20source/Transistor%20tail%20current%20source.plt) · [Video at 12:26](https://www.youtube.com/watch?v=mejPNuPAHBY&t=746s)

Alan replaces the 4.7 kΩ tail resistor with Q3, biased by a 20 kΩ/2.2 kΩ divider and given a 470 Ω emitter resistor. Q3's emitter degeneration holds its collector current steady whatever its collector voltage does, so the tail current no longer follows the common-mode level. Q1 and Q2 still steer that current between their collector branches. The sweep and the drive are unchanged from circuit 01.

![LTspice differential pair with transistor tail sink](02%20-%20Transistor%20tail%20current%20source/Transistor%20tail%20current%20source%20schematic.png)

![Transistor-tail common-mode sweep](02%20-%20Transistor%20tail%20current%20source/Transistor%20tail%20current%20source%20common-mode%20plot.png)

Same three panes, same vertical scales as circuit 01, and now the three stepped runs lie on top of one another in every pane. On a scale where the resistor tail spread its three common-mode settings across more than a volt, the current sink leaves them indistinguishable.

![Transistor-tail measurements](02%20-%20Transistor%20tail%20current%20source/Transistor%20tail%20current%20source%20SPICE%20measurements.png)

The logs give the comparison directly:

| Common-mode setting | Resistor tail: average OUT1 | Transistor tail: average OUT1 | Resistor tail: differential p-p | Transistor tail: differential p-p |
| ---: | ---: | ---: | ---: | ---: |
| 2.0 V | 7.5165 V | 6.3452 V | 0.5562 V | 0.9344 V |
| 2.5 V | 6.9915 V | 6.3437 V | 0.7315 V | 0.9343 V |
| 3.0 V | 6.4636 V | 6.3422 V | 0.8974 V | 0.9341 V |

Across the 2 V to 3 V sweep the resistor-tail OUT1 average falls by **1.053 V**; the transistor-tail average falls by only **2.91 mV**, a factor of 360. The differential gain also stops depending on the common-mode level: 0.934 V of swing at all three settings, against a 61 % change with the resistor. Both effects are the reason the tail current source is there.

## 03 - PNP current-mirror active load

[Open the schematic](03%20-%20PNP%20current%20mirror%20active%20load/PNP%20current%20mirror%20active%20load.asc) · [Saved plot settings](03%20-%20PNP%20current%20mirror%20active%20load/PNP%20current%20mirror%20active%20load.plt) · [Video at 17:03](https://www.youtube.com/watch?v=mejPNuPAHBY&t=1023s)

Alan then replaces the collector resistors with a PNP current mirror. The diode-connected left PNP sets the mirror bias and the right PNP feeds the output collector, so the current Q1 takes away and the current Q2 delivers both act on the same node. The two halves reinforce instead of cancelling, and the stage becomes single-ended with a very high collector load impedance. Alan does not name a PNP, so this schematic uses LTspice's 2N3906 as an illustrative model.

![LTspice differential pair with PNP mirror active load](03%20-%20PNP%20current%20mirror%20active%20load/PNP%20current%20mirror%20active%20load%20schematic.png)

![PNP active-load output](03%20-%20PNP%20current%20mirror%20active%20load/PNP%20current%20mirror%20active%20load%20output%20plot.png)

`V(MIRROR)` is the flat trace at 8.38 V, one PNP base-emitter drop below the 9 V rail, which is what a diode-connected transistor should sit at. `V(OUT2)` is the large waveform, and it is clipped flat at both ends.

![PNP active-load measurement](03%20-%20PNP%20current%20mirror%20active%20load/PNP%20current%20mirror%20active%20load%20SPICE%20measurements.png)

`SINGLE_PP` reports **6.933 V peak-to-peak** at OUT2 between 1 ms and 5 ms, against the 0.934 V the same pair produced across a resistor load. That is the active load's effect, but the number is a limit rather than a gain: the output runs from about 2.0 V to 8.9 V and sits against both ends for most of the cycle. The 50 mV drive that suited circuits 01 and 02 overloads this one, so no linear small-signal gain can be read from this run.
