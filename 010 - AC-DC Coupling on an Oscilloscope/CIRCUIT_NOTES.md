# Video 10: AC / DC Coupling on an Oscilloscope

Source: Alan Wolke (W2AEW), [#10: AC / DC Coupling on an Oscilloscope](https://www.youtube.com/watch?v=Hkq-fvb5-NI).

| Time | What Alan shows |
| --- | --- |
| [0:40](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=40s) | A multimeter's AC and DC ranges, which is the comparison the whole video sets out to correct: a scope's AC and DC positions are not the meter's AC and DC functions. |
| [1:58](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=118s) | Close-up of the breadboard and the clip leads feeding the scope probes. |
| [2:30](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=150s) | The CH1 front panel, with the AC - GND - DC coupling switch and the 1 M / 50 ohm input selector beside it. This switch is what both circuits here model. |
| [3:16](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=196s) | DC coupled on the 2465A: the trace is parked several divisions above the center line and the ripple is no more than a thickening of it. |
| [3:46](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=226s) | The same node AC coupled at the same setting: the trace drops to the baseline and is still almost flat, because the ripple is small. |
| [3:55](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=235s) | The gain turned up on that baseline trace, and the rectifier's ripple finally appears as a sawtooth filling several divisions. |
| [4:16](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=256s) | Draws "SIMPLE HALF-WAVE RECTIFIER, DC SUPPLY", the circuit in [01 - Half-wave rectifier supply](<01 - Half-wave rectifier supply/>). |
| [5:00](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=300s) | Two sine traces on the screen together, the amplifier's input and its output. |
| [5:06](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=306s) | Draws "SIMPLE AMPLIFIER - GAIN =~ -2.5", the circuit in [02 - Simple amplifier](<02 - Simple amplifier/>). |
| [6:50](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=410s) | Returns to the amplifier drawing to point out where on it he is probing. |
| [7:35](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=455s) | The collector waveform with visibly flattened peaks, because his bench stage is driven harder than it can follow. |
| [8:40](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=520s) | The coupling switch once more, with both channels on screen. |

## What the coupling switch actually is

A scope's AC position puts a capacitor in series with the vertical input, ahead of the 1 Mohm input resistance. Nothing is rectified and nothing is averaged. The capacitor simply charges up to whatever steady voltage is present and then passes only the changes, so the trace settles around the screen's zero line and the DC level is lost. The DC position shorts that capacitor out, so the trace shows the real voltage at the node, level and all.

Both schematics here model that switch literally, as `Cscope` into `Rscope`, and probe the same node twice: once directly and once through the capacitor. That is the whole comparison.

Two notes on the modeling, which apply to both circuits:

- A real scope couples through roughly 1 uF, which against 1 Mohm is a time constant of about a second. Simulating until that has settled is impractical, so `Cscope` is 100 nF here, giving 100 ms. At 1 kHz its reactance is about 1.6 kohm against a 1 Mohm load, so it still passes the signal essentially untouched; only the settling time changes.
- Each run is `.tran 0 1 990m 1u`, which simulates a full second but saves only the last 10 ms. That is long enough for the coupling capacitor to finish charging, so the AC-coupled trace is genuinely centered rather than still drifting down toward zero. Because the saved window starts at 990 ms, the waveform viewer's horizontal axis runs 0 to 10 ms rather than 990 ms to 1 s.

If the waveform window opens autoscaled instead of using the saved panes, press Ctrl+Space (Plot Settings > Reload Plot Settings).

## 01 - Half-wave rectifier supply

[`01 - Half-wave rectifier supply/Half-wave rectifier supply.asc`](<01 - Half-wave rectifier supply/Half-wave rectifier supply.asc>), introduced at [4:16](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=256s).

![Half-wave rectifier supply schematic](<01 - Half-wave rectifier supply/Half-wave rectifier supply schematic.png>)

Alan's drawing is an AC source, one diode, and a resistor and capacitor to ground: the crudest possible DC supply. He writes no values on it at all, so the 10 V peak at 1 kHz, the 1N4148, the 1 kohm load and the 10 uF smoothing capacitor are all chosen here. The topology is his.

`Cscope` and `Rscope` hang off the supply node as a second probe, standing for the same scope input switched to AC coupling.

![Half-wave rectifier supply coupling comparison](<01 - Half-wave rectifier supply/Half-wave rectifier supply coupling comparison.png>)

The top pane is the DC-coupled view, plotted against a 0 V to 11 V axis so the reader can see where the trace sits relative to ground. The supply is about 8.8 V with a small sawtooth on top, and at this scale the ripple is a thin fuzz on the line. That is exactly the problem the AC position solves.

The bottom pane is the AC-coupled view of the same node, on a 1.2 V window instead of an 11 V one. The 8.8 V has gone and the sawtooth fills the screen: a slow discharge through the load while the diode is off, then a fast recharge as the source peak comes round.

![Half-wave rectifier supply SPICE output log](<01 - Half-wave rectifier supply/Half-wave rectifier supply SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `supply_avg` | 8.844 V |
| `supply_max` | 9.241 V |
| `supply_min` | 8.440 V |
| `ripple_pp` | 0.801 V |
| `ac_avg` | 0.0004 V |
| `ac_pp` | 0.801 V |

The pair that matters is the last three. `ripple_pp` and `ac_pp` are both 0.801 V, so AC coupling has not attenuated or reshaped anything, and `ac_avg` is 0.4 mV against the DC-coupled 8.844 V, so the level really is gone rather than merely shifted.

### Against Alan's screen

His instrument is a Tektronix 2465A, an analog scope with no on-screen readout, and he neither states his supply voltage nor the load and smoothing capacitor he used, so the volts per division and the absolute ripple cannot be recovered from the video. What his screen does give is the sequence, and it is worth following frame by frame because the two panes above are that sequence:

- At [3:16](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=196s), DC coupled, the trace is parked several divisions above the center line and the ripple is no more than a thickening of the line. That is the top pane here, where 0.801 V of sawtooth sits on 8.844 V and is a thin fuzz on an 11 V axis.
- At [3:46](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=226s) he moves the switch to AC. The trace drops to the baseline and is still nearly flat, because removing the level does not make a small signal large.
- At [3:55](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=235s) he turns the gain up on that baseline trace and the sawtooth fills several divisions. That is the bottom pane, and the change of vertical axis from 11 V to 1.2 V is the same act as his turning the volts-per-division knob.

The ratio is the part that carries across even though the volts do not. Here the level is eleven times the ripple, which is why nothing useful is visible until the level is gone; on his screen the proportion is much the same, a trace several divisions up carrying a ripple that is a fraction of one division. Expanding a signal you cannot first center is the problem AC coupling exists to solve.

## 02 - Simple amplifier

[`02 - Simple amplifier/Simple amplifier.asc`](<02 - Simple amplifier/Simple amplifier.asc>), introduced at [5:06](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=306s).

![Simple amplifier schematic](<02 - Simple amplifier/Simple amplifier schematic.png>)

Alan's drawing gives four values: 20K and 10K from VCC to ground as a base divider, 2K in the collector, and 390 ohm in the emitter. The input signal arrives by an arrow pointing straight at the divider node, with no coupling capacitor drawn, and the supply is marked only as VCC. The device type is not given, so a 2N3904 is used here.

Two things had to be chosen, and both are stated on the drawing itself:

- **The supply.** 12 V. The divider on its own would put the base at VCC/3, which with 390 ohm in the emitter and 2 kohm in the collector saturates the transistor at any ordinary supply voltage. Since the signal source is wired directly onto that node, as drawn, it is the source that fixes the base DC level and the divider only loads it. The source offset is 1.87 V, which puts the collector at mid rail.
- **The drive level.** 0.2 V amplitude at 1 kHz, small enough that the stage stays linear.

![Simple amplifier coupling comparison](<02 - Simple amplifier/Simple amplifier coupling comparison.png>)

The top pane is the collector DC coupled, on a 0 V to 13 V axis. A 2 V signal sits on a 5.9 V level, and most of the screen is spent showing how far that level is above ground. The middle pane is the same node through the coupling capacitor: identical signal, no level. The bottom pane is the base, so the inversion can be read off the drawing - the collector is at its peak where the base is at its trough.

![Simple amplifier SPICE output log](<02 - Simple amplifier/Simple amplifier SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `vc_avg` | 5.934 V |
| `vc_pp` | 1.991 V |
| `vb_pp` | 0.400 V |
| `ve_avg` | 1.187 V |
| `vac_avg` | 6.5 uV |
| `vac_pp` | 1.991 V |
| `gain` | 4.980 |

`vac_pp` equals `vc_pp` to four figures and `vac_avg` is 6.5 microvolts, so once again the coupling capacitor has removed the level and left the signal alone.

Two differences from the video are worth naming. First, the measured gain is 4.98, which is just `-Rc/(Re + re)`: 2 kohm over 390 ohm plus about 9 ohm of emitter resistance at 3 mA. Alan titles his drawing "GAIN =~ -2.5". His screen at [7:35](https://www.youtube.com/watch?v=Hkq-fvb5-NI&t=455s) shows a collector waveform with flattened peaks, so his stage is being driven past the point where it can follow the input, and a compressed stage measures a lower gain than its small-signal value. Second, the drive here is deliberately kept small so that the two coupling views differ only in their DC level and not in their shape; a clipped waveform would still demonstrate the coupling switch, but it would confuse the two effects.
