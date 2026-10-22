# Video 157: Automatic audio leveling circuit

Source: Alan Wolke (W2AEW), [#157: Circuit fun: Automatic audio leveling circuit | audio compressor | for scanning receiver](https://www.youtube.com/watch?v=1h0FZJYXQ_w). The Eagle schematic he supplies is kept here as [W2AEW Video Notes - audioleveler_sch.pdf](<W2AEW Video Notes - audioleveler_sch.pdf>); its title block credits the design to W2AEW and the PCB to SM6XUN.

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=1h0FZJYXQ_w&t=15s) | The problem on a scope: audio from a scanning receiver arrives at wildly different levels as it steps from channel to channel, so anything comfortable on one is too loud or too quiet on the next. |
| [1:00](https://www.youtube.com/watch?v=1h0FZJYXQ_w&t=60s) | The circuit drawn out, reproduced in [01 - Discrete audio leveler](#01---discrete-audio-leveler). |
| [3:00](https://www.youtube.com/watch?v=1h0FZJYXQ_w&t=180s) | The six diodes identified as 1N34A germanium, which matters because their low forward drop is what lets the shunt work on audio-sized signals. |
| [5:20](https://www.youtube.com/watch?v=1h0FZJYXQ_w&t=320s) | The circuit working on the bench, with the output holding steady while the input is varied. |
| [7:36](https://www.youtube.com/watch?v=1h0FZJYXQ_w&t=456s) | The control voltage settling after the input jumps, which is the attack behaviour rather than the steady-state compression. |
| [11:34](https://www.youtube.com/watch?v=1h0FZJYXQ_w&t=694s) | The input stepped between two levels at 200 ms per division, so attack and release can both be seen in one picture. |

## What the lesson establishes

A compressor needs three parts: something to measure how loud the signal is, something to remember that measurement between syllables, and something to turn the measurement back into a change in gain. This circuit does all three with two transistors and six diodes, and no op amps at all.

- **Measure.** C3 couples the audio into a rectifier made from D1 and D2, with Q1 wired as a diode to set the bias so the pair sits just below conduction with no signal. Larger audio means more rectified current.
- **Remember.** That current charges C4 quickly and R4 drains it slowly, so the control voltage follows the signal's envelope upward fast and downward slowly. Fast attack stops a sudden loud passage getting through; slow release keeps the gain from pumping between words.
- **Change the gain.** The control voltage drives Q2 through R5, and Q2's collector current forward biases D3, which puts a low resistance across the signal path. Louder input, more current, lower shunt resistance, less signal through. D4 completes the shunt's return and D5 and D6 clamp whatever is left.

The germanium diodes matter throughout. A silicon diode needs around 0.6 V before it conducts at all, which is larger than the audio being handled; germanium starts conducting at around 0.2 V, so the rectifier and the shunt both work at speaker level.

## 01 - Discrete audio leveler

[01 - Discrete audio leveler/Discrete audio leveler.asc](<01 - Discrete audio leveler/Discrete audio leveler.asc>) follows the drawing Alan works through from 1:00, with the shortcut [Video 157 - 01 - Discrete audio leveler.url](<01 - Discrete audio leveler/Video 157 - 01 - Discrete audio leveler.url>) opening the video there.

![LTspice schematic of the discrete audio leveler](<01 - Discrete audio leveler/Discrete audio leveler schematic.png>)

The two sources differ in two places, and the schematic follows the video drawing because that is what this chapter is about:

| | Video drawing | Supplied PDF |
| --- | --- | --- |
| Control hold capacitor | 470 nF | 2.2 µF |
| Reference designators | 240 kΩ is R4, 100 Ω is R5 | the two labels are the other way round |

The hold capacitor is the one that matters, because with the 240 kΩ drain it sets the release time: 113 ms with 470 nF, 528 ms with 2.2 µF. Alan's stepped-input demonstration at 11:34 runs at 200 ms per division and the control voltage takes most of a division to come back down, which fits the larger capacitor better than the smaller one. The PDF is his Eagle file for the built board, so that is not surprising; the figure below uses the video's value.

D1 to D6 are the 1N34A he names at 3:00, simulated with a [legacy germanium model](<../LTspice/Models/Unverified/1N34A_legacy.lib>) copied from an old LTspice library. Its provenance is unverified: Central Semiconductor publishes a 1N34A datasheet but no SPICE model in its documentation links, so this is a generic germanium approximation rather than a fit to the part Alan used. The transistors are LTspice's bundled 2N3904, which is the part on both of his drawings.

The input amplitudes are a simulation choice. Alan drives his from a receiver, so there is no stated level; the four stepped values here span 0.2 V to 4.0 V peak to peak, a twenty to one range, to see what the circuit does with it.

### What the simulation shows

The run is `.tran 0 100m 50m 2u` at 1 kHz, measured over the saved 50 ms once the control voltage has settled. Extending the run to 900 ms moves the results by less than 0.2%, so the window is long enough.

![Input at both extremes above, the leveled output below](<01 - Discrete audio leveler/Discrete audio leveler response.png>)

If the waveform window opens autoscaled with all four steps overlaid, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Discrete audio leveler.plt](<01 - Discrete audio leveler/Discrete audio leveler.plt>), which shows only the first and last of them.

| `INPUT_PP` | `OUTPUT_PP` |
| ---: | ---: |
| 0.200 V | 36.4 mV |
| 1.000 V | 47.7 mV |
| 2.000 V | 41.8 mV |
| 4.000 V | 38.4 mV |

A twenty to one change at the input becomes a 1.3 to one change at the output, and the output never leaves the 36 to 48 mV band. Alan's own schematic is annotated "Output ca. 50 mVpp", so the simulated circuit lands where his built one is specified to.

The output is not monotonic in the input, and that is worth noticing rather than smoothing over: it peaks at 1 V of drive and comes back down on either side. Below that the shunt is barely conducting and the output follows the input; above it the loop is well into compression and tightens slightly as the drive grows. The 1 V point is where the loop is just taking hold.

What this figure does not show is the dynamics. The four steps are each a steady tone, so the control voltage has settled in every one of them. Alan's attack and release behaviour at 7:36 and 11:34 needs an input that changes level, which is a different stimulus from the one used here.
