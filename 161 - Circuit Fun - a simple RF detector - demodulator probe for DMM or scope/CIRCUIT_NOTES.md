# Video 161: a simple RF detector and demodulator probe

Source: Alan Wolke (W2AEW), [#161: Circuit Fun: a simple RF detector / demodulator probe for DMM or scope](https://www.youtube.com/watch?v=C8SKiyJUAlU). His notes page for the lesson is kept here as [W2AEW Video Notes - RF_detector_demodulator_probe.pdf](<W2AEW Video Notes - RF_detector_demodulator_probe.pdf>), and it carries both the circuit and the measured calibration curve the simulation is checked against.

| Time | What Alan shows |
| --- | --- |
| [0:55](https://www.youtube.com/watch?v=C8SKiyJUAlU&t=55s) | The notes page: what the probe is for, and the circuit itself, which is the one built in [01 - RF detector probe](<01 - RF detector probe/>). |
| [2:30](https://www.youtube.com/watch?v=C8SKiyJUAlU&t=150s) | His measured calibration curve, detected volts out against RF volts RMS in, with the 565 mVpp, 1.7 Vpp and 2.828 Vpp equivalents written under the axis. |
| [4:10](https://www.youtube.com/watch?v=C8SKiyJUAlU&t=250s) | The probe he actually built: two glass germanium diodes and two capacitors on a strip of copper clad, no bigger than a thumb. |
| [5:45](https://www.youtube.com/watch?v=C8SKiyJUAlU&t=345s) | The probe on the bench with a Fluke 87 reading its output and an MDO3104 watching the RF going in. |
| [7:00](https://www.youtube.com/watch?v=C8SKiyJUAlU&t=420s) | An amplitude-modulated carrier on the scope, the case built here as the AM variant. |

## What the circuit does

Alan's notes list four jobs for it: tuning IF stages, adjusting filter responses, peaking RF stages, and examining amplitude modulation. All four need the same thing, which is a relative reading of how much RF is present at a point in a circuit, available on a DMM or a slow scope input rather than on an RF instrument.

The circuit is five parts. A 1 nF capacitor couples the RF in and blocks any DC in the circuit under test. One germanium diode sits from the probe tip to ground, with its cathode at the tip, so it conducts on negative half cycles and holds the troughs near zero volts: it clamps. The second germanium diode is in series, and it charges the output 1 nF through a 10 kohm load on the positive half cycles: it rectifies. Because the clamp has already pushed the whole waveform up, the peaks the second diode sees are close to twice the RF amplitude, so the pair works as a voltage doubler and the detected DC can be larger than the RF peak.

Germanium matters here. The lesson needs a diode that starts conducting at a couple of hundred millivolts rather than six or seven hundred, so that small RF signals still register. Alan says in the video description that other low-capacitance, low-bias diodes would also work.

## 01 - RF detector probe

Both schematics are in [01 - RF detector probe](<01 - RF detector probe/>), introduced at [0:55](https://www.youtube.com/watch?v=C8SKiyJUAlU&t=55s). They are the same five parts; only the stimulus differs.

The 1N34A model used in both is `1N34A_LEGACY` from [`LTspice/Models/Unverified/1N34A_legacy.lib`](<../LTspice/Models/Unverified/1N34A_legacy.lib>). It is a legacy germanium point-contact fit whose provenance has not been established, not a manufacturer-supplied part, which is why it lives under `Unverified`.

### The calibration sweep

[`RF detector probe.asc`](<01 - RF detector probe/RF detector probe.asc>)

![RF detector probe schematic](<01 - RF detector probe/RF detector probe schematic.png>)

The parts are Alan's: 1 nF in, two 1N34A, 1 nF and 10 kohm out. What is not his is the test frequency. His notes mark the probe as useful from roughly 100 kHz to 100 MHz without naming the frequency he used, so 1 MHz is a choice made inside that range, and 50 ohm stands for the generator feeding the tip.

His curve is drawn against the RF input in volts RMS, so `VRMS` steps through the same seven levels his plotted points sit at, with the source amplitude derived from it as `VRMS * sqrt(2)`.

![RF detector probe response](<01 - RF detector probe/RF detector probe response.png>)

The top pane is the detected output at three of those levels. It is not flat DC: the output capacitor is recharged once per RF cycle and then discharges into the 10 kohm until the next peak, so each trace carries a small sawtooth. That ripple is invisible to the DMM the probe was built for, which is the point of the 10 kohm and 1 nF being where they are.

The bottom pane is the probe tip at the largest of the three drives. The clamp diode is doing its job: the troughs are held just below zero while the peaks reach 2.31 V, which is nearly twice the 1.41 V peak the generator is producing. That doubling is where the output voltage comes from.

![RF detector probe SPICE output log](<01 - RF detector probe/RF detector probe SPICE output log.png>)

| RF in, volts RMS | Simulated `vout` | Read off Alan's curve |
| --- | --- | --- |
| 0.1 | 0.059 V | about 0.07 V |
| 0.2 | 0.213 V | about 0.22 V |
| 0.4 | 0.623 V | about 0.55 V |
| 0.6 | 1.070 V | about 0.98 V |
| 0.8 | 1.529 V | about 1.38 V |
| 1.0 | 1.993 V | about 1.75 V |
| 1.2 | 2.461 V | about 2.20 V |

The right-hand column is read off a hand-drawn graph, so treat it as approximate. What the comparison shows is that the shape is right: both curve upward out of the origin, where the diodes are not yet conducting properly and the detector is square-law, then straighten into a line once the RF is comfortably larger than the germanium drop. Above 0.4 V RMS the simulation runs about ten percent high. That is the expected direction of error, because the real probe has cable capacitance, the real diodes have more series resistance than the model, and the DMM across the output loads it a little further. None of that changes the use of the probe, which Alan is careful to call a relative reading rather than a calibrated one.

The `vtip_min` column in the log is worth a look on its own. It only moves from -0.11 V to -0.30 V across a twelvefold change in drive, because that is the clamp diode's forward drop and nothing else.

### The AM variant

[`RF detector probe with AM input.asc`](<01 - RF detector probe/RF detector probe with AM input.asc>)

![RF detector probe with AM input schematic](<01 - RF detector probe/RF detector probe with AM input schematic.png>)

The same probe, with the generator replaced by a behavioral source producing an amplitude-modulated carrier, which stands in for the AM mode of Alan's generator. He does not state his carrier frequency, modulation rate or depth, so the 1 MHz carrier, 20 kHz tone and 50 percent depth are all choices. The 20 kHz is the one that matters: the output time constant is 1 nF into 10 kohm, which is 10 us, so the envelope has to be slower than that for the detector to follow it. A 20 kHz tone has a 50 us period, comfortably slower.

![RF detector probe with AM input demodulation](<01 - RF detector probe/RF detector probe with AM input demodulation.png>)

The top pane is the carrier at the probe tip. The clamp holds the bottom of the waveform near zero while the top rises and falls with the modulation, so the envelope is carried entirely on the positive peaks, which is exactly what the second diode is looking at.

The bottom pane is the probe output, and it is the modulating tone again: a 20 kHz sine swinging between 0.88 V and 3.27 V, with a little carrier ripple left on it. That residue is the same once-per-cycle recharge seen in the first schematic, now riding on a moving baseline instead of a fixed one.

![RF detector probe with AM input SPICE output log](<01 - RF detector probe/RF detector probe with AM input SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `vdet_avg` | 2.034 V |
| `vdet_max` | 3.272 V |
| `vdet_min` | 0.884 V |

Those two extremes can be checked against the first schematic's table. With a 1.0 V RMS carrier modulated 50 percent, the envelope swings between 0.5 and 1.5 V RMS, and the static curve gives roughly 0.84 V and 3.1 V at those levels. The AM run lands at 0.88 V and 3.27 V, so the detector is tracking its own static transfer curve almost exactly, which is another way of saying the 10 us time constant really is fast enough for a 20 kHz envelope.

## Reloading the saved plots

The calibration sweep is a stepped run, so its waveform window opens autoscaled with all seven steps overlaid. Press Ctrl+Space, or Plot Settings > Reload Plot Settings, to pick up the saved panes and their labeled traces.
