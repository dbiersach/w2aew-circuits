# Video 110: Flexible 555 ramp generator

Source: Alan Wolke (W2AEW), [#110: Circuit Fun: Flexible Ramp Generator to create frequency sweeps using 555 timer and op amps](https://www.youtube.com/watch?v=bVahBmsvirE). His drawing for the lesson is kept here as [W2AEW Video Notes - Flexible_ramp_generator_555.pdf](<W2AEW Video Notes - Flexible_ramp_generator_555.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:10](https://www.youtube.com/watch?v=bVahBmsvirE&t=10s) | The finished generator on the bench and the ramp it produces, with the speed, amplitude and offset controls adjusted one at a time. |
| [1:35](https://www.youtube.com/watch?v=bVahBmsvirE&t=95s) | The complete hand-drawn circuit, reproduced in [01 - Flexible 555 ramp generator](#01---flexible-555-ramp-generator). |
| [1:50](https://www.youtube.com/watch?v=bVahBmsvirE&t=110s) | The 555 wired as a reset switch rather than an oscillator: trigger, threshold and discharge all land on the timing capacitor, so the chip discharges it the moment it reaches two thirds of the supply and releases it at one third. Its output pin is used only as a trigger pulse for the scope. |
| [2:25](https://www.youtube.com/watch?v=bVahBmsvirE&t=145s) | The charging source: a 2N3906 with a 10 kΩ / 20 kΩ base divider and a 470 Ω resistor in series with the 5 kΩ SPEED control in its emitter. |
| [3:05](https://www.youtube.com/watch?v=bVahBmsvirE&t=185s) | The timing capacitor, and his note that 22 µF gives a sweep range of roughly 10 ms to 200 ms. |
| [3:25](https://www.youtube.com/watch?v=bVahBmsvirE&t=205s) | The first op-amp stage, and the reason for the starred resistor: it sets the reference the gain control works against, so the start of the ramp stays put while the amplitude is adjusted. 4.7 kΩ suited his build. |
| [4:25](https://www.youtube.com/watch?v=bVahBmsvirE&t=265s) | The 5 kΩ GAIN control feeding the second inverting stage through 20 kΩ with 100 kΩ of feedback. |
| [4:45](https://www.youtube.com/watch?v=bVahBmsvirE&t=285s) | The DC OFFSET control, a 5 kΩ pot between two 10 kΩ resistors across the +9 V and -9 V rails, driving the second stage's noninverting input. |
| [5:30](https://www.youtube.com/watch?v=bVahBmsvirE&t=330s) | The breadboarded circuit, and the ramp on the scope as he turns each control. |
| [7:30](https://www.youtube.com/watch?v=bVahBmsvirE&t=450s) | The point of the whole exercise: the ramp drives a signal generator's voltage-controlled frequency input, and a frequency counter follows the output as it sweeps. |
| [10:12](https://www.youtube.com/watch?v=bVahBmsvirE&t=612s) | The swept signal on an analog scope, its cycles visibly compressing from left to right across one sweep. |

## What the lesson establishes

The goal is a sweep voltage: a linear ramp to feed the voltage-controlled frequency input of a function generator, so its output sweeps smoothly from one frequency to another. That makes it possible to see the response of a filter, a receiver front end or an amplifier in one scope picture. For that to be useful, three things have to be adjustable independently: how fast the ramp runs, how far it swings, and where it sits in voltage.

Four ideas carry the circuit:

- **Charge the capacitor from a current source, not through a resistor.** An RC charging curve is an exponential, which would make the frequency sweep nonlinear. A PNP with a fixed base voltage and an emitter resistor delivers a nearly constant collector current regardless of the capacitor's voltage, so the ramp is straight. The 5 kΩ in the emitter sets that current, which is the SPEED control.
- **Use the 555 as a reset switch.** Tying trigger, threshold and discharge together to the capacitor turns the chip into a two-threshold reset: it grounds the capacitor when it reaches 2/3 of the supply and lets go at 1/3. The ramp therefore always swings the same 3 V no matter how the speed is set, which is exactly what keeps the sweep amplitude stable. The 555's own output pin is spare, so Alan takes it as a scope trigger.
- **Shift and scale with the first op amp.** The ramp sits 3 V above ground and the generator wants a signal near zero, so the first stage inverts it about a reference set by the 20 kΩ and the starred resistor. Alan is explicit about why the reference matters: it fixes the point the gain control pivots around, so turning the amplitude up does not also move the start of the sweep.
- **Set the amplitude and offset separately.** The 5 kΩ GAIN pot attenuates before the second inverting stage, and the second stage's noninverting input rides on an offset pot spanning both rails. Gain and offset are then two different knobs rather than one interacting pair.

## 01 - Flexible 555 ramp generator

[01 - Flexible 555 ramp generator/Flexible 555 ramp generator.asc](<01 - Flexible 555 ramp generator/Flexible 555 ramp generator.asc>) reproduces Alan's drawing, with the shortcut [Video 110 - 01 - Flexible 555 ramp generator.url](<01 - Flexible 555 ramp generator/Video 110 - 01 - Flexible 555 ramp generator.url>) opening the video where he presents it.

![LTspice schematic of the flexible 555 ramp generator](<01 - Flexible 555 ramp generator/Flexible 555 ramp generator schematic.png>)

| Part | Value | Role |
| --- | ---: | --- |
| `Vplus` / `Vminus` | +9 V / -9 V | Alan's two 9 V batteries |
| `U555` | NE555 | Resets the capacitor at 2/3 supply, releases at 1/3 |
| `Ccontrol` | 100 nF | Decoupling on the 555 control-voltage pin |
| `RbiasTop` / `RbiasBottom` | 10 kΩ / 20 kΩ | Holds the 2N3906 base at 6 V |
| `Rfixed` + `Rspeed` | 470 Ω + 5 kΩ | Sets the charging current; the SPEED control |
| `Cramp` | 22 µF | The timing capacitor, Alan's example value |
| `Rin1` / `Rfb1` | 100 kΩ / 100 kΩ | First stage, inverting, unity gain |
| `RrefTop` / `RrefBottom` | 20 kΩ / 4.7 kΩ | The starred reference, 1.71 V |
| `RgainUpper` / `RgainLower` | 2.5 kΩ / 2.5 kΩ | The 5 kΩ GAIN control, set to its midpoint |
| `Rin2` / `Rfb2` | 20 kΩ / 100 kΩ | Second stage, inverting, gain of 5 |
| `RoffHigh` / `RoffUpper` / `RoffLower` / `RoffLow` | 10 kΩ / 2.5 kΩ / 2.5 kΩ / 10 kΩ | The DC OFFSET control, set to its midpoint |

The three controls are pots on Alan's bench, so each appears here as a fixed pair of resistors at the middle of its range. The plot therefore shows one setting of an adjustable circuit, which is what the schematic note says.

`U1A` and `U1B` are the two halves of an LM358, one of the parts Alan names on his drawing, using LTspice's installed model. The 555 is LTspice's NE555 macromodel. LTspice does not reach the operating point by direct Newton iteration or Gmin stepping on this circuit, but source stepping finds it, so the run completes without any change to the circuit.

### What the simulation shows

The analysis is `.tran 0 600m 0 20u` with `.ic V(RAMP)=0`. Measurements are taken from 200 ms onward, by which time the capacitor has settled into its steady cycle, and the plot shows the same window.

![Timing ramp, the inverted and shifted ramp, and the output sweep](<01 - Flexible 555 ramp generator/Flexible 555 ramp generator output.png>)

If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Flexible 555 ramp generator.plt](<01 - Flexible 555 ramp generator/Flexible 555 ramp generator.plt>).

The three panes follow the signal path.

| Measurement | Result | Meaning |
| --- | ---: | --- |
| `RAMP_LO` / `RAMP_HI` | 3.00 V / 6.00 V | The 555's two thresholds, one third and two thirds of 9 V |
| `SWEEP_PERIOD` | 88.0 ms | One sweep at the midpoint speed setting |
| `ICHARGE` | 750.9 µA | The charging current, from `C` times the ramp slope |
| `INV1_HI` / `INV1_LO` | +0.43 V / -2.58 V | The first stage's output, inverted about its 1.71 V reference |
| `OUT_LO` / `OUT_HI` | -1.01 V / +6.06 V | The sweep the generator would see |

Each stage can be checked by hand against those numbers. The divider holds the 2N3906 base at 9 V times 20/30, or 6 V, and the measured 750.9 µA through 470 Ω plus 2.5 kΩ accounts for 2.23 V across the emitter chain. A constant 750.9 µA into 22 µF climbs at 34.1 V/s, so the 3.00 V window takes 88.0 ms, which is the measured period. The first stage inverts about its reference, giving `2 x 1.71 - V(RAMP)`, or +0.43 V falling to -2.57 V. The gain pot's lower leg is loaded by the 20 kΩ input resistor of the second stage, which is why the second stage sees 0.47 of the first stage's output rather than half of it, and the resulting gain of -2.35 turns that into the -1.01 V to +6.06 V output sweep.

That loading is worth noticing, because it is the same effect Alan's starred resistor compensates for. The gain control is not an isolated attenuator; the stage it feeds is part of its load.

### Simulation against Alan's bench

Alan's note says a 22 µF timing capacitor gives a sweep range of about 10 ms to 200 ms. The simulated 88.0 ms sits inside that range, at the midpoint of the speed control, as it should. Scaling the measured current to the ends of the 5 kΩ pot, from 470 Ω alone to 5.47 kΩ, puts the period between roughly 14 ms and 160 ms. That is arithmetic from the measured current rather than a second simulation, but it brackets Alan's figure closely.

One bench behavior the simulation cannot reproduce is the one Alan calls out in the video description: the start of his real ramp is slightly nonlinear. That is dielectric absorption, the charge that soaks into and out of an electrolytic capacitor's dielectric, and it is a property of the physical part rather than of the circuit. LTspice's capacitor is ideal and charges in a straight line from the first microsecond. Alan's point stands on its own: electrolytics are a poor choice where timing has to be precise, and film or ceramic parts are much better behaved.
