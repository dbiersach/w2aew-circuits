# Video 190: transistor current sources and mirrors

Source: w2aew, [Back to Basics: Transistor Current Sources and Mirrors](https://www.youtube.com/watch?v=xR0RfmmRhDw).

| Time | What Alan shows |
| --- | --- |
| [2:49](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=169s) | The 2N2222 emitter-resistor current sink: [2N2222 emitter resistor current sink.asc](01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20emitter%20resistor%20current%20sink.asc). |
| [3:40](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=220s) | The J310 self-biased sink: [J310 self-biased current sink.asc](02%20-%20J310%20self-biased%20current%20sink/J310%20self-biased%20current%20sink.asc). |
| [4:45](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=285s) | The two-transistor mirror concept: [Two-transistor current mirror.asc](03%20-%20Two-transistor%20current%20mirror/Two-transistor%20current%20mirror.asc). |
| [16:50](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=1010s) | The PNP mirror driving one LED: [PNP mirror - one LED.asc](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20one%20LED.asc). |
| [17:04](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=1024s) | Two LEDs in series: [PNP mirror - two LEDs.asc](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20two%20LEDs.asc). |
| [17:20](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=1040s) | Three LEDs in series: [PNP mirror - three LEDs.asc](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20three%20LEDs.asc). |

[Alan's handwritten circuit notes](W2AEW%20Video%20Notes%20-%20transistorcurrentsources.pdf) show the tested BJT and J310 sinks and the mirror configurations.

## Current Sink

A current sink takes current from a load connected above it and provides a path to ground. Alan calls the topic **transistor current sources** because *current source* is also a broad term for a circuit that sets current. This first NPN arrangement is specifically a **sink**: current enters Q1's collector and flows through its emitter and `RE` to ground. The +10 V supply provides the energy; Q1 controls the current.

The [2N2222 sink schematic](01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20emitter%20resistor%20current%20sink.asc) follows Alan's test fixture. `VBIAS` establishes the +10 V rail and Q1's base bias. The 470 Ω `RSHUNT` is across the floating adjustable source `VFLOAT`, and the zero-volt `VSENSE` represents the ammeter between their lower junction and Q1's collector. `RVOM` represents Alan's analog voltmeter connected from the collector to ground. On its 10 V range it loads the output with 200 kΩ. `I(VSENSE)` therefore includes both Q1's collector current and the voltmeter current; `Ic(Q1)` gives Q1's current alone. `I(RSHUNT)` is a separate current in the floating-supply branch.

### 1. How does RE push back against a current change?

Start with Q1's base near **1 V** and its emitter near **0.35 V**. The difference, about **0.65 V**, is what turns Q1 on.

Now imagine Q1 begins to draw *slightly more* current:

1. More current flows through the 1 kΩ resistor `RE`.
2. More current makes a larger voltage across RE, so Q1's **emitter voltage rises**.
3. The base stays near 1 V. A higher emitter voltage makes the **base-to-emitter difference smaller**.
4. A smaller difference makes Q1 conduct less, pushing back against the increase.

If current begins to fall, those steps reverse: the emitter voltage falls, the base-to-emitter difference grows, and Q1 conducts more. That is the feedback.

### 2. Where does the changing test voltage go?

Alan's floating supply has its positive terminal on the fixed +10 V rail. Its negative terminal is connected through the ammeter to Q1's collector. Neglecting the ideal ammeter's zero voltage drop, `V(COLLECTOR) = 10 V − VFLOAT`. The LTspice sweep changes `VFLOAT` from 0 to 8 V, so Q1's collector moves from 10 down to 2 V. This is the direction of Alan's fixture: increasing the floating supply's setting **lowers** the collector voltage.

The ammeter current reaches the collector junction and splits between Q1 and the voltmeter. Q1's emitter current then flows through `RE`; its collector and emitter currents differ slightly because of base current. The 470 Ω resistor lies **across VFLOAT**, so its current is not part of the ammeter reading. The floating source and its shunt meet at the junction above the ammeter.

At about 0.36 mA, `RE` drops about **0.36 V**. As collector voltage changes, RE's drop stays nearly steady because its current stays nearly steady:

| Q1 collector voltage | VFLOAT setting | Across RE | Across Q1 |
| ---: | ---: | ---: | ---: |
| 2 V | 8 V | ~0.36 V | ~1.64 V |
| 10 V | 0 V | ~0.36 V | ~9.64 V |

In each row, `VFLOAT + V_CE(Q1) + V(RE)` adds to the fixed 10 V rail. When collector voltage rises by 8 V, **almost all of that extra voltage appears between Q1's collector and emitter**. Q1 can operate with either of those voltages while conducting *approximately* the current established by its base and RE. RE helps correct the small current change that would otherwise occur. LTspice gives **357.35 µA at a 2 V collector** and **359.52 µA at a 10 V collector** for `Ic(Q1)`, a change of about 2.18 µA. The ammeter reading changes much more because the 200 kΩ voltmeter draws more current as collector voltage rises. Q1 does not hold current perfectly; if collector voltage falls too low, it will no longer have enough voltage to operate as a current sink.

### 3. Does the extra voltage become heat?

Yes. Approximate transistor dissipation is `P_Q1 = V_CE × I_C`. As Q1's collector voltage rises, it carries nearly the same current at a much larger collector-to-emitter voltage, so it dissipates more power:

| Q1 collector voltage | Approximate voltage across Q1 | Approximate Q1 current | Approximate heat in Q1 |
| ---: | ---: | ---: | ---: |
| 2 V | 1.64 V | 0.357 mA | 0.59 mW |
| 10 V | 9.64 V | 0.360 mA | 3.47 mW |

The extra dissipation in Q1 is about **2.9 mW**. RE also turns some power into heat, but its current and voltage drop barely change. The 470 Ω **shunt is a separate load on the floating supply**, not part of Q1's series current path. At an 8 V floating-source setting, its current is `8 V ÷ 470 Ω ≈ 17 mA` and it dissipates about `8² ÷ 470 ≈ 0.136 W`. The heat from Q1 and the resistors flows into their leads and surroundings.

A physical transistor's safe power depends on its exact part, package, mounting, and ambient temperature. For examples at 25 °C ambient, onsemi rates a [metal-can 2N2222A](https://www.onsemi.com/download/data-sheet/pdf/2n2222a-d.pdf) at 500 mW and a [plastic PN2222A](https://www.onsemi.com/download/data-sheet/pdf/pn2222a-d.pdf) at 625 mW. These are maximum ratings, not design targets, and allowable dissipation falls as ambient temperature rises. The LTspice `2N2222` model does not identify a physical package or certify a thermal limit. The modeled 3.4 mW in this example is far below either example rating.

### 4. Does Q1's effective resistance increase?

**Yes, if “resistance” only means the ratio of voltage across Q1 to current through it:**

| Q1 collector voltage | Voltage across Q1 | Current through Q1 | `V_CE ÷ I_C` |
| ---: | ---: | ---: | ---: |
| 2 V | ~1.64 V | ~0.357 mA | ~4.6 kΩ |
| 10 V | ~9.64 V | ~0.360 mA | ~26.8 kΩ |

Q1 is not a fixed resistor that physically changes from 4.6 kΩ to 26.8 kΩ. Its base-to-emitter drive and RE's feedback keep its current nearly steady; `V_CE ÷ I_C` describes the resulting operating point. The **small-change output resistance**, `ΔV_CE ÷ ΔI_C`, answers a different question: how much Q1's collector voltage must change to change its current slightly. It is about 3.7 MΩ over this simulated sweep, much larger than either `V_CE ÷ I_C` ratio. None of these numbers means Q1 can hold the current at *any* voltage; it still needs enough collector-to-emitter voltage to operate.

## Current Source

A current source delivers a controlled current into a load connected below it. Here *source* describes the direction of delivery: the supply provides the energy, and the circuit controls how much current it sends through the load. A current sink draws controlled current from a load toward ground; a current source sends controlled current from the positive supply into a load. Both need a complete path back to the supply.

The [PNP mirror driving one LED](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20one%20LED.asc) later in this video is a current-source example. `VBIAS` powers the reference sink, while `VCC` provides the current delivered to the LED. Follow it step by step:

1. The 2N2222 sink establishes a reference current in the left PNP transistor, QP1. QP1 has its collector tied to its base, so that reference current establishes the base-to-emitter voltage shared by QP1 and QP2.
2. The right PNP transistor, QP2, has its emitter connected to the positive `VCC` rail. With a similar base-to-emitter voltage and a similar transistor, QP2 supplies approximately the reference current from its collector into the LED string.
3. The output path is `VCC → QP2 → LED(s) → ground`. The LED current is the current delivered by the source; the LED does not choose that current by itself while QP2 has enough voltage to operate.
4. Adding an LED changes the voltage required by the load. QP2 can take a different voltage across its emitter and collector while delivering approximately the same current. This is why the video compares one, two, and three series LEDs.
5. The source has a limit. If `VCC` is too low to cover the LED voltage **and** leave sufficient voltage across QP2, the desired current cannot flow and the LED current falls. This is the sourcing counterpart of the sink running out of voltage across Q1.

The PNP mirror is not a perfect current source. Its current varies with transistor matching, base currents, temperature, and output voltage. The useful goal is **approximately steady load current over a specified range of load voltages**, rather than one exact current under all conditions.

## 2N2222 emitter-resistor current sink

The [BJT circuit](01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20emitter%20resistor%20current%20sink.asc) uses Alan's 20 kΩ / 2.2 kΩ divider, 1 kΩ emitter resistor, and 10 V bias supply. The divider keeps the base near 1 V. If emitter current increases, the emitter resistor raises emitter voltage and reduces base-emitter drive; this negative feedback keeps collector current fairly steady.

![LTspice 2N2222 current sink schematic](01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20schematic.png)

![LTspice 2N2222 I(VSENSE) sweep](01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20current%20sweep.png)

The plot shows the current through `VSENSE`, Alan's ammeter position. Its horizontal axis is the `VFLOAT` setting, from 0 to 8 V; the collector voltage moves the opposite way, from 10 down to 2 V.

### Floating test supply and 470 Ω shunt

Alan connects the positive terminal of a floating adjustable supply to the +10 V rail. He connects a 470 Ω resistor **across the two terminals of that supply**. The lower junction of the supply and resistor goes through an ammeter to Q1's collector. He also connects an analog voltmeter from the collector to ground. The LTspice schematic uses `VFLOAT`, `RSHUNT`, and a zero-volt `VSENSE` in the supply and ammeter positions, with a 200 kΩ `RVOM` for the voltmeter. The zero-volt source measures the combined Q1 and voltmeter current. Plot `I(VSENSE)` for Alan's ammeter reading, `Ic(Q1)` for the transistor current, and `I(RVOM)` for the voltmeter current. The shunt current `I(RSHUNT)` is separate.

The positive terminal of `VFLOAT` stays at +10 V. Thus `V(COLLECTOR) = 10 V − VFLOAT`, since `VSENSE` has zero volts across it. The `.dc VFLOAT 0 8 0.05` directive increases the floating source's setting from 0 to 8 V while Q1's collector falls from 10 to 2 V. The 470 Ω shunt carries `VFLOAT / 470 Ω`; the floating source must absorb or supply the balancing current. With an ideal voltage source, the shunt does not set the collector current; Q1's bias and emitter feedback do that.

Alan measures approximately 419 µA at a 10 V collector and 377 µA at a 2 V collector. He calculates `(10 V − 2 V) / (419 µA − 377 µA) ≈ 190 kΩ`. The schematic's `I_AT_10V` and `I_AT_2V` are the corresponding **ammeter** readings from the LTspice model: about 409.523 µA and 367.348 µA. `VCOL_AT_10V` and `VCOL_AT_2V` check that the collector really is at 10 V and 2 V. `ROUT_OHMS` applies Alan's same calculation to these simulated ammeter readings and reports about **189,684 Ω**. The model does not reproduce the exact current of his particular transistor, but it reproduces the reported resistance.

![LTspice 2N2222 .meas results for the ammeter readings](01%20-%202N2222%20emitter%20resistor%20current%20sink/2N2222%20SPICE%20output%20log.png)

For the `.dc VFLOAT 0 8 0.05` sweep, `AT=0` means the floating source is set to 0 V and the collector is at 10 V. `AT=8` means the floating source is set to 8 V and the collector is at 2 V. These are sweep settings, not times. Plot `I(VSENSE)` to see the current Alan's ammeter reads. [Video #191](../191%20-%20Beware%20of%20test%20equipment%20loading%20effects!!%20Learn%20from%20my%20error!/CIRCUIT_NOTES.md) checks the effect of the connected voltmeter and separates the ammeter reading from Q1's current.

## J310 self-biased current sink

The [J310 circuit](02%20-%20J310%20self-biased%20current%20sink/J310%20self-biased%20current%20sink.asc) grounds its gate and connects its source to ground through Alan's 4.7 kΩ resistor. More drain current raises the source voltage, makes the gate more negative relative to the source, and opposes the increase. The 10 V source is named `VPLUS` and is wired directly to the floating test fixture; it does not bias J1's gate. The only non-ground net label is `DRAIN`, which the `.meas` directives use. The test fixture follows Alan's drawing: the 470 Ω `RSHUNT` is **across** the floating `VFLOAT` supply, `VSENSE` is his series ammeter, and the 200 kΩ `RVOM` from drain to ground represents his analog voltmeter. `RSHUNT` is not in series with the J310.

![LTspice J310 current sink schematic](02%20-%20J310%20self-biased%20current%20sink/J310%20schematic.png)

![LTspice J310 I(VSENSE) sweep](02%20-%20J310%20self-biased%20current%20sink/J310%20current%20sweep.png)

The saved plot shows `I(VSENSE)`, the ammeter reading, versus the **setting of `VFLOAT`**. The +10 V rail stays fixed, so `V(DRAIN) = 10 V − VFLOAT`. Moving left to right from `VFLOAT=0` to `8 V` moves the drain from **10 V down to 2 V**. At the left, the ammeter reads about **655 µA**; at `VFLOAT=6 V` (drain 4 V), about **620 µA**; and at the right (drain 2 V), about **426 µA**. The sharp fall near the right is the compliance limit: sustaining about 600 µA through 4.7 kΩ would require about 2.8 V across `RS` alone, more than the available 2 V drain voltage.

Alan reports about **573 µA at a 10 V drain** and **533-534 µA at a 4 V drain**. His roughly 40 µA change over 6 V gives an apparent output resistance near **150 kΩ**. The schematic's `I_AT_10V` and `I_AT_4V` measure Alan's ammeter positions using `I(VSENSE)`; `VDRAIN_AT_10V` and `VDRAIN_AT_4V` confirm the drain voltages. The LTspice log reports `ROUT_OHMS = (10 V − 4 V) / (655.157 µA − 620.459 µA) = 172,923 Ω`. This is the same *ammeter-based* calculation Alan made, not the J310's unloaded output impedance. The model gives about 80-90 µA more absolute current than Alan's device. It uses the manufacturer's [InterFET J310-M model](../LTspice/Models/InterFET/J310.lib), not Alan's individual onsemi J310; JFET current varies substantially among devices.

![LTspice J310 .meas results for the ammeter readings](02%20-%20J310%20self-biased%20current%20sink/J310%20SPICE%20output%20log.png)

The ammeter also includes current through the voltmeter. At a 10 V drain, `RVOM` takes `10 V / 200 kΩ = 50 µA`; at 4 V it takes `20 µA`. Thus **30 µA of the simulated 34.7 µA ammeter change comes from the meter**, leaving about **4.7 µA of actual J310 drain-current change**. This is the same loading issue Alan revisits in [video #191](../191%20-%20Beware%20of%20test%20equipment%20loading%20effects!!%20Learn%20from%20my%20error!/CIRCUIT_NOTES.md). The 2 V point is useful for finding the compliance knee; Alan's 4-10 V interval is the appropriate comparison for his output-resistance calculation.

The curve is nearly flat while the drain is between about 10 V and 4 V. It bends downward as `VFLOAT` approaches 8 V and the drain approaches 2 V, because the J310 and its 4.7 kΩ source resistor run out of voltage headroom.

## Two-transistor current mirror

The video introduces several current source and mirror configurations. This example implements its basic two-transistor NPN mirror with discrete 2N3904 transistors. Q1 has collector and base tied together; both bases share the same bias. A 4.7 kΩ resistor from 12 V sets the reference current, and a 1 kΩ load receives the mirrored current.

![LTspice two-transistor NPN mirror schematic](03%20-%20Two-transistor%20current%20mirror/NPN%20mirror%20schematic.png)

![LTspice NPN mirror current and voltage response](03%20-%20Two-transistor%20current%20mirror/NPN%20mirror%20load%20response.png)

### Why use Q1 and a current mirror?

The design goal is to establish a current in one branch and reproduce approximately that current in another branch. `VREF` and `RSET` set the reference-branch current. Because Q1's collector is connected to its base, current through Q1 establishes the base-to-emitter voltage needed by that transistor. Q2 shares Q1's base voltage and has its emitter at the same ground node, so a similar Q2 tends to conduct a similar collector current through `RLOAD`. Q1 is therefore a current-to-bias converter; the shared voltage is the means of copying current, not the quantity the circuit is trying to keep fixed. `I(RSET)` includes the two base currents as well as Q1's collector current, so it is an approximate reference for `I(RLOAD)` rather than an exactly equal current.

A fixed voltage applied directly to Q2's base would be a poor substitute: transistor current is very sensitive to base-to-emitter voltage, and the voltage needed for a given current changes between devices and with temperature. Q1 develops that voltage using an actual transistor carrying the reference current. If Q1 and Q2 are well matched and at similar temperatures, their required voltages tend to change together, helping Q2's current track Q1's. This does not eliminate drift in the reference current from `VREF`, `RSET`, temperature, or device mismatch, and the simple mirror also has base-current error and finite output resistance.

Current mirrors are used to distribute one reference current to several amplifier stages, scale bias currents, make current sources or sinks, and provide active loads with high small-signal resistance for amplifier gain. The PNP LED circuits below show a mirror sourcing current to a load. This NPN circuit instead sinks current through `RLOAD`. Its `VLOAD` experiment tests a separate practical limit: Q2 can mirror current only while enough voltage remains across it. At 2 V, maintaining 2.60 mA would require 2.60 V across the 1 kΩ load alone, so that current is impossible even before allowing voltage across Q2.

The learning objective is to see both what the two-transistor mirror does and where it stops working as a current source. The reference supply stays at 12 V while the load supply steps between 2 and 12 V. At 12 V, the 1 kΩ load carries about 2.60 mA; at 2 V, the output collector is near ground and current falls to about 1.95 mA because Q2 has run out of voltage headroom. The plot puts `I(RLOAD)` above `V(VLOAD)` and `V(OUT)` so the current change can be matched to the supply step and Q2's collector voltage. This demonstrates the mirror's compliance limit, not a transient switching feature emphasized in the video. To examine the mirroring relationship itself, add `I(RSET)` to the current pane as a reference-branch comparison; that resistor current also supplies transistor base currents, so exact equality is not expected. The resistor and supply values are demonstration choices because the video compares many configurations without one fixed set of component values for this NPN mirror.

To use the schematic, open it in LTspice and click **Run**. The active `.tran 0 10m 0 2u` directive runs a 10 ms transient simulation. `VLOAD` is a voltage source whose value is already `PULSE(2 12 1m 1u 1u 4m 8m)`; no text needs to be changed into a SPICE directive. Its supply voltage starts at 2 V, rises to 12 V after 1 ms, stays high for 4 ms, then returns to 2 V before repeating. Right-click the `VLOAD` source if you want to change the pulse settings.

Click the positive wire above the `VLOAD` source to plot its voltage relative to ground; a net label is not required for probing. The wire has a `VLOAD` label only to give the trace a readable name, `V(VLOAD)`, in the plot and **Add Trace** list. The source name `VLOAD` and the wire's net label are separate names. This small circuit has no `.save` directive because the default waveform data is convenient for exploring other wires and component currents. A `.save` directive would restrict the data retained for plotting; it is useful for large simulations but unnecessary here. The log's `IOUT_AVG` is the average load current from 3 to 5 ms, safely within the 12 V interval. `IOUT_LOW` measures 6 to 8 ms in the 2 V interval. Comparing the two log values quantifies the current loss visible in the plot. `IOUT_AVG` by itself only reports the high-voltage operating point and does not establish current regulation or matching to the reference branch.

![LTspice NPN mirror .meas results for high and low supply averages](03%20-%20Two-transistor%20current%20mirror/NPN%20mirror%20SPICE%20output%20log.png)

Alan's later breadboard mirror is a **PNP** version that turns the BJT sink current into a sourcing current and drives LEDs. The NPN illustration shows the elementary matched-transistor principle; the separate PNP variants below address his bench demonstration.

## PNP mirror and one, two, or three series LEDs

At [15:55](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=955s), Alan connects the BJT current sink to a PNP mirror. The first PNP has its base tied to its collector, establishing the reference voltage. Both emitters connect to the positive rail, and the second PNP sources current into the LED string. This is the sourcing counterpart to the earlier NPN mirror. At about [16:50](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=1010s), [17:04](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=1024s), and [17:20](https://www.youtube.com/watch?v=xR0RfmmRhDw&t=1040s), he adds one, two, and three LEDs in series and observes approximately steady current while the mirror has enough voltage headroom.

### One LED

![LTspice PNP mirror with one LED schematic](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20one%20LED%20schematic.png)

![LTspice PNP mirror one LED current sweep](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20one%20LED%20current%20sweep.png)

![LTspice PNP mirror one LED .meas result](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20one%20LED%20SPICE%20output%20log.png)

The [one LED](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20one%20LED.asc), [two LED](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20two%20LEDs.asc), and [three LED](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20mirror%20-%20three%20LEDs.asc) schematics use the 20 kΩ/2.2 kΩ/1 kΩ BJT sink values from Alan's notes. The PNPs are LTspice bundled 2N3906 models; the series LEDs use the Lumileds `L128-RED1003500000` model bundled with LTspice. Alan's PNP and LED part numbers are not identified in the notes, so these are documented illustrative device choices, not exact bench parts. The 10 V `VBIAS` supply keeps the sink reference fixed while the PNP supply `VCC` sweeps from 6 to 10 V.

| LEDs in series | Simulated LED current at 10 V |
| --- | ---: |
| 1 | 383.28 µA |
| 2 | 377.47 µA |
| 3 | 371.67 µA |

### Two LEDs

![LTspice PNP mirror with two LEDs schematic](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20two%20LEDs%20schematic.png)

![LTspice PNP mirror two LED current sweep](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20two%20LEDs%20current%20sweep.png)

![LTspice PNP mirror two LED .meas result](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20two%20LEDs%20SPICE%20output%20log.png)

### Three LEDs

![LTspice PNP mirror with three LEDs schematic](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20three%20LEDs%20schematic.png)

![LTspice PNP mirror three LED current sweep](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20three%20LEDs%20current%20sweep.png)

![LTspice PNP mirror three LED .meas result](04%20-%20PNP%20mirror%20driving%20LEDs/PNP%20three%20LEDs%20SPICE%20output%20log.png)

The small current difference comes from changing output compliance, PNP output resistance, and the particular models. A current mirror keeps current approximately constant over its usable voltage range; it cannot sustain the set current if the LED voltage plus transistor headroom approaches the available supply. The three LED sweep stays between roughly 356 and 372 µA from 6 to 10 V. The vertical scale magnifies its small slope. Each log records the LED current measured at 10 V for its circuit.

Use separate, isolated bench supplies with their grounds connected when reproducing the test. The circuit uses only physical sources, resistors and transistors.

## Circuit files

Files beneath the same numbered circuit are LTspice test or model variants of that circuit; they share its entry point in the table above.

