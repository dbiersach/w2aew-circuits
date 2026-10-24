# Video 83: Basics of RF mixers in radio receivers

Source: Alan Wolke (W2AEW), [#83: Basics of RF Mixers in Radio Receivers / Mixer Tutorial / Frequency Conversion](https://www.youtube.com/watch?v=Mm7WfVzr1ao). Alan's [handwritten mixer notes](<W2AEW Video Notes - RFmixersheterodyne.pdf>) show the NE602AN wiring he uses.

| Time | What Alan shows |
| --- | --- |
| [5:50](https://www.youtube.com/watch?v=Mm7WfVzr1ao&t=350s) | [What Alan demonstrates](#what-alan-demonstrates) |
| [5:50](https://www.youtube.com/watch?v=Mm7WfVzr1ao&t=350s) | [01 - Transformer-coupled mixer, the connection Alan's notes show](#01---transformer-coupled-mixer-the-connection-alans-notes-show) |
| [5:50](https://www.youtube.com/watch?v=Mm7WfVzr1ao&t=350s) | [02 - Single-ended connection, for comparison](#02---single-ended-connection-for-comparison) |

## What Alan demonstrates

A mixer multiplies two signals, and the product contains the sum and difference of their frequencies. That is how a receiver moves a signal from wherever it arrives to a fixed intermediate frequency where the selectivity and gain live.

From about [5:50](https://www.youtube.com/watch?v=Mm7WfVzr1ao&t=350s) Alan drives an NE602A mixer board with a **28.4 MHz RF signal at about -30 dBm** and an external **17.7 MHz local oscillator at about 0 dBm**. The difference, 28.4 - 17.7 = **10.7 MHz**, is the standard FM intermediate frequency; the sum is 46.1 MHz. On the spectrum analyser he also points out 7 MHz (2 fLO - fRF), 24.7 MHz (3 fLO - fRF) and 35.4 MHz (2 fLO), the products that come from the mixer and LO not being perfectly linear or perfectly balanced.

His notes specify a 5 V supply, a 0.01 uF supply bypass, and a 50 ohm LO termination, with the RF and IF ports transformer-coupled to the differential pin pairs. They do not give transformer winding ratios, inductances or load impedances, so those are modeling choices here and are labeled as such on the schematics.

## The NE602A model

Both NE602A circuits place [LTspice/Symbols/sa612.asy](<../LTspice/Symbols/sa612.asy>), whose implementation is [LTspice/Symbols/SA612.asc](<../LTspice/Symbols/SA612.asc>): a schematic-level model of the NE602/SA612 written by **Joe Rocci, W3JDR**, included here with his readme ([`SA612 model readme - Joe Rocci W3JDR.txt`](<../LTspice/Symbols/SA612 model readme - Joe Rocci W3JDR.txt>)). His readme states the model was built by analyzing the datasheet schematic and measuring DC pin voltages and currents, filling in the unknown blocks from informed assumptions, and that it is not fully AC tested. [NXP has stated it does not provide an SA612A SPICE model](https://community.nxp.com/t5/Other-NXP-Products/SPICE-model-for-the-SA612A/m-p/714734), so there is no manufacturer alternative.

Treat the levels below as what this model does, not as measurements of Alan's board. The relative comparisons between the two connection styles are the useful part.

`NE602A` is the electrical device; `NE602AN` is the 8-pin plastic DIP order code, so the final letter is the package rather than a different mixer.

## 01 - Transformer-coupled mixer, the connection Alan's notes show

Introduced at [5:50](https://www.youtube.com/watch?v=Mm7WfVzr1ao&t=350s). File: [`NE602A transformer-coupled mixer.asc`](<01 - NE602A transformer-coupled mixer/NE602A transformer-coupled mixer.asc>).

![Transformer-coupled NE602A mixer](<01 - NE602A transformer-coupled mixer/NE602A transformer-coupled schematic.png>)

*The RF generator feeds a 1:1 transformer whose secondary drives pins 1 and 2 differentially. Pins 4 and 5 drive the IF transformer primary, and its secondary feeds the 1 kohm load. The LO reaches pin 6 through a 1 nF capacitor with its 50 ohm termination on the generator side, pin 3 is grounded, pin 7 is left open because the oscillator is driven externally, and pin 8 sits at 5 V behind a 10 nF bypass. The 1 uH and 100 uH winding inductances, the 0.99 coupling and the 1 kohm load are modeling assumptions; Alan gives no winding values.*

The source amplitudes set Alan's levels into matched 50 ohm terminations: 20 mV peak open circuit is -30 dBm of RF, and 0.63246 V peak open circuit is 0 dBm of LO.

![RF, LO and raw IF in time](<01 - NE602A transformer-coupled mixer/NE602A transformer-coupled IF waveform.png>)

*A 500 ns slice of the 40 us run. Top: the raw IF across the 1 kohm load, which is every product at once, so its envelope rises and falls as the 10.7 MHz difference and the 46.1 MHz sum drift in and out of phase. Middle and bottom: the LO and RF generators at their own scales.*

![IF spectrum](<01 - NE602A transformer-coupled mixer/NE602A transformer-coupled IF spectrum.png>)

*The FFT of the same IF node, 0 to 55 MHz. The difference product at 10.7 MHz and the sum at 46.1 MHz dominate, 0.4 dB apart. The 28.4 MHz RF leakage sits 45 dB below them and the 17.7 MHz LO leakage is not visible at all, 109 dB down: that cancellation is what the balanced connection buys. The 24.7 MHz line is the 3 fLO - fRF product Alan identifies on his analyser, and there is a 7 MHz line (2 fLO - fRF) at the left for the same reason.*

| Component in the IF output | Level | Relative to the 10.7 MHz IF |
| --- | --- | --- |
| 10.7 MHz difference | -28.3 dBV | reference |
| 46.1 MHz sum | -28.7 dBV | 0.4 dB below |
| 28.4 MHz RF leakage | -73.5 dBV | 45 dB below |
| 17.7 MHz LO leakage | -137.5 dBV | 109 dB below |

## 02 - Single-ended connection, for comparison

Introduced at [5:50](https://www.youtube.com/watch?v=Mm7WfVzr1ao&t=350s) as the same circuit; this version is an LTspice variation, not a second build shown in the video. File: [`NE602A single-ended.asc`](<02 - NE602A single-ended/NE602A single-ended.asc>).

![Single-ended NE602A mixer](<02 - NE602A single-ended/NE602A single-ended schematic.png>)

*Both transformers are replaced by 1 nF capacitors. RF enters pin 1 through one capacitor; a second capacitor gives pin 2 an RF return to ground without disturbing its DC bias. Pin 4 drives the 1 kohm load through a third capacitor and pin 5 is left open, so only half of the differential output is used. Everything else, including the sources, supply and LO coupling, is unchanged from circuit 01.*

![RF, LO and raw IF in time](<02 - NE602A single-ended/NE602A single-ended IF waveform.png>)

*The same 500 ns slice on the same vertical scales as circuit 01, so the two can be compared directly.*

![IF spectrum](<02 - NE602A single-ended/NE602A single-ended IF spectrum.png>)

*The wanted products are nearly as strong, but both generators now reach the output. The LO leakage has risen to 34 dB below the IF and the RF leakage to 23 dB below it.*

| Component in the IF output | Circuit 01, transformers | Circuit 02, single-ended |
| --- | --- | --- |
| 10.7 MHz difference | -28.3 dBV | -30.1 dBV |
| 46.1 MHz sum | -28.7 dBV | -30.9 dBV |
| 28.4 MHz RF leakage | -73.5 dBV | -53.4 dBV |
| 17.7 MHz LO leakage | -137.5 dBV | -64.4 dBV |

Reading the table across: the transformers cost nothing worth noticing in conversion, 1.8 dB, and buy 20 dB of RF rejection and 73 dB of LO rejection. A capacitor blocks DC, but it cannot produce the opposite-polarity signal that lets the mixer's two inputs cancel what is common to them. That is the practical reason Alan's board uses transformers on both the RF and IF ports.

## An illustrative single-diode mixer

[`Nonlinear RF frequency conversion example.asc`](<Illustrative single-diode mixing example/Nonlinear RF frequency conversion example.asc>) is not Alan's circuit. It is kept here because it shows, with four parts, where mixing products come from in the first place.

![Single-diode mixer](<Illustrative single-diode mixing example/Single-diode mixer schematic.png>)

*Two generators drive a 1N4148 through their own 50 ohm resistors. The diode's curved I-V characteristic is the nonlinearity that multiplies them, and the 1 kohm and 100 pF at the output roll off above about 1.6 MHz so the difference product survives while the sum does not. The frequencies, 7 MHz against 7.455 MHz, are chosen to land on 455 kHz, the classic AM intermediate frequency.*

![Single-diode mixer spectrum](<Illustrative single-diode mixing example/Single-diode mixer spectrum.png>)

*The 455 kHz difference appears as promised, at -47.4 dBV. But the 7.455 MHz LO comes straight through at -35.9 dBV, 11 dB stronger than the wanted product, because nothing in a single-diode mixer cancels it. Compare that with the 109 dB of LO rejection in circuit 01 and the value of a balanced mixer is obvious.*

## Reproducing these figures

For the time-domain views, open a schematic and press **Run**. If the waveform window opens autoscaled, press **Ctrl+Space** (Plot Settings > Reload Plot Settings).

**To see a spectrum exactly as it appears above**, run the schematic, then with the waveform window in front choose **View > FFT**. The dialog opens with whichever trace was last active already highlighted, so **click the output trace to select it on its own**: `V(if_raw)` for the two NE602A circuits, or `V(out)` for the diode example. Picking a source trace such as `V(rf_src)` gives a single line at the generator frequency and nothing else, and the saved plot settings will have no trace to attach to. Leave the windowing function at none and click OK.

Then choose **Plot Settings > Open Plot Settings File** and pick the `... spectrum.plt` beside the schematic. That restores the frequency range, the dB scale, the labels and the arrows in one step. LTspice writes the FFT data beside the circuit as a `.fft` file as it goes, and a later FFT run overwrites that file with whichever traces were selected then.

Each transient saves a window whose length holds a whole number of cycles of both tones, 40 us for the NE602A circuits and 200 us for the diode example. That is why the FFT lines are clean without any windowing function: an incoherent window would smear every peak. LTspice normalises FFT magnitudes to the RMS amplitude of the time-domain signal, so -28.3 dBV is 38 mV RMS, or 54 mV peak.
