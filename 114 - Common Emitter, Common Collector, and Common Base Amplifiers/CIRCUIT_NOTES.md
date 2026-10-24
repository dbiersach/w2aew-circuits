# Video 114: Common-emitter, common-collector, and common-base amplifiers

Source: [Alan Wolke, video #114](https://www.youtube.com/watch?v=zXh5gMc6kyU) and his [four-page handwritten notes](W2AEW%20Video%20Notes%20-%20Common_Emitter_CC_CB_amplifiers.pdf). Alan presents the three transistor connections in that order, each with a worked example on a 5 V supply.

| Time | What Alan shows |
| --- | --- |
| [0:49](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=49s) | [01 - Common emitter, with and without an emitter bypass](#01---common-emitter-with-and-without-an-emitter-bypass) |
| [4:48](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=288s) | [02 - Common collector, the emitter follower](#02---common-collector-the-emitter-follower) |
| [7:05](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=425s) | [03 - Common base, emitter input and collector output](#03---common-base-emitter-input-and-collector-output) |

Every resistor and capacitor below is the value Alan writes on his drawings. The 2N3904 transistor, the 100 kHz stimulus frequency, the generator amplitudes and the 470 nF emitter coupling capacitor in the common-base example are simulation choices: his drawings name no transistor or generator frequency, and the common-base coupling capacitor carries no value. These models therefore illustrate topology and relative behavior rather than Alan's exact bench readings.

Each simulation runs `.tran 0 300us 100us`, so only the settled last 200 µs is saved, and `.meas` directives report the peak-to-peak input and output and their ratio. Every plot shows three cycles of the 100 kHz drive, with the amplifier output in the top pane and the drive in the bottom pane; each pane is scaled to its own signal and shows the real node voltage including its DC level. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - Common emitter, with and without an emitter bypass

The input is applied to the base through 470 nF and the output is taken from the collector. A 10 kΩ/3.9 kΩ divider sets the bias, with 680 Ω in the collector branch and 180 Ω in the emitter branch.

### Without the bypass capacitor

Alan starts with the [unbypassed stage at 0:49](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=49s). In [Common Emitter Unbypassed.asc](01%20-%20Common%20emitter/Unbypassed%20variant/Common%20Emitter%20Unbypassed.asc) the emitter resistor carries the signal current as well as the bias current, so it feeds voltage back in opposition to the input.

![LTspice unbypassed common-emitter schematic](01%20-%20Common%20emitter/Unbypassed%20variant/Common%20Emitter%20Unbypassed%20schematic.png)

![Unbypassed common-emitter output and drive](01%20-%20Common%20emitter/Unbypassed%20variant/Common%20Emitter%20Unbypassed%20waveforms.png)

A 100 mV peak-to-peak drive produces 360 mV peak-to-peak at the collector, so the gain is 3.60 and inverted: the collector falls while the base rises. That figure is close to the textbook estimate of the collector resistance divided by the emitter resistance, 680/180 = 3.8, which is the point of Alan's `Av ≈ Rc/(re + Re)` note.

![Measured unbypassed gain](01%20-%20Common%20emitter/Unbypassed%20variant/Common%20Emitter%20Unbypassed%20SPICE%20output%20log.png)

### With the bypass capacitor

At [2:18 Alan connects a 10 µF capacitor](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=138s) across the emitter resistor, the component his drawing shows in dashed outline. [Common Emitter.asc](01%20-%20Common%20emitter/Common%20Emitter.asc) models that connection: the resistor still sets the DC operating point, while the capacitor holds the emitter at AC ground, so only the transistor's own internal emitter resistance limits the gain.

![LTspice bypassed common-emitter schematic](01%20-%20Common%20emitter/Common%20Emitter%20schematic.png)

![Bypassed common-emitter output and drive](01%20-%20Common%20emitter/Common%20Emitter%20waveforms.png)

The drive is reduced to 20 mV peak-to-peak and the collector still swings 1.85 V peak-to-peak, an inverted gain of 92.3. Twenty-five times more gain from one capacitor is why Alan turns the generator down before showing this version.

![Measured bypassed gain](01%20-%20Common%20emitter/Common%20Emitter%20SPICE%20output%20log.png)

## 02 - Common collector, the emitter follower

Alan introduces the [emitter follower at 4:48](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=288s). [Common Collector.asc](02%20-%20Common%20collector/Common%20Collector.asc) uses his 36 kΩ/20 kΩ divider and 2.7 kΩ emitter resistor, with the collector tied straight to +5 V and the output taken from the emitter.

![LTspice common-collector schematic](02%20-%20Common%20collector/Common%20Collector%20schematic.png)

![Emitter-follower output and drive](02%20-%20Common%20collector/Common%20Collector%20waveforms.png)

A 100 mV peak-to-peak drive gives 97 mV peak-to-peak at the emitter: a voltage gain of 0.973, in phase with the input. The emitter sits about 1.14 V, one base-emitter drop below the divider voltage, and tracks the base from there.

![Measured follower voltage and current gains](02%20-%20Common%20collector/Common%20Collector%20SPICE%20output%20log.png)

The same log reports the current gain, the peak-to-peak current in the 2.7 kΩ emitter resistor divided by the peak-to-peak base current: 36.0 µA against 206 nA, a ratio of 175. That is the stage's real purpose. It gives away almost nothing in voltage but takes very little current from whatever drives it, which is what makes it a buffer.

## 03 - Common base, emitter input and collector output

Alan shows the [common-base circuit at 7:05](https://www.youtube.com/watch?v=zXh5gMc6kyU&t=425s). In [Common Base.asc](03%20-%20Common%20base/Common%20Base.asc) a 3.9 kΩ/3.9 kΩ divider sets the base voltage and a 10 µF capacitor holds that base at AC ground. The generator couples through 470 nF into the emitter, which has a 3.3 kΩ resistor to ground for its DC return, and the collector drives a 2.2 kΩ resistor to +5 V.

![LTspice common-base schematic](03%20-%20Common%20base/Common%20Base%20schematic.png)

As Alan explains at about 8:20, this stage has a low input impedance, so on the bench the generator's own 50 Ω source resistance divides against it and the signal that actually reaches the transistor is smaller than the generator setting. The gain figure only means something when it is referred to the voltage on the *emitter side of the coupling capacitor*, which the schematic labels `E_IN` and the `.meas` directives use. The LTspice source has no series resistance, so here `E_IN` holds 19.8 mV of the generator's 20 mV peak-to-peak; on Alan's bench the loss is much larger.

![Common-base emitter drive and collector output](03%20-%20Common%20base/Common%20Base%20waveforms.png)

That 19.8 mV peak-to-peak at `E_IN` produces 919 mV peak-to-peak at the collector: a gain of 46.3, in phase with the drive. Note the bottom pane's vertical scale, 5 mV per division around a 1.86 V DC level, against 200 mV per division in the top pane.

![Measured common-base gain](03%20-%20Common%20base/Common%20Base%20SPICE%20output%20log.png)

Alan points to RF use, where the low input impedance suits a 50 Ω source, and explains that feeding a common emitter into a common base removes the Miller-effect bandwidth limit of the common-emitter stage on its own.

## Summary

| Configuration | Input node | Output node | Simulated voltage gain | Phase |
| --- | --- | --- | ---: | --- |
| Common emitter, unbypassed | Base | Collector | 3.60 | Inverted |
| Common emitter, bypassed | Base | Collector | 92.3 | Inverted |
| Common collector | Base | Emitter | 0.973 | In phase |
| Common base | Emitter, after the coupling capacitor | Collector | 46.3 | In phase |

Read the phase from the plots by comparing where each trace rises and falls, and take the gains from the peak-to-peak values in the SPICE output log images.
