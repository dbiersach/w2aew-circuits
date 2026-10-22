# Video 417 - What the transition frequency is, and how to measure it

Source: Alan Wolke (W2AEW), [#417: What is the Transition Frequency (fT) of a transistor - and how to test it.](https://www.youtube.com/watch?v=PRzytyqwK5U). His two pages of notes for it are in [W2AEW Video Notes - Transition-frequency.pdf](W2AEW%20Video%20Notes%20-%20Transition-frequency.pdf): page 1 defines fT and sketches the current-gain curve, page 2 is the test circuit he builds.

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=PRzytyqwK5U&t=15s) | A B&K Precision 530 semiconductor tester, which has a meter marked fT and a range switch for 100, 500 and 1500 MHz. |
| [1:44](https://www.youtube.com/watch?v=PRzytyqwK5U&t=104s) | A Peak Atlas DCA75 on the device under test: NPN silicon BJT, hFE = 198. It never reports a part number, and neither does the video. |
| [1:58](https://www.youtube.com/watch?v=PRzytyqwK5U&t=118s) | The same device on a Tektronix Type 576 curve tracer. |
| [2:20](https://www.youtube.com/watch?v=PRzytyqwK5U&t=140s) | Page 1 of his notes: fT is the frequency where the current gain falls to one, and it varies greatly with bias. |
| [5:00](https://www.youtube.com/watch?v=PRzytyqwK5U&t=300s) | The sketch of the curve: flat at low frequency, then a 6 dB per octave, 20 dB per decade slope, with fT = hFE times frequency and "measure here" written on the slope. |
| [6:55](https://www.youtube.com/watch?v=PRzytyqwK5U&t=415s) | Measuring fT on the 530, and its minimum-deflection caveat. |
| [7:55](https://www.youtube.com/watch?v=PRzytyqwK5U&t=475s) | Figure 16 from the 530 manual: constant-fT contours drawn against collector current and collector-emitter voltage, which is the bias dependence in one picture. |
| [8:20](https://www.youtube.com/watch?v=PRzytyqwK5U&t=500s) | Page 2, the manual test circuit he calls "not ideal". This is the circuit in [01 - Manual fT test circuit](#01---manual-ft-test-circuit). |
| [11:00](https://www.youtube.com/watch?v=PRzytyqwK5U&t=660s) | Both channels on his MDO4104C: the collector current on CH1 and the base current on CH2. |
| [11:42](https://www.youtube.com/watch?v=PRzytyqwK5U&t=702s) | The readings at 300 kHz: 1.581 mA and 7.883 uA of amplitude on a 9.989 mA and 57.29 uA bias. |
| [13:26](https://www.youtube.com/watch?v=PRzytyqwK5U&t=806s) | The same at 3 MHz, where the collector amplitude has fallen to 716.6 uA while the base amplitude has risen to 12.94 uA. |

## What fT is

A transistor's current gain is only constant up to a point. Above it the gain falls at 20 dB per decade, and the frequency at which it would reach one is the transition frequency. Because the fall is a single-pole slope, the product of the gain and the frequency is constant along it, so one measurement of gain anywhere on the slope gives fT directly. That is the arithmetic on Alan's page 1, and the reason he writes "measure here" on the sloping part rather than on the flat part.

Measuring it does not need a gain-bandwidth analyser, only a way to see the collector and base currents at the same time. Alan's circuit biases the transistor at a fixed collector current, injects a small signal into the base through a known resistor, and watches both currents on a scope. The gain is the ratio of the two amplitudes.

## 01 - Manual fT test circuit

Open [Manual fT test circuit.asc](01%20-%20Manual%20fT%20test%20circuit/Manual%20fT%20test%20circuit.asc); the [video shortcut](01%20-%20Manual%20fT%20test%20circuit/Video%20417%20-%2001%20-%20Manual%20fT%20test%20circuit.url) opens the drawing at [8:20](https://www.youtube.com/watch?v=PRzytyqwK5U&t=500s).

![LTspice schematic of the manual fT test circuit](01%20-%20Manual%20fT%20test%20circuit/Manual%20fT%20test%20circuit%20schematic.png)

*Alan's page-2 circuit with his values: an 8 V supply straight onto the collector, the emitter grounded, a DC bias through 120 k into the base node, and the signal arriving from a generator set to 100 mV peak to peak through a 5x attenuator, a DC block and 560 ohm. There is no collector resistor, so the collector sits at the full 8 V and the signal current flows back into the supply, which is exactly the short-circuit condition a current-gain measurement wants.*

### What stands in for the probes

Alan measures the collector current with a TCP0030 current probe clamped on the collector lead, which becomes CH1. In LTspice that lead is interrupted by `VCPROBE`, a zero-volt source, so `I(Vcprobe)` is the same current his probe reads.

He measures the base current indirectly: a TDP4000 differential probe across the 560 ohm, with the scope channel scaled so it reads in microamps rather than millivolts. In LTspice the base current is `I(Rb)` directly. His CH2 badge shows 18.2 uA per division, which is about 10 mV per division across 560 ohm.

The 5x attenuator is a box on his drawing. Here it is the resistive T pad that does the same job in a 50 ohm system, 33.3 ohm in each series arm and 20.8 ohm in the shunt arm, terminated by `RTERM`. `RSRC` is the generator's own 50 ohm output impedance, so `V1` carries his 100 mV peak to peak as an open-circuit amplitude.

### At 300 kHz and 3 MHz

`.step param FREQ list 300k 3Meg` runs Alan's two frequencies, and each `.meas` window is written as `{20/FREQ}` to `{30/FREQ}` so that both steps are measured over ten whole cycles.

![Collector and base current at both frequencies](01%20-%20Manual%20fT%20test%20circuit/Manual%20fT%20test%20circuit%20currents.png)

*Ten microseconds of both currents, with the step legend naming the two frequencies. The top pane is the collector current, Alan's CH1, and the bottom pane is the base current, his CH2. Going from 300 kHz to 3 MHz the collector swing shrinks from 1.71 mA to 1.21 mA while the base swing grows from 8.60 uA to 13.32 uA. The gain has fallen by more than half, and it has fallen at both ends: less current out and more current in.*

![The measured amplitudes, gains and fT estimates](01%20-%20Manual%20fT%20test%20circuit/Manual%20fT%20test%20circuit%20SPICE%20output%20log.png)

*The `.meas` results. `hfe` is the ratio of the two amplitudes and `ft` is that ratio multiplied by the test frequency, which is Alan's arithmetic done by the simulator.*

| Quantity | At 300 kHz | At 3 MHz |
| --- | --- | --- |
| Collector current, DC | 10.00 mA | 10.00 mA |
| Base current, DC | 48.07 uA | 48.07 uA |
| Collector current amplitude | 1.708 mA | 1.211 mA |
| Base current amplitude | 8.596 uA | 13.32 uA |
| Current gain | 198.7 | 90.9 |
| Gain times frequency | 59.6 MHz | 272.8 MHz |

The two numbers in the last row are the whole point of the lesson. They disagree by a factor of four and a half, and only the second one means anything, because at 300 kHz the gain has not started to fall yet and the product is simply the flat gain multiplied by an arbitrary frequency.

### Against Alan's bench

| Quantity | Alan at 300 kHz | Simulated at 300 kHz | Alan at 3 MHz | Simulated at 3 MHz |
| --- | --- | --- | --- | --- |
| Collector current amplitude | 1.581 mA | 1.708 mA | 716.6 uA | 1.211 mA |
| Base current amplitude | 7.883 uA | 8.596 uA | 12.94 uA | 13.32 uA |
| Current gain | 200.6 | 198.7 | 55.4 | 90.9 |
| Gain times frequency | 60.2 MHz | 59.6 MHz | 166 MHz | 272.8 MHz |

At 300 kHz the agreement is close on every line, which is the useful check: the drive level, the attenuator, the 560 ohm and the bias all land where his do, and the gain comes out within one percent of his 200.6. His DC bias current, 57.29 uA against the simulated 48.07 uA, is the one DC difference, and it says the real device has a slightly lower DC beta than the model.

At 3 MHz the two part company, and they part company for the only reason they could: this is not his transistor. His device has run out of gain faster, so its fT is 166 MHz against the 2N2222 model's 273 MHz by the same arithmetic. The video never identifies the part, so there is nothing to match the model to beyond the DCA75's hFE = 198.

### The whole curve

The same circuit at the same operating point, swept instead of pulsed, draws the curve Alan sketches on page 1. Open [Current gain frequency sweep.asc](01%20-%20Manual%20fT%20test%20circuit/Current%20gain%20frequency%20sweep.asc); it is an addition to the video rather than something he runs, and it exists to show where his two measurement points sit on the curve.

![Current gain against frequency](01%20-%20Manual%20fT%20test%20circuit/Current%20gain%20frequency%20sweep.png)

*The collector current divided by the base current, swept from 10 kHz to 1 GHz. Flat at 202 to about 1 MHz, then the 20 dB per decade slope, crossing a gain of one at 306 MHz. Alan's 300 kHz point is still on the flat part, and his 3 MHz point is on the knee rather than well down the slope.*

![The swept gains and the transition frequency](01%20-%20Manual%20fT%20test%20circuit/Current%20gain%20frequency%20sweep%20SPICE%20output%20log.png)

*`.meas ac` results. `ft` is found by asking where the gain crosses one rather than by extrapolating from a single point.*

| Frequency | Current gain | Gain times frequency |
| --- | --- | --- |
| 10 kHz | 202.1 (46.10 dB) | 2.0 MHz |
| 300 kHz | 198.3 (45.94 dB) | 59.5 MHz |
| 3 MHz | 91.0 (39.18 dB) | 273 MHz |
| 30 MHz | 10.2 (20.16 dB) | 306 MHz |
| 306.4 MHz | 1 | 306 MHz |

Read down the last column and the method explains itself. At 10 kHz and 300 kHz the answer is nonsense. At 3 MHz, on the knee, it is 11 percent low. At 30 MHz, properly on the slope, it is right to three figures. This is what "measure here" means, and it is the practical risk in the measurement: pick a frequency too low and the number comes out too small, with nothing on the scope to warn you.

Alan's device is better placed than it looks. If its gain also follows a single pole, then a flat gain of about 200 and an fT of 166 MHz put its knee near 830 kHz, so his 3 MHz reading is already more than three times up the slope and his 166 MHz should be within a few percent of the real figure.

## Models and assumptions

Q1 is a 2N2222 using the model LTspice installs in `standard.bjt`, chosen because its low-frequency gain of about 200 is close to the hFE = 198 the DCA75 reports for Alan's device, which is the only thing the video tells us about it. Its fT is not Alan's device's fT and the notes above do not treat it as such.

`VBIAS` is 6.51 V. The video never shows the bias supply setting, so this is the value that puts the collector current at the 10 mA his scope measures. `CBLOCK` is 0.1 uF; he draws a DC block without a value, and the choice matters only in that it must be large enough to pass 300 kHz through the 560 ohm, which 0.1 uF is by a wide margin. The simulation takes its DC operating point before the transient, so the block starts already charged and there is no settling to wait out.

Both files use `.save` to keep only the two currents, so the waveform window offers exactly the two traces the plots use. After pressing Run, press Ctrl+Space (Plot Settings > Reload Plot Settings) if a window opens autoscaled instead of showing the saved view.
