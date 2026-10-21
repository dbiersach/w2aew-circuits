# Video 77: Op amp peak detector

Source: Alan Wolke (W2AEW), [#77: Op Amp Peak Detector Tutorial, with peak detector basics](https://www.youtube.com/watch?v=Fn5kHhNRsz0).

| Time | What Alan shows |
| --- | --- |
| [0:24](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=24s) | [01 - A diode and a load resistor](#01---a-diode-and-a-load-resistor) |
| [2:22](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=142s) | [02 - Adding the capacitor](#02---adding-the-capacitor) |
| [6:32](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=392s) | [03 - Putting the diode inside the feedback loop](#03---putting-the-diode-inside-the-feedback-loop) |

## What Alan demonstrates

A peak detector captures the highest voltage a signal reaches and holds it. Alan builds one in three steps, and each step exposes the problem the next one solves.

He drives everything from a **500 Hz sine**, which his scope reads out at 500.001 Hz, and works at 500 mV per division. The three circuits below follow his order and use his measured numbers.

## Values, and where they come from

Alan never reads out a resistor or capacitor value, so the component values here are reconstructed from what his scope shows:

| Value | How it was chosen |
| --- | --- |
| 500 Hz sine, 1 V p-p then 3 V p-p | stated and shown on screen |
| R1 = 150 ohm | set so the diode drop at the peak comes out near the **680 mV** he measures with cursors; a much larger load would drop far less |
| C1 = 22 uF | with R1 it gives a 3.3 ms time constant, which produces the droop between peaks that his screen shows |
| D1 = 1N4148 | a small-signal silicon diode; the part is not identified in the video |
| R2 = 1 k at the op amp input | a series input resistor is in his drawing, without a value |
| LM358 on +/-10 V | the part is not named here, but his drawing marks the supply pins **V+** and **V-**, and video 75 that same week shows an LM358 on his bench |

The important thing is that these values reproduce his measurements rather than being chosen for convenience; where the simulation and his bench differ, it is noted.

## 01 - A diode and a load resistor

Introduced at [0:24](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=24s). File: [`Diode voltage drop.asc`](<01 - Diode and load resistor/Diode voltage drop.asc>).

![Diode and load resistor](<01 - Diode and load resistor/Diode and load resistor schematic.png>)

*The simplest thing that might work: a series diode into a load resistor. The input level is stepped to cover both cases Alan shows.*

![Both input levels](<01 - Diode and load resistor/Diode and load resistor waveforms.png>)

*Top: at 3 V p-p the diode conducts and the load follows the positive half of the input, 665 mV lower. Alan measures 680 mV on his bench. Bottom: at 1 V p-p the same diode barely turns on and just 16 mV reaches the load, which is his point about small signals being lost in the diode drop.*

![Measured peaks and drop](<01 - Diode and load resistor/Diode and load resistor SPICE output log.png>)

*Step 1 is the 0.5 V peak input, step 2 the 1.5 V peak. The `DIODE_DROP` measurement is the difference between the two peaks.*

Two things are wrong with this as a peak detector: it loses a diode drop, and it does not hold anything. The output falls back to zero the moment the input does.

## 02 - Adding the capacitor

Introduced at [2:22](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=142s). File: [`Diode peak detector.asc`](<02 - Diode peak detector/Diode peak detector.asc>).

![Diode peak detector](<02 - Diode peak detector/Diode peak detector schematic.png>)

*The same circuit with C1 added. Nothing else changes.*

Now the diode charges C1 near each positive peak and then stops conducting, so C1 holds that voltage. The only way the charge can leave is through R1, which is why Alan calls it the bleeder resistor. He points out that you choose it for the measurement you are making: too small and the reading sags between peaks, too large and the detector is slow to follow a falling signal.

![Charge and droop](<02 - Diode peak detector/Diode peak detector waveforms.png>)

*Top: C1 charges to 0.79 V near each peak and droops 0.31 V before the next one arrives, 2 ms later. That is the same shape as the cyan trace on Alan's screen; he says he deliberately kept the bleeder small so the droop is easy to see. Bottom: with the level dropped to 0.5 V p-p the detector reads nothing at all, because the peak never reaches the diode's turn-on voltage.*

![Measured hold and droop](<02 - Diode peak detector/Diode peak detector SPICE output log.png>)

*The held peak, the lowest point it droops to, and the difference.*

So the capacitor fixes the holding, but the diode drop is still there, and small signals still get nothing at all.

## 03 - Putting the diode inside the feedback loop

Introduced at [6:32](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=392s). File: [`Op amp peak detector.asc`](<03 - Op amp peak detector/Op amp peak detector.asc>).

![Op amp peak detector](<03 - Op amp peak detector/Op amp peak detector schematic.png>)

*Alan's drawing, titled "use negative feedback to get rid of the diode drop". The signal enters the + input through a series resistor, the op amp drives the diode, and the hold network is the same R1 and C1 as circuit 02. The feedback comes from the capacitor, on the far side of the diode.*

That last detail is the whole trick. The op amp compares the held voltage against the input, not its own output, so it raises its output by whatever the diode happens to drop until the capacitor reaches the real input peak. The diode's forward voltage is inside the loop, so it stops being an error.

![The drop has gone](<03 - Op amp peak detector/Op amp peak detector waveforms.png>)

*Top: against the same 1.50 V input peak the held output now reaches 1.43 V, where the plain diode managed 0.79 V. Bottom: at the 0.5 V p-p level that defeated the plain detector completely, this one still reads a 0.29 V peak, which is Alan's closing demonstration.*

![Measured peaks](<03 - Op amp peak detector/Op amp peak detector SPICE output log.png>)

*`VOUT_PK` against `VIN_PK` for both levels.*

The 70 mV that still separates the held value from the input peak is not a diode drop; it is the droop through R1 during the rest of the cycle plus the time the op amp needs to recover each time the diode stops conducting. Making the bleeder larger closes most of that gap, at the cost of a detector that is slower to follow a falling signal, which is the same trade Alan describes at [4:34](https://www.youtube.com/watch?v=Fn5kHhNRsz0&t=274s).

## The three circuits side by side

Against the same 500 Hz source, measured at the held output:

| Input | Diode and resistor | Diode and capacitor | Op amp detector |
| --- | --- | --- | --- |
| 3 V p-p (1.50 V peak) | 0.83 V peak, not held | 0.79 V, droops to 0.48 V | 1.43 V, droops to 0.89 V |
| 0.5 V p-p (0.25 V peak) | nothing usable | nothing at all | 0.29 V peak |

## Reproducing the plots

Open a schematic, press **Run**, and if the waveform window opens autoscaled press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`.

Each circuit steps the source amplitude, so the traces are written with the `@n` step selector: `@1` is the small input and `@2` the 3 V p-p one. The two panes use different vertical scales, because the small-signal case would be invisible at the scale the large one needs.

The two circuits with a capacitor run for 40 ms and save only the last 4 ms. The hold network needs several time constants to settle before the pattern repeats cleanly.
