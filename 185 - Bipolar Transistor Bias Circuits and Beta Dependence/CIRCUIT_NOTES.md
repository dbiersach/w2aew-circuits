# Video 185: Bipolar transistor bias circuits and beta dependence

Source: Alan Wolke (W2AEW), [full video](https://www.youtube.com/watch?v=YQlbPGNB-ys). W2AEW's original drawings are in [W2AEW Video Notes - BJT_bias_beta_dependence.pdf](W2AEW%20Video%20Notes%20-%20BJT_bias_beta_dependence.pdf).

| Time | What Alan shows |
| --- | --- |
| [4:25](https://www.youtube.com/watch?v=YQlbPGNB-ys&t=265s) | Fixed base bias, the first of the three networks: [01 - Fixed base bias](#01---fixed-base-bias). |
| [5:57](https://www.youtube.com/watch?v=YQlbPGNB-ys&t=357s) | Collector feedback bias: [02 - Collector feedback bias](#02---collector-feedback-bias). |
| [8:50](https://www.youtube.com/watch?v=YQlbPGNB-ys&t=530s) | Voltage divider bias, the least beta-sensitive: [03 - Voltage divider bias](#03---voltage-divider-bias). |

## What the three circuits compare

All three circuits use a 9 V supply and a 3.9 kΩ collector resistor. The goal is about 1 mA of collector current, giving roughly 4 V **across the collector resistor**. That voltage is `VRC = V(VCC) - V(COLLECTOR)`. It is not the collector voltage measured relative to ground. At a 4 V resistor drop, the collector is near 5 V.

Transistor beta (β, or `hFE`) is the ratio `IC/IB` in the active region. It varies between nominally identical devices and also with collector current, collector-emitter voltage, and temperature. W2AEW tested three physical transistors whose separately measured beta values were about **115 (low), 180 (nominal), and 275 (high)**. A bias network that depends heavily on beta moves the quiescent collector current and voltage when a transistor is replaced or warms up. That can reduce available signal swing, cause clipping, or move a device toward cutoff or saturation. Beta independence means making the *operating point* relatively insensitive to beta; it does not imply that the transistor has no beta.

| Circuit | LTspice file | Bias network | Expected beta sensitivity |
| --- | --- | --- | --- |
| 01 - Fixed base | [Fixed Base Bias.asc](01%20-%20Fixed%20base%20bias/Fixed%20Base%20Bias.asc) | 1 MΩ from VCC to base; emitter grounded | Strongest |
| 02 - Collector feedback | [Collector Feedback Bias.asc](02%20-%20Collector%20feedback%20bias/Collector%20Feedback%20Bias.asc) | 560 kΩ from collector to base; emitter grounded | Intermediate |
| 03 - Voltage divider | [Voltage Divider Bias.asc](03%20-%20Voltage%20divider%20bias/Voltage%20Divider%20Bias.asc) | 20 kΩ / 2.7 kΩ base divider and 470 Ω emitter resistor | Weakest |

Each numbered folder contains the schematic, its LTspice plot settings, and a YouTube shortcut to the chapter start. The video folder contains the full-video shortcut and shared PDF.

## 01 - Fixed base bias

The 1 MΩ resistor feeds the base directly from 9 V. With the emitter grounded, the base current is approximately `IB = (VCC - VBE)/RB`. As long as the transistor remains in its active region, `IC ≈ β × IB`, so `VRC ≈ RC × β × IB`. The circuit has no meaningful DC feedback to correct a change in beta. Higher beta draws more collector current and creates a larger drop across the 3.9 kΩ resistor. The high-beta case approaches saturation, where the simple `IC = β × IB` rule ceases to be accurate.

![Video 185 fixed-base circuit captured from LTspice](01%20-%20Fixed%20base%20bias/Fixed%20Base%20Bias%20schematic.png)

*The 1 MΩ base resistor connects to VCC, so changes in beta directly affect collector current.*

![Fixed-base bias: widely separated collector-resistor voltage drops for three beta values](01%20-%20Fixed%20base%20bias/beta_sweep_fixed_base.png)

*Fixed-base LTspice sweep: the collector-resistor drop changes by about 4.78 V from the low- to high-beta case. Each trace is labeled with its BETA step in the LTspice plot.*

| Trace level | LTspice BETA step | Simulated voltage across RC |
| --- | ---: | ---: |
| Top | 275 (high) | 8.735 V |
| Middle | 180 (nominal) | 6.010 V |
| Bottom | 115 (low) | 3.957 V |

![Fixed-base VRC and VC results from the LTspice output log](01%20-%20Fixed%20base%20bias/Fixed%20Base%20Bias%20SPICE%20output%20log.png)

*The log lists VRC and the collector voltage VC for beta steps 115, 180, and 275 in that order. VRC rises from 3.957 V to 8.735 V.*

## 02 - Collector feedback bias

The 560 kΩ resistor takes its supply from the **collector**, below the collector resistor, rather than directly from VCC. If collector current rises, the drop across RC rises and collector voltage falls. That lowers current through the collector-to-base resistor and pushes collector current back down. This is negative feedback. In the active-region approximation, `IB ≈ (VCC - VBE) / [RB + (β + 1)RC]`. Increasing beta therefore increases the effective term `(β + 1)RC` in the denominator, reducing sensitivity compared with fixed base bias. The current in RC is `IC + IB`, since RC supplies both the collector and the feedback branch.

![Video 185 collector-feedback circuit captured from LTspice](02%20-%20Collector%20feedback%20bias/Collector%20Feedback%20Bias%20schematic.png)

*RB connects from the collector back to the base. Its feedback wire passes above the VCC label without touching that rail.*

![Collector-feedback bias: moderately separated collector-resistor voltage drops for three beta values](02%20-%20Collector%20feedback%20bias/beta_sweep_collector_feedback.png)

*Collector-feedback LTspice sweep: each curve is labeled with its beta and measured collector-resistor voltage. Negative feedback reduces the low-to-high spread to about 1.70 V.*

![Collector-feedback VRC and VC results from the LTspice output log](02%20-%20Collector%20feedback%20bias/Collector%20Feedback%20Bias%20SPICE%20output%20log.png)

*The beta steps 115, 180, and 275 produce VRC values of 3.849 V, 4.745 V, and 5.550 V.*

## 03 - Voltage divider bias

### Start with the goal

In this circuit, **R1 = 20 kΩ and R2 = 2.7 kΩ choose a base voltage**, while **RE = 470 Ω converts emitter current into an emitter voltage**. Together they make the current depend mainly on these resistors and the supply, instead of on which transistor happens to be installed. The 3.9 kΩ collector resistor, RC, then converts collector current into the voltage shown in the plot: `VRC = IC × RC`. Similar VRC values therefore mean similar collector currents.

### Step 1: The divider gives the base a fairly firm starting voltage

With the transistor disconnected, the two resistors put the base connection at `9 V × 2.7 kΩ/(20 kΩ + 2.7 kΩ) ≈ 1.07 V`. About `9 V/(20 kΩ + 2.7 kΩ) ≈ 0.396 mA` flows through the divider. When Q1 is connected, some current also leaves that junction for its base, so the actual base voltage is a little lower than 1.07 V.

The divider's effective resistance as seen from the base is `RTH = 20 kΩ || 2.7 kΩ ≈ 2.38 kΩ`. This is useful because any extra base current lowers the base voltage by approximately `extra base current × 2.38 kΩ`. The base needs only a few microamps while the divider carries hundreds of microamps. Changing beta therefore changes the base voltage by millivolts, rather than letting the base current set the operating point directly as it does in the fixed-base circuit. The divider is **fairly stiff**, not an ideal voltage source; its remaining voltage change explains part of the small spread in the plot.

### Step 2: The emitter resistor turns current into voltage

The base-emitter junction needs roughly 0.6-0.7 V to conduct at this current. With the base near 1.07 V, the emitter sits several tenths of a volt above ground. Every milliamp through RE produces `0.470 V` across it, because `VE = IE × 470 Ω`. In this circuit, the emitter current is roughly 0.9 mA and the emitter voltage is roughly 0.4 V. The exact values come from the transistor model and the slightly loaded divider.

The important connection is that **the emitter is not tied directly to ground**. More current through Q1 must also flow through RE. That raises the emitter voltage. If the base voltage stays nearly fixed, raising the emitter moves it closer to the base, so `VBE = VB − VE` becomes smaller. A smaller VBE reduces the transistor's tendency to conduct. RE thus creates *negative feedback*: a change in current creates a voltage change that opposes that current change.

### Step 3: Follow a higher-beta transistor through the feedback loop

1. Imagine replacing Q1 with a transistor that tends to draw more collector current for the available base drive.
2. Its emitter current also tends to rise, because emitter current is the collector current plus the much smaller base current.
3. The additional emitter current raises the voltage across the 470 Ω resistor: `ΔVE = ΔIE × 470 Ω`. For example, an attempted 0.1 mA rise would raise VE by 47 mV.
4. The divider holds VB approximately steady, so that rise in VE reduces VBE by nearly the same amount. A change of tens of millivolts in VBE has a strong effect on transistor current.
5. Q1 consequently conducts less than it would have without RE. The current settles where the transistor's behavior and the resistor voltage drops are consistent. Lower beta reverses the sequence: falling current lowers VE, increases VBE, and encourages more current.

This is a **DC bias correction**, not a transistor dynamically changing its collector-to-emitter resistance to keep an exact current. RE supplies the correction automatically through ordinary voltage drops and the transistor's response to VBE. It also provides the same kind of local feedback for small AC changes, reducing gain unless an emitter-bypass capacitor is added; this schematic has no such capacitor.

### Step 4: See why beta has only a small place in the current equation

Using the divider's 1.07 V unloaded voltage and 2.38 kΩ effective resistance, a simple active-region approximation is:

`VTH = IB × RTH + VBE + IE × RE`, with `IE ≈ (β + 1) × IB`.

Rearranging gives `IE ≈ (VTH − VBE) / [RE + RTH/(β + 1)]`, and `IC ≈ [β/(β + 1)] × IE`. This is an *explanation of the trend*, not an exact replacement for the LTspice transistor model. Beta appears in two relatively small corrections: `RTH/(β + 1)` beside the 470 Ω emitter resistor, and the factor `β/(β + 1)` that converts emitter current to collector current. For β = 115, `RTH/(β + 1) ≈ 20.5 Ω`; for β = 275 it is about `8.6 Ω`. Both are small beside 470 Ω. Even with a large beta change, the dominant resistance setting emitter current hardly changes.

Compare that with fixed-base bias: its base resistor approximately fixes **IB**, then `IC ≈ β × IB`, so changing beta changes IC almost directly. Here the divider approximately fixes **VB** and RE limits **IE**. The transistor takes whatever small base current is needed to support that emitter current, subject to the divider's finite stiffness.

### Step 5: Read the three simulated outcomes

| Model's BETA step | VRC across 3.9 kΩ | Approximate collector current, VRC/3.9 kΩ |
| ---: | ---: | ---: |
| 115 | 3.397 V | 0.871 mA |
| 180 | 3.452 V | 0.885 mA |
| 275 | 3.487 V | 0.894 mA |

Beta more than doubles from 115 to 275, while collector current rises by only about 0.023 mA, or 2.7% of the low-beta result. The plot shows the corresponding **0.090 V** spread in VRC. Alan's three physical transistors produce a larger but still modest **0.31 V** spread in this circuit. Their separately measured beta values are not guaranteed to equal their effective `IC/IB` here, and the real devices can differ in VBE and other properties. LTspice changes one model's `BF` parameter; it does not model all differences between three physical transistors.

### What the emitter resistor cannot correct

The current still changes when the supply or resistor values change, and VBE itself changes with device and temperature. The feedback also needs enough supply voltage to leave the collector-emitter junction in its active operating region; near saturation, the approximation above breaks down. A larger RE generally makes the current less sensitive to device differences, but for the same current it uses more voltage and may require a different base voltage. Thus **beta tolerant** is more accurate than **beta independent**: the divider and emitter resistor greatly reduce beta's influence, but do not remove every source of variation.

![Video 185 voltage-divider circuit captured from LTspice](03%20-%20Voltage%20divider%20bias/Voltage%20Divider%20Bias%20schematic.png)

*The 20 kΩ and 2.7 kΩ divider biases the base; the 470 Ω emitter resistor provides feedback.*

![Voltage-divider bias: closely grouped collector-resistor voltage drops for three beta values](03%20-%20Voltage%20divider%20bias/beta_sweep_voltage_divider.png)

*Voltage-divider LTspice sweep: each curve is labeled with its beta and measured collector-resistor voltage. The low-to-high spread is about 0.09 V.*

![Voltage-divider VRC and VC results from the LTspice output log](03%20-%20Voltage%20divider%20bias/Voltage%20Divider%20Bias%20SPICE%20output%20log.png)

*The three beta steps produce VRC values of 3.397 V, 3.452 V, and 3.487 V. The log shows the collector voltage moving in the opposite direction.*

## What the video measures

These are W2AEW's **bench measurements** from his drawing, in volts across the collector resistor. The beta labels are the separately measured gain of each physical transistor, not guaranteed beta at every circuit operating point.

| Circuit | β ≈ 115 | β ≈ 180 | β ≈ 275 | Low-to-high span |
| --- | ---: | ---: | ---: | ---: |
| Fixed base | 2.98 V | 4.02 V | 8.69 V | 5.71 V |
| Collector feedback | 3.28 V | 3.86 V | 5.50 V | 2.22 V |
| Voltage divider | 3.67 V | 3.79 V | 3.98 V | 0.31 V |

The shrinking span is the main observation: each change in bias topology reduces dependence on the particular transistor.

## Running the LTspice examples

Open each `.asc` and select **Run**. The saved `.plt` plots `V(VCC)-V(COLLECTOR)`, the same voltage measured in the video. The three **flat** traces are steady DC bias levels for `.step param BETA list 115 180 275`; their separation, not their shape over time, is the lesson. The `.tran` analysis provides a waveform plot, and `.meas tran VRC` reports precise values for all three steps in the SPICE error log (Ctrl+L). `.meas tran VC` reports collector voltage relative to ground.

In the screenshots above, green is BETA=115, blue is BETA=180, and red is BETA=275. **Each plot has its own vertical scale**, so use the voltage labels or the table below to compare the spreads; the divider plot is zoomed into a much narrower voltage range.

| Circuit | Simulated VRC, BETA=115 | BETA=180 | BETA=275 | Low-to-high span |
| --- | ---: | ---: | ---: | ---: |
| Fixed base | 3.957 V | 6.010 V | 8.735 V | 4.778 V |
| Collector feedback | 3.849 V | 4.745 V | 5.550 V | 1.701 V |
| Voltage divider | 3.397 V | 3.452 V | 3.487 V | 0.090 V |

**Why the fixed-base values do not match Alan's:** Read each result by its beta label, not by which voltage happens to look close. LTspice's 3.957 V trace is **BETA=115 (low)**, its 6.010 V trace is **BETA=180 (nominal)**, and its 8.735 V trace is **BETA=275 (high)**. Alan measured 2.98 V, 4.02 V, and 8.69 V for his low, nominal, and high transistors, respectively. Thus the 6.010 V simulation corresponds to Alan's **4.02 V nominal** result; it does not correspond to his 2.98 V low result. The fact that the simulated low trace happens to lie near Alan's nominal 4.02 V is a coincidence. Also, the simulated nominal **collector-to-ground** voltage is 2.990 V (`VC` in the log), numerically close to Alan's 2.98 V, but Alan's `VRC` is measured **across the collector resistor**. These are different measurements.

The base resistor supplies approximately `(9 V − 0.7 V)/1 MΩ = 8.3 µA` to the base. Alan's 2.98 V drop across 3.9 kΩ implies about `0.764 mA` collector current and an effective operating beta near `0.764 mA / 8.3 µA ≈ 92`; his 4.02 V nominal drop implies about `1.03 mA` and effective beta near `124`. Those are rough estimates because actual base voltage and transistor behavior vary. His separately measured beta labels of about 115 and 180 need not be the effective betas in this circuit. LTspice steps one model's `BF` parameter to 115, 180, and 275, but `BF` is not a guarantee that `IC/IB` will equal that number at every operating point. The three physical devices can also differ in base-emitter voltage, Early effect, current-dependent gain, and saturation behavior. The high-beta case is close to saturation, limiting its resistor drop to a little below 9 V. The lesson is the strong dependence on the actual transistor, not an exact prediction of Alan's three bench readings.

W2AEW's fixed-base calculation also uses a rough `β ≈ 120` at its approximately 1 mA example operating point; this does not conflict with the separately listed nominal transistor beta of about 180. Beta is not a constant across current and voltage.

The three circuits are directly wired on the schematic. VCC is a conventional named supply connection, and each ground return is explicit. The collector label marks the node used in the voltage-drop measurement.

