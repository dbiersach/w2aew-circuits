# Video 82: How to use a diode as a switch

Source: Alan Wolke (W2AEW), [#82: How to use a Diode as a Switch / Diodes as Switches / Basics of Diode Switches](https://www.youtube.com/watch?v=YBNIq_d56sA).

| Time | What Alan shows |
| --- | --- |
| [4:31](https://www.youtube.com/watch?v=YBNIq_d56sA&t=271s) | [What Alan demonstrates](#what-alan-demonstrates) |
| [4:31](https://www.youtube.com/watch?v=YBNIq_d56sA&t=271s) | [01 - 1N4007 rectifier as a switch](#01---1n4007-rectifier-as-a-switch) |
| [8:36](https://www.youtube.com/watch?v=YBNIq_d56sA&t=516s) | [02 - 1N4148 switching diode](#02---1n4148-switching-diode) |

## What Alan demonstrates

A forward-biased series diode conducts a small RF signal; removing the DC bias current makes the same diode block it. At [4:31](https://www.youtube.com/watch?v=YBNIq_d56sA&t=271s) Alan introduces the practical circuit and tests a 1N4007 rectifier with a 455 kHz, 50 mV peak-to-peak signal and two approximately 390 ohm bias resistors. At [7:53](https://www.youtube.com/watch?v=YBNIq_d56sA&t=473s) he raises the generator to 8.83 MHz, and signal now reaches the scope even with the bias removed: the rectifier's junction capacitance bypasses the open switch. At [8:36](https://www.youtube.com/watch?v=YBNIq_d56sA&t=516s) he substitutes a 1N4148 switching diode, whose much smaller junction capacitance restores the off-state isolation. The later part of the video introduces series and shunt switching and PIN diodes without giving a fully specified bench circuit for them.

The two circuits below follow that sequence: the same fixture is simulated at both of Alan's frequencies, once with each diode.

## The simulated fixture

Both circuits use the topology Alan draws. The generator feeds the diode's anode through a 10 nF coupling capacitor. R1 (390 ohm) carries the DC bias current from V2 down into the anode; R2 (390 ohm) returns that current to ground from the cathode and loads the signal path. A second 10 nF capacitor passes the switched signal to the 1 Meg oscilloscope input.

`V2` is stepped between the two states Alan shows, 0 V (switch off) and 2.3 V (switch on). The 2.3 V value is chosen to put roughly 2 mA through the two 390 ohm resistors and the diode, matching the bias current Alan describes; it is not a supply voltage stated in the video. The 10 nF coupling capacitors and the 1 Meg scope load are also simulation choices, because the video does not specify them.

The diodes are the `1N4007` and `1N4148` entries in LTspice's installed `standard.dio` library. In that library the 1N4007 junction capacitance is roughly 30 pF against roughly 4 pF for the 1N4148, which is the device difference Alan describes with his bench parts. No custom diode `.model` is used anywhere in this chapter.

Each simulation measures the generator and the scope voltage with `.meas tran ... PP`, so the attenuation quoted below comes from the run rather than from reading the trace.

## 01 - 1N4007 rectifier as a switch

Introduced at [4:31](https://www.youtube.com/watch?v=YBNIq_d56sA&t=271s). Files: [`1N4007 455 kHz switch.asc`](<01 - 1N4007 diode switch/1N4007 455 kHz switch.asc>) and [`1N4007 8.83 MHz comparison.asc`](<01 - 1N4007 diode switch/1N4007 8.83 MHz comparison.asc>).

![1N4007 switch fixture at 455 kHz](<01 - 1N4007 diode switch/1N4007 455 kHz schematic.png>)

*The fixture at Alan's first test frequency. The bias branch (V2 and R1) sits above the signal path, which runs left to right from the generator through the coupling capacitor, the diode, and the output capacitor to the 1 Meg scope load.*

![1N4007 switching at 455 kHz](<01 - 1N4007 diode switch/1N4007 455 kHz switching.png>)

*At 455 kHz the switch works as intended. Top pane: with 2.3 V of bias the scope sees 51.0 mV p-p, essentially the whole generator signal. Middle pane: with the bias removed only 1.7 mV p-p survives, an attenuation of about 30 dB. Bottom pane: the 50.0 mV p-p generator, drawn on the same vertical scale so the three panes can be compared directly.*

![1N4007 455 kHz measurements](<01 - 1N4007 diode switch/1N4007 455 kHz SPICE output log.png>)

*The `.meas` results for the 455 kHz run. Step 1 is the off state (V2 = 0 V) and step 2 the on state (V2 = 2.3 V).*

Raising the generator to 8.83 MHz, Alan's second test, changes the result completely.

![1N4007 switch fixture at 8.83 MHz](<01 - 1N4007 diode switch/1N4007 8.83 MHz schematic.png>)

*The same fixture with the generator at 8.83 MHz and the transient window shortened to 2 us.*

![1N4007 feedthrough at 8.83 MHz](<01 - 1N4007 diode switch/1N4007 8.83 MHz feedthrough.png>)

*The off state no longer blocks. Middle pane: with no bias current at all, 27.2 mV p-p still reaches the scope through the rectifier's junction capacitance, slightly more than half the generator signal and only about 5 dB down. This is the failure Alan shows on his bench.*

![1N4007 8.83 MHz measurements](<01 - 1N4007 diode switch/1N4007 8.83 MHz SPICE output log.png>)

*The `.meas` results for the 8.83 MHz run.*

## 02 - 1N4148 switching diode

Introduced at [8:36](https://www.youtube.com/watch?v=YBNIq_d56sA&t=516s). Files: [`1N4148 455 kHz switch.asc`](<02 - 1N4148 diode switch/1N4148 455 kHz switch.asc>) and [`1N4148 8.83 MHz comparison.asc`](<02 - 1N4148 diode switch/1N4148 8.83 MHz comparison.asc>).

Alan swaps the rectifier for a small-signal switching diode and repeats the 8.83 MHz test. The 455 kHz run here has no bench counterpart in the video; it is included so the two devices can be compared at both frequencies with everything else unchanged.

![1N4148 switch fixture at 455 kHz](<02 - 1N4148 diode switch/1N4148 455 kHz schematic.png>)

*The same fixture with a 1N4148 in place of the 1N4007. Nothing else changes.*

![1N4148 switching at 455 kHz](<02 - 1N4148 diode switch/1N4148 455 kHz switching.png>)

*At 455 kHz the off state is essentially silent: 0.2 mV p-p, a flat line on this scale and about 47 dB below the generator. The on state passes 48.4 mV p-p.*

![1N4148 455 kHz measurements](<02 - 1N4148 diode switch/1N4148 455 kHz SPICE output log.png>)

*The `.meas` results for the 1N4148 at 455 kHz.*

![1N4148 switch fixture at 8.83 MHz](<02 - 1N4148 diode switch/1N4148 8.83 MHz schematic.png>)

*The 1N4148 fixture at Alan's second test frequency.*

![1N4148 isolation at 8.83 MHz](<02 - 1N4148 diode switch/1N4148 8.83 MHz isolation.png>)

*At 8.83 MHz the off state leaks 4.3 mV p-p rather than the rectifier's 27.2 mV. The isolation is about 21 dB instead of about 5 dB, which is why Alan reaches for a switching diode once the frequency rises.*

![1N4148 8.83 MHz measurements](<02 - 1N4148 diode switch/1N4148 8.83 MHz SPICE output log.png>)

*The `.meas` results for the 1N4148 at 8.83 MHz.*

## The two devices side by side

Every figure below is a `PP(V(vout))` measurement from the run, against a 50.0 mV p-p generator.

| Frequency | Diode | Off state (V2 = 0 V) | On state (V2 = 2.3 V) | Off-state attenuation |
| --- | --- | --- | --- | --- |
| 455 kHz | 1N4007 | 1.7 mV p-p | 51.0 mV p-p | about 30 dB |
| 455 kHz | 1N4148 | 0.2 mV p-p | 48.4 mV p-p | about 47 dB |
| 8.83 MHz | 1N4007 | 27.2 mV p-p | 50.1 mV p-p | about 5 dB |
| 8.83 MHz | 1N4148 | 4.3 mV p-p | 48.8 mV p-p | about 21 dB |

Both diodes pass the signal equally well when biased on, so the on state tells you almost nothing about which part to choose. The off state is where they separate, and the separation grows with frequency: at 455 kHz the rectifier is already about 17 dB worse than the switching diode, and at 8.83 MHz it is about 16 dB worse and no longer usable as a switch. That is the lesson of the video.

The on-state figures sit within a few percent of the generator; the small excess over 50.0 mV comes from the start of the window, where the coupling capacitors are still settling. These are simulated results from the installed library models. They show the same device behaviour Alan measures, not the exact numbers his particular parts produce.

## Reproducing the plots

Open a schematic, press **Run**, and if the waveform window opens autoscaled press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`. Each plot puts the on state on top, the off state in the middle, and the generator at the bottom, all on one vertical scale.

Because `V2` is stepped, the output traces are written as `V(vout)@2` (on) and `V(vout)@1` (off), one per pane. LTspice draws such a trace once per step, which makes it look speckled; open **Plot Settings > Select Steps**, clear **Auto Range**, select a single step and click OK to get the clean single-colour traces shown above. The saved vertical limits then stay as they are in these captures.
