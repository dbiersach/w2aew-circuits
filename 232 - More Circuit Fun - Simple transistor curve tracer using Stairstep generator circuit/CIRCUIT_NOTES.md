# Video 232: Simple transistor curve tracer

Source: Alan Wolke (W2AEW), [#232: More Circuit Fun: Simple transistor curve tracer using Stairstep generator circuit](https://www.youtube.com/watch?v=ZOLLoa2fH24). His drawing for the lesson is kept here as [W2AEW Video Notes - curvetracer.pdf](<W2AEW Video Notes - curvetracer.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=15s) | The stairstep generator from [video 231](<../231 - Circuit Fun - Stairstep generator using 555 and op amps/CIRCUIT_NOTES.md>), which this video builds on. |
| [1:02](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=62s) | What a curve tracer is for: collector current against collector-emitter voltage, drawn once for each of several base currents, so the family of curves shows how the device behaves across its whole operating range at once. |
| [3:52](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=232s) | The complete circuit, with the generator page taped beside the new tracer page, reproduced in [01 - Transistor curve tracer](#01---transistor-curve-tracer). The parts list names general-purpose diodes, 2N3904 or 2N2222 NPNs, an LMC6482 or similar rail-to-rail op amp, and a 555. |
| [4:30](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=270s) | How the collector sweep is made: the 555's pulse discharges a 10 nF capacitor through a transistor, and a 100 kΩ resistor recharges it between pulses, so each clock period produces one sawtooth. |
| [6:00](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=360s) | The current mirror that carries the device's collector current and copies it into a sense resistor, so the current can be read as a voltage without putting a resistor in series with the device. |
| [6:45](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=405s) | The scope in X-Y mode showing the collector curves, with the schematic held up beside it. |
| [9:45](https://www.youtube.com/watch?v=ZOLLoa2fH24&t=585s) | The breadboarded tracer, and the curves it produces for a real transistor. |

## What the lesson establishes

A curve tracer answers a question a single measurement cannot: not "what is the gain at this bias" but "what does this device do everywhere". It needs three things working together, and the elegance of this circuit is that two of them come from a generator that already existed.

- **A stepped base current.** The staircase from video 231 drives the device's base through a large resistor, so each step is a different base current. Because the staircase is already synchronized to the 555, no extra timing is needed.
- **A fast collector voltage sweep, one per step.** The same 555 pulse that advances the staircase also dumps a small capacitor, which then recharges through a resistor. That gives one sawtooth per step, sweeping the device's collector from near zero up to the supply.
- **A way to see the collector current.** Putting a sense resistor in series with the collector would corrupt the voltage being swept. Instead a current mirror carries the collector current and reproduces it in a separate branch, where a resistor can turn it into a voltage without disturbing the device.

Feed the collector voltage to the scope's X input and the sense voltage to Y, and each sweep draws one curve. The staircase steps between sweeps, so the sweeps stack up into a family. Alan is straightforward about the result: the circuit is very basic and the curves are not perfect, but it works well enough for testing and matching transistors.

## 01 - Transistor curve tracer

[01 - Transistor curve tracer/Transistor curve tracer.asc](<01 - Transistor curve tracer/Transistor curve tracer.asc>) contains the whole thing, the video 231 generator and the tracer added to it, as Alan draws it. The shortcut [Video 232 - 01 - Transistor curve tracer.url](<01 - Transistor curve tracer/Video 232 - 01 - Transistor curve tracer.url>) opens the video where he presents it.

![LTspice schematic of the stairstep generator and curve tracer](<01 - Transistor curve tracer/Transistor curve tracer schematic.png>)

The left two thirds are the generator covered in video 231. The tracer is on the right:

| Part | Value | Role |
| --- | ---: | --- |
| `R15` / `C6` | 100 kΩ / 10 nF | The collector sweep: C6 recharges through R15 between clock pulses |
| `R16` / `Q3` | 3.9 kΩ / 2N3904 | The 555 pulse dumps C6 through Q3 at the start of each sweep |
| `U3`, `R17`, `R18` | LMC6482A, 3.9 kΩ, 10 kΩ | Amplifies the sawtooth to drive the mirror |
| `Q4` / `Q5` | 2N3906 pair | Current mirror: Q4 feeds the device, Q5 copies that current |
| `R19` | 270 Ω | Turns the mirrored current into the sense voltage `Y` |
| `R20` | 470 kΩ | Converts the staircase voltage into the device's base current |
| `QDUT` | 2N3904 | The device under test, emitter grounded, collector at `X` |

Because `QDUT`'s emitter is grounded, node `X` is its collector-emitter voltage directly. Node `Y` is the sense voltage, so the collector current is approximately `V(Y)` divided by 270 Ω. Alan's parts list names the NPNs and the op amp, so those are his; the PNP mirror pair is not named, and the 2N3906 is a simulation choice.

### What the simulation shows

The run is `.tran 0 16.6m 11.2m 1u`, which saves exactly one staircase between two resets, so the figures show one complete family rather than several overlaid. `.option plotwinsize=0` keeps every simulated point, which matters for the X-Y view. The reset timing itself is covered in video 231's chapter.

![Stairstep base drive, collector sweep and sense voltage against time](<01 - Transistor curve tracer/Transistor curve tracer LTspice waveforms.png>)

Read top to bottom, the three panes are the mechanism. `V(OUT)` climbs one step per clock, reaching 8.99 V. `V(X)` is one sawtooth per clock, peaking at 7.80 V, so every step gets its own sweep. `V(Y)` holds the shape of one sweep's collector current, and the level it reaches grows with each step.

| Measurement | Result | Meaning |
| --- | ---: | --- |
| `STEP_V` | 8.989 V | Top of the staircase |
| `IB_MAX` | 19.1 µA | The largest base current, as `STEP_V` through the 470 kΩ |
| `VX_MAX` | 7.80 V | How far the collector sweep reaches |
| `VY_MAX` | 1.587 V | Largest sense voltage |
| `IC_MAX` | 5.88 mA | The matching collector current, as `VY_MAX` over 270 Ω |

Those two currents are worth putting side by side: 5.88 mA of collector current at 19.1 µA of base current is a current gain of about 308, which is a plausible figure for a 2N3904 at a few milliamps and is the number the top curve of the family encodes.

![Collector curves: sense voltage against collector voltage](<01 - Transistor curve tracer/Transistor curve tracer LTspice XY curves.png>)

This is the X-Y view, and it is the picture the whole circuit exists to produce. It is saved separately as [Transistor curve tracer XY.plt](<01 - Transistor curve tracer/Transistor curve tracer XY.plt>), because an X-Y plot and a time plot cannot live in one settings file; load it with **Plot Settings > Open Plot Settings File**.

Each trace is one base-current step. The steep rise at the left is saturation, where the device cannot support much collector-emitter voltage yet; the knee is where it enters the active region; and the long, nearly flat run to the right is the active region proper, where collector current depends mostly on base current and only weakly on collector voltage. That weak dependence is visible as the slight upward slope of each curve, which is the Early effect.

The one artifact to ignore is the diagonal line crossing the family from the lower left to the upper right. That is the trace between sweeps, when the sweep capacitor is being dumped while the staircase steps. LTspice draws every simulated point, so the transition shows up; a real scope in X-Y mode draws it too, usually faintly.

## Simulation against Alan's bench

Alan quotes no numbers for his build, so there is nothing numerical to compare. What can be compared is the shape of the result, and the family here has the same character as his: a tight bundle of curves near the origin, a clear knee, and a fan of flat lines spreading with base current.

He is also candid about the circuit's limits, and the simulation shows the same ones. The sweep does not reach the supply rail, stopping at 7.80 V rather than 9 V, because the capacitor is still charging when the next pulse dumps it. The curve spacing is not even, because the staircase steps are even in voltage but the device's gain is not constant across that range. And the mirror is only approximate, so `V(Y)` over 270 Ω is close to the collector current rather than equal to it. None of that stops the circuit doing what it is for, which is comparing one transistor against another.
