# Video 219: Introduction to field effect transistors

Source: [Alan Wolke (W2AEW), Back to Basics: Introduction to Field Effect Transistors JFET MOSFET](https://www.youtube.com/watch?v=oambDFa0Pr8). [Alan's handwritten notes](W2AEW%20Video%20Notes%20-%20IntroToFETs.pdf) include the curve tracer and its 20 Ω current sense resistor.

| Time | What Alan shows |
| --- | --- |
| [8:47](https://www.youtube.com/watch?v=oambDFa0Pr8&t=527s) | [01 - The J310 JFET](#01---the-j310-jfet) |
| [17:51](https://www.youtube.com/watch?v=oambDFa0Pr8&t=1071s) | [02 - The 2N7000 MOSFET](#02---the-2n7000-mosfet) |

Alan builds one simple curve tracer and puts two different devices in it. A swept drain supply draws out the device's output characteristic while a second supply sets the gate bias; two 2N3906 PNP transistors form a high-side current mirror whose second transistor reproduces the device current through a 20 Ω resistor, so the voltage on that resistor divided by 20 Ω is the current. Alan sweeps with a sawtooth and watches an XY oscilloscope; both LTspice files use a nested DC sweep instead, which draws the whole family of curves in one run.

Each plot carries a step legend naming the gate voltage of every curve. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

Two things about the measurement are worth knowing before reading the numbers. The horizontal axis is the *applied sweep supply*, which sits about one PNP base-emitter drop above the device's actual drain voltage while the mirror conducts, and the mirror has finite gain and output resistance, so `I(Rsense)` approximates rather than exactly equals the device current. The 0 to 10 V sweep range and the gate-voltage increments are simulation choices; Alan's notes do not give his settings.

## 01 - The J310 JFET

[Tester explanation at 8:47](https://www.youtube.com/watch?v=oambDFa0Pr8&t=527s) · [Schematic](01%20-%20J310%20JFET/J310%20JFET%20curve%20tracer.asc) · [Saved plot settings](01%20-%20J310%20JFET/J310%20JFET%20curve%20tracer.plt)

Alan puts a J310 in the tester at about 10:09. A JFET is a *depletion* device: it conducts with no gate bias at all, and a negative gate voltage squeezes the channel shut.

![LTspice J310 curve tracer schematic](01%20-%20J310%20JFET/J310%20JFET%20curve%20tracer%20schematic.png)

![J310 simulated output curves](01%20-%20J310%20JFET/J310%20JFET%20curve%20tracer%20output%20curves.png)

The gate steps from -4 V to 0 V in 1 V increments. At a 10 V applied supply the sensed current is:

| Gate bias | Sensed current at 10 V |
| ---: | ---: |
| -4 V | about 0 mA |
| -3 V | 0.24 mA |
| -2 V | 6.9 mA |
| -1 V | 22.5 mA |
| 0 V | 46.8 mA |

Two features stand out on every curve. Below about 1.5 V the current rises almost in proportion to the voltage: the channel is behaving as a resistor whose value the gate sets, which is the region that makes a JFET useful as a voltage-controlled resistor. Above it each curve flattens into a nearly constant current, and the gate alone decides which flat level the device settles at. The -4 V curve lies on the axis, which is the pinch-off Alan describes.

These are InterFET [J310-M model](../LTspice/Models/InterFET/J310.lib) results, not measurements of Alan's onsemi J310.

## 02 - The 2N7000 MOSFET

[Enhancement-mode test at 17:51](https://www.youtube.com/watch?v=oambDFa0Pr8&t=1071s) · [Schematic](02%20-%202N7000%20MOSFET/2N7000%20MOSFET%20curve%20tracer.asc) · [Saved plot settings](02%20-%202N7000%20MOSFET/2N7000%20MOSFET%20curve%20tracer.plt)

Alan swaps in a 2N7000 and reverses the gate supply polarity, because this is an *enhancement* device: it is off with no gate bias and needs a positive gate-to-source voltage to create a channel at all. The tester around it is unchanged.

![LTspice 2N7000 curve tracer schematic](02%20-%202N7000%20MOSFET/2N7000%20MOSFET%20curve%20tracer%20schematic.png)

![2N7000 simulated output curves](02%20-%202N7000%20MOSFET/2N7000%20MOSFET%20curve%20tracer%20output%20curves.png)

The gate steps from 0 V to 3 V in 0.5 V increments. At a 10 V applied supply the sensed current is effectively zero through 2 V of gate bias, about 3.42 mA at 2.5 V, and 26.99 mA at 3 V. The contrast with the JFET is the whole point of putting the two devices in the same fixture: the JFET's largest current is at zero gate bias, the MOSFET's is at its most positive.

Alan's physical 2N7000 starts to show current around 1.6 V. Threshold voltage varies widely between individual 2N7000s, and the model is not his device, so the plotted turn-on should not be read as a reconstruction of his measurement. The simulation uses [onsemi's published 2N7000 Rev. 0 PSpice subcircuit](https://www.onsemi.com/download/models/lib/2n7000.rev0.lib) dated 31 March 2004, whose external pin order is drain, gate, source, matching the LTspice symbol and the generated netlist. The [local copy](../LTspice/Models/onsemi/2N7000.REV0.LIB) carries a proprietary Symmetry Design Systems notice; `LTspice/README.md` records its redistribution caveat.

## Source limits

Page 4 of Alan's notes also sketches a simple JFET bias circuit with a drain load, a gate return and a source resistor, but gives neither resistor values nor a measured operating point, so that example is not reconstructed here. The 2N3906 mirror uses LTspice's installed model; if exact shunt calibration matters, check the mirror against real transistors.
