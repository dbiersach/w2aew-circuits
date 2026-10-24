# Video 412: Common-emitter input and output impedance

Sources: [Alan Wolke's video](https://www.youtube.com/watch?v=yhuf2_Zu8T8) and his [eight-page handwritten circuit and calculation notes](<W2AEW Video Notes - InputZceAmp.pdf>). The circuit is introduced at 1:34, collector loading at 5:13, and emitter bypass at 10:55.

| Time | What Alan shows |
| --- | --- |
| [1:34](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=94s) | [01 - Unbypassed common emitter: measuring the input impedance](#01---unbypassed-common-emitter-measuring-the-input-impedance) |
| [5:13](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=313s) | [02 - What a load on the collector costs](#02---what-a-load-on-the-collector-costs) |
| [10:55](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=655s) | [03 - Bypassing the emitter resistor](#03---bypassing-the-emitter-resistor) |

Alan uses a 12 V rail, a 47 kΩ/8.2 kΩ base divider, a 6.8 kΩ collector resistor, a 1 kΩ emitter resistor, 4.7 µF input and output coupling capacitors, a 1 kHz test source, and a 2N2222 or 2N3904. His physical supply has a 100 µF bypass capacitor; the ideal 12 V source in these schematics is already an AC short to ground, so adding one would not change the 1 kHz result. The simulations use LTspice's standard-library 2N2222. Alan's hand calculations assume β ≈ 100, while the model has its own operating-point β, which is where the differences below come from.

The measurement method is Alan's: put a known resistance in series with the source and watch how much the base signal shrinks. When the base signal halves, the series resistance equals the amplifier's input impedance. Each simulation steps that series resistance between 50 Ω and the comparison value, and `.meas` reports the peak-to-peak base and output voltages for both steps.

Every pane carries its own step legend, because LTspice assigns step colors separately in each pane. Note also that the base pane is centered on the divider's 1.746 V DC bias while the output pane sits at 0 V, because the output is taken through a coupling capacitor. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - Unbypassed common emitter: measuring the input impedance

[Open the segment at 1:34](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=94s) · [Schematic](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter.asc) · [Saved plot settings](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter.plt)

![Unbypassed amplifier schematic](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter%20schematic.png)

![Base and output waveforms for two source resistances](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter%20LTspice%20plot.png)

![Measured peak-to-peak voltages](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter%20SPICE%20measurements.png)

With 50 Ω in series the base sees 19.85 mV peak-to-peak; with 6.5 kΩ it sees 10.18 mV, almost exactly half. By Alan's method the input impedance is therefore about 6.5 kΩ, which matches his own estimate for the unbypassed stage with β ≈ 100. The output falls in the same proportion, from 77.9 mV to 40.0 mV, because the transistor amplifies whatever reaches its base: the gain from base to output has not changed, only the signal arriving there.

That distinction is the point of the exercise. Source-to-output gain and base-to-output gain are different things, and the difference between them is the divider formed by the source resistance and the amplifier's input impedance.

## 02 - What a load on the collector costs

[Open the segment at 5:13](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=313s) · [Schematic](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison.asc) · [Saved plot settings](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison.plt)

Here the series resistance is fixed and the *load* is stepped instead, between Alan's 10 kΩ and a 1 MΩ stand-in for an open output.

![Collector-load comparison schematic](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison%20schematic.png)

![Output and base waveforms for two loads](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison%20LTspice%20plot.png)

![Measured peak-to-peak voltages](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison%20SPICE%20measurements.png)

The base waveform is the same in both runs, 19.85 mV against 19.85 mV: a load on the collector does nothing to the input. The output, though, falls from 130.0 mV unloaded to 77.9 mV with the 10 kΩ load, so base-to-output gain drops from 6.55 to 3.93.

The reason is the amplifier's output impedance. For AC the 10 kΩ load appears in parallel with the 6.8 kΩ collector resistor, giving about 4 kΩ of effective collector load, and the gain follows that resistance down. A stage whose output impedance is 6.8 kΩ cannot drive a 10 kΩ load without losing 40 % of its signal.

## 03 - Bypassing the emitter resistor

[Open the segment at 10:55](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=655s) · [Schematic](03%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter.asc) · [Saved plot settings](03%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter.plt)

Alan's 4.7 µF capacitor across the emitter resistor removes the emitter degeneration at 1 kHz.

![Emitter-bypassed amplifier schematic](03%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter%20schematic.png)

![Base and output waveforms with the emitter bypassed](03%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter%20LTspice%20plot.png)

![Measured peak-to-peak voltages](03%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter%20SPICE%20measurements.png)

The gain rises dramatically, from 77.9 mV of output to 1.848 V for a nearly unchanged 19.72 mV at the base, a base-to-output gain of 94 instead of 3.93. The input impedance pays for it: now only **4.7 kΩ** in series is needed to halve the base signal, 19.72 mV down to 9.73 mV, where the unbypassed stage needed 6.5 kΩ.

That is the trade the bypass capacitor makes. The emitter resistor was setting both the gain and, through β, most of the input impedance; removing it for AC raises one and lowers the other together.

## Comparison and model limits

| | Base-to-output gain at 1 kHz | Series resistance that halves the base signal |
| --- | ---: | ---: |
| Unbypassed, 10 kΩ load | 3.93 | 6.5 kΩ |
| Unbypassed, effectively open output | 6.55 | 6.5 kΩ |
| Bypassed, 10 kΩ load | 94 | 4.7 kΩ |

Alan estimates about 6.5 kΩ input impedance unbypassed and about 1.9 kΩ bypassed using β ≈ 100. The unbypassed figure agrees; the bypassed one does not, because the LTspice 2N2222 reaches the half-voltage condition near 4.7 kΩ. That is a difference in the model's operating-point β and small-signal emitter resistance, not a change to any of Alan's component values.

The 10 mV source amplitude, the 50 Ω source baseline, the 1 MΩ open-load stand-in and the comparison resistance values are simulation choices. The 12 V rail, the divider, the collector and emitter resistors, the 10 kΩ load, the 4.7 µF capacitors, the 1 kHz test frequency and the measurement method all come from Alan's notes.
