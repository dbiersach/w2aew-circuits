# Video 90: Measuring capacitance and inductance with a scope

Source: Alan Wolke (W2AEW), [#90: Measure Capacitors and Inductors with an Oscilloscope and some basic parts](https://www.youtube.com/watch?v=74fz9iwZ_sM). His handwritten notes for the lesson are kept here as [W2AEW Video Notes - Measure_caps_inductors_with_scope.pdf](<W2AEW Video Notes - Measure_caps_inductors_with_scope.pdf>).

| Time | What Alan shows |
| --- | --- |
| [1:00](https://www.youtube.com/watch?v=74fz9iwZ_sM&t=60s) | The fast-edge square wave generator he drives both tests with: a 74AC14 running at roughly 5 to 6 kHz with about a 2 ns rise time, from a 2 to 5 V supply. |
| [2:02](https://www.youtube.com/watch?v=74fz9iwZ_sM&t=122s) | The RC time-constant method, reproduced in [01 - RC time constant](#01---rc-time-constant). |
| [3:42](https://www.youtube.com/watch?v=74fz9iwZ_sM&t=222s) | The LC tank method, reproduced in [02 - LC ringdown](#02---lc-ringdown). |
| [5:32](https://www.youtube.com/watch?v=74fz9iwZ_sM&t=332s) | The test fixture built on copper board, with clip leads for the part under test. |
| [7:00](https://www.youtube.com/watch?v=74fz9iwZ_sM&t=420s) | The scope showing the capacitor's charging curve, with a cursor on the 63 percent point. |
| [8:20](https://www.youtube.com/watch?v=74fz9iwZ_sM&t=500s) | The scope showing the tank ringing after each edge. |

## What the lesson establishes

Both measurements turn an unknown reactance into a **time** you can read off a scope, which is the one thing an oscilloscope is good at. Neither needs an LCR bridge.

For a capacitor, drive it through a known resistor with a fast edge and watch it charge. The voltage follows `V = Vpeak * (1 - exp(-t/RC))`, so at `t = RC` it has reached 63 percent of the step, and the capacitance is `C = t / R`. Alan's bench shortcut for reading that time is to set the step to exactly 8 vertical divisions and measure how long the trace takes to rise 5 of them, since 5 of 8 is 62.5 percent.

For an inductor, put it in parallel with a **known** capacitor, hit the tank with a fast edge, and measure the frequency it rings at. Then `L = 1 / ((2*pi*fR)^2 * C)`. The method also works the other way round for a capacitor if you have a known inductor.

The generator at 1:00 is itself a Schmitt-trigger oscillator of the kind built in [video 87](<../087 - Schmitt Trigger Oscillator - Tutorial - 74AC14 Inverter - squarewave generator/CIRCUIT_NOTES.md>), so it is not rebuilt here. What matters for these two tests is only that its edge is fast compared with the time being measured.

The component values below come from Alan's handwritten notes: 1 kohm in series for the RC test, and a 10 pF coupling capacitor into a 1 nF known tank capacitor for the ring test. The parts under test, `CUNKNOWN` and `LUNKNOWN`, are the things you would be measuring, so the 10 nF and 10 uH used here stand in for them and the simulation then checks whether the method recovers those values.

## 01 - RC time constant

[Schematic](<01 - RC time constant/RC time constant.asc>) - [Saved plot settings](<01 - RC time constant/RC time constant.plt>) - [Video at 2:02](<01 - RC time constant/Video 090 - 01 - RC time constant.url>)

![RC time constant schematic copied from LTspice](<01 - RC time constant/RC time constant schematic.png>)

A 0 V to 5 V edge at 10 us charges `CUNKNOWN` through Alan's 1 kohm `RTEST`. With a 10 nF part the time constant is 10 us, so the 63 percent point should fall at 20 us.

![RC charging curve with the 63 percent point, copied from LTspice](<01 - RC time constant/RC charge and 63 percent point.png>)

| `.meas` result | Value | What it shows |
| --- | ---: | --- |
| `CAP_20U` | 3.1605 V | the capacitor voltage one time constant after the edge, 63.21 percent of 5 V |
| `TAU` | 10.0005 us | the time from the edge to the exact 63.2 percent crossing |
| `C_FROM_TAU` | 10.0005 nF | that time divided by 1 kohm, against a true 10 nF |
| `C_FROM_5DIV` | 9.8076 nF | the same calculation using Alan's 5-of-8-divisions reading |

The exact method returns the capacitance to five figures, as it must, since the simulation has no strays. The interesting number is the last one: reading 5 divisions of 8 gives 62.5 percent instead of 63.2 percent, which lands 1.9 percent low. That is the built-in cost of the shortcut, and it is comfortably inside the tolerance of most capacitors, which is why the shortcut is worth using.

On a bench the other error is the probe. Alan's note "watch probe capacitance for low C values" matters because a 10x probe adds something like 10 to 15 pF across the part under test. Against this 10 nF that is about 0.1 percent; against a 100 pF part it would be more than 10 percent, and the measurement would need the probe capacitance subtracted.

## 02 - LC ringdown

[Schematic](<02 - LC ringdown/LC ringdown.asc>) - [Saved plot settings](<02 - LC ringdown/LC ringdown.plt>) - [Video at 3:42](<02 - LC ringdown/Video 090 - 02 - LC ringdown.url>)

![LC ringdown schematic copied from LTspice](<02 - LC ringdown/LC ringdown schematic.png>)

The fast edge reaches the tank through Alan's 10 pF `CCOUPLE`. `CKNOWN` is his 1 nF, `LUNKNOWN` is the part being measured, and `RPROBE` is the 10x scope probe he clips on the tank. The coil carries 8 ohm of series resistance, which is what makes the ring decay; Alan draws no loss element, but a real coil has one and without it the tank would ring indefinitely.

![LC tank ringdown copied from LTspice](<02 - LC ringdown/LC tank ringdown.png>)

| `.meas` result | Value | What it shows |
| --- | ---: | --- |
| `RING_PERIOD` | 631.96 ns | measured between two zero crossings one cycle apart |
| `RING_FREQ` | 1.5824 MHz | the reciprocal of that period |
| `FIRST_PEAK` | 49.5 mV | how far the 10 pF coupling drives the tank from a 5 V edge |

Putting the measured frequency into `L = 1 / ((2*pi*fR)^2 * C)` with C taken as the known 1 nF gives **10.12 uH**, against the 10 uH actually in the schematic. The 1.2 percent error is not noise: the 10 pF coupling capacitor sits across the tank as well, so the circuit resonates on about 1.01 nF while the calculation assumes 1.00 nF. That is the practical reason Alan picks a known capacitor of 1 nF rather than something small, and it is the same lesson as the probe capacitance in circuit 01.

The first peak is only 49.5 mV because 10 pF into 1 nF is a hundred-to-one divider. On the bench that is why the ring is viewed on a sensitive vertical setting, and why the coupling capacitor is kept small enough not to detune the tank but large enough to excite it.

## Running these in LTspice

Open either schematic and press Run. If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up the saved `.plt`. The `.meas` results appear in View > SPICE Output Log. To use either circuit as a measuring tool rather than a demonstration, replace `CUNKNOWN` or `LUNKNOWN` with the part in question and read the same results.
