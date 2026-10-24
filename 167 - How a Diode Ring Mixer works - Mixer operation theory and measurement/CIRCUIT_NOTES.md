# Video 167: How a Diode Ring Mixer works

Source: Alan Wolke (W2AEW), [How a Diode Ring Mixer works](https://www.youtube.com/watch?v=junuEwmQVQ8). See [Alan's handwritten video notes](W2AEW%20Video%20Notes%20-%20Diode_ring_mixer_operation.pdf).

| Time | What Alan shows |
| --- | --- |
| [0:26](https://www.youtube.com/watch?v=junuEwmQVQ8&t=26s) | He draws the passive diode ring mixer and holds up the physical module, which is the circuit modeled in [01 - Diode ring mixer](<01 - Diode ring mixer/>). |
| [1:39](https://www.youtube.com/watch?v=junuEwmQVQ8&t=99s) | The handwritten product-to-sum identity behind the sum and difference frequencies. |
| [1:50](https://www.youtube.com/watch?v=junuEwmQVQ8&t=110s) | The bench setup: the mixer board driven by two generators, with the scope on the IF port. |

## What to look for

The LO drives the four-diode ring so that one diagonal pair conducts during one half-cycle and the other pair conducts during the next. This reverses the RF signal's connection to the IF port on each half-cycle. In effect, the circuit multiplies the RF signal by a switching waveform. The IF therefore contains both the **difference** and **sum** of the RF and LO frequencies. Alan shows the switching paths, then examines the time-domain signal and spectrum.

The [main schematic](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20conversion%20example.asc) follows the ring and two-transformer arrangement in the video. Its LO transformer is on the left, the four diodes form the ring in the center, and the RF transformer is on the right. The LO winding's center tap goes to ground. The RF winding's center tap is the 50 Ω IF output. The [circuit shortcut](01%20-%20Diode%20ring%20mixer/Video%20167%20-%2001%20-%20Diode%20ring%20mixer.url) opens the beginning of the demonstration.

![Main diode-ring mixer schematic copied from LTspice](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20schematic.png)

The generated LTspice netlist connects the LO and RF windings to opposite ring corners. Each diode connects a neighboring LO and RF corner. This is the topology required for alternate diode pairs to steer the RF signal.

## Short transient: see the switching result

The main schematic runs `.tran 0 10u 0 10p`. Its sources use Alan's **7 MHz LO** and **10 MHz RF**. The simulation lasts 10 µs, but the [saved plot settings](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20conversion%20example.plt) display the first 1 µs so individual cycles remain legible. IF is at the top, RF in the middle, and LO at the bottom. The **10 ps maximum time step** limits how far LTspice may advance at once; it does not mean that every plotted point is exactly 10 ps apart.

![First microsecond of the mixer transient copied from LTspice](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%201%20us%20transient.png)

The same LTspice run across its full **0-10 µs** interval is shown below. It contains 100 RF cycles and 70 LO cycles, so the individual IF switching details are harder to distinguish than in the zoomed view above.

![Full ten microseconds of the same mixer transient copied from LTspice](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%2010%20us%20transient.png)

The RF and LO inputs are steady-amplitude sine waves. In the 1 µs display, RF completes 10 cycles and LO completes 7. The IF is no longer a sine wave: diode switching creates several frequency components. The most important frequencies to check in the FFT are the **3 MHz difference** and **17 MHz sum**. An apparent envelope in the time plot is not a separate measurement of output frequency; the FFT resolves the components.

## FFT: locate the inputs and mixing products

The separate [spectrum schematic](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20spectrum.asc) uses the same physical ring and transformer connections. It runs `.tran 0 40u 20u 10p` and saves `V(IF)`, `V(RF_SRC)`, and `V(LO_SRC)` from 20 to 40 µs. This produces a 20 µs FFT record with 50 kHz frequency spacing. The first 20 µs let startup settle; the following 20 µs contain an integer number of both source cycles. The short transient schematic remains the useful view for individual switching cycles. The 10 ps maximum step makes the analysis slower and its `.raw` file larger.

![Spectrum schematic copied from LTspice](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20spectrum%20schematic.png)

For Alan's **10 MHz RF** and **7 MHz LO**, the expected frequencies are:

| Peak marked on the FFT | Calculation | Meaning |
| --- | --- | --- |
| **Difference: 3 MHz** | 10 MHz − 7 MHz | The desired IF in this demonstration |
| **LO: 7 MHz** | Input LO frequency | LO feedthrough, if present at IF; ideally suppressed by ring balance |
| **RF: 10 MHz** | Input RF frequency | RF feedthrough, if present at IF; ideally suppressed by ring balance |
| **Sum: 17 MHz** | 10 MHz + 7 MHz | The other principal mixing product |

![LTspice FFT with labels at the 3 MHz difference, 7 MHz LO input, 10 MHz RF input, and 17 MHz sum peaks](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20LO%20RF%20and%20IF%20spectrum.png)

> **After opening the FFT in LTspice, press Ctrl+Space.** This runs **Plot Settings > Reload Plot Settings** and switches the new FFT from LTspice's broad default display to the predefined frequency scale and peak labels shown above. Do this each time you create a new FFT window.

The FFT shows the **LO input trace at 7 MHz**, the **RF input trace at 10 MHz**, and the **IF output trace at the 3 MHz difference and 17 MHz sum**. The LO and RF markers identify their input spectra, not strong IF output peaks: a balanced mixer suppresses those input frequencies at its IF port. The horizontal axis is frequency. The vertical axis is LTspice voltage FFT magnitude in dB referenced to 1 V RMS; it is **not dBm**. Smaller IF peaks can come from switching harmonics, imbalance, or the modeled circuit. The [saved FFT settings](01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20spectrum.plt) preserve the marked view. The FFT uses the full saved 20 µs interval, LTspice's three-point binomial smoothing, and no additional window. Both input tones complete an integer number of cycles in that interval: **140 LO cycles** and **200 RF cycles**. This makes a rectangular window appropriate for locating these tones.

## Model scope

Alan uses hand-wound center-tapped transformers and 1N5711 diodes. The simulation's 25 µH primary and 6.25 µH secondary half-windings, 0.999 coupling, 50 Ω source and IF terminations, 0.1 V-peak RF drive, and 2 V-peak LO drive are illustrative assumptions. The local [1N5711WS diode model](../LTspice/Models/Diodes-Inc/DI_1N5711WS.lib) represents a related Schottky part, not measurements of Alan's particular diodes. The simulation demonstrates the topology and frequency products; its conversion loss, leakage, and harmonic levels are not predictions for Alan's hardware.

The [alternative T1-6T-X65+ schematic](01%20-%20Diode%20ring%20mixer/Alternative%20T1-6T-X65%2B%20model/Diode%20ring%20mixer%20-%20T1-6T-X65%2B.asc) keeps the ring and IF connection but draws two five-pin transformer symbols. Its [circuit shortcut](01%20-%20Diode%20ring%20mixer/Alternative%20T1-6T-X65%2B%20model/Video%20167%20-%2001%20-%20Alternative%20T1-6T-X65%2B%20model.url) points to the same lesson. This is an optional implementation example; Alan's hand-wound transformers are the baseline.

![Alternative transformer schematic copied from LTspice](<01 - Diode ring mixer/Alternative T1-6T-X65+ model/Diode ring mixer alternative schematic.png>)

![First microsecond of the alternative transformer transient copied from LTspice](<01 - Diode ring mixer/Alternative T1-6T-X65+ model/Diode ring mixer alternative 1 us transient.png>)

![Alternative transformer FFT copied from LTspice, showing the 3 MHz difference, 7 MHz LO, 10 MHz RF, and 17 MHz sum](<01 - Diode ring mixer/Alternative T1-6T-X65+ model/Diode ring mixer alternative LO RF and IF spectrum.png>)

> **After opening this FFT in LTspice, press Ctrl+Space.** This reloads its predefined plot settings; otherwise LTspice may show a GHz-wide default view that hides the MHz peaks at the left edge.

The alternative uses `.tran 0 40u 20u 10p`, the same timing as the main spectrum schematic. Its 20-40 µs saved interval gives a 20 µs FFT record and **50 kHz bin spacing**. The FFT image above is captured from this alternative circuit, with the same 2-20 MHz frequency range and +10 to −110 dB magnitude range as the main spectrum image. Its 3 MHz difference and 17 MHz sum peaks are both on the green `V(IF)` trace; the 7 MHz blue and 10 MHz red peaks identify the input sources. The peak frequencies match the main circuit; the alternative transformer assumptions can change their amplitudes and other harmonics. The [saved plot settings](<01 - Diode ring mixer/Alternative T1-6T-X65+ model/Diode ring mixer - T1-6T-X65+.plt>) retain the labeled FFT view. The [transformer subcircuit](<../LTspice/Models/Educational/T1_6T_X65.sub>) follows the physical pin arrangement, but its inductances and coupling are illustrative. It is **not** a Mini-Circuits manufacturer SPICE model and should not be used to predict the actual transformer's RF performance.

To reproduce the FFT image in LTspice, run the alternative `.asc`, right-click the transient plot, and choose **View > FFT**. In the waveform dialog, Ctrl-click so **all three** traces, `V(if)`, `V(lo_src)`, and `V(rf_src)`, are selected. Keep the full 20 µs saved interval and click OK. LTspice initially opens a newly created FFT with its broad default frequency range, so choose **Plot Settings > Reload Plot Settings** (Ctrl+Space) in the FFT window. That restores the saved 2-20 MHz scale and peak labels. The FFT calculation is the same before and after reloading; only its display changes.
