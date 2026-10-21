# Video 87: Schmitt trigger RC oscillator

Source: Alan Wolke (W2AEW), [#87: Schmitt Trigger Oscillator / Tutorial / 74AC14 Inverter / squarewave generator](https://www.youtube.com/watch?v=NuXitMK3HSA).

| Time | What Alan shows |
| --- | --- |
| [0:30](https://www.youtube.com/watch?v=NuXitMK3HSA&t=30s) | What a Schmitt trigger is, and the two things it is used for: cleaning up a slow or noisy logic input, and making oscillators. |
| [1:40](https://www.youtube.com/watch?v=NuXitMK3HSA&t=100s) | The transfer characteristic, with the two switching thresholds and the hysteresis between them. |
| [2:46](https://www.youtube.com/watch?v=NuXitMK3HSA&t=166s) | He draws the oscillator itself, the circuit reproduced in [01 - Schmitt trigger RC oscillator](#01---schmitt-trigger-rc-oscillator). |
| [4:18](https://www.youtube.com/watch?v=NuXitMK3HSA&t=258s) | Why the frequency depends on the device: the output swing and the threshold positions both enter it, and a 74AC14 gives faster edges than a 74HC14. |
| [5:18](https://www.youtube.com/watch?v=NuXitMK3HSA&t=318s) | The parts on the bench, where he names the 74AC14 with roughly 6.8 kohm of feedback and a 47 nF timing capacitor. |
| [6:10](https://www.youtube.com/watch?v=NuXitMK3HSA&t=370s) | The scope, showing the timing capacitor ramping between the thresholds. |

## What the lesson establishes

An inverting Schmitt gate has two input thresholds rather than one. Tie its output back to its input through a resistor and hang a capacitor on the input, and it cannot settle: the capacitor charges toward whatever the output is doing until it crosses a threshold, the output flips, and the capacitor starts charging the other way. The result is a square wave at the output and a triangular ramp on the capacitor, with no need for a separate timing reference.

The frequency is set by the resistor and capacitor together with **the device's own thresholds and output levels**, which is the point Alan makes at 4:18. That is why this is a two-part oscillator whose frequency you cannot calculate from R and C alone, and why he mentions the 74AC14 specifically: the part's hysteresis band and how close its output gets to the rails both move the answer.

## 01 - Schmitt trigger RC oscillator

[Schematic](<01 - Schmitt trigger RC oscillator/Schmitt trigger RC oscillator.asc>) - [Saved plot settings](<01 - Schmitt trigger RC oscillator/Schmitt trigger RC oscillator.plt>) - [Video at 2:46](<01 - Schmitt trigger RC oscillator/Video 087 - 01 - Schmitt trigger RC oscillator.url>)

![Schmitt trigger RC oscillator schematic copied from LTspice](<01 - Schmitt trigger RC oscillator/Schmitt trigger RC oscillator schematic.png>)

`Rfeedback` is 6.8 kohm and `Ctiming` is 47 nF, the two values Alan states at 5:18. `Rload` at 100 kohm and the 5 V logic levels are assumptions; Alan does not say what the output drives.

**The gate is a labelled proxy, not a 74AC14.** `A1` is LTspice's behavioural `Digital\schmtinv` with `Vt=2.5`, `Vh=0.7`, `Vhigh=5` and `Vlow=0`, which puts its thresholds at 1.8 V and 3.2 V. Those are assumed numbers, not the real part's. Texas Instruments does publish an SN74AC14 model, kept at [`LTspice/Models/Texas-Instruments/SN74AC14.cir`](<../LTspice/Models/Texas-Instruments/SN74AC14.cir>), and it parses in LTspice, but its input subcircuit presents an effective 2.4e-05 ohm shunt to ground, which holds the input near zero so the oscillator will not start. That is why the proxy is used here and why the frequency below is a property of the model rather than a measurement of Alan's build.

![Schmitt oscillator output and timing capacitor, copied from LTspice](<01 - Schmitt trigger RC oscillator/Schmitt oscillator output.png>)

The top pane is `V(OUT)`, the square wave; the bottom pane is `V(RC)`, the timing capacitor. The view covers 1.0 ms to 2.5 ms, four full cycles after the start-up transient has passed. Each output edge happens exactly where the ramp reaches a threshold, which is the mechanism in one picture.

| `.meas` result | Value | What it means |
| --- | ---: | --- |
| `VRC_UPPER` | 3.200 V | the upper threshold the ramp turns around at |
| `VRC_LOWER` | 1.800 V | the lower threshold, 1.4 V of hysteresis below it |
| `PERIOD` | 367.81 us | measured between two successive rising output edges |
| `FREQ` | 2.719 kHz | the reciprocal of that period |

The measured period agrees with the RC prediction for these thresholds. Charging 47 nF through 6.8 kohm between 1.8 V and 3.2 V from a 5 V swing gives `R*C*ln((5-1.8)/(5-3.2) * 3.2/1.8)`, which is 367.9 us against the simulated 367.81 us. That agreement is a check that the model is behaving as the arithmetic says, not evidence about the real 74AC14: change the thresholds and the same R and C give a different frequency, which is exactly Alan's point.

## Running this in LTspice

Open the schematic and press Run. If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up the saved `.plt`, which sets the two panes and the 1.0 ms to 2.5 ms window. The `.meas` results appear in View > SPICE Output Log. The `.ic V(RC)=0` directive starts the capacitor discharged so the first cycle is predictable.
