# Video 273: Common Emitter Amplifier Design Tips

Source: [Alan Wolke (W2AEW), video #273](https://youtu.be/VWY2WQcKJgk)

| Time | What Alan shows |
| --- | --- |
| [9:40](https://www.youtube.com/watch?v=VWY2WQcKJgk&t=580s) | [LTspice examples and model scope](#ltspice-examples-and-model-scope) |

Alan uses a physical common-emitter test circuit to explain Class A bias point choice and gain shortcuts. The [original three-page notes](W2AEW%20Video%20Notes%20-%20common_emitter_tips.pdf) show a 12 V 2N2222A stage with a 33 kΩ / 3.3 kΩ base divider, a 1.2 kΩ emitter resistor, a variable collector resistor (examples 20 kΩ and 4.7 kΩ), 2.2 µF input coupling capacitor, and optional 47 µF emitter bypass capacitor. The bench test feeds a 10 kHz signal through a 10× attenuator and uses a 50 Ω termination.

With the emitter resistor unbypassed, the small-signal voltage gain magnitude is approximately R_C/R_E and the feedback improves linearity. Bypassing the emitter resistor raises gain; the rough gain magnitude is g_m R_C, where g_m is set by the quiescent collector current. That configuration is more susceptible to distortion. The collector resistor and bias point must allow sufficient voltage swing before cutoff or saturation.

## LTspice examples and model scope

- [01: Unbypassed emitter resistor](01%20-%20Unbypassed%20emitter%20resistor/Unbypassed%20emitter%20resistor.asc) keeps the 1.2 kΩ emitter feedback resistor active for AC. Open its [saved plot](01%20-%20Unbypassed%20emitter%20resistor/Unbypassed%20emitter%20resistor.plt) or [Alan's 9:40 explanation](https://www.youtube.com/watch?v=VWY2WQcKJgk&t=580s).
- [02: Bypassed emitter resistor](02%20-%20Bypassed%20emitter%20resistor/Bypassed%20emitter%20resistor.asc) places Alan's 47 µF capacitor across that resistor. Open its [saved plot](02%20-%20Bypassed%20emitter%20resistor/Bypassed%20emitter%20resistor.plt) or [Alan's 14:53 demonstration](https://www.youtube.com/watch?v=VWY2WQcKJgk&t=893s). Both examples retain the 12 V supply, 33 kΩ/3.3 kΩ base divider, 4.7 kΩ collector resistor, 2.2 µF input coupling capacitor, and a 10 kHz test signal. The collector resistor is one of the values in Alan's notes; the 20 kΩ alternative is not shown here.

The simulation uses LTspice's built-in **2N2222** model because a verified manufacturer 2N2222A model was not available in the project or local component libraries. Alan specifies **2N2222A**; the model difference can affect exact bias and gain. The 2.5 mV peak source gives approximately 5 mV peak to peak at the coupled input, matching Alan's stated bench input after his 10× attenuator. The attenuator itself is simplified to this input level. The collector output is DC coupled in these examples; the LTspice plots retain its actual DC voltage. These are circuit teaching examples, not an exact prediction of Alan's physical transistor or generator.

## Simulated result

### Unbypassed emitter resistor

![LTspice unbypassed emitter-resistor schematic](01%20-%20Unbypassed%20emitter%20resistor/Unbypassed%20emitter%20resistor%20schematic.png)

![LTspice unbypassed input and collector-output waveforms](01%20-%20Unbypassed%20emitter%20resistor/Unbypassed%20emitter%20resistor%20waveforms.png)

![LTspice unbypassed Fourier distortion and gain measurements](01%20-%20Unbypassed%20emitter%20resistor/Unbypassed%20emitter%20resistor%20SPICE%20output%20log.png)

### 47 µF emitter bypass capacitor

![LTspice bypassed emitter-resistor schematic](02%20-%20Bypassed%20emitter%20resistor/Bypassed%20emitter%20resistor%20schematic.png)

![LTspice bypassed input and collector-output waveforms](02%20-%20Bypassed%20emitter%20resistor/Bypassed%20emitter%20resistor%20waveforms.png)

![LTspice bypassed Fourier distortion and gain measurements](02%20-%20Bypassed%20emitter%20resistor/Bypassed%20emitter%20resistor%20SPICE%20output%20log.png)

Each LTspice graph has the coupled base voltage in its top pane and collector voltage below. The vertical scales differ: read the actual node voltage on each axis, and compare the peak-to-peak values in the log to calculate gain. The collector falls when the base voltage rises, so the output is inverted. Without the bypass, emitter feedback limits the gain; the measured input and output swings are 4.911 mV and 18.096 mV peak to peak, giving a magnitude gain of **3.68**. With the 47 µF bypass, the swings are 4.896 mV and 331.1 mV peak to peak, giving **67.6**. The waveform shapes look similar at this scale, so the plots alone do not make the distortion difference clear. These gain numbers come from LTspice's `.meas` log and depend on the built-in transistor model. Alan's bench measurements of approximately 3.9 and 78.8 (predicted, before measuring the bypassed stage) are comparison points, not values asserted by this simulation.

### Quantifying the distortion

Both schematics also run `.four 10k 10 5 V(out)`. LTspice analyzes the **last five complete 10 kHz cycles** (1.5 to 2.0 ms), measures the 10 kHz fundamental and harmonics through 100 kHz, and reports total harmonic distortion (THD) in the SPICE output log. THD is the combined harmonic voltage divided by the fundamental voltage. It measures the output's departure from a pure sine wave; it does not require the waveform to look clipped.

| Emitter resistor | Input swing | Output swing | Gain magnitude | LTspice output THD |
| --- | ---: | ---: | ---: | ---: |
| Unbypassed | 4.911 mV peak to peak | 18.096 mV peak to peak | 3.68 | **0.217%** |
| Bypassed with 47 µF | 4.896 mV peak to peak | 331.1 mV peak to peak | 67.6 | **2.270%** |

At essentially the same input swing, the bypassed circuit produces about **10.5 times the THD**. Its 20 kHz second harmonic is about 2.27% of the 10 kHz fundamental, and therefore accounts for nearly all its reported THD. The emitter bypass removes most AC negative feedback, so transistor nonlinearity has more effect on the collector waveform while gain increases. The 2.27% result is measurable distortion, but it is modest enough that a visual comparison of the two plots can be unconvincing. This comparison holds the input level fixed; it does not compare the circuits at equal output swing. The numbers are predictions of the LTspice 2N2222 model and this test setup, not measurements of Alan's physical transistor.

The emitter resistor still sets the DC operating point in the bypassed example, because the capacitor blocks DC. At 10 kHz it substantially shunts the resistor for AC, so local negative feedback falls and the gain rises. The measured values should be read as an illustration of Alan's design point, not as a replacement for checking his board's bias and distortion on the bench. The two timestamped video shortcuts begin at Alan's explanation of the unbypassed case (about 9:40) and his insertion of the bypass capacitor (about 14:53).

Each saved LTspice plot puts the coupled input in the top pane and the collector output in the bottom pane, with a separate voltage scale for each signal. The input source is V1 and the supply is V2, in their left-to-right schematic order.
