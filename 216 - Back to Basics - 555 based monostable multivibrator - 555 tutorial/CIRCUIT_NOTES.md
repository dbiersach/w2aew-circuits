# Video 216: 555 monostable multivibrator

Source: Alan Wolke (W2AEW), [#216: Back to Basics: 555 based monostable multivibrator | 555 tutorial](https://www.youtube.com/watch?v=MbWc70ZzTlI). His notes for the lesson are kept here as [W2AEW Video Notes - 555monostable.pdf](<W2AEW Video Notes - 555monostable.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=MbWc70ZzTlI&t=15s) | What a one-shot is: a circuit that puts out a single pulse of a fixed length in response to a trigger, and then waits for the next one. |
| [1:00](https://www.youtube.com/watch?v=MbWc70ZzTlI&t=60s) | The circuit on a breadboard, with the relay and LED it drives. |
| [1:50](https://www.youtube.com/watch?v=MbWc70ZzTlI&t=110s) | The full schematic: the 555 with its 470 kΩ and 2.2 µF timing pair, the 10 kΩ pull-up on the trigger, the 10 nF on the control pin, and the supply bypass. |
| [5:40](https://www.youtube.com/watch?v=MbWc70ZzTlI&t=340s) | The relay driver: a 2N3904 from the 555 output through 470 Ω, a flyback diode across the coil, and the relay contact switching an LED, reproduced in [01 - 555 relay one-shot](#01---555-relay-one-shot). |
| [8:10](https://www.youtube.com/watch?v=MbWc70ZzTlI&t=490s) | The scope showing the trigger, the output pulse and the timing capacitor charging. |
| [10:32](https://www.youtube.com/watch?v=MbWc70ZzTlI&t=632s) | Where 1.1RC comes from. Rearranging the capacitor charging equation for time gives `t = -RC ln(1 - Vc/V)`, and the 555 ends the pulse at two thirds of the supply, so `t = -RC ln(1/3)`, which is 1.1RC. |

## What the lesson establishes

The 555's internal comparators trip at one third and two thirds of the supply. In monostable use the trigger pin watches for a fall below one third, which sets the output high and releases the discharge transistor so the timing capacitor can charge. The output stays high until the capacitor reaches two thirds of the supply, at which point the chip resets and dumps the capacitor.

The pulse length therefore has nothing to do with how long the trigger was held, and nothing to do with the supply voltage either. Both thresholds are fractions of the supply, so the supply cancels out of the arithmetic, and the whole answer is in the time constant and the fraction the capacitor has to reach. That is the derivation Alan works through at 10:32: 1.1 is not a magic number, it is `-ln(1/3)`.

With his 470 kΩ and 2.2 µF, the pulse should be `1.1 x 470k x 2.2µ`, or 1.1374 seconds.

## 01 - 555 relay one-shot

The shortcut [Video 216 - 01 - 555 relay one-shot.url](<01 - 555 relay one-shot/Video 216 - 01 - 555 relay one-shot.url>) opens the video where Alan reaches the relay driver. The folder holds two schematics: his complete circuit, and a cut-down version of the same timing path for comparison.

### The complete circuit

[01 - 555 relay one-shot/555 relay one-shot.asc](<01 - 555 relay one-shot/555 relay one-shot.asc>) follows his circuit page.

![LTspice schematic of the 555 one-shot with relay driver](<01 - 555 relay one-shot/555 relay one-shot schematic.png>)

| Part | Value | Role |
| --- | ---: | --- |
| `R1` / `C1` | 470 kΩ / 2.2 µF | The timing pair |
| `C2` | 10 nF | Control-pin bypass |
| `C3` | 10 µF | Supply bypass |
| `R2` | 10 kΩ | Trigger pull-up |
| `Rbase` / `Q1` | 470 Ω / 2N3904 | Relay driver |
| `Dfly` | 1N914 | Flyback diode across the coil |
| `Rled` / `Dled` | 180 Ω / LED | Switched by the relay contact |

Two things stand in for hardware Alan does not specify. His trigger is a normally-open push switch against the 10 kΩ pull-up; here an ideal source produces the same voltage at pin 2, `PULSE(5 0 10m 1u 1u 1m 3s)`, a 1 ms dip at 10 ms. And he gives no relay coil resistance, inductance or contact rating, so the 100 Ω / 100 mH coil and the voltage-controlled switch are **illustrative**, labelled as such on the schematic. Their currents are not measurements of his relay. U1 is LTspice's NE555 macromodel rather than a verified model of his LM555.

![Trigger and output, timing capacitor, and coil and LED currents](<01 - 555 relay one-shot/555 relay one-shot waveforms.png>)

If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [555 relay one-shot.plt](<01 - 555 relay one-shot/555 relay one-shot.plt>).

The trigger dip at 10 ms is only a millisecond wide, so against a 1.4 second axis it is the narrow spike at the far left; the output it starts is the wide pulse that follows. The middle pane shows the timing capacitor charging toward two thirds of 5 V, which is 3.33 V, and dropping the moment it arrives. The bottom pane is the illustrative load.

`PULSE_WIDTH`, measured between the output's own half-supply crossings, is **1.13760 s** against the hand-calculated 1.1374 s. The two agree to better than a part in five thousand, which is what should happen: the 555's thresholds are set by an internal divider, and the simulation's resistor and capacitor are exact.

### The timing core alone

[01 - 555 relay one-shot/555 one-shot timing core.asc](<01 - 555 relay one-shot/555 one-shot timing core.asc>) is the same timing path with the driver, coil, contact and LED taken away. It is an **adaptation rather than a circuit from the video**, kept because it separates the part of the result that rests on Alan's stated values from the part that rests on the illustrative relay.

![Timing core schematic](<01 - 555 relay one-shot/555 one-shot timing core schematic.png>)

![Timing core trigger, output and capacitor voltage](<01 - 555 relay one-shot/555 one-shot timing core waveforms.png>)

Its `PULSE_WIDTH` is **1.13760 s**, the same figure to six digits. That is the useful result: the relay and its flyback diode change nothing about the timing, so the assumptions made about the coil do not touch the number this chapter quotes.

## Simulation against Alan's bench

The agreement with the arithmetic is exact to the digits that matter, which is the expected outcome for an ideal R and C and is not evidence about his build. A real 2.2 µF electrolytic can be 20% away from its marking, and that error goes straight into the pulse length, so a bench measurement of this circuit would be expected to differ from 1.1374 s by rather more than the simulation does. What the simulation confirms is the mechanism and the 1.1RC relationship, not the tolerance of any particular part.
