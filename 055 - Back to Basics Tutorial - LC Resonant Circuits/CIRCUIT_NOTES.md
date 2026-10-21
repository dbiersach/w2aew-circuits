# Video 055 - Back to Basics: Tutorial on LC Resonant Circuits

[Watch Alan Wolke's video](https://www.youtube.com/watch?v=hqhV50852jA) alongside his [handwritten notes](<W2AEW Video Notes - LC_Resonance.pdf>). This video builds on [video 054](https://www.youtube.com/watch?v=ykgmKOVkyW0): current leads voltage in a capacitor and lags it in an inductor.

| Time | What Alan shows |
| --- | --- |
| [0:30](https://www.youtube.com/watch?v=hqhV50852jA&t=30s) | Resonance is the frequency where the capacitive reactance 1/(2 pi f C) equals the inductive reactance 2 pi f L, and the voltage and current are in phase, as in a resistor. |
| [1:04](https://www.youtube.com/watch?v=hqhV50852jA&t=64s) | **Series LC.** The same current flows through both parts. V(L) leads that current by 90 degrees and V(C) lags it by 90 degrees, so the two voltages are 180 degrees apart. At resonance they are equal, cancel, and the series LC looks like a short circuit. Below resonance it looks capacitive; above, inductive. |
| [3:32](https://www.youtube.com/watch?v=hqhV50852jA&t=212s) | Series LC on the breadboard. Channel 2 probes the inductor and channel 1 the whole stack; the scope's math trace CH1 - CH2 gives the capacitor voltage. As Alan sweeps the generator, V(L) and V(C) stay 180 degrees apart and trade size. At resonance, near 35 kHz on the scope readout, channel 1 nearly vanishes. |
| [5:47](https://www.youtube.com/watch?v=hqhV50852jA&t=347s) | **Parallel LC.** The same voltage is across both parts. I(L) lags and I(C) leads, so the two branch currents are 180 degrees apart and cancel at resonance: the tank looks like an open circuit. |
| [7:32](https://www.youtube.com/watch?v=hqhV50852jA&t=452s) | Parallel LC on the breadboard, with channel 1 directly across the tank. Off resonance the tank loads the generator and the voltage drops. At resonance it peaks at about the generator's open-circuit voltage. |

Page 2 of the notes gives the design formulas, f = 1/(2 pi sqrt(L C)), with L and C solved from each other. It also notes that, ideally, any L and C pair with the same product resonates at the same frequency. For example, 1 pF with 253 uH and 1 uF with 253 pH both resonate at 10 MHz.

## The test setup in LTspice

Alan connects the generator directly to the LC network; there is no resistor in his circuit. The only resistance is the generator's own output resistance, modeled here as `Rser = 50` on V1, plus the inductor's winding resistance. That 50 Ohm is what lets the parallel tank "load the generator" when it is off resonance.

| Value | Source | Used in the simulation |
| --- | --- | --- |
| Topology and probes | Notes page 1 and the bench at 3:32 and 7:32 | Series: C1 above L1 to ground, `CH1` across the stack, `CH2` across L1. Parallel: L1 and C1 both across `CH1` |
| Resonant frequency | Scope frequency readout near 35 kHz during the series demonstration | f0 = 33.9 kHz |
| L and C | Not stated in the video | 220 uH with 1 Ohm winding resistance (`Rser=1`) and 100 nF, standard values for f0 = 1/(2 pi sqrt(220 uH x 100 nF)) = 33.9 kHz |
| Generator | Open-circuit level read from the parallel peak at 8:42, about 4 V p-p; typical 50 Ohm output | 2 V peak (4 V p-p) open circuit, Rser = 50 Ohm |

The transient schematics step the generator through three frequencies in one run: `.step param f list 20k 33.93k 50k`, below, at and above resonance. They save 200 to 300 us, after start-up has settled. LTspice shows that window on a 0 to 100 us axis, matching Alan's 10 us/div scope screens. Each step has its own pane, built with the `@n` step selector (for example `V(ch2)@1` is step 1, 20 kHz). Every pane is labeled with its frequency, what each trace is, and the measured values.

The sweep schematics replace the sine with `AC 2` and run `.ac dec 200 5k 200k`. Each sweep plot has two panes:

- **Top pane:** the voltage Alan's channel 1 shows, on a linear scale.
- **Bottom pane:** the network's impedance, as magnitude on a log scale (solid) and phase (dashed, right axis).

For `.meas` in AC analysis, LTspice reports magnitudes in dB; the tables below convert them.

If the waveform window opens autoscaled or without the labels after you click **Run**, press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`. In the stepped transient plots, LTspice may draw a one-trace pane once per step in alternating colors. **Plot Settings > Select Steps** (Shift+S) with a single step selected and Auto Range cleared draws each `@n` trace cleanly.

## 01 - Series LC circuit

[Watch the series explanation from 1:04](https://www.youtube.com/watch?v=hqhV50852jA&t=64s) and the [bench demonstration from 3:32](https://www.youtube.com/watch?v=hqhV50852jA&t=212s).

### Below, at and above resonance

[Open the schematic](<01 - Series LC circuit/Series LC below at and above resonance.asc>).

![LTspice series LC schematic](<01 - Series LC circuit/Series LC schematic.png>)

![LTspice series LC at three frequencies](<01 - Series LC circuit/Series LC below at and above resonance.png>)

Each pane shows three traces, the ones Alan displays:

- `V(ch2)`: the inductor voltage V(L1).
- `V(ch1)-V(ch2)`: the capacitor voltage V(C1), the scope's math trace.
- `V(ch1)`: the whole stack.

Reading the panes from top to bottom:

- **20 kHz, below resonance.** C1's reactance (80 Ohm) exceeds L1's (28 Ohm), so V(C1) is the larger voltage. The stack voltage follows V(C1): the series circuit is capacitive.
- **33.9 kHz, at resonance.** Both reactances are 46.9 Ohm. V(L1) and V(C1) are equal at 3.68 V p-p and exactly opposite, so they cancel. Only 78 mV p-p remains across the stack; it comes from L1's 1 Ohm winding resistance. The stack is almost a short circuit, as on Alan's scope at 5:00. Each part carries nearly the full generator voltage even though the pair carries almost none.
- **50 kHz, above resonance.** L1 dominates (69 Ohm against 32 Ohm), and the stack follows V(L1): the circuit is inductive.

In every pane the inductor and capacitor voltages stay 180 degrees apart, which Alan points out at 4:38.

![LTspice series LC measurements](<01 - Series LC circuit/Series LC SPICE output log.png>)

| Step | Frequency | `VL_PP` | `VC_PP` | `STACK_PP` |
| ---: | ---: | ---: | ---: | ---: |
| 1 | 20 kHz | 1.52 V | 4.37 V | 2.85 V |
| 2 | 33.9 kHz | 3.68 V | 3.68 V | 0.078 V |
| 3 | 50 kHz | 4.38 V | 2.01 V | 2.36 V |

### Frequency sweep

[Open the sweep schematic](<01 - Series LC circuit/Series LC frequency sweep.asc>).

![LTspice series LC sweep schematic](<01 - Series LC circuit/Series LC frequency sweep schematic.png>)

![LTspice series LC frequency sweep](<01 - Series LC circuit/Series LC frequency sweep.png>)

- **Top pane:** `V(ch1)`, the stack voltage, is about 2 V away from resonance, where the LC's large reactance takes almost all the generator voltage. It falls to 39 mV at 33.9 kHz.
- **Bottom pane:** `V(ch1)/I(C1)`, the stack's impedance, dips to 1.0 Ohm at resonance, the inductor's winding resistance. Its phase jumps from -90 degrees (capacitive) to +90 degrees (inductive) as the frequency passes through f0.

![LTspice series LC sweep measurements](<01 - Series LC circuit/Series LC frequency sweep SPICE output log.png>)

| Measurement | LTspice result | Meaning |
| --- | --- | --- |
| `F_RES` | 33932 Hz | The frequency where the impedance has no imaginary part, matching 1/(2 pi sqrt(L C)) = 33.93 kHz. |
| `Z_RES` | 0.044 dB = 1.005 Ohm | Impedance at resonance: just the winding resistance. |
| `STACK_RES` | -28.09 dB = 39 mV peak | Voltage across the stack at resonance (78 mV p-p, as in the transient run). |

## 02 - Parallel LC circuit

[Watch the parallel explanation from 5:47](https://www.youtube.com/watch?v=hqhV50852jA&t=347s) and the [bench demonstration from 7:32](https://www.youtube.com/watch?v=hqhV50852jA&t=452s).

### Below, at and above resonance

[Open the schematic](<02 - Parallel LC circuit/Parallel LC below at and above resonance.asc>).

![LTspice parallel LC schematic](<02 - Parallel LC circuit/Parallel LC schematic.png>)

![LTspice parallel LC at three frequencies](<02 - Parallel LC circuit/Parallel LC below at and above resonance.png>)

The top three panes show `V(ch1)`, the tank voltage on Alan's channel 1, at 20 kHz, 33.9 kHz and 50 kHz:

- **20 kHz.** The tank is inductive with a low impedance (42 Ohm), so it loads the 50 Ohm generator and the voltage drops to 2.52 V p-p.
- **33.9 kHz, at resonance.** The tank rises to 3.91 V p-p, almost the 4 V p-p open-circuit generator voltage. The tank barely loads the generator.
- **50 kHz.** The tank is capacitive (59 Ohm) and the voltage drops again, to 3.03 V p-p.

The bottom pane explains the resonance case, drawn on page 1 of Alan's notes. `I(L1)@2` and `I(C1)@2` are each 83 mA p-p but exactly opposite, so they cancel. The generator supplies only the 1.8 mA p-p difference (`-I(V1)@2`). Large currents circulate between L1 and C1 while the outside world sees nearly an open circuit.

![LTspice parallel LC measurements](<02 - Parallel LC circuit/Parallel LC SPICE output log.png>)

| Step | Frequency | `TANK_PP` | `IL_PP` | `IGEN_PP` |
| ---: | ---: | ---: | ---: | ---: |
| 1 | 20 kHz | 2.52 V | 91.0 mA | 59.4 mA |
| 2 | 33.9 kHz | 3.91 V | 83.4 mA | 1.78 mA |
| 3 | 50 kHz | 3.03 V | 43.9 mA | 51.4 mA |

### Frequency sweep

[Open the sweep schematic](<02 - Parallel LC circuit/Parallel LC frequency sweep.asc>).

![LTspice parallel LC sweep schematic](<02 - Parallel LC circuit/Parallel LC frequency sweep schematic.png>)

![LTspice parallel LC frequency sweep](<02 - Parallel LC circuit/Parallel LC frequency sweep.png>)

- **Top pane:** the tank voltage peaks at 1.96 V (3.91 V p-p) at 33.9 kHz. Far from resonance it falls to about 0.3 V, where the tank's small reactance shorts the generator. This is what Alan sees on his scope at 8:18 as he moves the frequency above and below resonance.
- **Bottom pane:** `-V(ch1)/I(V1)`, the tank impedance seen by the generator, peaks at 2.19 kOhm. That peak is set by L1's 1 Ohm winding resistance: L / (R C) = 2.2 kOhm. The phase runs from +90 degrees (inductive) below resonance to -90 degrees (capacitive) above, the opposite of the series circuit.

![LTspice parallel LC sweep measurements](<02 - Parallel LC circuit/Parallel LC frequency sweep SPICE output log.png>)

| Measurement | LTspice result | Meaning |
| --- | --- | --- |
| `F_RES` | 33925 Hz | Zero-phase frequency of the tank; the winding resistance moves it a few hertz below the ideal 33.93 kHz. |
| `Z_RES` | 66.80 dB = 2188 Ohm | Tank impedance at resonance. |
| `TANK_RES` | 5.82 dB = 1.955 V peak | Tank voltage at resonance: 98 percent of the 2 V open-circuit generator voltage. |

## Circuit files

| File | Purpose |
| --- | --- |
| `01 - Series LC circuit/Series LC below at and above resonance.asc` and `.plt` | Series LC at 20 kHz, 33.9 kHz and 50 kHz, with V(L1), V(C1) and the stack voltage. |
| `01 - Series LC circuit/Series LC frequency sweep.asc` and `.plt` | AC sweep of the stack voltage and impedance. |
| `02 - Parallel LC circuit/Parallel LC below at and above resonance.asc` and `.plt` | Parallel tank voltage at three frequencies, plus the branch currents at resonance. |
| `02 - Parallel LC circuit/Parallel LC frequency sweep.asc` and `.plt` | AC sweep of the tank voltage and impedance. |
| `Video 055 - 01 - Series LC circuit.url`, `Video 055 - 02 - Parallel LC circuit.url` | Open the video where each circuit is introduced. |
