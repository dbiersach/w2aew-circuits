# Video 381 - Trimming the twin-tee oscillator for lowest distortion

Source: Alan Wolke (W2AEW), [#381: Circuit Fun Followup: Trimming out distortion on Twin-Tee Oscillator - FFT &THD measurement](https://www.youtube.com/watch?v=Dm1YjETg3rU). The circuit is the one on page 3 of his drawing for the previous video, [W2AEW Video Notes - twintee_oscillator.pdf](../380%20-%20Circuit%20Fun%20-%20Twin-Tee%20Oscillator%20-%20low%20distortion%20op%20amp%20sine%20waves/W2AEW%20Video%20Notes%20-%20twintee_oscillator.pdf), where he writes "some minor trimming for lowest distortion". This video is that trimming.

| Time | What Alan shows |
| --- | --- |
| [0:08](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=8s) | The page-3 drawing again: the twin tee in the feedback loop, a 5 V supply, and the 4.7 k plus 500 ohm trim in the shunt leg. This is the circuit in [01 - Twin-tee oscillator distortion trim](#01---twin-tee-oscillator-distortion-trim). |
| [0:42](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=42s) | The output on his Tektronix 2 Series scope, Ch 1 at 600 mV per division: a sine that runs from the ground rail up to about 4.8 V. |
| [1:06](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=66s) | Setting up Math 1 as an FFT of Ch 1. |
| [1:52](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=112s) | The waveform and its spectrum side by side, the FFT at 10 dBm per division, with a comb of harmonics standing well clear of the noise floor. |
| [3:23](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=203s) | The zoomed sine next to the comb: the waveform looks clean while the spectrum says it is not. |
| [3:35](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=215s) | A Keithley 2015 THD multimeter on the output, reading 1.594 percent before any trimming. |
| [4:05](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=245s) | A screwdriver on the 500 ohm trim pot, watching the harmonics drop as he turns it. |
| [4:19](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=259s) | 0.660 percent on the THD meter, part way through. |
| [5:07](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=307s) | 0.118 percent, with the meter settling between 0.118 and 0.122. |
| [5:26](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=326s) | The finished board, the probe and the meter leads on the bench. |

## Why the trim is touchy

The twin tee is a notch, and it sits in the only feedback path this amplifier has. At the notch frequency almost nothing comes back to the inverting input, the stage has nearly all of its open-loop gain, and the loop oscillates there. How much gain is left over depends on how closely the network is balanced, and that is what the 500 ohm pot in series with the 4.7 k shunt leg adjusts.

Too much spare gain and the output grows until something stops it, which in a circuit with no amplitude control means the supply rails. Too little and the oscillation dies out. Between those lies a narrow setting where the output settles just clear of the rails, and that is where the distortion is lowest. Alan's method is the right one for finding it: trim while watching the spectrum, because the waveform at one or two percent distortion still looks like a sine wave.

## 01 - Twin-tee oscillator distortion trim

Open [Twin-tee oscillator distortion trim.asc](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Twin-tee%20oscillator%20distortion%20trim.asc); the [video shortcut](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Video%20381%20-%2001%20-%20Twin-tee%20oscillator%20distortion%20trim.url) opens the drawing at [0:08](https://www.youtube.com/watch?v=Dm1YjETg3rU&t=8s).

![LTspice schematic of the twin-tee oscillator with its trim resistor](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Twin-tee%20oscillator%20distortion%20trim%20schematic.png)

*Alan's page-3 circuit with his values: 10 k and 10 k with 20 nF to ground in the upper tee, 10 nF and 10 nF with 4.7 k plus the trim to ground in the lower one, a 2.2 k pair holding the non-inverting input at half of the 5 V supply, and the 0.1 uF bypass he draws across it. `RTRIM` stands for the wiper setting of his 500 ohm pot.*

### The op amp is a documented substitute

Alan's drawing names an MCP6002 and then adds "or any R-R I/O op amp (others will work)". That permission matters here, because the MCP6001-family macromodel used for the oscillator in video 380 states in its own header that detailed distortion behavior is not supported, so it cannot answer the question this video asks. `U1` is therefore an LT1810, a rail-to-rail input and output part whose manufacturer model ships with LTspice in `LTC.lib`. Everything passive is Alan's.

Read the absolute distortion figures below as what this model does with his network, not as a measurement of an MCP6002. The model's output also reaches within 2.4 mV of the ground rail, which is closer than any real part will manage into a load, so the amplitudes at the three low trim settings are optimistic.

### What the simulation does

`.tran 0 5s 4.7s 1u uic` lets the oscillator run for 4.7 seconds before it saves anything, so what is plotted and measured is the settled state rather than the start-up transient. `.ic V(out)=3.5` is the kick that starts it. `.step param TRIM list 200 250 295 300` walks the wiper across the interesting range, and `.four 1.592k V(out)` asks LTspice for the harmonic amplitudes and total harmonic distortion of the last cycle of each step.

The `.meas` pair `AMP_EARLY` and `AMP_LATE` measures the peak-to-peak output at the two ends of the saved window, and `HOLD` is their ratio. That ratio is the check that matters when trimming for distortion: a dying oscillator also has a falling distortion reading, and the ratio is what tells the two apart.

### The waveform cannot tell you

![Four trim settings overlaid in the time domain](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Twin-tee%20oscillator%20distortion%20trim%20waveforms.png)

*Two milliseconds of the settled output, about three cycles, with one trace per trim setting named in the step legend. The traces sit at different phases only because their frequencies differ slightly after 4.7 seconds. At 200, 250 and 295 ohm the three are the same sine to the eye, 4.74 to 4.80 V peak to peak with the negative peak flattened on the ground rail, even though their distortion differs by a factor of eight. Only the 300 ohm trace looks different, and it is the one that is dying.*

### The spectrum can

![The harmonic comb at four trim settings](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Twin-tee%20oscillator%20distortion%20trim%20spectrum.png)

*An FFT of the same saved window, taken in LTspice with View > FFT on `V(out)` and a Hann window, plotted from 0 to 16 kHz against a dB scale referred to 1 V RMS. The fundamental is 1.59 kHz at about 1.7 V RMS in every step. The difference is the comb at 3.18 kHz and every multiple of it above: the 3.18 kHz second harmonic alone falls 25 dB between the 200 ohm step and the 295 ohm step. This is the picture Alan is working from at 1:52, and it is why he trims against it rather than against the waveform.*

The Hann window is there because the saved window does not hold a whole number of cycles. Each step oscillates at a slightly different frequency, so no single save interval could be coherent for all four, and the window keeps the skirts off the harmonics.

### Results

| Trim | Peak to peak at 4.70 s | Peak to peak at 4.98 s | `HOLD` | Output range | Frequency | THD |
| --- | --- | --- | --- | --- | --- | --- |
| 200 ohm | 4.798 V | 4.798 V | 1.0000 | 0.0024 to 4.801 V | 1599.0 Hz | 1.504 percent |
| 250 ohm | 4.770 V | 4.770 V | 0.9999 | 0.0024 to 4.772 V | 1595.3 Hz | 0.575 percent |
| 295 ohm | 4.736 V | 4.736 V | 1.0000 | 0.0025 to 4.738 V | 1591.9 Hz | 0.181 percent |
| 300 ohm | 3.939 V | 3.902 V | 0.9905 | 0.415 to 4.317 V | 1591.5 Hz | 0.183 percent |

![The measured amplitudes, frequencies and hold ratios](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Twin-tee%20oscillator%20distortion%20trim%20SPICE%20output%20log.png)

*The `.meas` results for the four steps. The distortion figures in the table come from the `.four` blocks higher up the same log.*

The first three rows are a sustained oscillator: the amplitude at the end of the window equals the amplitude at its start, and advancing the trim buys a factor of eight in distortion while costing 62 mV of swing. The fourth row is the trap. At 300 ohm the output has finally come off both rails, which is what a clean sine wave is supposed to look like, and the distortion reading is no better than at 295 ohm; but the amplitude falls about one percent every 280 ms, so the oscillation is on its way out. A THD reading taken there would be a reading of a decaying waveform.

The frequency does its own small thing. The lower tee's shunt leg is 4.7 k plus the trim, and the balanced value for 10 k and 10 nF is exactly 5 k, so advancing the trim is also pulling the network into balance: the output moves from 1599.0 Hz at 200 ohm to 1591.5 Hz at 300 ohm, which is the 1/(2 pi R C) figure of 1591.5 Hz for Alan's values.

### Against Alan's bench

His Keithley 2015 reads 1.594 percent before trimming, 0.660 percent part way through, and 0.118 percent when he stops. The simulation walks the same path, 1.504 percent to 0.575 percent to 0.181 percent, in the same order and over nearly the same range. That agreement in magnitude is better than a macromodel has any right to deliver and should not be read as a prediction of his MCP6002; what the model does reproduce is the shape of the problem, which is that a few tens of ohms on a 500 ohm pot move the distortion by more than an order of magnitude while the waveform barely changes.

Alan's trimmed output and the 295 ohm step also agree about where the amplitude sits: his sine runs from the ground rail to about 4.8 V at 600 mV per division, and so does the simulation. Neither of them has any amplitude control, so in both the rails end up doing the limiting.

## Models and assumptions

The LT1810 subcircuit comes from `LTC.lib`, which is installed with LTspice; nothing in this folder depends on a model from outside it. `RTRIM` is a fixed resistor standing in for the wiper position of Alan's 500 ohm pot, and the four values are chosen to bracket the behavior, because his knob position is never read out on screen. The 0.1 uF bypass is drawn as he draws it, across a 5 V ideal source.

After pressing Run, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window opens autoscaled with all four steps overlaid instead of the saved view. The spectrum is a second view of the same data and is not reached by Ctrl+Space: run the simulation, open View > FFT, select `V(out)`, set the windowing function to Hann, and then load [Twin-tee oscillator distortion trim spectrum.plt](01%20-%20Twin-tee%20oscillator%20distortion%20trim/Twin-tee%20oscillator%20distortion%20trim%20spectrum.plt) with Plot Settings > Open Plot Settings File.
