# Video 56: Capacitor and inductor self-resonance and parasitics

Source: Alan Wolke (W2AEW), [#56: Basics of Capacitor & Inductor self-resonance, parasitics, etc. - Tutorial](https://www.youtube.com/watch?v=vi24SpKYYoQ). His handwritten notes for the lesson are kept here as [W2AEW Video Notes - Parasitics_and_Self-Resonance.pdf](<W2AEW Video Notes - Parasitics_and_Self-Resonance.pdf>).

| Time | What Alan shows |
| --- | --- |
| [1:00](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=60s) | The resonance formula rearranged three ways, so that any one of f, L and C follows from the other two. |
| [3:20](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=200s) | The point that infinitely many LC pairs share a resonance: 1 pF with 253 uH and 1 uF with 253 pH both land on 10 MHz. |
| [5:00](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=300s) | Component leads have inductance. Two inches, or 5 cm, of 22 AWG wire is about 57 nH. |
| [7:20](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=440s) | A "103" capacitor and where its parasitics come from: dielectric loss, lead inductance, lead resistance and skin effect. |
| [7:50](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=470s) | The real world capacitor model, reproduced in [01 - Real world capacitor](#01---real-world-capacitor). |
| [13:40](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=820s) | Inductors: the winding has resistance and skin-effect loss, and the turns have capacitance between them. |
| [14:10](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=850s) | The real world inductor model and Q = XL / Rs, reproduced in [02 - Real world inductor](#02---real-world-inductor). |
| [17:00](https://www.youtube.com/watch?v=vi24SpKYYoQ&t=1020s) | Adding a magnetic core cuts the turns count but introduces another loss term, drawn as Rp across the winding capacitance. |

## What the lesson establishes

Every component is a network, not a single element. A capacitor carries the series resistance and inductance of its leads and plates and the loss of its dielectric; an inductor carries the resistance and skin-effect loss of its wire and the capacitance between its turns. At some frequency the stray reactance equals the intended one, and the part self-resonates. Above that frequency it behaves as the opposite kind of component: a capacitor looks inductive, and an inductor looks capacitive.

Alan's arithmetic at 3:20 is the reason the effect is unavoidable rather than a manufacturing defect. Resonance fixes only the product of L and C, so a given frequency has no unique pair. At 10 MHz, 1 pF resonates with 253 uH and 1 uF resonates with 253 pH; both satisfy `f = 1 / (2*pi*sqrt(L*C))`, which rearranges to `L = 1 / (39.48 * f^2 * C)`. Stray values of a few nanohenries or a few picofarads are therefore enough to put a self-resonance inside the range a circuit actually works in.

This video is a whiteboard tutorial. Alan draws both equivalent circuits and reasons about their impedance curves, but he does not measure a physical part, so there is no bench reading for the simulations to match. What the two schematics below reproduce is his topology and the shape of the curve he sketches.

Both circuits are driven by a 1 A AC current source, so the node voltage `V(Z)` is numerically the impedance of the model in ohms. That is the one departure from a breadboardable circuit: it is a measurement probe rather than a part, and it is what makes Alan's impedance-against-frequency axes reproducible. Note that the `.meas` lines in the SPICE log report `mag(V(Z))` in decibels, which here means decibels relative to 1 ohm, while the plots read directly in ohms. Both numbers are quoted below.

## 01 - Real world capacitor

[Schematic](<01 - Real world capacitor/Real world capacitor.asc>) - [Saved plot settings](<01 - Real world capacitor/Real world capacitor.plt>) - [Video at 7:50](<01 - Real world capacitor/Video 056 - 01 - Real world capacitor.url>)

Alan's page-2 drawing is `Rs` and `L` in series with the capacitance, and `Rp` across the capacitance for dielectric leakage. The schematic follows that exactly.

![Real world capacitor schematic copied from LTspice](<01 - Real world capacitor/Real world capacitor schematic.png>)

Two of the values are Alan's own. `C` is 10 nF, the part marked "103" that he holds up at 7:20. `L` is 57 nH, his figure for two inches of 22 AWG lead. `Rs` and `Rp` he draws without giving values, so 0.1 ohm and 10 Mohm are illustrative; they set how deep the notch goes and how much the dielectric leaks, not whether the resonance happens.

![Real world capacitor impedance against frequency, copied from LTspice](<01 - Real world capacitor/Real world capacitor impedance sweep.png>)

The sweep is `.ac dec 200 10k 1G`, so the horizontal axis is logarithmic frequency, not time. Reading left to right, the impedance falls along the capacitive line `1 / (2*pi*f*C)`, reaches a sharp minimum, then climbs along the inductive line `2*pi*f*L`. The `.meas` results put numbers on all three regions:

| Frequency | Simulated `V(Z)` | As impedance | What sets it |
| --- | ---: | ---: | --- |
| 100 kHz | 44.03 dB | 159.1 ohm | the 10 nF, since `1/(2*pi*f*C)` is 159.2 ohm |
| 6.666 MHz | -19.91 dB | 0.101 ohm | `Rs`, because the reactances have cancelled |
| 100 MHz | 31.04 dB | 35.7 ohm | the 57 nH, since `2*pi*f*L` is 35.8 ohm |

The minimum lands at 6.67 MHz, which is `1 / (2*pi*sqrt(57 nH * 10 nF))`, and its value is the series resistance, matching the "approximately Rs" that Alan writes at the bottom of his sketched curve. Above that frequency the part is no longer usable as a 10 nF capacitor: at 100 MHz it presents 35.7 ohm and rising, which is what makes lead length matter for a bypass capacitor.

## 02 - Real world inductor

[Schematic](<02 - Real world inductor/Real world inductor.asc>) - [Saved plot settings](<02 - Real world inductor/Real world inductor.plt>) - [Video at 14:10](<02 - Real world inductor/Video 056 - 02 - Real world inductor.url>)

Alan's page-3 drawing is `Rs` in series with `L`, with the interwinding capacitance `Cw` across the pair. The schematic follows that.

![Real world inductor schematic copied from LTspice](<02 - Real world inductor/Real world inductor schematic.png>)

Alan gives no values for this model at all, so every value here is illustrative and chosen for a small air-cored RF choke: 10 uH with 5 pF between the windings, and 25 ohm of series resistance standing for the winding resistance plus the skin-effect loss he describes at 13:40. Changing them moves the resonance and the height of the peak; it does not change the shape.

![Real world inductor impedance against frequency, copied from LTspice](<02 - Real world inductor/Real world inductor impedance sweep.png>)

| Frequency | Simulated `V(Z)` | As impedance | What sets it |
| --- | ---: | ---: | --- |
| 1 MHz | 36.62 dB | 67.8 ohm | `Rs` and the 10 uH together, since the magnitude of `25 + j62.8` is 67.6 ohm |
| 22.51 MHz | 97.75 dB | 77.1 kohm | the parallel resonance of the 10 uH against the 5 pF |
| 200 MHz | 44.15 dB | 161.2 ohm | the 5 pF, since `1/(2*pi*f*Cw)` is 159.2 ohm |

Below about 100 kHz the trace is flat at 25 ohm, because `Rs` is larger than the reactance of 10 uH down there. It then rises as `2*pi*f*L`, peaks at 79.7 kohm, and falls again along the capacitive line. The peak is the mirror image of the capacitor's notch, and it is why a choke stops choking above its self-resonance.

The `Rs` value is doing visible work in this plot. With a 1 ohm winding resistance the Q would be about 1400 and the resonance would be narrower than the frequency steps of the sweep, so the peak LTspice drew would be an artefact of where the sweep points happened to fall rather than a result. At 25 ohm the peak is resolved by the `.ac dec 500` sweep and can be read honestly.

Alan also notes at 17:00 that a magnetic core adds a further frequency-dependent and current-dependent loss, drawn as `Rp` across `Cw`. That variation is not simulated here.

## Running these in LTspice

Open either schematic and press Run. If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up the saved `.plt`, which sets the logarithmic ohms axis and the labels. The `.meas` results appear in View > SPICE Output Log.
