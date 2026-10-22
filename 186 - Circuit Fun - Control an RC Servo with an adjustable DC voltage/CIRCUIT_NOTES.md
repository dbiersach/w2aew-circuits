# Video 186 - Driving an RC servo from a DC voltage

Source: Alan Wolke (W2AEW), [#186: Circuit Fun: Control an RC Servo with an adjustable DC voltage](https://www.youtube.com/watch?v=iaGZOO33Z-o). Alan's four handwritten pages for the lesson are in [W2AEW Video Notes - Analog_Control_RC_Servo.pdf](W2AEW%20Video%20Notes%20-%20Analog_Control_RC_Servo.pdf): page 2 is the complete circuit, pages 3 and 4 the building blocks.

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=20s) | The servo on the bench beside the scope, as the thing the circuit has to drive. |
| [1:00](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=60s) | What an RC servo actually wants: a pulse 1 to 2 ms wide repeated every 20 to 30 ms, which is 30 to 50 Hz, with the width and not the rate carrying the position. |
| [1:40](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=100s) | The approach the whole circuit follows: generate a triangle and slice it with a comparator, so moving the slicing level moves the pulse width. |
| [2:20](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=140s) | The triangle on the scope. |
| [2:47](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=167s) | The complete circuit on page 2, which is what [circuit 01](#01---analog-voltage-servo-controller) reproduces. |
| [5:00](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=300s) | The first building block: the hysteresis comparator and integrator that make the triangle, with the arithmetic for the switching thresholds and the slew rate. |
| [8:00](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=480s) | The second building block: the attenuator and the unity inverting stage with offset, and why about 150 mV of movement at the comparator is what buys the 1 to 2 ms range. |
| [14:20](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=860s) | The finished drawing, including the note to use a rail-to-rail op amp such as the LMC6482 or LMC6484, and the three terminals that go to the servo. |

## What the circuit has to do

A hobby servo does not take a voltage. It takes a pulse, repeated somewhere between 30 and 50 times a second, and reads its own commanded position from how long that pulse lasts: about 1 ms at one end of travel, about 2 ms at the other. The repetition rate barely matters; the width is everything.

So turning a knob into a servo position means turning a DC voltage into a pulse width, and the standard way to do that is the one Alan draws at 1:40. Make a triangle wave at the frame rate, compare it against a DC level, and the comparator output is high for exactly as long as the triangle is above that level. Move the level down and the pulse gets wider.

Everything else in the circuit exists to make that work on a single 5 V supply: a reference at mid-supply so the triangle has room to swing both ways, and a conditioning stage that maps a 0 to 5 V control input onto the narrow band of levels that produces 1 to 2 ms.

## 01 - Analog voltage servo controller

Open [Analog voltage servo controller.asc](01%20-%20Analog%20voltage%20servo%20controller/Analog%20voltage%20servo%20controller.asc); the [video shortcut](01%20-%20Analog%20voltage%20servo%20controller/Video%20186%20-%2001%20-%20Analog%20voltage%20servo%20controller.url) opens the complete-circuit drawing at [2:47](https://www.youtube.com/watch?v=iaGZOO33Z-o&t=167s).

![LTspice schematic of the four-stage servo controller](01%20-%20Analog%20voltage%20servo%20controller/Analog%20voltage%20servo%20controller%20schematic.png)

*All four stages from Alan's page 2, with his values. The supply block on the left makes `VREF` at mid-supply; `VCC`, `VREF` and ground are carried to the stages as labels, and every signal path is wired.*

### The sawtooth generator

`U1` is a comparator with positive feedback: `VREF` on the inverting input, and the non-inverting input driven from the triangle through `RhystRamp` while `RhystFeedback` pulls it toward whichever rail the output is sitting on. With a rail-to-rail output swinging between 0 and `VCC`, it flips when the triangle gets `VREF` × 3.9k/10k away from `VREF`, which is 0.975 V either side.

`U2` is an integrator. It takes `U1`'s square output through 68 k, charges 0.22 µF, and so ramps at `(VREF − Vin)/RC`. The two together oscillate: the integrator ramps until the comparator trips, the comparator reverses, the integrator ramps the other way.

Alan's design arithmetic puts the swing at about 2 V and the ramp at about 200 V/s, which would give a frame around 20 ms. The simulation gives:

| Quantity | Directive | Result |
| --- | --- | --- |
| Triangle amplitude | `RAMP_PP` | 1.931 V |
| Frame period | `PERIOD` | 23.41 ms |

1.931 V against the 1.95 V his threshold calculation predicts, and a 23.41 ms frame, which is 42.7 Hz and sits inside the 30 to 50 Hz a servo expects. Dividing the two gives a ramp rate of 165 V/s, close to his 200 V/s estimate.

Note that the waveform is a symmetrical triangle rather than a true sawtooth: the integrator ramps at the same rate in both directions because `U1`'s output is symmetrical about `VREF`. Alan calls it a sawtooth and draws it as a triangle, and for slicing it makes no difference.

### Conditioning the control voltage

The control input cannot be fed to the comparator directly, because the triangle only spans 1.53 to 3.47 V and the useful 1 to 2 ms band is a fraction of that. So `U3` maps the 0 to 5 V input onto that band.

`RattenTop` and `RattenBottom` divide the input by 34, so 5 V becomes 147 mV. `U3` inverts that at unity gain about a reference of its own: `RbiasTop` and `RbiasBottom` put `VREF` × 220k/320k, or 1.72 V, on its non-inverting input, and an inverting stage with equal resistors sits its output at twice that minus the input, which is 3.44 V with no input. `COND_LEVEL` measures it at 3.402 V falling to 3.256 V as the control voltage goes from 0 to 5 V: 36 mV below the ideal value, which is the macromodel's offset and finite gain, and a span of 146 mV against the 147 mV the divider asks for.

That 147 mV of movement is the whole control range, and it is deliberate. At 165 V/s, moving the slicing level by 147 mV changes each edge by 0.89 ms, and because the triangle crosses the level on the way up and again on the way down, the pulse width changes by twice that, 1.78 ms. Alan arrives at the same place on page 4 by a shorter route: 200 V/s for 0.5 ms is 100 mV, so use about 150 mV to be sure of covering 1 to 2 ms.

`U4` is the output comparator, with `RpwmRamp` and `RpwmFeedback` giving it a little hysteresis so it does not chatter where the triangle crosses slowly.

### Simulated result

`.step param VCTRL list 0 2.5 5` runs the circuit at the two ends and the middle of the control range.

| Control voltage | `COND_LEVEL` | `HIGH_TIME` |
| ---: | ---: | ---: |
| 0 V | 3.402 V | 0.399 ms |
| 2.5 V | 3.329 V | 1.291 ms |
| 5 V | 3.256 V | 2.183 ms |

![Simulated triangle, conditioned level and servo pulse at three control voltages](01%20-%20Analog%20voltage%20servo%20controller/Servo%20pulse%20width%20versus%20control%20voltage.png)

*One pane per control voltage, each showing the triangle, the flat conditioned level it is compared against, and the resulting pulse. The window is 8 ms, enough for one pulse; the pattern repeats every 23.41 ms. At 0 V the level sits right at the triangle's peak so only a sliver gets through, and as the level drops the pulse widens.*

The three widths are 0.399, 1.291 and 2.183 ms, which are evenly spaced to within a microsecond: 0.892 ms per 2.5 V of control, either side. The control is linear, which is what makes the circuit usable.

What it is not is calibrated. The ends of the control range land at 0.4 ms and 2.18 ms, outside the 1 to 2 ms a servo reads as travel, so a real build wants either a restricted control range, roughly 1.7 to 4.5 V by this model's numbers, or the attenuator and offset trimmed. Alan says as much when he sizes the span to "ensure" 1 to 2 ms rather than to land on it.

## Model and numerical notes

Alan specifies a rail-to-rail op amp, naming the LMC6482 and LMC6484. The simulation uses National Semiconductor's published macromodel for one section of the **LMC6482A**, from [LMC6482A.lib](../LTspice/Models/National%20Semiconductor/LMC6482A.lib), with four instances standing in for his four amplifiers. The symbol beside the schematic is a local wrapper around that model; the model file itself is a manufacturer release, kept unmodified, and its header grants permission to copy and distribute it.

The rail-to-rail output matters to the result rather than being a convenience. The hysteresis thresholds are derived from the output reaching 0 and `VCC`, and the servo pulse itself has to reach the rails to be read as a logic level. An ordinary op amp in this circuit would give a smaller triangle and different thresholds.

One practical note for anyone running it: LTspice cannot find the operating point by direct Newton iteration or by Gmin stepping for this circuit, and reports both as failing in the output log. It then succeeds by source stepping, and all three steps complete. Those two messages are expected and are not errors.
