# Video 303 - What is a Pulse Counting FM Demodulator | Detector | Discriminator?

[Watch Alan Wolke's video](https://www.youtube.com/watch?v=jQlN2fc7LJc) alongside his [three-page handwritten notes](<W2AEW Video Notes - pulse_counting_fm_demod.pdf>). Alan introduces his two-transistor bench circuit [at 7:01](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=421s).

| Time | What Alan shows |
| --- | --- |
| [0:00](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=0s) | The idea (notes page 1): one narrow, fixed-width pulse per IF cycle. Averaging the pulses gives a voltage that follows the frequency. |
| [2:19](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=139s) | Why down-conversion is needed (page 2). A 100 MHz carrier with +/-50 kHz deviation barely changes the duty cycle; Alan shows this on the scope with a 1 Hz modulation rate. |
| [4:50](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=290s) | A diode ring mixer with a 100.1 MHz LO converts the signal down to a 100 kHz IF, which then swings from 50 to 150 kHz. |
| [7:01](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=421s) | The two-transistor circuit on page 3: a common-emitter gain stage (Q1) acts as the limiter, followed by a "monostable pulse generator" (CT, the diode, and Q2). The scope beside it reads a 100.2 kHz mean IF and a 49.9 kHz minimum. |
| [9:00](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=540s) | The scope shows the IF at 50 mV/div and the pulse output at 2 V/div, 4 us/div. Each IF cycle produces one short negative-going pulse. |
| [9:39](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=579s) | Practical tips: the IF must exceed the peak deviation, a lower IF gives a larger output, and a higher IF is easier to filter. |
| [10:47](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=647s) | Listening to the output. The pulses pass through the 10 kOhm resistor and stray capacitance into a small audio amplifier, whose limited bandwidth does the averaging. Alan sweeps the modulation from 1 Hz to about 500 Hz, then applies audio. |
| [12:08](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=728s) | How the blocks on page 3 form a complete receiver, and a credit to Alan Yates (VK2ZAY), whose receiver inspired the circuit. |

## How pulse counting demodulates FM

The detector needs no tuned circuit. A limiter turns the IF into a square wave. A one-shot then produces a pulse of roughly fixed width and height at one edge of every cycle. The pulse rate equals the IF frequency, so the pulse train's average voltage rises and falls with the frequency. A low-pass filter extracts that average, which is the recovered audio. Alan's notes add that the pulses may be positive-going or negative-going. Negative pulses simply invert the audio, so a higher IF frequency gives a *lower* voltage.

Down-conversion is what makes the method practical. At 100 MHz, a 50 kHz deviation changes the pulse rate by only 0.05 percent. After conversion to a 100 kHz IF, the same deviation changes it 3:1, from 50 to 150 kHz. Each pulse must be shorter than half an IF period at the highest frequency. At 150 kHz that limit is 3.33 us.

## 01 - Two-transistor pulse counting discriminator

[Open the LTspice schematic](<01 - Pulse counting discriminator/Pulse counting discriminator.asc>) or [jump to the circuit in the video](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=421s).

![LTspice pulse counting discriminator schematic](<01 - Pulse counting discriminator/Pulse counting discriminator schematic.png>)

The schematic follows the right half of Alan's page 3 drawing, part for part:

- **Q1, the limiter.** CIN (10 nF) couples the IF into Q1's base. RFB (20 kOhm, collector to base) biases Q1, and RC1 (3.9 kOhm) is its collector load. With about 160 mV p-p of drive, Q1's collector (node `LIM`) is driven into limiting.
- **CT, D1 and Q2, the one-shot.** In Alan's drawing, Q2 is a **common-base** stage: its base is grounded, and its emitter connects to the junction of CT (1 nF) and D1. The 1N914's anode is on that junction and its cathode at ground.
  - When `LIM` rises, CT charges through RC1 while D1 holds the junction about 0.6 V above ground.
  - When Q1 switches on and `LIM` falls, CT drags the junction below ground. This forward-biases Q2's emitter, and Q2 pulls a burst of current through RC2 (3.9 kOhm).
  - The result is one short negative pulse at `PULSE` for each falling `LIM` edge, which is each rising IF edge. The charge in each burst is set by CT and the `LIM` swing, which keeps the pulse area roughly constant.
  - This is how Alan describes the circuit at [8:01](https://www.youtube.com/watch?v=jQlN2fc7LJc&t=481s): the falling collector pulls the node "below ground" and "momentarily turns on" Q2.
- **RLP and CLP, the averager.** RLP is Alan's 10 kOhm resistor. CLP (10 nF) stands in for the stray capacitance and limited audio-amplifier bandwidth that do the filtering on his bench.

All transistors and the diode are LTspice's built-in 2N3904 and 1N914 models, the parts named on page 3. The mixer and audio amplifier are outside the schematic. The IF source `VIF` plays the mixer's IF output, as described in the table below.

| Value | Source | Used in the simulation |
| --- | --- | --- |
| IF center and deviation | Notes page 2; scope at 7:01 (49.9 to 137.6 kHz captured, 100.2 kHz mean) | 100 kHz +/- 50 kHz |
| IF amplitude | Scope at 9:00: about 3.2 div at 50 mV/div | 160 mV p-p (`80m` peak) behind 50 Ohms, a typical mixer port impedance |
| Modulation | Alan uses 1 Hz to watch the waveform, then about 500 Hz to listen | 500 Hz tone: `SFFM(0 80m 100k 100 500)`, where the modulation index is 50 kHz / 500 Hz = 100 |
| Supply | Not stated or readable in the video. The breadboard also carries a 74LS123, a 5 V part. | 5 V (assumption) |
| Averaging capacitor | Drawn in parentheses on page 3; Alan uses stray capacitance plus the amplifier's bandwidth | 10 nF (assumption; with RLP this gives a 1.6 kHz corner) |

### Recovered audio

![LTspice recovered audio plot](<01 - Pulse counting discriminator/Pulse counting discriminator recovered audio.png>)

- **Axes.** The horizontal axis is time from 1 to 5 ms, two cycles of the 500 Hz tone after start-up has settled.
- **Top pane: `V(audio)`.** This is the recovered tone, 0.50 V p-p, centered near 4.24 V.
- **Bottom pane: the IF frequency.** This trace is not a circuit node. It is a waveform-viewer expression that computes the instantaneous IF frequency in kHz from the `VIF` settings: 100 kHz + 50 kHz cos(2 pi 500 t). LTspice's `cos()` takes degrees, which is why the expression reads `cos(360*500*time)`.

Reading the two panes together shows the discriminator at work. When the IF is lowest (50 kHz, at 1 and 3 ms), there are fewest pulses and AUDIO is highest. When the IF is highest (150 kHz, at 2 and 4 ms), AUDIO is lowest. Because the pulses are negative-going, the audio is inverted. The peaks trail the frequency extremes by about 0.15 ms; that delay comes from the RLP-CLP filter. The fine sawtooth riding on the trace is IF-rate ripple that the single-pole filter does not remove. In Alan's setup, the audio amplifier's bandwidth removes it.

The waveform tops are broader than the troughs. The circuit is less sensitive at high IF, which the frequency sweep below measures directly.

If the waveform window opens autoscaled or without these labels after you click **Run**, press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`.

### Pulse detail at the two frequency extremes

Two extra plot settings files zoom into the same simulation for 40 us. To view one, use **Plot Settings > Open Plot Settings File** and choose `Pulse counting discriminator - 50 kHz detail.plt` or `Pulse counting discriminator - 150 kHz detail.plt`. Each view has three panes:

- **Bottom: `V(if)`.** The IF at Q1's base.
- **Middle: `V(lim)`.** Q1's collector.
- **Top: `V(pulse)`.** Q2's collector.

![LTspice 50 kHz pulse detail](<01 - Pulse counting discriminator/Pulse counting discriminator 50 kHz pulse detail.png>)

![LTspice 150 kHz pulse detail](<01 - Pulse counting discriminator/Pulse counting discriminator 150 kHz pulse detail.png>)

These are the waveforms sketched on page 1 of Alan's notes:

- **Pulse rate.** The same 40 us window holds 2 pulses at 50 kHz and 6 pulses at 150 kHz.
- **Pulse shape.** Each pulse is narrow and dips to about -0.6 V. Q2 saturates while its emitter is below ground, so its collector goes below ground too.
- **Comparison with Alan's scope.** His pulses at 9:00 show the same below-ground dip, which is a signature of the common-base connection. The small kinks on the IF peaks are Q1's base current at each switching edge, and Alan's IF trace shows similar notches.
- **Why the pulse area shrinks at high IF.** `LIM` falls quickly when Q1 conducts, but rises slowly while RC1 recharges CT through D1, with a time constant of 3.9 us. At 50 kHz `LIM` reaches 3.6 V before Q1 turns back on; at 150 kHz it reaches only 3.0 V. Less charge is stored in CT, so the pulses are narrower: 0.9 us instead of 1.3 us.

The SPICE Output Log gives the numbers:

![LTspice output log measurements](<01 - Pulse counting discriminator/Pulse counting discriminator SPICE output log.png>)

| Measurement | Value | Meaning |
| --- | ---: | --- |
| `AUDIO_MAX` | 4.489 V | AUDIO near the 50 kHz frequency minimum (2 to 4 ms window). |
| `AUDIO_MIN` | 3.988 V | AUDIO near the 150 kHz frequency maximum. |
| `AUDIO_PP` | 0.501 V | Recovered 500 Hz tone, peak to peak, for +/-50 kHz deviation. |
| `PW_50K` | 1.31 us | Pulse width at the 2.5 V level when the IF is 50 kHz (t = 3 ms). |
| `PW_150K` | 0.89 us | Pulse width when the IF is 150 kHz (t = 4 ms); still well under the 3.33 us half-period limit. |
| `AVG_50K` | 4.475 V | Average of `PULSE` over 100 us around t = 3 ms, where the IF is near 50 kHz. |
| `AVG_150K` | 4.003 V | Average of `PULSE` over 100 us around t = 4 ms, where the IF is near 150 kHz. |

**Comparison with the video.** Alan's scope at 9:00 shows pulses roughly 1.5 to 2 us wide at about 100 kHz, about 3.6 V high, dipping slightly below ground. The simulated pulses are a little narrower and their resting level is higher, about 4.7 to 4.85 V. Alan's supply voltage is unknown, and his 10 kOhm output feeds the audio amplifier's input instead of an unloaded capacitor, which lowers the high level. The behavior matches; the exact levels depend on the assumed supply and load.

### Experiment: steady-frequency sweep

[Open the sweep schematic](<01 - Pulse counting discriminator/Pulse counting discriminator - frequency sweep.asc>). It is an optional experiment, not a circuit from the video. It uses Alan's circuit unchanged, but replaces `VIF` with an unmodulated 160 mV p-p sine and steps its frequency with `.step param fif list 50k 75k 100k 125k 150k`. Each step settles to one AUDIO level, so the five levels trace out the discriminator's transfer curve.

![LTspice frequency sweep schematic](<01 - Pulse counting discriminator/Pulse counting discriminator frequency sweep schematic.png>)

![LTspice frequency sweep levels](<01 - Pulse counting discriminator/Pulse counting discriminator frequency sweep levels.png>)

The plot shows `V(audio)` from 0.6 to 1.5 ms for all five steps. Each step is labeled with its frequency and measured average; LTspice assigns the colors itself. The sawtooth on each line is the residual pulse ripple. A higher IF gives a lower average, as the main plot showed. The steps are not evenly spaced, though. Equal 25 kHz increases lower AUDIO by 183, 132, 101 and then 80 mV.

![LTspice sweep measurements](<01 - Pulse counting discriminator/Pulse counting discriminator frequency sweep SPICE output log.png>)

| `fif` | `AUDIO_AVG` |
| ---: | ---: |
| 50 kHz | 4.491 V |
| 75 kHz | 4.308 V |
| 100 kHz | 4.176 V |
| 125 kHz | 4.075 V |
| 150 kHz | 3.995 V |

An ideal pulse counter, with truly fixed pulse area, would give equal steps. This one compresses at high frequency for the reason the 150 kHz detail plot shows: CT has less time to recharge through RC1, so each pulse carries less charge. That is why Alan's notes require the pulse to be much shorter than half an IF period. It is also a practical reason to keep the IF low relative to the one-shot's recovery time, which fits his tip that a lower IF gives a larger output. The non-linearity also explains the broad tops and sharp troughs of the 500 Hz tone in the main plot. Alan acknowledges at 13:10 that a better one-shot design is possible. His "dirty bench top engineering" circuit still produces clearly recognizable audio.

### Circuit files

| File | Purpose |
| --- | --- |
| `Pulse counting discriminator.asc` | Alan's circuit with a 500 Hz FM tone on the 100 kHz IF. |
| `Pulse counting discriminator.plt` | Recovered audio and the instantaneous IF frequency, 1 to 5 ms. |
| `Pulse counting discriminator - 50 kHz detail.plt` | IF, LIM and PULSE for 40 us around t = 3 ms. |
| `Pulse counting discriminator - 150 kHz detail.plt` | IF, LIM and PULSE for 40 us around t = 4 ms. |
| `Pulse counting discriminator - frequency sweep.asc` and `.plt` | Optional experiment: settled AUDIO level at five steady IF frequencies. |
| `Video 303 - 01 - Pulse counting discriminator.url` | Opens the video at 7:01. |

## Source scope and supplemental reference

Alan's page 3 also draws the diode ring mixer that produces the IF. It is not simulated here; [video 167](https://www.youtube.com/watch?v=junuEwmQVQ8) covers that mixer in detail. Alan does not give a supply voltage or a value for the parenthesized output capacitor, so those two values are labeled as assumptions in both schematics.

The [Alan Yates receiver material](<Reference - Alan Yates receiver/>) is credited background on a complete transistor pulse-counting FM broadcast receiver by Alan Yates (VK2ZAY). Alan Wolke says at 13:39 that he lifted parts of his circuit from that design. The folder contains links to Yates' article, its comments and his IF-signal video, plus a photo of his hand-drawn receiver schematic (credit: Alan Yates, VK2ZAY). His pulse generator uses the same arrangement as Alan's: a common-base second transistor whose emitter is driven through a small capacitor, with a clamp diode to ground. It is not the source of the W2AEW schematic above.
