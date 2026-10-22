# Video 079 - Running an op amp from a single supply

Source: Alan Wolke (W2AEW), [#79: Op Amp Power Supply Considerations: split, single, virtual ground, etc. - a tutorial](https://www.youtube.com/watch?v=MtccB9K09ck). Alan's handwritten pages for the lesson are in [W2AEW Video Notes - opamp_power_supplies.pdf](W2AEW%20Video%20Notes%20-%20opamp_power_supplies.pdf).

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=MtccB9K09ck&t=20s) | The title page, and the claim the rest of the video defends: the op amp does not care whether its two supply pins are fed from a split supply or a single one. |
| [1:10](https://www.youtube.com/watch?v=MtccB9K09ck&t=70s) | The two arrangements drawn side by side: plus and minus 5 V against a single plus 10 V, which are the same 10 V as far as the part is concerned. |
| [2:10](https://www.youtube.com/watch?v=MtccB9K09ck&t=130s) | A 100 k pair across the single supply making a midpoint, and the name it usually goes by: a virtual ground. |
| [3:10](https://www.youtube.com/watch?v=MtccB9K09ck&t=190s) | The question that actually decides whether a given op amp will work: how close can its inputs and its output get to either rail. |
| [4:10](https://www.youtube.com/watch?v=MtccB9K09ck&t=250s) | The MC1458 data sheet, which is a pair of 741s on one chip, opened to find that answer. |
| [5:10](https://www.youtube.com/watch?v=MtccB9K09ck&t=310s) | The input and output voltage range entries, and the supply conditions they are specified at. |
| [6:10](https://www.youtube.com/watch?v=MtccB9K09ck&t=370s) | The output voltage swing curves plotted against supply voltage. |
| [6:45](https://www.youtube.com/watch?v=MtccB9K09ck&t=405s) | The test circuit he builds: an inverting stage with 1.5 k in, 2.2 k of feedback and 2.2 k from the reference to the plus input, on a single 10 V supply. See [circuit 01](#01---lm741-supply-example). |
| [8:25](https://www.youtube.com/watch?v=MtccB9K09ck&t=505s) | The scope with all three channels at 2 V per division and the generator at 5.00002 kHz: the input in pink, the reference in blue and the output in yellow. |
| [10:25](https://www.youtube.com/watch?v=MtccB9K09ck&t=625s) | The output flattening against a rail as he moves the reference away from mid-supply. |
| [12:22](https://www.youtube.com/watch?v=MtccB9K09ck&t=742s) | The part he swaps in: an AD8032, a rail-to-rail amplifier in the same 8-pin package. See [circuit 02](#02---ad8032-rail-to-rail-example). |
| [13:07](https://www.youtube.com/watch?v=MtccB9K09ck&t=787s) | The same bench settings with the AD8032 in the socket. |
| [14:40](https://www.youtube.com/watch?v=MtccB9K09ck&t=880s) | The summary: keep the inputs and the output inside the range the data sheet allows, and a single supply is no obstacle. |

## The idea the video is built on

An op amp has two supply pins and no ground pin. It knows nothing about the voltage you call zero; all it sees is the total across those two pins and where its own inputs and output sit inside that span. Powering it from plus and minus 5 V and powering it from a single 0 to 10 V rail present it with exactly the same 10 V.

What changes is where the signal has to sit. With a split supply, zero volts is in the middle of the span and an AC signal can swing both ways around it for free. With a single supply, zero volts is at the bottom, so the signal has to be lifted to a reference partway up the rail before it has room to swing in both directions. That reference is the virtual ground on Alan's page 2, and in the test circuit it is the DC source `V3` feeding the plus input through `R3`.

The reference being there does not make the amplifier work. What makes it work is the reference being placed so that neither the inputs nor the output is ever asked to go somewhere the part cannot reach, and that is what the two circuits below measure.

## 01 - LM741 supply example

Two schematics share this folder: the amplifier at its intended mid-supply reference, and the same amplifier with the reference stepped away from it. The [video shortcut](01%20-%20LM741%20supply%20example/Video%20079%20-%2001%20-%20LM741%20supply%20example.url) opens Alan's drawing of the circuit at [6:35](https://www.youtube.com/watch?v=MtccB9K09ck&t=395s).

![LTspice schematic of the LM741 single-supply amplifier](01%20-%20LM741%20supply%20example/LM741%20single%20supply%20schematic.png)

*The circuit from Alan's page: `V1` is the 10 V single supply, `R2` and `R1` set the inverting gain at 2.2 k over 1.5 k, and `R3` ties the plus input to the reference `V3`. `V2` is the 5 kHz signal, drawn in series with `V3` so the input rides on the reference exactly as it does on his bench. The probe points carry his channel names.*

### At the mid-supply reference

With `V3` at 5 V, [LM741 Op Amp - Single Rail Mode.asc](01%20-%20LM741%20supply%20example/LM741%20Op%20Amp%20-%20Single%20Rail%20Mode.asc) runs the circuit as intended.

| Quantity | Directive | Result |
| --- | --- | --- |
| Output peak | `VOUT_MAX` | 7.93 V |
| Output trough | `VOUT_MIN` | 2.07 V |
| Output peak to peak | `VOUT_PP` | 5.86 V |
| Input peak to peak | `VIN_PP` | 4.00 V |
| Gain magnitude | `GAIN` | 1.465 |

![Simulated input, reference and output at a 5 V reference](01%20-%20LM741%20supply%20example/LM741%20single%20supply%20waveforms.png)

*Three traces on one axis, like Alan's three channels: the input riding on the reference, the flat 5 V reference, and the inverted output. The measured 1.465 is the 2.2 k over 1.5 k the resistors ask for, and the output sits comfortably between the rails.*

### Moving the reference until the output runs out of room

![LTspice schematic of the sweep variant, with the reference as a parameter](01%20-%20LM741%20supply%20example/LM741%20virtual%20ground%20sweep%20schematic.png)

*The same drawing with `V3` written as `{VREF}` and a `.step` directive underneath. The AD8032 folder holds the matching pair, which differ from these two only in the amplifier.*

[LM741 Virtual Ground Sweep.asc](01%20-%20LM741%20supply%20example/LM741%20Virtual%20Ground%20Sweep.asc) steps `VREF` to 2, 5 and 8 V. These three values are a simulation choice. Alan turns his reference by hand and does not state where he puts it, so the three settings here are picked to span the range rather than to copy a number from the bench.

With a gain magnitude of 1.467 on a 2 V peak input, the output wants to swing 2.93 V either side of the reference whatever the reference is. At 2 V that means reaching down to minus 0.93 V, and at 8 V it means reaching up to 10.93 V. Neither is possible on a 0 to 10 V supply, so the only question is how close the part gets before it gives up.

| Reference | Output asked for | `VOUT_MIN` | `VOUT_MAX` |
| ---: | --- | ---: | ---: |
| 2 V | -0.93 V to 4.93 V | 1.03 V | 4.93 V |
| 5 V | 2.07 V to 7.93 V | 2.07 V | 7.93 V |
| 8 V | 5.07 V to 10.93 V | 5.07 V | 8.97 V |

![Simulated LM741 output at three reference settings](01%20-%20LM741%20supply%20example/LM741%20virtual%20ground%20sweep.png)

*One pane per reference setting on a common axis whose top and bottom are the two supply rails. The middle pane is the clean case. In the outer two the output flattens about a volt short of the rail it is heading for, and the flat top or bottom is the part of the sine that simply could not be produced.*

The number worth carrying away is that volt. The 741 output stage cannot get closer than about 1.03 V to either rail in this circuit, which on a 10 V supply costs about a fifth of the available swing before any signal has been asked for.

## 02 - AD8032 rail-to-rail example

The [video shortcut](02%20-%20AD8032%20rail-to-rail%20example/Video%20079%20-%2002%20-%20AD8032%20rail-to-rail%20example.url) opens the moment Alan holds the part up at [12:18](https://www.youtube.com/watch?v=MtccB9K09ck&t=738s). The two schematics here are the same two drawings with one component changed, so the captures can be compared directly against the pair above.

![LTspice schematic of the AD8032 single-supply amplifier](02%20-%20AD8032%20rail-to-rail%20example/AD8032%20single%20supply%20schematic.png)

*Identical to the 741 drawing apart from the amplifier itself.*

### At the mid-supply reference

| Quantity | Directive | Result |
| --- | --- | --- |
| Output peak | `VOUT_MAX` | 7.93 V |
| Output trough | `VOUT_MIN` | 2.07 V |
| Gain magnitude | `GAIN` | 1.465 |

![Simulated AD8032 waveforms at a 5 V reference](02%20-%20AD8032%20rail-to-rail%20example/AD8032%20single%20supply%20waveforms.png)

*Indistinguishable from the 741 at this reference, which is the point: when nothing is near a rail, the expensive part buys nothing.*

### The same sweep

| Reference | Output asked for | `VOUT_MIN` | `VOUT_MAX` |
| ---: | --- | ---: | ---: |
| 2 V | -0.93 V to 4.93 V | 0.035 V | 4.93 V |
| 5 V | 2.07 V to 7.93 V | 2.07 V | 7.93 V |
| 8 V | 5.07 V to 10.93 V | 5.07 V | 9.96 V |

![Simulated AD8032 output at three reference settings](02%20-%20AD8032%20rail-to-rail%20example/AD8032%20virtual%20ground%20sweep.png)

*The same three settings on the same axis. The output still clips, because minus 0.93 V and 10.93 V remain impossible, but it now clips 35 mV from the rail instead of a volt from it.*

Putting the two sweeps side by side gives the comparison in one line: at the extreme references the 741 keeps 1.03 V away from the rail it is heading for and the AD8032 keeps 0.035 V away, a factor of about thirty. A rail-to-rail part does not remove the limit, it moves it almost all the way out to the supply.

## Models and limits

Both amplifiers use the macromodels that ship with LTspice: `LM741` from its `LM741.lib` and the `AD8032` symbol, which netlists to the shared `AD8031` amplifier macromodel in LTspice's `ADI.lib`. Neither needs a file from this repository. Analog Devices' [AD8031/AD8032 data sheet](https://www.analog.com/media/en/technical-documentation/data-sheets/AD8031_8032.pdf) specifies rail-to-rail input and output for that family.

The part Alan actually has in the socket for the first half is an MC1458, the dual 741 whose data sheet he reads at 4:10. The LM741 model stands in for one half of it.

What the simulation can and cannot say is worth separating. The gain, the clipping levels relative to the reference, and the shape of the clipped waveform are set by the circuit and come out of the models reliably. The exact headroom figures, the 1.03 V and the 0.035 V, are macromodel outputs rather than guaranteed limits: a real output stage's headroom depends on load current, temperature and the particular device, and the data sheet's numbers are specified under conditions this test fixture does not reproduce.

The 2 V peak at 5 kHz is read off Alan's scope, where all three channels are set to 2 V per division and the frequency counter reads 5.00002 kHz. The 2, 5 and 8 V reference settings are not his; they are chosen to put the output comfortably inside the rails once and hard against them twice.
