# Video 147: Varactor diodes and a voltage controlled oscillator

Source: Alan Wolke (W2AEW), [#147: Basics of Varactor Diodes | Voltage Controlled Oscillator VCO Example](https://www.youtube.com/watch?v=icw8terKP-M). His two pages of notes are kept here as [W2AEW Video Notes - Varactor_diodes_with_VCO_example.pdf](<W2AEW Video Notes - Varactor_diodes_with_VCO_example.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:10](https://www.youtube.com/watch?v=icw8terKP-M&t=10s) | What a varactor is. Every diode behaves as a voltage-dependent capacitor when reverse biased; a varactor is one optimised for the job, with lower loss and higher Q. |
| [0:45](https://www.youtube.com/watch?v=icw8terKP-M&t=45s) | The mechanism, drawn on the junction: the depletion region is the insulating gap, and the P and N regions either side of it are the plates. |
| [1:20](https://www.youtube.com/watch?v=icw8terKP-M&t=80s) | Reverse bias widens that depletion region, which moves the plates further apart, so the capacitance falls as the control voltage rises. |
| [1:54](https://www.youtube.com/watch?v=icw8terKP-M&t=114s) | The bias arrangement used to measure it, reproduced in [02 - Varactor reverse-bias demonstration](#02---varactor-reverse-bias-demonstration). Note that his page 1 marks this drawing "was drawn with wrong polarity in the video". |
| [3:54](https://www.youtube.com/watch?v=icw8terKP-M&t=234s) | The measurement itself, on an AADE L/C Meter IIB: 66.00 pF with the control supply at 0.000 V. |
| [4:34](https://www.youtube.com/watch?v=icw8terKP-M&t=274s) | 30.68 pF at 2.831 V. |
| [5:00](https://www.youtube.com/watch?v=icw8terKP-M&t=300s) | 22.4 pF at 4.84 V, less than a third of the zero-bias figure. |
| [5:18](https://www.youtube.com/watch?v=icw8terKP-M&t=318s) | The complete VCO, reproduced in [01 - MV209 two-J310 VCO](#01---mv209-two-j310-vco). |
| [7:04](https://www.youtube.com/watch?v=icw8terKP-M&t=424s) | The oscillator running at 18.094 MHz with 12.39 V of control. |
| [7:34](https://www.youtube.com/watch?v=icw8terKP-M&t=454s) | 18.196 MHz at 24.79 V, the top of his tuning range. |
| [7:46](https://www.youtube.com/watch?v=icw8terKP-M&t=466s) | 17.223 MHz at 1.286 V, the bottom of it. |

## What the lesson establishes

A reverse-biased junction stores charge across its depletion region, so it is a capacitor, and the width of that region depends on the reverse voltage applied. More reverse bias means a wider gap and less capacitance. That is true of every diode; a varactor is simply a diode built so the effect is usable, with low series resistance so the Q stays high at RF.

Put such a diode in a resonant tank and the resonant frequency becomes a function of a DC control voltage. That is a voltage controlled oscillator, and it is the building block behind frequency modulation, phase-locked loops and electronic tuning generally.

The two circuits here are the two halves of Alan's demonstration: first the capacitance change measured directly, then the oscillator that puts it to work.

## 01 - MV209 two-J310 VCO

[01 - MV209 two-J310 VCO/MV209 two-J310 VCO.asc](<01 - MV209 two-J310 VCO/MV209 two-J310 VCO.asc>) is his page-2 drawing, with the shortcut [Video 147 - 01 - MV209 two-J310 VCO.url](<01 - MV209 two-J310 VCO/Video 147 - 01 - MV209 two-J310 VCO.url>) opening the video there.

![LTspice schematic of the MV209 two-J310 VCO](<01 - MV209 two-J310 VCO/MV209 two-J310 VCO schematic.png>)

Reading left to right, exactly as Alan draws it:

| Section | Parts | Role |
| --- | --- | --- |
| Control feed | 100 kΩ, 0.01 µF | Brings the control voltage in without loading the tank at RF |
| Varactor pair | two MV209, common cathode | One anode to ground, one to the tank; the control voltage sits on the shared cathode |
| Tank | 33 pF series, 100 kΩ, 33 pF shunt, 1 µH | The resonant circuit, the inductor being 16 turns on a T30-6 core |
| Oscillator | 100 pF, 100 kΩ, J310, 220 pF / 220 pF, 2.2 kΩ, 22 Ω | A Colpitts, with the capacitive divider providing the feedback |
| Buffer | 10 pF, 100 kΩ, J310, 1 kΩ, 22 Ω, 0.1 µF | A source follower so the load does not pull the oscillator |

The two varactors share a cathode on purpose. With the control voltage on the common cathode and the anodes going to ground and to the signal, the RF swing drives them in opposite directions, so the capacitance change it causes in one is cancelled by the other. That keeps the tank linear at signal levels where a single varactor would distort.

Three things are simulation choices. The 100 kΩ scope load stands in for Alan's probe, since he does not state its impedance. The J310 is InterFET's `J310-M` model, and the MV209 is a legacy model whose provenance is discussed below. The supply is 5 V; his drawing marks only `VCC`.

### What the simulation shows

The run is `.tran 0 200u 0 2n uic` with `.ic V(TANK)=10m` to start the oscillation, stepped at **Alan's own three control voltages** so the comparison is direct. The frequency comes from fifty zero crossings of the tank after 150 µs, by which time the amplitude has settled.

![Tank waveform at each of Alan's three control voltages](<01 - MV209 two-J310 VCO/MV209 two-J310 VCO tank waveforms.png>)

If the waveform window opens autoscaled with all three steps overlaid, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [MV209 two-J310 VCO.plt](<01 - MV209 two-J310 VCO/MV209 two-J310 VCO.plt>), which puts one step in each pane.

| Control voltage | Alan measures | Simulated | Difference |
| ---: | ---: | ---: | ---: |
| 1.286 V | 17.223 MHz | 15.678 MHz | -9.0% |
| 12.39 V | 18.094 MHz | 16.621 MHz | -8.1% |
| 24.79 V | 18.196 MHz | 16.785 MHz | -7.8% |

The tuning behaviour is right: frequency rises with control voltage, most steeply at the bottom of the range and flattening off above about 12 V, which is what a varactor's capacitance curve predicts. Alan covers 973 kHz across that span and the simulation covers 1107 kHz.

What is wrong is the absolute frequency, by a consistent 8%. Since frequency goes as the inverse square root of the LC product, 8% low means the simulated tank has about 17% more LC than his. Two things contribute, and both are visible without guessing.

**The inductor.** Alan labels it 1 µH and also writes down how he wound it: 16 turns on a T30-6 core. The published AL figure for that core is 36 µH per 100 turns, which makes 16 turns 0.92 µH rather than 1.0. The schematic uses the 1 µH he states rather than the 0.92 µH his winding implies, because that is the value on his drawing; the difference alone accounts for roughly 4% of frequency.

**The varactor model.** This is where his own measurements become useful, because he gives three capacitance readings and the model is a one-line expression that can be evaluated against them. `MV209_LEGACY` is `Cjo=125p Vj=.75 M=.908`, so its junction capacitance is `125p / (1 + V/0.75)^0.908`:

| Reverse bias | Alan's L/C meter | Legacy model |
| ---: | ---: | ---: |
| 0.000 V | 66.00 pF | 125 pF |
| 2.831 V | 30.68 pF | 30.2 pF |
| 4.84 V | 22.4 pF | 20.2 pF |

At 2.8 V the model is within 2%, which is why the tuning *shape* comes out right. At zero bias it is nearly double his reading, though that comparison is the least fair of the three: an L/C meter applies its own test signal, and at no bias at all the diode conducts on part of every cycle, so neither number is a clean junction capacitance. The useful conclusion is narrower and still worth having: this model is good in the middle of the range and should not be trusted at its ends.

## 02 - Varactor reverse-bias demonstration

[02 - Varactor reverse-bias demonstration/Varactor reverse-bias demonstration.asc](<02 - Varactor reverse-bias demonstration/Varactor reverse-bias demonstration.asc>) is the bias arrangement from his page 1, with the shortcut [Video 147 - 02 - Varactor reverse-bias demonstration.url](<02 - Varactor reverse-bias demonstration/Video 147 - 02 - Varactor reverse-bias demonstration.url>).

![LTspice schematic of the reverse-bias demonstration](<02 - Varactor reverse-bias demonstration/Varactor reverse-bias demonstration schematic.png>)

Alan's own page carries an arrow and the note "was drawn with wrong polarity in the video", pointing at the diode. The schematic follows the corrected polarity from the PDF, so the diode here is genuinely reverse biased.

His drawing gives the two 100 kΩ resistors, which feed the bias in and return it without shorting the signal, and the 0.47 µF output coupling capacitor. It does not give a test signal, because on the bench he used an L/C meter rather than a generator. The 50 mV 17 MHz source, its 50 Ω source resistance, the 0.47 µF input capacitor and the 50 Ω load are therefore **measurement fixtures chosen here**, picked to put the varactor in the same frequency range as the VCO.

### What the simulation shows

![Signal through the varactor at 1 V and at 25 V of reverse bias](<02 - Varactor reverse-bias demonstration/Varactor reverse-bias demonstration waveforms.png>)

Both panes use the same vertical scale, so the change is the picture rather than a number. If the waveform window opens autoscaled with all four steps overlaid, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up [Varactor reverse-bias demonstration.plt](<02 - Varactor reverse-bias demonstration/Varactor reverse-bias demonstration.plt>).

| Reverse bias | `OUT_PP` | `IN_PP` at the cathode |
| ---: | ---: | ---: |
| 1 V | 26.15 mV | 88.6 mV |
| 3 V | 14.73 mV | 96.3 mV |
| 12 V | 5.06 mV | 99.3 mV |
| 25 V | 2.68 mV | 99.6 mV |

Ten times less signal gets through at 25 V than at 1 V. The second column is the same story from the other side: as the varactor's capacitance falls it loads the generator less, so the voltage at the cathode climbs toward the full open-circuit 100 mV.

This is a transmission measurement rather than a capacitance measurement, so the numbers are not directly comparable with the pF readings Alan takes on his meter. What it does share with his demonstration is the direction and the rough size of the effect, driven by the same model whose accuracy is tabulated above.
