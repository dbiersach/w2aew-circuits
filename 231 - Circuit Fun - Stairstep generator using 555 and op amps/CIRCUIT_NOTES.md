# Video 231: Stairstep generator using a 555 and op amps

Source: Alan Wolke (W2AEW), [#231: Circuit Fun: Stairstep generator using 555 and op amps](https://www.youtube.com/watch?v=Kqb5zcrgv7s). His drawing is kept here as [W2AEW Video Notes - stairstep.pdf](<W2AEW Video Notes - stairstep.pdf>). Dino, KL0S, annotated that schematic with the charge, hold and reset paths marked; his pages are kept as [KL0S Notes - 231-KL0S_Notes.pdf](<KL0S Notes - 231-KL0S_Notes.pdf>) and are worth reading alongside it.

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=15s) | The finished staircase on the scope: a voltage that climbs in equal steps and snaps back to zero. |
| [1:00](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=60s) | Where the circuit comes from. His friend Pete, K2LCN, showed it to him, and the original is cited to the *IEEE Engineering Science and Education Journal*, vol. 8 no. 1, February 1999, pp. 25-26. Alan's change was to run it from a single supply using rail-to-rail op amps. |
| [1:45](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=105s) | The complete circuit, reproduced in [01 - Stairstep generator](#01---stairstep-generator). |
| [4:10](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=250s) | The relaxation oscillator built from one half of the dual op amp: a 0.1 µF capacitor charged quickly through D3 and 2.2 kΩ and discharged slowly through D4 and 39 kΩ, with a 33 kΩ / 33 kΩ reference and 15 kΩ of positive feedback setting its thresholds. Its output is a narrow pulse at a long interval. |
| [5:30](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=330s) | The scope beside the drawing, so the measured waveform can be matched to the node producing it. |
| [10:50](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=650s) | The accumulator: the other op-amp half, its three 10 kΩ resistors and 0.1 µF hold capacitor, and the two transistors, one resetting the 555 and one dumping the hold capacitor. The parts list on the page gives general-purpose types: 1N914A or 1N4148 for D1 to D4, 2N3904 or 2N2222 for Q1 and Q2. |
| [13:00](https://www.youtube.com/watch?v=Kqb5zcrgv7s&t=780s) | The staircase and its reset together on the scope. |

## What the lesson establishes

The circuit turns a stream of identical short pulses into a voltage that climbs by a fixed amount per pulse and then starts over. Three blocks do it, and each is a recognisable circuit in its own right:

- **A 555 astable with asymmetric timing.** Charging through one resistor and discharging through another, with diodes steering each path, gives a pulse train whose high time is much shorter than its low time. That matters here because the accumulator adds charge only while the pulse is high; a narrow pulse makes each step well defined.
- **A second astable, much slower, made from an op amp.** The same trick of two diode-steered RC paths sets how long the staircase is allowed to run before it is reset. Its output drives two transistors: one resets the 555 so the stepping stops, the other shorts the hold capacitor so the output falls to zero.
- **An integrator that accumulates charge.** A viewer identified this as a **Deboo integrator**, which is the form that integrates with a grounded capacitor and a noninverting op amp, so it works from a single supply instead of needing a negative rail. That is the reason the circuit can run from one battery.

The staircase amplitude per step is set by how much charge each pulse delivers against the hold capacitor, and the number of steps by how long the reset oscillator waits. Those are independent, which is what makes the circuit useful as a base-current source for a curve tracer, as in [video 232](<../232 - More Circuit Fun - Simple transistor curve tracer using Stairstep generator circuit/CIRCUIT_NOTES.md>).

## 01 - Stairstep generator

[01 - Stairstep generator/Stairstep generator.asc](<01 - Stairstep generator/Stairstep generator.asc>) follows Alan's drawing, with the shortcut [Video 231 - 01 - Stairstep generator.url](<01 - Stairstep generator/Video 231 - 01 - Stairstep generator.url>) opening the video where he presents it.

![LTspice schematic of the stairstep generator](<01 - Stairstep generator/Stairstep generator schematic.png>)

The passive values are Alan's, and so are the semiconductors. His page carries a parts list: general-purpose diodes for D1 to D4, general-purpose NPNs such as the 2N3904 or 2N2222 for Q1 and Q2, an LMC6482 or "most rail-rail op amp" for U1, and a 555 for U2. The schematic uses a 1N4148, a 2N3904, the [National Semiconductor LMC6482A](<../LTspice/Models/National Semiconductor/LMC6482A.lib>) and LTspice's NE555 macromodel. The LMC6482 model is kept in the collection so the schematic stays portable; its header carries no revision date, so switching details may differ from a current release.

The rail-to-rail op amp is not incidental. Alan's change to Pete's original was to run the circuit from a single supply, and that only works if the op amp's output can reach close to both rails.

Alan's drawing marks `VCC` without committing to a voltage, and gives a broad operating range instead. **9 V is a simulation choice** and is stated as such on the schematic. The run also carries `.ic V(OUT)=0 V(CLOCK)=0` so the staircase starts from the bottom rather than from whatever the operating point happens to latch into.

### What the simulation shows

![555 clock, reset pulse and accumulated staircase](<01 - Stairstep generator/Stairstep generator waveforms.png>)

If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Stairstep generator.plt](<01 - Stairstep generator/Stairstep generator.plt>).

The top pane is the result: `V(OUT)` climbing one step per pulse. The two panes below it are the causes, on the same time axis: `V(CLOCK)`, the 555's narrow pulses, and `V(PULSE)`, the slower oscillator that fires the reset.

| Measurement | Result | Meaning |
| --- | ---: | --- |
| `CLK_PERIOD` | 345.1 µs | One 555 cycle, so one step |
| `RESET_PERIOD` | 5.595 ms | The interval between resets, from the slow oscillator |
| `STEPS` | 16.2 | Clock cycles per staircase, as the ratio of the two |
| `OUT_PEAK` | 8.989 V | The highest the output reaches before a reset |

The two oscillators are independent, so `STEPS` need not be a whole number and is not: the reset arrives wherever it arrives in the step sequence.

The plot shows something the ratio alone does not. The staircase does not use all 16 of those cycles, because `OUT_PEAK` of 8.989 V has run into the 9 V rail. Counting the risers in the top pane, the output climbs for about thirteen steps and then sits flat against the supply until the reset comes. That flat top is a real limit of the circuit as simulated at 9 V, and it is the thing to adjust if a particular number of usable steps is wanted: either slow the 555 down, shorten the reset interval, or reduce the charge each pulse delivers.

Everything above describes this simulation at this supply voltage. Alan does not quote step counts or timings for his bench unit, so there is nothing here to compare them against; what can be compared is the shape, and the stepped rise with a fast reset is what his scope shows at 0:15 and 13:00.
