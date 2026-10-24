# Video 105: Three-transistor sawtooth generator

Source: Alan Wolke (W2AEW), [#105: More Circuit Fun: Simple 3 transistor sawtooth generator / oscillator](https://www.youtube.com/watch?v=2a1I1X3RV0g).

| Time | What Alan shows |
| --- | --- |
| [0:05](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=5s) | The finished oscillator on a breadboard, three transistors and a handful of passives. |
| [0:10](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=10s) | The op-amp and diode-bridge sawtooth generator from his previous lesson, for contrast. A viewer had asked whether the same waveform could be made from plain NPN and PNP transistors. |
| [0:26](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=26s) | The answer, drawn in full: a 9 V supply, a PNP current source, a 10 nF timing capacitor and a two-transistor regenerative reset. |
| [0:40](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=40s) | The current source. A 1 kΩ / 10 kΩ divider holds the PNP base near 8.2 V, and the 10 kΩ emitter resistor turns the small remaining headroom into a charging current of roughly 30 µA. |
| [1:28](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=88s) | The regenerative pair: a second PNP whose emitter watches the capacitor, and an NPN whose collector pulls the PNP's own base reference down. Each transistor turns the other on harder, so the reset is abrupt. |
| [2:04](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=124s) | The 10 kΩ / 10 kΩ divider that sets the trip point at half the supply. |
| [2:48](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=168s) | The expected waveform sketched under the circuit: a long linear rise and a near-vertical fall. |
| [3:16](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=196s) | The breadboarded circuit with scope probes on the capacitor and on the reset node. |
| [3:56](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=236s) | The result on a Tektronix scope: a clean sawtooth at 1 V/div and 250 µs/div, with the counter reading 801.301 Hz. |

## What the lesson establishes

This is the minimal version of the idea Alan develops at length in [video 104](<../104 - Circuit tutorial - sawtooth generator with current sources, diode switches, hysteresis comparator/CIRCUIT_NOTES.md>). A capacitor fed from a constant current ramps linearly at `I/C` volts per second; if something discharges it quickly whenever it reaches a fixed voltage, the result repeats as a sawtooth. Video 104 does the charging, the discharging and the threshold detection with current sources, a diode bridge and an op-amp comparator. Here all three jobs are done by three bipolar transistors.

Two mechanisms carry the lesson:

- **A PNP current source.** The 1 kΩ / 10 kΩ divider pins the base, and the emitter sits one base-emitter drop above it. Whatever is left between the emitter and the 9 V rail appears across the 10 kΩ emitter resistor, and that fixes the emitter current. Because the collector current then barely depends on the collector voltage, the capacitor sees a nearly constant current and its voltage climbs in a straight line.
- **A regenerative reset instead of a comparator.** The second PNP's emitter sits on the capacitor and its base sits on the 10 kΩ / 10 kΩ divider at half supply. When the ramp climbs a base-emitter drop above that divider, the PNP begins to conduct and feeds the NPN's base. The NPN pulls the divider node down, which increases the PNP's emitter-base bias, which drives the NPN harder. The loop runs away in a fraction of a microsecond, dumps the capacitor, and then starves itself once the capacitor is empty.

The threshold divider is therefore not a passive reference; it is part of the feedback loop, and watching it collapse is the clearest way to see the regeneration happen.

## 01 - Three transistor sawtooth

[01 - Three transistor sawtooth/Three transistor sawtooth.asc](<01 - Three transistor sawtooth/Three transistor sawtooth.asc>) reproduces the drawing Alan introduces at [0:26](https://www.youtube.com/watch?v=2a1I1X3RV0g&t=26s), with the shortcut [Video 105 - 01 - Three transistor sawtooth.url](<01 - Three transistor sawtooth/Video 105 - 01 - Three transistor sawtooth.url>) opening the video at that moment.

![LTspice schematic of the three-transistor sawtooth oscillator](<01 - Three transistor sawtooth/Three transistor sawtooth schematic.png>)

Every value on the schematic is one Alan writes on his page:

| Part | Value | Role |
| --- | ---: | --- |
| `Vrail` | 9 V | Supply |
| `RbiasHigh` / `RbiasLow` | 1 kΩ / 10 kΩ | Sets the current-source base voltage |
| `Remitter` | 10 kΩ | Converts the remaining headroom into the charging current |
| `Ctiming` | 10 nF | The ramp capacitor |
| `RthresholdHigh` / `RthresholdLow` | 10 kΩ / 10 kΩ | Sets the trip point at half supply |

Alan does not name the transistors, so the schematic uses the LTspice library `2N2907` for both PNPs and `2N2222` for the NPN. Those are **simulation choices**, and the note on the schematic says so. The frequency depends on their base-emitter voltage, as the comparison below shows.

The analysis is `.tran 0 20m 0 100n`, with `.ic V(RAMP)=0` so the capacitor starts empty rather than at the circuit's latched DC operating point. The measurements are taken from 5 ms onward, after the first few cycles have settled.

### What the simulation shows

![LTspice ramp above the threshold and reset-drive traces](<01 - Three transistor sawtooth/Three transistor sawtooth LTspice plot.png>)

The top pane is `V(RAMP)`, the voltage on the 10 nF capacitor, over three cycles from 5 ms to 10 ms. It is the waveform Alan sketches at 2:48: a straight rise and a fall too fast to see at this time scale. The bottom pane is the reset mechanism, on a shared time axis. `V(THRESH)` rests at 4.5 V, exactly half the supply, and collapses to near zero for a few microseconds at each reset; `V(DRIVE)`, the NPN base, rests at about 0.5 V and spikes with it. The two happening together is the regeneration: neither transistor turns on without the other.

If the waveform window opens autoscaled instead of using the saved panes, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Three transistor sawtooth.plt](<01 - Three transistor sawtooth/Three transistor sawtooth.plt>).

The `.meas` directives report:

| Measurement | Result | Meaning |
| --- | ---: | --- |
| `RAMP_MIN` | 0.666 V | Where the capacitor is left after a reset |
| `RAMP_MAX` | 4.950 V | The trip point, one base-emitter drop above the 4.5 V divider |
| `PERIOD` | 1.6687 ms | Measured between successive crossings of 2 V |
| `FREQ` | 599.26 Hz | Oscillation frequency |
| `RAMP_SLOPE` | 2570 V/s | Slope of the rising edge, between 1.5 V and 4.5 V |
| `ICHARGE` | 25.70 µA | The charging current, as `C` times that slope |
| `VBIAS` | 8.182 V | The current-source base voltage |

`ICHARGE` is the number to compare with Alan's quoted figure of roughly 30 µA. It is not measured directly; it is derived from the ramp slope, because a constant current into a capacitor gives `i = C dV/dt`, and 10 nF times 2570 V/s is 25.7 µA.

`VBIAS` confirms the divider: 9 V across 1 kΩ and 10 kΩ leaves 8.182 V on the base, so only 0.818 V remains between the base and the rail. Of that, 25.70 µA through the 10 kΩ emitter resistor accounts for 0.257 V, which puts the model's base-emitter drop at 0.561 V.

### Simulation against Alan's bench

Alan's scope reads **801.301 Hz**; the simulation runs at **599.26 Hz**. The ramp amplitude, by contrast, agrees closely: his sawtooth spans a little over four divisions at 1 V/div, against a simulated 4.284 V swing.

That pattern locates the difference. The period is `C` times the swing divided by the charging current, so with the swing matching, the gap has to be in `C` or in the current. Both are soft:

- The charging current is the difference of two nearly equal voltages. Only 0.818 V separates the base from the rail, and the base-emitter drop consumes two thirds of it, leaving 0.257 V to set the current. Reaching 801 Hz at the same swing needs 34.3 µA, which is 0.343 V across the emitter resistor, which is a base-emitter drop of 0.475 V. In other words the whole discrepancy is 86 mV of `Vbe`, well inside the spread between a real small-signal PNP and a library model, and 5 % resistors move it further.
- The frequency is inversely proportional to the timing capacitor. A 10 nF ceramic 25 % below its marking would by itself take 599 Hz to 799 Hz.

This sensitivity is worth noticing rather than tuning away. It is the practical cost of the simplification: video 104's current sources are biased from a diode string that tracks the transistor's own junction, so the current survives part tolerance, whereas here the current is whatever is left over after `Vbe` is subtracted from a fixed divider voltage. The circuit oscillates reliably and its waveform is a good sawtooth, but its frequency is not a design value.

The reset behavior matches well. Alan's falling edge is a vertical line at 250 µs/div, and the simulated discharge takes a few microseconds. His capacitor does not return all the way to zero either, for the same reason the simulation leaves 0.666 V on it: the regenerative pair starves itself once there is no longer enough voltage across the discharging PNP to keep the loop running.
