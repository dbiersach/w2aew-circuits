# Video 104: Adjustable sawtooth generator

Source: Alan Wolke (W2AEW), [#104: Circuit tutorial: sawtooth generator w/ current sources, diode switches, hysteresis comparator](https://www.youtube.com/watch?v=ibnz5UjQ4u0). His four-page notes for the lesson are kept here as [W2AEW Video Notes - Adjustable_Sawtooth_Generator.pdf](<W2AEW Video Notes - Adjustable_Sawtooth_Generator.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:45](https://www.youtube.com/watch?v=ibnz5UjQ4u0&t=45s) | The goal: a sawtooth of **constant amplitude** whose rising and falling slopes can be varied independently, built from current sources, a diode switch bridge and a comparator with hysteresis. |
| [3:20](https://www.youtube.com/watch?v=ibnz5UjQ4u0&t=200s) | The functional diagram: two current sources, a switch between them, and the capacitor that integrates whichever one is connected. A constant current into a capacitor gives a straight ramp, `i = C dV/dt`. |
| [6:20](https://www.youtube.com/watch?v=ibnz5UjQ4u0&t=380s) | How the switch is actually built: a four-diode bridge used as an SPDT current switch. |
| [9:20](https://www.youtube.com/watch?v=ibnz5UjQ4u0&t=560s) | The comparator with positive feedback, and why its moving threshold is the same mechanism as a Schmitt trigger, except that here it is adjustable. |
| [11:15](https://www.youtube.com/watch?v=ibnz5UjQ4u0&t=675s) | The complete circuit, reproduced in [01 - Adjustable sawtooth generator](#01---adjustable-sawtooth-generator). |
| [14:10](https://www.youtube.com/watch?v=ibnz5UjQ4u0&t=850s) | The finished generator on the bench, with the sawtooth on a Tektronix scope. |

## What the lesson establishes

A capacitor fed from a constant current ramps linearly, at `I/C` volts per second. Feed it from one current source and it rises; switch to a second source that pulls current out and it falls. If a comparator watches the capacitor and throws the switch at a fixed upper and lower threshold, the result is a repeating sawtooth whose **amplitude is set by the two thresholds** and whose **two slopes are set by the two currents**. Because those are separate controls, the rise and fall can be adjusted independently without the amplitude moving, which is the point Alan writes at the top of his first page.

Three pieces make that work:

- **Current sources.** A string of diodes sets a fixed base voltage, and the emitter resistor of each transistor turns that into a fixed emitter current, so the collector current barely depends on what the collector is connected to. One PNP sources current from the rail, one NPN sinks it to ground.
- **A diode bridge as an SPDT current switch.** With the bridge's control corner driven high, one diagonal pair conducts and the charging current reaches the capacitor; driven low, the other pair conducts and the discharging current does. Because the bridge only ever steers an existing current, it switches quickly and without the charge injection a transistor switch would add.
- **A comparator with positive feedback.** Three equal resistors set the mid-rail reference and feed a fraction of the output back to the positive input, so the threshold moves with the output state. That is what makes the capacitor turn around at two fixed voltages instead of chattering at one.

## 01 - Adjustable sawtooth generator

[Schematic](<01 - Adjustable sawtooth generator/Adjustable sawtooth generator.asc>) - [Saved plot settings](<01 - Adjustable sawtooth generator/Adjustable sawtooth generator.plt>) - [Video at 11:15](<01 - Adjustable sawtooth generator/Video 104 - 01 - Adjustable sawtooth generator.url>)

![Adjustable sawtooth generator schematic copied from LTspice](<01 - Adjustable sawtooth generator/Adjustable sawtooth generator schematic.png>)

Every value on Alan's page-4 drawing is used as he gives it: the two 1 kohm adjustments with their 180 ohm series resistors, the 1 kohm reference resistor in the diode string, three 3.9 kohm resistors around the comparator, 0.1 uF of timing capacitance, and 1N4148 bridge diodes.

Two points about the parts. Alan writes "all diodes: 1N4198" on his sheet, which is not a catalog number; 1N4148 is the evident reading and is what the simulation uses. And he does say something about the amplifiers, which is easy to miss: "I used rail-rail o/p op amp, OK for lower speed". He names no part, so `UniversalOpAmp2` stands in for both the comparator and the buffer. The 9 V rail, the 2N3904 and 2N3906, and the 100 kohm load are simulation choices.

`RRISE` and `RFALL` are parameters standing for the two 1 kohm adjustments, set to their mid positions at 500 ohm each.

![Sawtooth output and comparator control waveform, copied from LTspice](<01 - Adjustable sawtooth generator/Adjustable sawtooth output.png>)

The top pane carries `V(RAMP)` on the timing capacitor and `V(OUT)` from the buffer; they lie on top of each other, which is the buffer doing its job of presenting the waveform without loading the capacitor. The bottom pane is `V(CTRL)`, the comparator output that throws the bridge.

| `.meas` result | Value |
| --- | ---: |
| `RAMP_MIN` | 2.976 V |
| `RAMP_MAX` | 6.024 V |
| `FREQ` | 1651.5 Hz |
| `RISE_SLOPE` | 10.06 kV/s |
| `FALL_SLOPE` | 10.08 kV/s |

With both adjustments centered the two slopes match to within 0.2 percent, so the output is a symmetrical triangle. The slope figure also recovers the current: `I = C dV/dt` is `0.1 uF x 10.06 kV/s`, or about 1.01 mA in each source.

### The adjustment actually is independent

Re-running with the two adjustments moved, and changing nothing else, is what demonstrates Alan's headline claim:

| `RRISE` | `RFALL` | Rise slope | Fall slope | Ramp span | Duty cycle | Frequency |
| ---: | ---: | ---: | ---: | --- | ---: | ---: |
| 500 | 500 | 10.06 kV/s | 10.08 kV/s | 2.976 to 6.024 V | 50.0 % | 1651.5 Hz |
| 200 | 800 | 17.62 kV/s | 7.09 kV/s | 2.986 to 6.042 V | 28.7 % | 1654.0 Hz |
| 100 | 900 | 23.63 kV/s | 6.45 kV/s | 2.991 to 6.054 V | 21.4 % | 1655.0 Hz |

Lowering `RRISE` steepens only the rise; raising `RFALL` flattens only the fall. The amplitude stays within 30 mV of 3.05 V across all three, which is the constant-amplitude property.

The frequency barely moves either, but that is a consequence of how these three cases were chosen rather than a property of the circuit: the two resistances sum to 1000 ohm in each row, so the rise and fall times trade against each other and the period stays near 605 us. What does change is the **duty cycle**, from 50 percent to 21 percent, and that is exactly what Alan labels on his drawing as the "variable duty cycle square wave o/p" available at the comparator output. The same control therefore gives a sawtooth of adjustable symmetry at one output and a variable duty-cycle square wave at the other.

To reproduce any row, edit the `.param` line on the schematic and re-run.

## Running this in LTspice

Open the schematic and press Run. If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up the saved `.plt`, which sets the two panes and the 2.0 ms to 3.5 ms window. The `.meas` results appear in View > SPICE Output Log.

The log reports that direct Newton iteration failed to find an operating point and that gmin stepping was used instead. That is expected: the circuit has no stable DC solution, because it is an oscillator, and the `.ic V(RAMP)=0` directive starts the capacitor discharged so the first cycle is predictable.
