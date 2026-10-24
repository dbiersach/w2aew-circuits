# Video 191: beware of test equipment loading

Source: Alan Wolke (W2AEW), [Beware of test equipment loading effects!! Learn from my error!](https://www.youtube.com/watch?v=JbCI4Lsnqho).

| Time | What Alan shows |
| --- | --- |
| [1:44](https://www.youtube.com/watch?v=JbCI4Lsnqho&t=104s) | The analog meter connection that caused the error, modeled by [Current-source voltmeter loading.asc](01%20-%20Current-source%20voltmeter%20loading/Current-source%20voltmeter%20loading.asc). |
| [4:31](https://www.youtube.com/watch?v=JbCI4Lsnqho&t=271s) | The same circuit measured again with a DMM, which is the comparison this chapter reproduces. |

## What went wrong

This lesson revisits the [2N2222 current-sink test from video #190](../190%20-%20Back%20to%20Basics%20-%20Transistor%20Current%20Sources%20and%20Mirrors/CIRCUIT_NOTES.md). Alan's floating adjustable supply sets the collector voltage; a series ammeter reads current delivered to the output node. He also connects a voltmeter **from that collector node to ground**. The current arriving at the node splits: some enters Q1 and some enters the voltmeter. The ammeter reads the **sum**, although Alan initially treats it as Q1 current alone.

The Simpson 260 analog voltmeter has a sensitivity of 20 kΩ per volt, so its 10 V range has `20 kΩ/V × 10 V = 200 kΩ` input resistance. It draws `10 V / 200 kΩ = 50 µA` when the collector is at 10 V and `2 V / 200 kΩ = 10 µA` at 2 V. Its current therefore changes by **40 µA**. Alan's original ammeter readings change from about 419 µA to 377 µA, a **42 µA** difference. Almost all of that difference is voltmeter current, which is why `(10 V − 2 V) / (419 µA − 377 µA) ≈ 190 kΩ` does not describe Q1 alone.

At [4:31](https://www.youtube.com/watch?v=JbCI4Lsnqho&t=271s), Alan substitutes a 10 MΩ digital multimeter and reports roughly 372 µA at 10 V and 369 µA at 2 V. The same 8 V voltage change divided by about 3 µA gives **2.7 MΩ**, much closer to the current sink's output resistance. The DMM still draws 1 µA at 10 V and 0.2 µA at 2 V, so it does not remove loading completely. The simulation models voltmeter input resistance; its zero-volt `VSENSE` is an ideal ammeter and does not include physical ammeter burden voltage.

## Schematic: video #190 baseline with a different voltmeter

The [video #191 schematic](01%20-%20Current-source%20voltmeter%20loading/Current-source%20voltmeter%20loading.asc) uses the same circuit connections as the [video #190 schematic](../190%20-%20Back%20to%20Basics%20-%20Transistor%20Current%20Sources%20and%20Mirrors/01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20emitter%20resistor%20current%20sink.asc): `VBIAS` supplies the 10 V rail and the 20 kΩ/2.2 kΩ base divider; Q1 is a 2N2222 with a 1 kΩ emitter resistor; the 470 Ω `RSHUNT` is **across** the floating adjustable `VFLOAT` source; and zero-volt `VSENSE` occupies Alan's ammeter position between the lower source/shunt junction and the collector. `RVOM` runs from the collector to ground, in parallel with Q1's output path. It is the voltmeter Alan changes in video #191. The 470 Ω shunt is not a series test resistor, and `I(RSHUNT)` is not the ammeter reading.

Video #190 uses a fixed **200 kΩ** `RVOM` for Alan's analog voltmeter. Video #191 changes that one component to **10 MΩ** for the digital meter. Run each circuit separately and compare their single `I(VSENSE)` traces and log results. Both use `.dc VFLOAT 0 8 0.05` to sweep the floating supply from 0 to 8 V. Its positive terminal stays on the 10 V rail, so `V(COLLECTOR) = 10 V − VFLOAT`: `AT=0` in the log means a **10 V collector**, and `AT=8` means a **2 V collector**. Everything else stays at the video #190 values. The circuit uses LTspice's bundled `2N2222` model.

![Video 191 LTspice schematic: the 10 MΩ voltmeter connects from COLLECTOR to ground](01%20-%20Current-source%20voltmeter%20loading/Current-source%20voltmeter%20loading%20schematic.png)

The LTspice schematic keeps the video #190 current sink and test fixture; `RVOM = 10Meg` is the digital meter input resistance. The `.meas` directives below the drawing separate the ammeter reading, Q1 current, and meter current.

## What the LTspice log shows

`I(VSENSE)` is the current Alan's ammeter sees, `Ic(Q1)` is transistor collector current alone, and `I(RVOM)` is voltmeter input current. At either voltage, `I(VSENSE) = Ic(Q1) + I(RVOM)`. The `.meas` commands sample all three currents at both collector voltages; the collector-voltage measurements check the sweep endpoints. `ROUT_OHMS` divides the 8 V collector change by the **ammeter-current change**, while `ROUT_Q1_OHMS` divides by the **transistor-current change**. These are finite-difference estimates over 2-10 V, not single-point resistances. Video #190 reports the original ammeter-based calculation; video #191 also measures Q1 current and voltmeter current to explain why that calculation was misleading.

| Log measurement | Why it is included |
| --- | --- |
| `I_AT_10V` | Ammeter current `I(VSENSE)` with the collector at 10 V; includes Q1 and voltmeter current. |
| `I_AT_2V` | The same ammeter current with the collector at 2 V. |
| `VCOL_AT_10V` | Confirms the first sweep endpoint puts the collector at 10 V. |
| `VCOL_AT_2V` | Confirms the second sweep endpoint puts the collector at 2 V. |
| `ROUT_OHMS` | Apparent resistance: `(VCOL_AT_10V − VCOL_AT_2V) / (I_AT_10V − I_AT_2V)`. |
| `IQ1_AT_10V` | Q1 collector current `Ic(Q1)` at 10 V, excluding voltmeter current. |
| `IQ1_AT_2V` | Q1 collector current at 2 V. |
| `ROUT_Q1_OHMS` | Q1-only resistance: `(VCOL_AT_10V − VCOL_AT_2V) / (IQ1_AT_10V − IQ1_AT_2V)`. |
| `IVOM_AT_10V` | Voltmeter current `I(RVOM)` at 10 V; shows the parallel loading directly. |
| `IVOM_AT_2V` | Voltmeter current at 2 V. |

![Video 191 LTspice SPICE output log: measurement results only](01%20-%20Current-source%20voltmeter%20loading/Current-source%20voltmeter%20loading%20SPICE%20output%20log.png)

These are the result lines from the LTspice output log. The image omits the log header and local file paths. Its `AT=0` and `AT=8` entries refer to the swept `VFLOAT` values, not the collector voltage; the `VCOL` results confirm which collector voltage each endpoint produces.

| Circuit and meter | `I(VSENSE)` at 10 V / 2 V | `Ic(Q1)` at 10 V / 2 V | `I(RVOM)` at 10 V / 2 V | `ROUT_OHMS` | `ROUT_Q1_OHMS` |
| --- | ---: | ---: | ---: | ---: | ---: |
| Video #190: 200 kΩ analog VOM | 409.523 / 367.348 µA | 359.523 / 357.348 µA | 50 / 10 µA | 189,684 Ω | 3,677,542 Ω |
| Video #191: 10 MΩ DMM | 360.523 / 357.548 µA | 359.523 / 357.348 µA | 1 / 0.2 µA | 2,688,740 Ω | 3,677,542 Ω |

Video #190's log reports the ammeter-based values. Its Q1-only and voltmeter-current entries in this comparison follow from the same simulated Q1 and the 200 kΩ `RVOM`; the added measurements appear in video #191's log.

With video #190's 200 kΩ analog voltmeter, the ammeter change is about **42.175 µA**. Q1 accounts for only **2.175 µA**; the voltmeter accounts for the other **40 µA**. Thus the loaded result is about 190 kΩ even though Q1's own result is about 3.68 MΩ. With video #191's 10 MΩ DMM, the voltmeter-current change shrinks to 0.8 µA and the apparent result rises to about 2.69 MΩ, close to Alan's corrected 2.7 MΩ bench estimate. The exact simulated currents differ from Alan's because the bundled `2N2222` model is not his physical transistor.

### How to read the saved plot

The saved plot has **one pane and one trace**, `I(VSENSE)`, like video #190. It shows the current Alan's ammeter would read with a **10 MΩ digital voltmeter** connected. The horizontal axis is `VFLOAT`, not time or Q1's collector voltage. At the left edge, `VFLOAT = 0 V` and the collector is at **10 V**; the ammeter reads about **360.523 µA**. At the right edge, `VFLOAT = 8 V` and the collector is at **2 V**; the ammeter reads about **357.548 µA**.

![Video 191 LTspice plot of ammeter current as VFLOAT changes](01%20-%20Current-source%20voltmeter%20loading/Current-source%20voltmeter%20loading%20current%20sweep.png)

The gentle downward slope is the small change in the current seen by the ammeter as the collector voltage falls from 10 V to 2 V. It combines Q1's change with the 0.8 µA change in current drawn by the 10 MΩ meter.

Compare this trace with video #190's single `I(VSENSE)` trace using a 200 kΩ analog voltmeter: **409.523 µA at 10 V** and **367.348 µA at 2 V**. The transistor itself has the same collector current in both circuits. The large difference in the ammeter readings comes from current flowing through the voltmeter. The log's `Ic(Q1)` and `I(RVOM)` measurements make that split explicit; the plot keeps the comparison to one reading at a time.

