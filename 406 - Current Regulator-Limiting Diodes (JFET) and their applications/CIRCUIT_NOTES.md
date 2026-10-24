# Video 406 - Current regulator diodes and four things to do with them

Source: Alan Wolke (W2AEW), [#406: Current Regulator/Limiting Diodes (JFET) and their applications](https://www.youtube.com/watch?v=VXZH3UE-kSw). Alan's handwritten pages for the lesson are in [W2AEW Video Notes - CurrentRegulatorDiodes.pdf](W2AEW%20Video%20Notes%20-%20CurrentRegulatorDiodes.pdf).

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=15s) | A bag of current regulator diodes and the first page of his notes, introducing them as the constant-current counterpart of a zener. |
| [1:00](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=60s) | Central Semiconductor's 1N5283 through 1N5314 data sheet, the family the 1N5297 and 1N5305 come from. |
| [2:00](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=120s) | The I-V characteristic he draws: current rises steeply, then stays nearly flat above a knee he marks as 1 to 3 V typical. |
| [2:48](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=168s) | A Tektronix 576 curve tracer sweeping a real part at 200 uA and 2 V per division, which is the curve [circuit 01](#01---current-regulator-diode-i-v-curve) reproduces. |
| [4:00](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=240s) | The point that makes the rest of the lesson work: these parts are JFETs with gate tied to source, so the plateau is the device's IDSS. |
| [5:00](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=300s) | His list of applications, from bias circuits and LED drive to timing ramps and amplifier tails. |
| [5:16](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=316s) | The linear voltage ramp drawing, and the point that a known current turns a slope measurement into a capacitance measurement. See [circuit 02](#02---linear-capacitor-ramp). |
| [6:20](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=380s) | The breadboarded ramp with its discharge switch. |
| [7:20](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=440s) | Scope cursors on the ramp: 686.0 us apart, 7.280 V tall, dV/dt reading 10.61 kV/s. |
| [7:48](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=468s) | The sawtooth relaxation oscillator drawing, with the 2N3904 connected upside down and its base left open. See [circuit 03](#03---avalanche-sawtooth-oscillator). |
| [10:45](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=645s) | The sawtooth on the scope, with the frequency readout at 3.31703 kHz. |
| [10:58](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=658s) | The current mirror and magnifier drawing, with its 330 ohm and 33 ohm emitter resistors. See [circuit 04](#04---current-mirror-and-multiplier). |
| [12:56](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=776s) | The meter in the output branch reading 20.66 mA against roughly 2 mA in the reference branch. |
| [13:01](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=781s) | The differential amplifier tail source drawing, and why a tail resistor lets gain follow the common-mode voltage. See [circuit 05](#05---differential-amplifier-tail-source). |
| [14:55](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=895s) | The bench demonstration: he turns the common-mode voltage from 3.540 V up to 5.61 V on a Fluke 79 while the output amplitude grows on screen. |

## What a current regulator diode is

A current regulator diode, also sold as a constant-current diode or a current limiting diode, is a two-terminal part that holds its current nearly fixed over a wide range of applied voltage. Alan's first page puts it next to a zener: a zener holds voltage steady while current varies, and this part does the opposite.

Inside, as he says at 4:00, there is no exotic physics. It is a JFET with its gate tied to its source, packaged with two leads. With zero gate-source voltage the drain current is the JFET's IDSS, and once the drain-source voltage clears pinch-off the current stops depending on it. That is why the plateau current is a part number rather than something you set: a 1N5297 is a 1.0 mA part and a 1N5305 is a 2.0 mA part, each with its own tolerance band.

The four circuits that follow are the applications he builds. All of them use the plateau as a current source; what differs is what the current is made to do.

## 01 - Current regulator diode I-V curve

Open [Current regulator diode I-V curve.asc](01%20-%20Current%20regulator%20diode%20I-V%20curve/Current%20regulator%20diode%20I-V%20curve.asc); the [video shortcut](01%20-%20Current%20regulator%20diode%20I-V%20curve/Video%20406%20-%2001%20-%20Current%20regulator%20diode%20I-V%20curve.url) opens the curve tracer segment at [2:48](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=168s).

![LTspice schematic of the two-diode sweep fixture](01%20-%20Current%20regulator%20diode%20I-V%20curve/Current%20regulator%20diode%20I-V%20curve%20schematic.png)

*One swept source drives both parts in parallel. `Vm5297` and `Vm5305` are zero-volt sources used as ammeters, standing in for the curve tracer's current measurement.*

This is the measurement Alan makes on the 576 before he builds anything, and it is worth repeating in the simulator because every number in the other four circuits comes off this plateau. `.dc V1 0 25 0.025` sweeps the voltage across both parts at once, so their curves can be compared on one axis.

| Quantity | Directive | Result |
| --- | --- | --- |
| 1N5297 at its limiting voltage | `I5297_KNEE` | 1.004 mA at 1.35 V |
| 1N5297 at the data sheet's reference point | `I5297_25V` | 1.033 mA at 25 V |
| 1N5305 at its limiting voltage | `I5305_KNEE` | 2.009 mA at 1.85 V |
| 1N5305 at the data sheet's reference point | `I5305_25V` | 2.067 mA at 25 V |

![Simulated I-V curves for the two current regulator diode models](01%20-%20Current%20regulator%20diode%20I-V%20curve/Current%20regulator%20diode%20I-V%20curve.png)

*Both traces climb almost vertically to their rated current and then stay there. The residual slope across the plateau is the dynamic impedance, which is what the data sheet quotes as a minimum: on this axis a 30 nA rise over 24 V is barely a line thickness.*

Alan's tracer is set to 200 uA and 2 V per division and the trace he gets sits a little under five divisions, so about 1.0 mA, with the knee a bit past half a division and the sweep running out to roughly 14 V. The model's plateau and knee land in the same place. The sweep here goes to 25 V instead of 14 because that is where the data sheet specifies the part, not because anything changes above 14 V.

## 02 - Linear capacitor ramp

Open [Linear capacitor ramp.asc](02%20-%20Linear%20capacitor%20ramp/Linear%20capacitor%20ramp.asc); the [video shortcut](02%20-%20Linear%20capacitor%20ramp/Video%20406%20-%2002%20-%20Linear%20capacitor%20ramp.url) opens the ramp drawing at [5:16](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=316s).

![LTspice schematic of the current-regulator ramp generator](02%20-%20Linear%20capacitor%20ramp/Linear%20capacitor%20ramp%20schematic.png)

*A 1N5297 charges 0.1 uF from a 12 V rail. S1 and V2 stand in for the manual switch across the capacitor on Alan's drawing; here it opens at 1 ms.*

Charge a capacitor through a resistor and you get an exponential, because the current falls as the capacitor voltage rises. Charge it from a current source and the current does not care what the capacitor is doing, so the voltage is a straight line. That is the whole circuit, and `dV/dt = I/C` is the whole analysis.

Alan then turns the relation around. If the current is known and the slope is measured, the capacitance follows from `C = I / (V/s)`, which is a perfectly good way to measure an unmarked capacitor with nothing but a scope.

| Quantity | Directive | Result |
| --- | --- | --- |
| Ramp slope over the 0.66 V to 7.94 V interval | `RAMP_SLOPE` | 10.12 kV/s |
| Charging current while the ramp runs | `I_CHARGE` | 1.010 mA |

![Simulated ramp voltage and charging current](02%20-%20Linear%20capacitor%20ramp/Linear%20capacitor%20ramp%20output.png)

*The upper pane is the capacitor voltage, a straight line from the instant the switch opens. The lower pane is the current into the capacitor: zero while the switch holds it discharged, then a flat 1.010 mA. The flatness of the lower trace is what makes the upper one straight.*

The two measurement levels are not arbitrary. At 7:20 Alan places his cursors at 660 mV and 7.940 V, 686.0 us apart, and his scope computes 10.61 kV/s; the `.meas` directives use the same two voltages so the two slopes are measured over the same span. The simulation gives 10.12 kV/s, 4.6 percent lower.

That gap is the diode, not the circuit. Working backwards through `I = C dV/dt`, Alan's specimen is delivering 1.061 mA where the model delivers 1.010 mA. The 1N5297's published band is 0.85 to 1.15 mA, so both numbers are ordinary parts; his simply sits above nominal and the model sits on it.

## 03 - Avalanche sawtooth oscillator

Open [Avalanche sawtooth oscillator.asc](03%20-%20Avalanche%20sawtooth%20oscillator/Avalanche%20sawtooth%20oscillator.asc); the [video shortcut](03%20-%20Avalanche%20sawtooth%20oscillator/Video%20406%20-%2003%20-%20Avalanche%20sawtooth%20oscillator.url) opens the drawing at [7:48](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=468s).

![LTspice schematic of the sawtooth relaxation oscillator](03%20-%20Avalanche%20sawtooth%20oscillator/Avalanche%20sawtooth%20oscillator%20schematic.png)

*The charging half is circuit 02 again. In place of the switch there is a 2N3904 wired upside down, emitter to the ramp node, collector to ground, base left open.*

Take the ramp and give the capacitor something that will empty it once the voltage gets high enough, and the ramp becomes a sawtooth. Alan's discharge element is the part of this lesson that is genuinely odd: a 2N3904 with its emitter and collector swapped and its base disconnected. Reverse-biased, the emitter-base junction breaks down somewhere around 6 to 7 V, and in this connection the breakdown has a negative-resistance region. He calls it emitter-collector breakdown and compares it to a tunnel diode. The device sits there blocking while the capacitor charges, snaps into conduction at the breakdown voltage, dumps the charge, and switches off again when the current falls too low to sustain it.

Ordinary SPICE will not do this. LTspice's bundled `2N3904` is a forward-active model with a `Vceo` rating and no reverse breakdown characteristic at all, and adding a junction breakdown parameter gets the part to clamp rather than to snap back. So the discharge element here is [2N3904_avalanche_proxy.lib](../LTspice/Models/Unverified/2N3904_avalanche_proxy.lib), a hysteretic switch with a 1 Gohm base return to keep the open base from floating. **It is a behavioral stand-in for the mechanism, not a transistor model**, and nothing it produces should be read as a prediction about any particular 2N3904.

What it is fitted to matters, so here it is explicitly. The switch turns on at 7.25 V and off at 4.35 V, the two levels Alan's sawtooth reaches on his screen at 10:45, and its 150 ohm on-resistance gives a discharge fast enough to match the near-vertical fall he shows. Those are the only two things taken from the video. The frequency is then an output.

| Quantity | Directive | Result |
| --- | --- | --- |
| Peak of the sawtooth | `RAMP_MAX` | 7.248 V |
| Trough of the sawtooth | `RAMP_MIN` | 4.415 V |
| Period | `PERIOD` | 288.1 us |
| Frequency | `FREQ` | 3.471 kHz |

![Simulated sawtooth and capacitor current](03%20-%20Avalanche%20sawtooth%20oscillator/Avalanche%20sawtooth%20oscillator%20output.png)

*The upper pane is the capacitor voltage over seven cycles, the same span Alan has on screen. The lower pane shows why the fall is so much faster than the rise: the charge goes in at 1.0 mA and comes out in a 48 mA pulse lasting a few microseconds.*

Alan's scope reads 3.31703 kHz. The simulation gives 3.471 kHz, 4.6 percent high, and the reason is the same 1.0 mA against 1.061 mA that showed up in circuit 02 working the other way: with a swing read off a screen to about a tenth of a volt, a model current this close puts the frequency within five percent without anything being tuned to it. A device-specific avalanche model, or a measured snapback curve for his particular transistor, is what it would take to do better than that.

## 04 - Current mirror and multiplier

Open [Current mirror multiplier.asc](04%20-%20Current%20mirror%20multiplier/Current%20mirror%20multiplier.asc); the [video shortcut](04%20-%20Current%20mirror%20multiplier/Video%20406%20-%2004%20-%20Current%20mirror%20multiplier.url) opens the drawing at [10:58](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=658s).

![LTspice schematic of the current mirror and multiplier](04%20-%20Current%20mirror%20multiplier/Current%20mirror%20multiplier%20schematic.png)

*A 1N5305 sets about 2 mA in the reference leg. Q1 is diode connected, Q2 shares its base, and the two emitter resistors differ by ten to one. `Vsense` is a zero-volt ammeter where Alan's drawing has a meter.*

A current regulator diode comes in the current you can buy, and 2 mA may not be the 20 mA the load wants. This circuit gets the larger current without a larger diode. Q1 and Q2 share a base node, so they also share a base-emitter voltage, which means the voltages across the two emitter resistors are nearly equal and the currents divide in inverse proportion to the resistors. Ten to one in the resistors, ten to one in the currents, approximately.

Alan writes "approximately" on the drawing, and the simulation shows what the word is carrying.

| Quantity | Directive | Result |
| --- | --- | --- |
| Reference branch current at the 12 V rail | `I_REF` | 1.975 mA |
| Output branch current at the 12 V rail | `I_OUT` | 17.94 mA |
| Ratio | `CURRENT_RATIO` | 9.08 |

![Simulated branch currents against the supply voltage](04%20-%20Current%20mirror%20multiplier/Current%20mirror%20multiplier%20currents.png)

*The sweep runs the rail from 0 to its 12 V operating point. The reference branch reaches regulation first, at about 2.6 V, because it only has to clear the diode's knee plus one base-emitter drop; the output branch follows it up and flattens at 17.94 mA. Note the different vertical scales: the panes are the same shape because one current tracks the other.*

The ratio comes out 9.08 rather than 10, and the reason is the thing the circuit assumes away. The two transistors do share a base voltage, but Q2 is carrying nine times Q1's current, so its base-emitter voltage is about 60 mV higher at room temperature. That 60 mV comes straight off the 0.65 V across the 330 ohm resistor before the 33 ohm resistor ever sees it, and 60 mV out of 650 is most of the shortfall.

Alan's meter reads 20.66 mA at 12:56, above the drawing's nominal 20 mA rather than below it. The same arithmetic run backwards says his reference branch is carrying about 2.2 mA, which is inside the 1N5305's 1.7 to 2.3 mA band. A part near the top of its tolerance makes up for the base-emitter offset and then some; the model's part sits near nominal and does not.

## 05 - Differential amplifier tail source

Alan's last application compares two ways to bias a differential pair, and the two schematics differ by one component. Both open at [13:01](https://www.youtube.com/watch?v=VXZH3UE-kSw&t=781s):

- [Differential amplifier - Resistive tail.asc](05%20-%20Differential%20amplifier%20tail%20source/Resistive%20tail/Differential%20amplifier%20-%20Resistive%20tail.asc) uses the 3.9 kohm tail resistor on the drawing.
- [Differential amplifier - Current-regulator tail.asc](05%20-%20Differential%20amplifier%20tail%20source/Current-regulator%20tail/Differential%20amplifier%20-%20Current-regulator%20tail.asc) replaces it with a current regulator diode, the substitution he draws in red.

Everything else is from his page: two 3.9 kohm collector resistors, two 20 kohm base resistors to a common-mode node, a 1 uF coupling capacitor at the input and a 10 uF bypass on the common-mode node.

![LTspice schematic of the differential pair with a resistive tail](05%20-%20Differential%20amplifier%20tail%20source/Resistive%20tail/Resistive%20tail%20schematic.png)

*The resistive-tail version. `Vcm` sets the common-mode voltage at both bases and `Rtail` turns the voltage above it into the pair's bias current.*

![LTspice schematic of the differential pair with a current-regulator tail](05%20-%20Differential%20amplifier%20tail%20source/Current-regulator%20tail/Current-regulator%20tail%20schematic.png)

*The same circuit with the tail resistor replaced by a current regulator diode.*

The gain of a differential pair is set by the transconductance of its transistors, and transconductance is set by the current through them. With a resistor in the tail, that current is `(Vcm - Vbe) / Rtail`, so moving the common-mode voltage moves the bias current, which moves the gain. This is the defect Alan demonstrates on the bench from 14:55: he turns the common-mode voltage up from 3.540 V towards 5.61 V on a 5 kHz signal and the output grows while he does it.

A current source in the tail breaks that chain. The current no longer depends on the voltage above it, so the bias current, the transconductance and the gain all stay put while the common mode moves.

Both schematics step `VCM_VAL` through the three readings on Alan's meter and measure the midband gain at his 5 kHz. `Vsig` is 1 V AC, so the magnitude of `V(OUT_L,OUT_R)` in dB is the differential gain directly.

| Common-mode voltage | 3.9 kohm tail | Current-regulator tail |
| --- | ---: | ---: |
| 3.54 V | 31.62 dB | 33.26 dB |
| 4.05 V | 32.51 dB | 33.25 dB |
| 5.61 V | 34.34 dB | 33.20 dB |

![Simulated gain of the resistive tail at three common-mode settings](05%20-%20Differential%20amplifier%20tail%20source/Resistive%20tail/Resistive%20tail%20gain.png)

*One pane per common-mode setting, all three on the same 20 to 40 dB axis. The plateau lifts visibly down the page: 2.72 dB between the lowest setting and the highest.*

![Simulated gain of the current-regulator tail at the same three settings](05%20-%20Differential%20amplifier%20tail%20source/Current-regulator%20tail/Current-regulator%20tail%20gain.png)

*The same three settings and the same axis with the diode in the tail. The three plateaus sit on top of each other, 0.06 dB apart end to end, which is the point of the whole circuit.*

The low-frequency corner near 30 Hz is the 1 uF coupling capacitor working into the 20 kohm bias resistor, and the fall above 100 kHz is the transistors running out of gain. Neither depends on the tail, which is why the two figures differ only in the middle.

Alan does not name the tail diode on his drawing, so the simulation uses the 1 mA 1N5297 already in circuits 02 and 03. That sets the bias current, and therefore the absolute gain, to a value he never states; the comparison that matters is between the two columns of the table, not against a number from his bench.

## Models and limits

Both current regulator diode models are local approximations, not manufacturer files, and they live with the collection's other unverified models:

- [1N5297_illustrative.lib](../LTspice/Models/Unverified/1N5297_illustrative.lib) and [1N5305_illustrative.lib](../LTspice/Models/Unverified/1N5305_illustrative.lib) are single JFETs with gate tied to source, fitted to the plateau current, the limiting voltage and the minimum dynamic impedance that Central Semiconductor's [1N5283 to 1N5314 data sheet](https://my.centralsemi.com/datasheets/1N5283-5314.PDF) specifies at 25 V. They cover the forward regulating quadrant only and say nothing about temperature, part spread or reverse behavior. Circuit 01 is where to look at what they actually do.
- [2N3904_avalanche_proxy.lib](../LTspice/Models/Unverified/2N3904_avalanche_proxy.lib) is the behavioral switch described under circuit 03. It is not a transistor.

The two transistors in circuits 04 and 05 use LTspice's bundled `2N3904` model, which is the part Alan labels, and there the simulation is modeling the device rather than standing in for it.

Everything runs at LTspice's default 27 C. Current regulator diodes have a real temperature coefficient and the 2N3904's base-emitter offset in circuit 04 is proportional to absolute temperature, so none of these results should be read as holding across a temperature range.
