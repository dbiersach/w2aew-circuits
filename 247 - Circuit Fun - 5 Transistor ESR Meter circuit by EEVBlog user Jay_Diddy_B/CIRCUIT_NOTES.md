# Video 247 - A five transistor ESR meter

Source: Alan Wolke (W2AEW), [#247: Circuit Fun: 5 Transistor ESR Meter circuit by EEVBlog user Jay_Diddy_B](https://www.youtube.com/watch?v=3fiUZZlveS0). The circuit is not Alan's: it was designed by EEVblog user **Jay_Diddy_B** and discussed in [his forum thread](https://www.eevblog.com/forum/projects/5-transistor-esr-meter-design/msg171364/#msg171364), where he also attached the LTspice file this chapter adapts.

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=3fiUZZlveS0&t=15s) | The schematic on paper, with the designer credited on it in Alan's own hand. |
| [1:00](https://www.youtube.com/watch?v=3fiUZZlveS0&t=60s) | The working meter on the bench: an analog movement deflecting as he touches different electrolytics, with the scope showing the bridge waveforms beside it. |
| [4:23](https://www.youtube.com/watch?v=3fiUZZlveS0&t=263s) | The start of the stage-by-stage walkthrough of the complete schematic, which is where [circuit 01](#01---five-transistor-esr-meter) begins. |
| [5:20](https://www.youtube.com/watch?v=3fiUZZlveS0&t=320s) | The oscillator pair at the left of the drawing, which generates the square wave everything else works from. |
| [7:00](https://www.youtube.com/watch?v=3fiUZZlveS0&t=420s) | The schematic held up beside the scope so the traces can be matched to the nodes, which is how he spends most of the rest of the video. |
| [8:40](https://www.youtube.com/watch?v=3fiUZZlveS0&t=520s) | The four traces with the readout clear of his hand: every channel on 1.00 V per division, 2.00 us per division, 500 MS/s into 10k points. The square wave's period can be counted off that graticule, which is what [the frequency section](#frequency-and-what-the-measurement-actually-is) does. |
| [14:30](https://www.youtube.com/watch?v=3fiUZZlveS0&t=870s) | Back to the breadboard for closing comments on the build. |

## What the circuit is for

An electrolytic capacitor usually fails by drying out, and when it does its equivalent series resistance rises long before its capacitance changes much. That makes ESR the useful thing to measure, and measuring it is awkward because it is a small resistance hiding behind a large capacitance.

The trick is frequency. At 100 kHz a healthy 47 uF electrolytic has a reactance of a few tens of milliohms, which is small compared with the ohm or two of ESR that marks a failing part. So a meter that drives the capacitor with a high-frequency square wave and measures the voltage developed across it is, for practical purposes, reading ESR. What it is really reading is impedance at that frequency, and the notes below are careful about the difference.

## 01 - Five transistor ESR meter

Open [Five transistor ESR meter.asc](01%20-%20Five%20transistor%20ESR%20meter/Five%20transistor%20ESR%20meter.asc); the [video shortcut](01%20-%20Five%20transistor%20ESR%20meter/Video%20247%20-%2001%20-%20Five%20transistor%20ESR%20meter.url) opens the walkthrough at [4:23](https://www.youtube.com/watch?v=3fiUZZlveS0&t=263s).

![LTspice schematic of the five transistor ESR meter](01%20-%20Five%20transistor%20ESR%20meter/Five%20transistor%20ESR%20meter%20schematic.png)

*The designer's circuit, laid out left to right in the five stages Alan walks through. Component values and connections are his; only the arrangement on the page and the two net labels `OSC` and `SENSE` are added here, so that the traces and measurements below have readable names. Like the designer's own file, this represents the video's 9 V battery and 5 V regulator as an ideal 5 V rail.*

### How it works

**Q1 and Q2** form the oscillator. Their collector and emitter networks with `C1` across them make an astable pair, and `R6` gives `Q2` a square-wave collector output at the node labeled `OSC`.

**Q3**, the 2N3906, is driven from `OSC` and acts as the bridge driver, switching the 5 V rail into two resistive arms through its collector.

The **bridge** is the heart of it. One arm is `R7` at 150 ohms down to `R8` at 3 ohms, and the capacitor under test hangs on that 3 ohm node, which is labeled `SENSE`. The other arm is `R9` at 1500 ohms down to `R10` at 30 ohms, labeled `BR_RET`, and has nothing on it. The two arms have the same ten to one ratio, so with no capacitor connected they produce the same waveform and there is nothing to measure.

Connect a capacitor and the sense arm changes. A good capacitor is nearly a short circuit at the oscillator frequency, so it holds `SENSE` almost still while `BR_RET` keeps swinging, and the two arms disagree by a lot. A capacitor with high ESR cannot hold the node down, so `SENSE` swings nearly as much as `BR_RET` and the two arms agree. **The meter reads the disagreement, so a low ESR gives a large reading.** `D1` and `D2`, back to back across `SENSE`, protect the input from a charged capacitor being connected.

**Q4 and Q5** are identical common-emitter stages, one on each arm, AC coupled through `C3` and `C5`. **D5, D6 and R23** rectify the difference between the two amplified arms, and `R22` with `C8` across it is the meter branch. `I(R22)` is therefore the meter current.

### Simulated result

`.step param R LIST` sweeps the series resistance `R11` through fifteen values from 0.0001 to 20 ohms with a fixed 47 uF for `C2`, and `.measure Iout AVG I(R22)` averages the meter current over the last half millisecond of each 10 ms run.

![LTspice output log showing the average meter current for all fifteen steps](01%20-%20Five%20transistor%20ESR%20meter/Five%20transistor%20ESR%20meter%20SPICE%20measurements.png)

*The fifteen steps from the output log, in amps. Step 1 is 0.0001 ohms, step 5 is 1 ohm, step 7 is 4 ohms, step 10 is 10 ohms and step 15 is 20 ohms.*

| Series resistance | Average meter current |
| ---: | ---: |
| 0.0001 Ω | 60.44 µA |
| 0.5 Ω | 48.74 µA |
| 1 Ω | 40.18 µA |
| 2 Ω | 28.61 µA |
| 4 Ω | 16.31 µA |
| 10 Ω | 4.69 µA |
| 20 Ω | 1.20 µA |

![Simulated meter current at three series resistances, with the bridge arms underneath](01%20-%20Five%20transistor%20ESR%20meter/Five%20transistor%20ESR%20meter%20LTspice%20plot.png)

*The top three panes are the meter current at three of the fifteen steps, on a common 0 to 70 µA axis so they can be read against each other: nearly full scale at 0.0001 ohms, a quarter of it at 4 ohms, and almost nothing at 20 ohms. The bottom pane shows why. `V(br_ret)`, the reference arm with nothing on it, swings the full 95 mV, while `V(sense)`, the arm carrying a near-perfect capacitor, barely moves. It is that difference the amplifier and rectifier turn into meter current.*

Two things are worth drawing out of the table. The first is that the scale is deliberately nonlinear and crowds the useful end: the first ohm uses a third of the deflection, while everything above ten ohms is squeezed into the last few microamps. For judging whether an electrolytic is tired, that is exactly the right way round. The second is that `R22` is 20 kΩ in the original, and at the low-ESR end the simulated branch current exceeds the 50 µA movement the design is built around, so a physical build needs calibrating for its own meter and diodes. The table is a shape, not a calibration.

### Frequency, and what the measurement actually is

Alan's description of the video gives the drive as a 100 kHz square wave, and that is the design intent. Run in LTspice 26.1.1, the designer's oscillator comes out at **85.9 kHz**: `.meas tran OSC_PERIOD` gives a period of 11.65 µs, and it holds that to within 0.1 percent across all fifteen resistance steps.

His own build settles the question between those two figures. At [8:40](https://www.youtube.com/watch?v=3fiUZZlveS0&t=520s) his MDO4104C is on **2.00 µs per division** and the square wave on channel 1 runs a full period in a little under five and a half divisions, so his oscillator is near **11 µs, about 92 kHz**. That is 7 percent above the model and 8 percent below the nominal 100 kHz, which is the right order for an astable of this kind: the period depends on transistor storage time and on the particular devices, and neither a model nor a datasheet pins that down. It does not change any of the conclusions above, and the plot's time axis is read directly from this model rather than from the nominal figure.

The other thing his readout gives is the scale of what he is looking at. All four channels are on **1.00 V per division**, so the traces he matches to the drawing are the volt-level nodes, the oscillator and the amplified arms, not the bridge arms themselves. `V(br_ret)` swings 95 mV, a tenth of a division on his setting, which is why the amplifier stages exist at all.

At 85.9 kHz the 47 µF under test has a reactance of about 39 mΩ. That is small against the 1 Ω or more that marks a failing electrolytic, which is why the reading approximates ESR, but it is not zero: for a smaller capacitor, or with real lead inductance in the test leads, the reactance stops being negligible and the meter is plainly reading impedance rather than resistance. Short test leads matter for the same reason, and the capacitor must be discharged before it is connected.

## Models

The transistors use LTspice's installed `2N3904` and `2N3906` models and the protection diodes its `ES1D`. The rectifier diodes `D5` and `D6` use the `DI_1N5711W` model embedded in Jay_Diddy_B's original file, which this reproduction keeps as he wrote it; its provenance is not established here. Diodes Incorporated publishes a current model for the related [1N5711WS](https://www.diodes.com/part/view/1N5711WS/), but that is a different part and substituting it would shift the scale, so it has not been used.
