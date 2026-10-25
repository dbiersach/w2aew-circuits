# Video 412: Common-emitter input and output impedance

Sources: [Alan Wolke's video](https://www.youtube.com/watch?v=yhuf2_Zu8T8) and his [eight-page handwritten circuit and calculation notes](<W2AEW Video Notes - InputZceAmp.pdf>).

| Time | What Alan shows |
| --- | --- |
| [1:34](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=94s) | The test circuit, its values and the bench setup around it: [01 - The amplifier and its unloaded gain](#01---the-amplifier-and-its-unloaded-gain). |
| [3:52](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=232s) | The first scope view: channel 1 on the base reading 680 mV, channel 2 on the collector reading 4.54 V, and a math trace reading a gain of 6.7. |
| [5:13](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=313s) | Why the output impedance is essentially RC, and what any load therefore does to the gain: [02 - What a 10k load costs](#02---what-a-10k-load-costs). |
| [6:09](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=369s) | The 10k load connected, and the same scope view with the gain down to 3.94. |
| [7:17](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=437s) | The input impedance derivation: R1 in parallel with R2 in parallel with beta times RE. |
| [9:38](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=578s) | The arithmetic that predicts 6.5k, and the measurement that will test it: [03 - Measuring the input impedance](#03---measuring-the-input-impedance). |
| [10:08](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=608s) | The substitution box turned up until the base signal halves, 680 mV down to 344 mV, with the box reading 6.5k. |
| [10:55](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=655s) | What happens when the emitter resistor is bypassed: [04 - Bypassing the emitter resistor](#04---bypassing-the-emitter-resistor). |
| [12:26](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=746s) | The bypassed stage on the scope: 18 mV at the base, 4.62 V at the collector, a gain of 250. |
| [13:14](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=794s) | Why 76k to 77k of series resistance was needed before that stage could be measured at all. |

## The bench, and how these simulations copy it

Alan's test circuit is a 2N2222 common-emitter stage on a 12 V rail: a 47k and 8.2k divider holding the base near 1.6 V, a 1k emitter resistor setting about 1 mA, a 6.8k collector resistor, and 4.7 uF capacitors coupling the input and the output. A 1 kHz generator set to 700 mV drives the input through its own 50 ohm output impedance and a resistor substitution box, which starts at 0. His oscilloscope probes the base on channel 1 and the collector on channel 2, both AC coupled, and a math trace divides the channel 2 amplitude by the channel 1 amplitude to read the gain directly.

Each schematic here carries those exact parts and that exact drive level, and each saved plot is drawn at his instrument settings: 400 us per division horizontally, 200 mV per division on the base, 500 mV per division on the collector, and 10 mV per division on the base in the bypassed experiment. His channels are AC coupled, so the traces here are plotted with the operating-point DC subtracted, 1.745 V at the base and 4.634 V at the collector. Those two numbers are measured by `.meas tran VB_DC` and `.meas tran VC_DC` and printed in the log of [01](#01---the-amplifier-and-its-unloaded-gain). Every circuit also reports `CH1_PP`, `CH2_PP` and a `GAIN` measurement that is literally his math trace, `CH2_PP/CH1_PP`.

Three further conventions apply throughout. Each `.tran` saves only the last 4 ms of a longer run, and the waveform viewer numbers that saved window from 0, so the plot x axis runs 0 to 4 ms while `.meas` reports the absolute simulation time. And after running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`; stepped runs otherwise open autoscaled with every step overlaid. And in the stepped circuits, the `@1` and `@2` suffixes on the traces are run indices, not positions in the `.step` list: **LTspice silently reorders a `list` into ascending order of value before running it.** Circuit 02 writes `list 1Meg 10k` to follow the order Alan demonstrates, so its `@1` is the 10k and its `@2` is the 1Meg, the opposite of the reading order. The `.log` is the only place this is visible, as a `.step` line per run in run order, and the `.meas` tables are numbered to match it. Each plot note here names the component value rather than the step index for that reason.

## 01 - The amplifier and its unloaded gain

[Open the segment at 1:34](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=94s) and [the scope view at 3:52](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=232s) - [Schematic](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter.asc) - [Saved plot settings](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter.plt)

![Unbypassed amplifier schematic](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter%20schematic.png)

The substitution box is at 0 here, so only the generator's own 50 ohm output impedance stands between the source and the input capacitor, and nothing is connected to the output terminal. RLOAD is 1Meg rather than absent because LTspice needs a DC path at that node.

![Base and collector at Alan's scope settings](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter%20LTspice%20plot.png)

The upper pane is his channel 2 and the lower pane his channel 1, each at the volts per division he uses. The collector waveform is inverted with respect to the base, four cycles of 1 kHz fill the 4 ms window, and the collector amplitude is 4.54 V for 694 mV at the base.

![Measured peak-to-peak voltages and gain](01%20-%20Unbypassed%20common%20emitter/Unbypassed%20common%20emitter%20SPICE%20measurements.png)

`GAIN` is 6.54 against the 6.705 on Alan's math trace and the 6.8 that RC over RE predicts. Both the simulation and the bench fall a little short of RC over RE for the same reason: the transistor's own small-signal emitter resistance, about 26 ohms at 1 mA, adds to the 1k in the emitter leg, and 6800 divided by 1026 is 6.63.

The collector amplitude is the headline number, because it matches his 4.54 V reading exactly. The base is 694 mV where his scope reads 680 mV, the difference being how much of the generator's 700 mV the 50 ohm source loses into the amplifier's input impedance.

## 02 - What a 10k load costs

[Open the segment at 5:13](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=313s) and [the loaded scope view at 6:09](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=369s) - [Schematic](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison.asc) - [Saved plot settings](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison.plt)

The collector behaves as a current source, so the stage's output impedance is essentially RC itself. Anything hung on the output therefore appears in parallel with the 6.8k for AC, and the gain follows that parallel value down. Alan's arithmetic: 6.8k in parallel with 10k is about 4k, so the gain should fall to about 4.

![Collector load comparison schematic](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison%20schematic.png)

RLOAD is stepped between Alan's 10k and a 1Meg stand-in for the open output terminal he starts from. The schematic writes `.step param RL list 1Meg 10k`, but LTspice runs a list in ascending order of value rather than in the order written, so step 1 is the 10k load and step 2 is the open output. The `@1` and `@2` suffixes on the plotted traces follow that run order, which is why the larger, unloaded swing is `@2`. The log settles it: it prints `.step rl=10000` before `.step rl=1000000`.

![Collector and base waveforms for both loads](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison%20LTspice%20plot.png)

![Measured peak-to-peak voltages and gain](02%20-%20Collector%20load%20comparison/Collector%20load%20comparison%20SPICE%20measurements.png)

With the load connected the collector amplitude falls from 4.54 V to 2.72 V and the gain from 6.54 to 3.92, against the 2.68 V and 3.941 his scope reads. The lower pane is the point of the comparison: the two base traces lie exactly on top of each other at 694 mV, because a load on the collector does nothing at all to the signal arriving at the input. Output impedance and input impedance are separate properties, and this run separates them.

## 03 - Measuring the input impedance

[Open the segment at 9:38](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=578s) and [the measurement at 10:08](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=608s) - [Schematic](03%20-%20Input%20impedance%20measurement/Input%20impedance%20measurement.asc) - [Saved plot settings](03%20-%20Input%20impedance%20measurement/Input%20impedance%20measurement.plt)

Alan's method, drawn on page 5 of his notes, is to put a known resistance between the generator and the input and turn it up until the signal measured at the base has dropped to half of what it was with the box at 0. At that point the series resistance equals the amplifier's input impedance, because the two then form an equal-valued divider.

![Input impedance measurement schematic](03%20-%20Input%20impedance%20measurement/Input%20impedance%20measurement%20schematic.png)

RSER is the substitution box, stepped between 1 milliohm and 6.5k. The first step stands for his box at 0, which LTspice will not accept as a literal zero-ohm resistor.

![The base signal halving, and the collector following it](03%20-%20Input%20impedance%20measurement/Input%20impedance%20measurement%20LTspice%20plot.png)

![Measured peak-to-peak voltages and gain](03%20-%20Input%20impedance%20measurement/Input%20impedance%20measurement%20SPICE%20measurements.png)

With the box at 0 the base reads 694 mV; with 6.5k in series it reads 355 mV, which is 51 percent. That is the same 6.5k Alan dials in, and it agrees with his arithmetic: 47k in parallel with 8.2k is about 7k, beta times the 1k emitter resistor is about 100k, and 7k in parallel with 100k is about 6.5k.

The lower pane carries the lesson that is easy to miss. The collector amplitude falls in exactly the same proportion, 4.54 V to 2.32 V, and the measured gain is 6.54 in both runs, because CH1 is probed at the base, downstream of RSER, so the attenuation falls outside both probes rather than between them. The series resistance has not reduced the gain of the amplifier. It has attenuated the signal before the amplifier ever sees it, which is why input impedance matters when one stage drives another.

## 04 - Bypassing the emitter resistor

[Open the segment at 10:55](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=655s) and [the scope view at 12:26](https://www.youtube.com/watch?v=yhuf2_Zu8T8&t=746s) - [Schematic](04%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter.asc) - [Saved plot settings](04%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter.plt)

Putting a capacitor across the emitter resistor leaves the DC bias alone but removes the emitter degeneration at signal frequencies. The gain is then RC over the transistor's own small-signal emitter resistance, 26 mV divided by the 1 mA collector current, or about 26 ohms, which gives roughly 260. The input impedance pays for it: beta times 26 ohms is 2.6k, and 7k in parallel with 2.6k is about 1.9k.

That gain is high enough that the 700 mV generator would drive the collector into the rails, so Alan puts 76k to 77k in series to bring the base down to 18 to 20 mV first.

![Emitter bypassed amplifier schematic](04%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter%20schematic.png)

RSER is fixed at 76.5k, the middle of the range he gives. CEMIT is stepped: step 1 is the 4.7 uF drawn on page 6 of his notes, step 2 is 100 uF.

![Collector and base waveforms for both bypass capacitors](04%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter%20LTspice%20plot.png)

![Measured peak-to-peak voltages and gain](04%20-%20Emitter%20bypassed%20common%20emitter/Emitter%20bypassed%20common%20emitter%20SPICE%20measurements.png)

The two steps are there for a reason. A 4.7 uF capacitor has a reactance of 33.9 ohms at 1 kHz, which is larger than the 26 ohms of small-signal emitter resistance it is meant to swamp, so it only partly bypasses the emitter: the simulated gain is 153 and the collector waveform is noticeably shifted in phase by that reactance. At 100 uF the reactance is 1.6 ohms, the emitter is a short for AC, and the gain rises to 247. That second figure is the one Alan's scope reads, 249.8 V/V hovering between 250 and 255, so the capacitor on his board is behaving as a complete bypass at 1 kHz.

The same step shows the input impedance change. With the full bypass the base sees 26.0 mV of the generator's 700 mV through 76.5k, which puts the input impedance at about 3.0k; with the partial bypass the emitter impedance is higher, the input impedance is higher with it, and 37.0 mV reaches the base.

## Where the simulation and the bench differ

| | Base p-p | Collector p-p | Gain |
| --- | ---: | ---: | ---: |
| Unloaded, simulated | 694 mV | 4.54 V | 6.54 |
| Unloaded, Alan's scope | 680 mV | 4.54 V | 6.705 |
| 10k load, simulated | 694 mV | 2.72 V | 3.92 |
| 10k load, Alan's scope | 680 mV | 2.68 V | 3.941 |
| Bypassed, simulated with 100 uF | 26.0 mV | 6.43 V | 247 |
| Bypassed, Alan's scope | 18.00 mV | 4.620 V | 249.8 |

The unbypassed rows agree closely, and so does the bypassed gain. The bypassed base and collector amplitudes do not, and the reason is beta. Alan's arithmetic assumes beta is about 100, and his 18 mV reading implies a bypassed input impedance near 2.0k, which is what his 1.9k calculation predicts. The LTspice 2N2222 runs at a beta nearer 190, so its bypassed input impedance is about 3.0k, the same 76.5k series resistor leaves more signal at the base, and the collector swing is correspondingly larger. The gain itself is untouched by that difference, because it depends on the collector current rather than on beta, which is why 247 still lands on his 249.8.

The unbypassed input impedance is dominated by R1 in parallel with R2 rather than by beta times RE, so the beta difference barely shows there and both the simulation and the bench land on 6.5k.

Three values in these schematics are simulation choices rather than Alan's: the 1Meg standing in for the open output terminal, the 1 milliohm standing in for the substitution box at 0, and the 100 uF emitter bypass. Everything else, including the 700 mV generator level, the 50 ohm source impedance, the 76.5k series resistance, every component value and the 1 kHz test frequency, comes from the video or from his handwritten notes. His physical supply carries a 100 nF bypass capacitor that is not drawn here, because the ideal 12 V source is already an AC short to ground.
