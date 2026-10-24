# Video 413: Cascading common-emitter amplifiers

Source: Alan Wolke (W2AEW), [#413: Cascading Common-Emitter Amplifiers using an Emitter Follower](https://www.youtube.com/watch?v=pAUYDPwCMj4). His three pages of notes are kept here as [W2AEW Video Notes - Cascade-Common-Emitter-Amplifiers.pdf](<W2AEW Video Notes - Cascade-Common-Emitter-Amplifiers.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:10](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=10s) | The single stage carried over from [video 412](<../412 - Common Emitter Amplifier - Input and Output Impedance/CIRCUIT_NOTES.md>) and its three numbers: about 6.5 kΩ input impedance, 6.8 kΩ output impedance and 6.6 V/V of unloaded gain. |
| [1:10](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=70s) | Two of those stages cascaded on the bench, and the disappointment: the measured gain is nowhere near 6.6 squared. |
| [2:04](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=124s) | Why, on the scope: the first stage's collector swing is much smaller than it was on its own, reproduced in [01 - Direct common-emitter cascade](#01---direct-common-emitter-cascade). |
| [2:40](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=160s) | The arithmetic. The second stage's input impedance appears in parallel with the first stage's collector resistor, so the first stage works into 6.8 kΩ parallel 6.5 kΩ, about 3.3 kΩ. Its gain halves to about 3.3 V/V and the pair gives about 22 V/V rather than 44. |
| [4:06](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=246s) | The fix: an emitter follower between the stages, because it has high input impedance so it does not load the first stage, and low output impedance so the second stage cannot load it. |
| [4:40](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=280s) | The buffered circuit with its 20 kΩ emitter resistor, reproduced in [02 - Emitter-follower buffered cascade](#02---emitter-follower-buffered-cascade). |
| [5:10](https://www.youtube.com/watch?v=pAUYDPwCMj4&t=310s) | The bench again with the buffer in place, and the gain restored to about 43 V/V. |

## What the lesson establishes

Two amplifiers with a gain of 6.6 each do not make an amplifier with a gain of 44. The reason is that the gain of a common-emitter stage depends on what its collector works into, and the thing its collector works into is the next stage's input impedance. Those two numbers here are both in the kilohm range, so connecting them roughly halves the first stage's load resistance and therefore its gain.

This is not a flaw in either stage. It is what happens whenever a circuit with a high output impedance drives one with a comparable input impedance, and the general cure is the same: put something between them that looks like a light load on one side and a stiff source on the other. An emitter follower does exactly that, trading its lack of voltage gain for a large impedance transformation.

Both circuits reuse the stage from video 412: a 12 V supply, a 47 kΩ / 8.2 kΩ base divider, a 6.8 kΩ collector resistor and a 1 kΩ unbypassed emitter resistor. Each stage inverts, so the two-stage output is back in phase with the input.

## 01 - Direct common-emitter cascade

[01 - Direct common-emitter cascade/Direct common-emitter cascade.asc](<01 - Direct common-emitter cascade/Direct common-emitter cascade.asc>) is the unbuffered pair, with the shortcut [Video 413 - 01 - Direct common-emitter cascade.url](<01 - Direct common-emitter cascade/Video 413 - 01 - Direct common-emitter cascade.url>) opening the video where Alan takes it apart.

![LTspice schematic of the direct two-stage cascade](<01 - Direct common-emitter cascade/Direct common-emitter cascade schematic.png>)

A coupling capacitor joins the first collector to the second stage's biased input. Nothing else separates them, so the second stage's input impedance sits across the first stage's collector resistor for AC.

![Input, loaded first collector and output](<01 - Direct common-emitter cascade/Direct common-emitter cascade LTspice plot.png>)

The panes follow the signal: the biased input, the first collector, and the AC-coupled output.

![SPICE measurements for the direct cascade](<01 - Direct common-emitter cascade/Direct common-emitter cascade SPICE measurements.png>)

| Measurement | Result |
| --- | ---: |
| `IN_PP` | 19.832 mV |
| `STAGE1_PP` | 65.144 mV |
| `OUT_PP` | 426.620 mV |
| `TOTAL_GAIN` | **21.51 V/V** |

The first stage manages 65.144 over 19.832, or 3.28 V/V, which is half the 6.6 it gives unloaded and matches Alan's estimate of about 3.3. The overall 21.51 V/V is close to his rounded 22.

## 02 - Emitter-follower buffered cascade

[02 - Emitter-follower buffered cascade/Emitter-follower buffered cascade.asc](<02 - Emitter-follower buffered cascade/Emitter-follower buffered cascade.asc>) adds the buffer, with its own shortcut [Video 413 - 02 - Emitter-follower buffered cascade.url](<02 - Emitter-follower buffered cascade/Video 413 - 02 - Emitter-follower buffered cascade.url>).

![LTspice schematic of the buffered cascade](<02 - Emitter-follower buffered cascade/Emitter-follower buffered cascade schematic.png>)

The first collector now drives a common-collector stage whose emitter, loaded by the 20 kΩ resistor from Alan's notes, feeds the second common-emitter stage through a coupling capacitor.

![Input, first collector with buffer emitter, and output](<02 - Emitter-follower buffered cascade/Emitter-follower buffered cascade LTspice plot.png>)

The middle pane carries both the first collector and the buffer emitter. They sit at different DC levels, so compare their AC swings rather than their positions.

![SPICE measurements for the buffered cascade](<02 - Emitter-follower buffered cascade/Emitter-follower buffered cascade SPICE measurements.png>)

| Measurement | Result |
| --- | ---: |
| `IN_PP` | 19.830 mV |
| `STAGE1_PP` | 129.933 mV |
| `BUFFER_PP` | 126.652 mV |
| `OUT_PP` | 829.461 mV |
| `TOTAL_GAIN` | **41.83 V/V** |

Three numbers tell the story. The first stage's swing has gone from 65.144 mV to 129.933 mV, which is 6.55 V/V, its unloaded figure recovered almost exactly. The follower passes 126.652 of those 129.933 mV, or 97.5%, which is the small price of its lack of voltage gain. And the complete circuit reaches 41.83 V/V against Alan's approximate 43, nearly double the unbuffered result.

## Modeling and measurement scope

Both schematics use LTspice's bundled 2N2222, since Alan's handout does not name the transistor. The 10 mV 1 kHz source, its 50 Ω source resistance, the 4.7 µF coupling capacitors and the 1 MΩ scope load are simulation choices where his handout gives no values. Measurements are taken over the last five milliseconds of the run, after the coupling capacitors have settled.

Alan's 22 and 43 are rounded estimates from impedance arithmetic, not targets, so the agreement to within a few percent is as close as the comparison can meaningfully get. A different transistor model, or a different load on the output, would move both numbers.
