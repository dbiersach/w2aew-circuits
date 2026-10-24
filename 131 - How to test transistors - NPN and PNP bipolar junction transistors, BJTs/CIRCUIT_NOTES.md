# Video 131: Testing NPN and PNP bipolar transistors

Source: [Alan Wolke, *How to test transistors - NPN and PNP bipolar junction transistors, BJTs*](https://www.youtube.com/watch?v=qM7_h8my8eA). The [full-video shortcut](Video%20131%20-%20How%20to%20test%20transistors%20-%20NPN%20and%20PNP%20BJTs.url) opens the same source. Alan draws the NPN and PNP two-junction equivalents around [2:31](https://www.youtube.com/watch?v=qM7_h8my8eA&t=151s), then demonstrates loose-device checks with a Simpson 260, a Fluke DMM, and two Heathkit transistor testers.

| Time | What Alan shows |
| --- | --- |
| [1:00](https://www.youtube.com/watch?v=qM7_h8my8eA&t=60s) | A loose transistor checked on a Simpson 260 analog meter. |
| [2:31](https://www.youtube.com/watch?v=qM7_h8my8eA&t=151s) | He draws the NPN and PNP two-junction equivalents. All four fixtures below illustrate this one drawing, which is why they share this entry point: [01](#01---npn-base-to-emitter), [02](#02---pnp-emitter-to-base), [03](#03---npn-base-to-collector), [04](#04---pnp-collector-to-base). |
| [5:00](https://www.youtube.com/watch?v=qM7_h8my8eA&t=300s) | The same checks on a Fluke DMM, where an open reading one way and a junction drop the other is what the fixtures model. |

## What the junction check establishes, and what it does not

Seen from the outside, a bipolar transistor behaves like two diode junctions sharing the base. Touching a meter's leads across each pair in both polarities locates the base, tells NPN from PNP, and catches a junction that is shorted or open. For a PNP every lead polarity is the opposite of the NPN case. What these checks cannot show is current gain, leakage at operating voltage, or breakdown, so a transistor that passes them can still be unusable.

Alan does not state the Simpson range's effective open-circuit voltage and internal resistance, the Fluke's diode-test current, or the Heathkit testers' internal circuits. The four LTspice fixtures below are therefore **illustrative models of the polarity lesson**, not reconstructions of his instruments: each applies a swept test voltage through a 1 kΩ limiting resistor, which stands in for a meter's internal resistance, and measures the current that flows. The 1 GΩ resistor on the third, untouched terminal only keeps that node from floating in SPICE. The devices are LTspice's bundled 2N3904 and 2N2907 models; Alan does not name the parts he probes.

Each fixture sweeps `VTEST` from -1.2 V to +1.2 V and uses `.meas` to report the current at +1 V and at -1 V. All four plots share the same axes, so the four curves can be laid side by side, and each is annotated with its forward and reverse result. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - NPN, base to emitter

[Schematic](01%20-%20NPN%20junction%20test/NPN%20junction%20test.asc) · [Saved plot settings](01%20-%20NPN%20junction%20test/NPN%20junction%20test.plt) · [Video at 2:31](01%20-%20NPN%20junction%20test/Video%20131%20-%2001%20-%20NPN%20junction%20test.url)

The positive test lead sits on the **base** and the negative lead on the **emitter**, which is grounded here. This is the forward direction for an NPN base-emitter junction.

![NPN base-emitter LTspice schematic](01%20-%20NPN%20junction%20test/NPN%20junction%20test%20schematic.png)

![NPN base-emitter current against test voltage](01%20-%20NPN%20junction%20test/NPN%20junction%20test%20LTspice%20plot.png)

The trace is `I(RLIMIT)`, the current through the 1 kΩ limiting resistor, against the swept test voltage. Nothing measurable flows until about +0.5 V, after which the curve turns up sharply and reaches 326 µA at +1 V. On the negative half the current is 2 pA, which is a flat line at this scale. That contrast, a reading one way and effectively an open circuit the other, is what a meter shows on a healthy junction.

![NPN base-emitter measured currents](01%20-%20NPN%20junction%20test/NPN%20junction%20test%20SPICE%20measurements.png)

## 02 - PNP, emitter to base

[Schematic](02%20-%20PNP%20junction%20test/PNP%20junction%20test.asc) · [Saved plot settings](02%20-%20PNP%20junction%20test/PNP%20junction%20test.plt) · [Video at 2:31](02%20-%20PNP%20junction%20test/Video%20131%20-%2002%20-%20PNP%20junction%20test.url)

For a PNP the leads swap over: the positive test lead goes to the **emitter** and the grounded negative lead to the **base**. The current now flows into the emitter and out of the base, the opposite of circuit 01.

![PNP emitter-base LTspice schematic](02%20-%20PNP%20junction%20test/PNP%20junction%20test%20schematic.png)

![PNP emitter-base current against test voltage](02%20-%20PNP%20junction%20test/PNP%20junction%20test%20LTspice%20plot.png)

The curve has the same shape as the NPN one, reaching 334 µA at +1 V against 1 pA at -1 V. Only the lead positions changed. A meter that reads a junction drop here but not with the leads the other way round has found a PNP.

![PNP emitter-base measured currents](02%20-%20PNP%20junction%20test/PNP%20junction%20test%20SPICE%20measurements.png)

## 03 - NPN, base to collector

[Schematic](03%20-%20NPN%20base-collector%20test/NPN%20base-collector%20test.asc) · [Saved plot settings](03%20-%20NPN%20base-collector%20test/NPN%20base-collector%20test.plt) · [Video at 2:31](03%20-%20NPN%20base-collector%20test/Video%20131%20-%2003%20-%20NPN%20base-collector%20test.url)

The positive lead stays on the **base** while the negative lead moves from the emitter to the **collector**; the emitter now has only the 1 GΩ return. This is the second of the two junction checks that together identify the base pin.

![NPN base-collector LTspice schematic](03%20-%20NPN%20base-collector%20test/NPN%20base-collector%20test%20schematic.png)

![NPN base-collector current against test voltage](03%20-%20NPN%20base-collector%20test/NPN%20base-collector%20test%20LTspice%20plot.png)

The result, 331 µA at +1 V against 2 pA at -1 V, is close enough to circuit 01 that a meter would show a similar reading. That similarity is the point: the base is the one pin that reads forward against *both* of the others, which is how it is identified on an unmarked device.

![NPN base-collector measured currents](03%20-%20NPN%20base-collector%20test/NPN%20base-collector%20test%20SPICE%20measurements.png)

## 04 - PNP, collector to base

[Schematic](04%20-%20PNP%20base-collector%20test/PNP%20base-collector%20test.asc) · [Saved plot settings](04%20-%20PNP%20base-collector%20test/PNP%20base-collector%20test.plt) · [Video at 2:31](04%20-%20PNP%20base-collector%20test/Video%20131%20-%2004%20-%20PNP%20base-collector%20test.url)

The mirror of circuit 03: the positive lead goes to the **collector** and the **base** is grounded, with the emitter left on its 1 GΩ return.

![PNP collector-base LTspice schematic](04%20-%20PNP%20base-collector%20test/PNP%20base-collector%20test%20schematic.png)

![PNP collector-base current against test voltage](04%20-%20PNP%20base-collector%20test/PNP%20base-collector%20test%20LTspice%20plot.png)

341 µA flows at +1 V and 1 pA at -1 V. Taken with circuit 02, this completes the PNP pair: both readings point *into* the base rather than out of it.

![PNP collector-base measured currents](04%20-%20PNP%20base-collector%20test/PNP%20base-collector%20test%20SPICE%20measurements.png)

## Reading the four results together

| Fixture | Positive lead | Grounded lead | Current at +1 V | Current at -1 V |
| --- | --- | --- | ---: | ---: |
| 01 NPN | Base | Emitter | 326 µA | 2 pA |
| 02 PNP | Emitter | Base | 334 µA | 1 pA |
| 03 NPN | Base | Collector | 331 µA | 2 pA |
| 04 PNP | Collector | Base | 341 µA | 1 pA |

The forward currents differ by only a few percent, so the useful information is in which *pin combination and polarity* conducts, not in the exact reading. These fixtures illustrate that polarity lesson; they do not model the behavior or calibration of Alan's individual meters or Heathkit testers.
