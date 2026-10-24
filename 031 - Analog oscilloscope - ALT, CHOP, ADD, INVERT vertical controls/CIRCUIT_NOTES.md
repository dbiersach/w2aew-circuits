# Video 31: Analog oscilloscope ALT, CHOP, ADD, INVERT vertical controls

Source: Alan Wolke (W2AEW), [#31: Analog oscilloscope ALT, CHOP, ADD, INVERT vertical controls](https://www.youtube.com/watch?v=zsy-pxpfB4o).

| Time | What Alan shows |
| --- | --- |
| [0:30](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=30s) | Working the vertical mode buttons with a single channel on screen. |
| [1:00](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=60s) | The CH1 panel with CH1, ALT, CHOP, ADD and X-Y in a row, which is the set of controls the video is about. |
| [4:03](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=243s) | Two traces on screen together in CHOP, both the same way up. |
| [4:10](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=250s) | Draws the circuit in [01 - Phase splitter](<01 - Phase splitter/>), the source of the two signals he probes. |
| [5:30](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=330s) | Checking the DC levels on the breadboard with a Fluke 87. |
| [6:10](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=370s) | The four readings the meter settles on, one after another: 0.980 V at the emitter, 1.626 V at the base, 4.000 V at the collector and 3.021 V across collector to emitter. |
| [7:51](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=471s) | Two flat traces while he sets each channel's baseline before combining them. |
| [9:15](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=555s) | The collector and the emitter together, one the mirror image of the other. |
| [9:40](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=580s) | A single trace after ADD with INVERT CH2, visibly larger than either channel was. |

## What the four controls do

ALT and CHOP are only about how one electron beam is shared between two channels. In ALT the scope draws a whole sweep of CH1, then a whole sweep of CH2, alternating; in CHOP it switches between them many times within a single sweep. Both show two traces, and neither changes the signals, so neither can be simulated: they are a property of the display, not of the circuit.

ADD and INVERT are different. ADD sends the sum of the two channels to the one beam, and INVERT CH2 flips the sign of CH2 before that sum is taken. Together they turn a two-channel scope into something that shows the voltage difference between two points, which is the part the simulation here reproduces.

## 01 - Phase splitter

[`01 - Phase splitter/Phase splitter.asc`](<01 - Phase splitter/Phase splitter.asc>), introduced at [4:10](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=250s).

![Phase splitter schematic](<01 - Phase splitter/Phase splitter schematic.png>)

Alan needs two signals that are related in a way worth measuring, and he builds the simplest circuit that produces them. His drawing gives +5 V, a 20K and 10K divider on the base, 2.2K in the collector and 2.2K in the emitter, with the generator coupled in through a capacitor whose value he does not write down.

Making the collector and emitter resistors equal is the whole trick. The collector gain is `-Rc / (Re + re)` and the emitter gain is `+Re / (Re + re)`, so with Rc equal to Re the two outputs have the same size and opposite sign. A circuit built to do this deliberately is called a phase splitter.

Three values had to be chosen because the drawing does not give them, and all three are stated on the schematic: the 1 uF coupling capacitor, the 0.5 V amplitude and the 1 kHz. His scope is an analog Tektronix with no on-screen readout, and he neither states the generator settings nor turns the knobs to camera, so the drive level and frequency cannot be recovered from the video the way a digital scope's readout would give them. The amplitude matters. The divider puts the base at 1.65 V, which sets the emitter near 1.0 V and the collector near 4.0 V, so the collector has only about 1 V of room before it runs into the 5 V rail. At 0.5 V amplitude both outputs stay clean.

The bias point is a different matter, because Alan measures all of it with a Fluke 87 at [6:10](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=370s) and the digits are unambiguous. That is the part of this circuit the simulation can be checked against directly, and it is checked in [the table below](#where-the-simulation-and-the-bench-differ).

### What the three panes show

![Phase splitter ADD and INVERT](<01 - Phase splitter/Phase splitter ADD and INVERT.png>)

All three panes share one 0 V to 5.5 V axis so the comparison is direct, and the horizontal axis is the last 5 ms of a 50 ms run, five cycles of the 1 kHz input.

The top pane is the two channels as the scope shows them in ALT or CHOP: the collector riding on 3.99 V and the emitter riding on 1.02 V, the same amplitude and mirror images of each other.

The middle pane is ADD with CH2 the right way up. The two signals are equal and opposite, so they cancel, and what is left is a flat line at 5.0 V, which is just the two DC levels added together. On the same axis that held two 1 V signals a moment ago there is now nothing moving at all.

The bottom pane is ADD with INVERT CH2, which subtracts instead. Now the two signals reinforce and the result is twice the size of either one. This is the pane that corresponds to Alan's screen at [9:40](https://www.youtube.com/watch?v=zsy-pxpfB4o&t=580s), where a single trace appears that is larger than either channel had been.

![Phase splitter SPICE output log](<01 - Phase splitter/Phase splitter SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `vb_avg` | 1.6516 V |
| `vc_avg` | 3.9864 V |
| `ve_avg` | 1.0186 V |
| `vce_avg` | 2.9678 V |
| `vc_pp` | 0.9668 V |
| `ve_pp` | 0.9716 V |
| `sum_pp` | 0.0048 V |
| `diff_pp` | 1.9384 V |

The two channel amplitudes agree to within half a percent, which is why `sum_pp` comes out at 4.8 mV against the 967 mV in either channel: a cancellation of about 200 to 1. `diff_pp` is 1.9384 V, which is `vc_pp + ve_pp` to four figures.

This is also why the technique is useful rather than merely clever. Neither 3.99 V nor 1.02 V is interesting on its own, and no single probe can show the difference between them, but ADD with INVERT displays that difference directly without a differential probe.

### Where the simulation and the bench differ

The bias point can be compared node for node, because Alan reads every one of them off the Fluke 87:

| Node | Alan's Fluke 87 | Simulated | Difference |
| --- | ---: | ---: | ---: |
| Emitter | 0.980 V | 1.019 V | 39 mV |
| Base | 1.626 V | 1.652 V | 26 mV |
| Collector | 4.000 V | 3.986 V | 14 mV |
| Collector to emitter | 3.021 V | 2.968 V | 53 mV |

Every node agrees to within 4 percent, and the pattern of the differences is consistent: the model sits a little further forward in conduction than his transistor did, so its base and emitter are slightly high and its collector slightly low. Resistor tolerance alone would account for most of it, since 5 percent parts are normal on a breadboard and the divider sets the base before the transistor has any say. The important point is that the operating region is the same one, with about 3 V across the device and roughly 0.45 mA through the two 2.2K resistors, so the small-signal behavior the rest of this chapter depends on is the behavior he had on the bench.

The AC side cannot be compared in the same way. The generator settings are not recoverable, so the amplitudes here are set by the chosen 0.5 V drive rather than matched to his screen; what can be compared is the shape, and his screen shows what the top pane does: two equal traces, mirrored about their own DC levels.

Alan's cancellation is also not as complete as 200 to 1, because on the bench the two channels have to be matched by hand. Their volts-per-division settings, their variable gain controls and the two probes themselves all have to agree before the signals will cancel, and the scope's own position controls shift each trace independently. The simulation subtracts two node voltages exactly, so it shows the best the circuit can do rather than the best the instrument can do. The residual on Alan's screen is a measure of how well he matched his two channels; the 4.8 mV here is a measure of how well the two resistors match, and nothing else.
