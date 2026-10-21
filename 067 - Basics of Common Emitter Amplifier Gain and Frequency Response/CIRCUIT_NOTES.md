# Video 67: Common-emitter amplifier gain and frequency response

Source: Alan Wolke (W2AEW), [video](https://www.youtube.com/watch?v=NizrzRKQqII) and the one-page handwritten [video notes](W2AEW%20Video%20Notes%20-%20Freq_response_common_emitter_amplifier.pdf).

| Time | What Alan shows |
| --- | --- |
| [1:30](https://www.youtube.com/watch?v=NizrzRKQqII&t=90s) | The 2 kHz common-emitter stage, which circuit 01 reproduces. |
| [9:00](https://www.youtube.com/watch?v=NizrzRKQqII&t=540s) | The rising-frequency test that finds the upper corner, which circuit 03 reproduces. |
| [10:20](https://www.youtube.com/watch?v=NizrzRKQqII&t=620s) | The falling-frequency test that finds the lower corner, which circuit 02 reproduces. |

## What Alan demonstrates

The 2N2222 common-emitter stage uses a 5 V supply, a 56 kΩ/20 kΩ base-bias divider, a 10 kΩ collector resistor, and a 2.2 kΩ emitter resistor bypassed by 47 µF. A 4.7 µF capacitor couples the generator into the base, and a 220 pF capacitor shunts the collector output. The common-emitter output is inverted. Alan's bench estimates are 1.28 V at the base, 0.685 V at the emitter, 1.99 V at the collector, and about 301 µA collector current. With a roughly 26 mV thermal voltage, he calculates an incremental emitter resistance near 86 Ω and a midband gain magnitude near 116. The bench measurement is about 17.5 mV peak-to-peak input and 2 V peak-to-peak output, or approximately 115.

At the **upper corner**, the 220 pF output capacitor and 10 kΩ collector resistor give an approximate 72 kHz time-constant estimate. Alan measures about 71 kHz in the video. At the **lower corner**, the 47 µF emitter-bypass capacitor becomes less effective; with the 86 Ω incremental emitter resistance, the rough estimate is 39 Hz. Alan measures about 38 Hz. A corner is where the output voltage falls to about 70.7% of the midband value (−3 dB), with the input amplitude held essentially constant. His 2 V peak-to-peak midband output therefore becomes about 1.41 V peak-to-peak at either corner.

## LTspice circuits and plots

The three compact schematics use the values from Alan's drawn circuit. The 50 Ω generator resistance represents the signal generator; the installed LTspice `2N2222` library model is the simulation transistor. The source waveform amplitude and precise 39 Hz/71.5 kHz test frequencies are simulation choices chosen to illustrate the measured corners, not additional component values claimed by Alan. The two-pane saved plots put the base input above the collector output. `V(in)` is the **biased transistor-base node after the 4.7 µF coupling capacitor**, so its plotted level is near 1.29 V DC; Alan's oscilloscope input channel is at the signal-generator side. Compare each waveform's peak-to-peak swing, rather than its DC level. The `.meas Gain` directive divides two positive peak-to-peak amplitudes, so it reports a positive **gain magnitude**. The opposite direction of the two plotted waves shows the inversion.

| Circuit | Frequency | Simulated `V(in)` p-p | Simulated `V(out)` p-p | Gain magnitude | Relative to midband |
| --- | ---: | ---: | ---: | ---: | ---: |
| [01 - 2 kHz](01%20-%20Common%20emitter%20at%202%20kHz/Common%20Emitter%20%282%20kHz%29.asc) | 2 kHz | 19.743 mV | 2.173 V | 110.1 | 100% |
| [02 - lower corner](02%20-%20Low-frequency%20response/Common%20Emitter%20%28Low%20Frequency%29.asc) | 39 Hz | 19.191 mV | 1.492 V | 77.7 | 70.6% |
| [03 - upper corner](03%20-%20High-frequency%20response/Common%20Emitter%20High%20Frequency%29.asc) | 71.5 kHz | 19.579 mV | 1.522 V | 77.7 | 70.6% |

These simulation gains depend on the transistor model and the base-node measurement point; their values need not equal the bench gain exactly. The ratio of each corner gain to the simulated midband gain demonstrates the roughly 3 dB reduction Alan explains.

### 2 kHz midband

![LTspice 2 kHz common-emitter schematic](01%20-%20Common%20emitter%20at%202%20kHz/Common%20Emitter%20%282%20kHz%29%20schematic.png)

![LTspice 2 kHz input above inverted output](01%20-%20Common%20emitter%20at%202%20kHz/Common%20Emitter%20%282%20kHz%29%20waveforms.png)

![LTspice 2 kHz measurements](01%20-%20Common%20emitter%20at%202%20kHz/Common%20Emitter%20%282%20kHz%29%20SPICE%20output%20log.png)

### 39 Hz lower corner

![LTspice 39 Hz common-emitter schematic](02%20-%20Low-frequency%20response/Common%20Emitter%20%28Low%20Frequency%29%20schematic.png)

![LTspice 39 Hz input above reduced output](02%20-%20Low-frequency%20response/Common%20Emitter%20%28Low%20Frequency%29%20waveforms.png)

![LTspice 39 Hz measurements](02%20-%20Low-frequency%20response/Common%20Emitter%20%28Low%20Frequency%29%20SPICE%20output%20log.png)

### 71.5 kHz upper corner

![LTspice 71.5 kHz common-emitter schematic](03%20-%20High-frequency%20response/Common%20Emitter%20High%20Frequency%29%20schematic.png)

![LTspice 71.5 kHz input above reduced output](03%20-%20High-frequency%20response/Common%20Emitter%20High%20Frequency%29%20waveforms.png)

![LTspice 71.5 kHz measurements](03%20-%20High-frequency%20response/Common%20Emitter%20High%20Frequency%29%20SPICE%20output%20log.png)

## Circuit files

Each numbered folder contains the schematic, saved plot, and a shortcut to the segment where Alan covers that measurement.

