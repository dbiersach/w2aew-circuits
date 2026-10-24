# Video 223: Basics of the Gilbert cell

Source: [Alan Wolke (W2AEW)](https://www.youtube.com/watch?v=7nmmb0pqTU0). His [video notes](W2AEW%20Video%20Notes%20-%20GilbertCell.pdf), page 4, show the six-transistor 2N3904 test circuit. The [circuit demonstration begins around 10:24](https://www.youtube.com/watch?v=7nmmb0pqTU0&t=624s); the physical breadboard appears around 11:16 and the two-collector comparison around 14:20.

| Time | What Alan shows |
| --- | --- |
| [10:24](https://www.youtube.com/watch?v=7nmmb0pqTU0&t=624s) | The circuit demonstration begins, on the six-transistor cell modeled in [01 - The six-transistor cell](#01---the-six-transistor-cell). |
| [11:16](https://www.youtube.com/watch?v=7nmmb0pqTU0&t=676s) | The physical breadboard. |
| [14:20](https://www.youtube.com/watch?v=7nmmb0pqTU0&t=860s) | The two-collector comparison. |

## 01 - The six-transistor cell

[Schematic](01%20-%20Six%20transistor%20Gilbert%20cell/Six%20transistor%20Gilbert%20cell.asc) · [Time-domain plot settings](01%20-%20Six%20transistor%20Gilbert%20cell/Six%20transistor%20Gilbert%20cell.plt) · [Spectrum plot settings](01%20-%20Six%20transistor%20Gilbert%20cell/Six%20transistor%20Gilbert%20cell%20spectrum.plt) · [Video at 10:24](01%20-%20Six%20transistor%20Gilbert%20cell/Video%20223%20-%2001%20-%20Six%20transistor%20Gilbert%20cell.url)

The six 2N3904s, 12 V supply, R1/R2 270 Ω collector loads, R3 270 Ω tail resistor, R4 4.7 kΩ, R5 3.3 kΩ, R6 2.2 kΩ, R7 to R10 2.2 kΩ, five 0.1 µF capacitors and two 50 Ω instrument terminations all follow Alan's page-4 drawing. The built-in LTspice 2N3904 model stands for all six devices, so this is a perfectly matched cell, not a model of his breadboard.

![LTspice schematic of the six-transistor Gilbert cell](01%20-%20Six%20transistor%20Gilbert%20cell/Six%20transistor%20Gilbert%20cell%20schematic.png)

Q5 and Q6 steer the tail current between the two halves of the upper quad. Q1 and Q4 respond to one polarity of the upper input and Q2 and Q3 to the other, and the collectors are cross-connected so that the useful output is their difference, `V(COL_A)-V(COL_B)`. Changing either differential input changes that difference; balancing either one ideally takes it to zero.

Alan does not give generator amplitudes or frequencies on the drawing, so the simulation uses **illustrative** 50 mV peak drives at 10 kHz on the upper input and 500 Hz on the lower. Input and bias network loading mean only about 12.7 mV peak of the lower drive actually reaches the lower pair.

Choosing 10 kHz and 500 Hz has a practical reason as well as a pedagogical one: their greatest common divisor is 500 Hz, so a 2 ms window holds a whole number of cycles of both. The analysis saves 16 ms of settled data, eight such windows, which makes the FFT below coherent and lets it run with no window function at all. After running the simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## What the time plot shows

![LTspice differential output above the two differential inputs](01%20-%20Six%20transistor%20Gilbert%20cell/Gilbert%20cell%20LTspice%20time%20plot.png)

The top pane is the differential collector voltage and the bottom pane holds both inputs: the 10 kHz upper drive at 50 mV peak and, as the slow curve under it, the 500 Hz lower drive. The output measures 0.611 V peak-to-peak and its envelope follows the 500 Hz input exactly, collapsing to nothing at every slow zero crossing and reversing polarity on the other side. A mixer that merely passed the fast signal through would show a constant envelope; this changing one is the time-domain signature of multiplication.

## What the spectrum shows

To read the products, load [Six transistor Gilbert cell spectrum.plt](01%20-%20Six%20transistor%20Gilbert%20cell/Six%20transistor%20Gilbert%20cell%20spectrum.plt) with Plot Settings > Open Plot Settings File after taking View > FFT of `V(col_a)` and `V(col_b)` over the whole 16 ms with no window function, then plotting their difference. The frequency axis is linear from 0 to 25 kHz and the vertical axis is dBV referred to the time-domain RMS amplitude.

![FFT of the differential output](01%20-%20Six%20transistor%20Gilbert%20cell/Gilbert%20cell%20LTspice%20IF%20spectrum.png)

Multiplying 10 kHz by 500 Hz should give the difference and sum, 9.5 kHz and 10.5 kHz, and nothing at either input frequency. That is what the simulation produces:

| Component | Level | Relative to the products |
| --- | ---: | ---: |
| 500 Hz, lower drive leakage | 6.1 µV RMS (-104.2 dBV) | -85.4 dB |
| **9.5 kHz, difference product** | **114.0 mV RMS (-18.86 dBV)** | 0 dB |
| 10 kHz, upper drive leakage | 0.68 mV RMS (-63.4 dBV) | -44.5 dB |
| **10.5 kHz, sum product** | **113.9 mV RMS (-18.87 dBV)** | -0.01 dB |
| 20 kHz, second harmonic of the upper drive | 0.91 mV RMS (-60.8 dBV) | -41.9 dB |

The two wanted products are equal to within 0.01 dB, and both input frequencies are suppressed: that is what makes this a *double-balanced* mixer rather than a simple one. Neither input appears at the output on its own, only their products.

The suppression figures belong to the simulation, not to Alan's breadboard. They are this good because all six modeled transistors are identical and the resistors are exact. A physical cell is limited by how well its transistors and bias components match, so a real build shows considerably more carrier feedthrough and more distortion products than the table above.
