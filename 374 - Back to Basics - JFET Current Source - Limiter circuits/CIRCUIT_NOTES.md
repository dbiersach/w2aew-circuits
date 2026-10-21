# Video 374: JFET current source and limiter circuits

Source: [Alan Wolke (W2AEW)](https://www.youtube.com/watch?v=XJadPFYWglQ). His hand-drawn [JFET current-source notes](W2AEW%20Video%20Notes%20-%20JFET-Current-Sources.pdf) and [50 µA curve comparison](W2AEW%20Video%20Notes%20-%2050uA_curves.pdf) are in this folder.

| Time | What Alan shows |
| --- | --- |
| [5:00](https://www.youtube.com/watch?v=XJadPFYWglQ&t=300s) | [01 - Gate shorted to source](#01---gate-shorted-to-source) |
| [8:36](https://www.youtube.com/watch?v=XJadPFYWglQ&t=516s) | [02 - Adding a source resistor](#02---adding-a-source-resistor) |
| [11:26](https://www.youtube.com/watch?v=XJadPFYWglQ&t=686s) | [03 - The cascode](#03---the-cascode) |

A JFET's drain current flattens once the drain-to-source voltage passes the compliance knee, and that flat region is what makes it a current limiter. Shorting gate to source gives roughly the device's zero-gate-voltage drain current, **IDSS**. Below the knee the channel still behaves as a resistor and current rises with voltage; above it, the current becomes far less sensitive to voltage. Individual J310s vary a great deal: Alan quotes the datasheet's 24 to 60 mA IDSS range and measures roughly 35 mA in his own direct limiter test.

The three circuits below follow his order, each better at holding its current than the last. All three sweep an illustrative 0 to 12 V test supply and measure the current at 9 V and at 10 V, so the quality of the regulation becomes a single number: how much the current moves for one volt of supply change. Each saved plot shows the whole curve in the top pane and a zoom on the flat region below it, because on a full-scale axis all three look equally flat. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

The swept supply is a simulator test fixture, not an extra part in the current source.

## 01 - Gate shorted to source

[Open the segment at 5:00](https://www.youtube.com/watch?v=XJadPFYWglQ&t=300s) · [Schematic](01%20-%20Gate-source%20shorted%20limiter/Gate-source%20shorted%20limiter.asc) · [Saved plot settings](01%20-%20Gate-source%20shorted%20limiter/Gate-source%20shorted%20limiter.plt)

The simplest possible version: one JFET, gate wired to source, nothing else.

![LTspice gate-source shorted limiter schematic](01%20-%20Gate-source%20shorted%20limiter/Gate-source%20shorted%20limiter%20schematic.png)

![Full curve and zoom for the shorted-gate limiter](01%20-%20Gate-source%20shorted%20limiter/Gate-source%20shorted%20limiter%20current%20sweep.png)

![Measured currents at 9 V and 10 V](01%20-%20Gate-source%20shorted%20limiter/Gate-source%20shorted%20limiter%20SPICE%20output%20log.png)

The current limits at 43.90 mA at a 9 V supply, which is this model's IDSS. The zoomed pane shows the catch: between 9 V and 10 V the current still climbs by **797 µA**, about 1.8 % per volt. It is a limiter, but not a precise current source.

## 02 - Adding a source resistor

[Open the segment at 8:36](https://www.youtube.com/watch?v=XJadPFYWglQ&t=516s) · [Schematic](02%20-%20Source%20resistor%20adjustment/Source%20resistor%20adjustment.asc) · [Saved plot settings](02%20-%20Source%20resistor%20adjustment/Source%20resistor%20adjustment.plt)

A resistor between source and ground, with the gate still grounded, makes the source positive with respect to the gate. That is a negative gate-to-source voltage, which pinches the channel and lowers the current. It is also negative feedback: any rise in current raises the source voltage, which pinches harder.

Alan inserts 100 Ω, 200 Ω and 300 Ω and observes about 14 mA, 9.5 mA and 7 mA near a 9 V supply. The saved schematic uses his 300 Ω case.

![LTspice source resistor schematic](02%20-%20Source%20resistor%20adjustment/Source%20resistor%20adjustment%20schematic.png)

![Full curve and zoom with a 300 ohm source resistor](02%20-%20Source%20resistor%20adjustment/Source%20resistor%20adjustment%20current%20sweep.png)

![Measured currents at 9 V and 10 V](02%20-%20Source%20resistor%20adjustment/Source%20resistor%20adjustment%20SPICE%20output%20log.png)

The current drops to 6.536 mA at 9 V, in the same region as Alan's 7 mA reading, and the change from 9 V to 10 V falls to **29.5 µA**: twenty-seven times steadier than circuit 01 as well as adjustable.

## 03 - The cascode

[Open the segment at 11:26](https://www.youtube.com/watch?v=XJadPFYWglQ&t=686s) · [Schematic](03%20-%20Cascode%20current%20source/Cascode%20current%20source.asc) · [Saved plot settings](03%20-%20Cascode%20current%20source/Cascode%20current%20source.plt)

A second JFET sits above the first, its gate tied to the lower device's source. Whatever the supply does, the upper JFET takes up the change, so the lower one sees a nearly fixed drain-to-source voltage and no longer has any reason to change its current.

![LTspice cascode current source schematic](03%20-%20Cascode%20current%20source/Cascode%20current%20source%20schematic.png)

![Full curve and zoom for the cascode](03%20-%20Cascode%20current%20source/Cascode%20current%20source%20current%20sweep.png)

![Measured currents at 9 V and 10 V](03%20-%20Cascode%20current%20source/Cascode%20current%20source%20SPICE%20output%20log.png)

The current settles at 6.373 mA, close to circuit 02 because the same 300 Ω resistor sets it, and the change from 9 V to 10 V is **0.41 µA**. The top pane shows what it costs: the knee has moved right, because two devices in series need more voltage across them before both are in their flat regions. That is the compliance price for the extra regulation.

## The three compared

| Circuit | Current at 9 V | Change from 9 V to 10 V | Change per volt |
| --- | ---: | ---: | ---: |
| 01 Gate shorted to source | 43.90 mA | 797 µA | 1.8 % |
| 02 300 Ω source resistor | 6.536 mA | 29.5 µA | 0.45 % |
| 03 Cascode | 6.373 mA | 0.41 µA | 0.0065 % |

Each step costs something. The source resistor gives up most of the available current; the cascode gives up compliance voltage. In exchange the supply sensitivity improves by a factor of 27, then by a further factor of 72.

## Model limits

The model is [InterFET's published J310-M SPICE model](https://interfet.com/jfet-spice-models/), kept in [`LTspice/Models/InterFET/J310.lib`](../LTspice/Models/InterFET/J310.lib); InterFET's low and high variants sit beside it for exploring device spread. Alan's physical J310 is an onsemi part, so this is a J310-family demonstration rather than a prediction of his device, and a simulated 9 V current need not match his bench reading. The [onsemi J309/J310 datasheet](https://www.onsemi.com/download/data-sheet/pdf/j309-d.pdf) gives the 24 to 60 mA IDSS specification he discusses.
