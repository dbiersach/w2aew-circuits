# Video 224: AM and DSB-SC modulation with the Gilbert cell

Source: Alan Wolke (W2AEW), [#224: AM & DSB-SC Modulation with the Gilbert Cell](https://www.youtube.com/watch?v=38OQub2Vi2Q). His one-page drawing for the lesson is kept here as [W2AEW Video Notes - GilbertCellModulation.pdf](<W2AEW Video Notes - GilbertCellModulation.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:15](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=15s) | The circuit, which is the one from [video 223](<../223 - Basics of the Gilbert Cell - Analog Multiplier - Mixer - Modulator/CIRCUIT_NOTES.md>) with one change: the DC offset on the lower pair's baseband input can now be adjusted. |
| [2:05](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=125s) | The complete six-transistor circuit, reproduced in [01 - AM bias](#01---am-bias) and [02 - DSB-SC balanced bias](#02---dsb-sc-balanced-bias). |
| [3:28](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=208s) | AM on a Tektronix MDO4104C at 400 µs/div. The modulated output rises and falls but never collapses, and the baseband trace below it stays entirely on one side of the zero line. |
| [4:45](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=285s) | The same circuit after the offset is trimmed. Now the baseband straddles zero, and the modulated output pinches to a thin waist at each crossing: DSB-SC. |
| [6:33](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=393s) | The scope's spectrum display turned on below the waveforms, at 5 kHz/div and 10 dB/div. |
| [7:10](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=430s) | Reading the spectrum: the carrier line and the two sidebands either side of it, and how much the carrier drops when the bias is balanced. |
| [9:33](https://www.youtube.com/watch?v=38OQub2Vi2Q&t=573s) | A zoomed-out view of the two cases for comparison. |

## What the lesson establishes

A Gilbert cell multiplies two inputs. Feed the upper quad a carrier and the lower pair a baseband tone, and the output is their product, which is a pair of sidebands at the sum and difference frequencies and nothing at the carrier frequency itself. That is DSB-SC: double sideband, suppressed carrier.

Ordinary AM is the same thing with a constant added to the baseband. Multiply the carrier by `(1 + m·cos(ωt))` instead of by `cos(ωt)` and the constant term puts the carrier back. In this circuit that constant is simply a **DC offset on the lower pair**, which is why one bias adjustment moves the circuit between the two modulation types and sets the modulation depth in between.

The thing to watch is whether the lower pair's differential input crosses zero:

- If the offset keeps one side of the pair always ahead of the other, the cell's gain keeps the same sign, the carrier never vanishes, and the result is AM. The envelope traces the baseband.
- If the offset is trimmed so the input swings either side of zero, the gain reverses sign each time it crosses. The output collapses at the crossing and comes back in antiphase. The envelope looks similar at a glance, but the carrier has been cancelled and only the sidebands remain.

That phase reversal is the real signature, and it is why Alan brings up the spectrum display: in the time domain a fully modulated AM signal and a DSB-SC signal are easy to confuse, while in the frequency domain the difference is a line that is either there or not.

## The two schematics

Both files are the **same circuit with one different number**. They differ only in the heading and in `VBIAS`, the DC supply feeding the lower pair's baseband input through R9:

| Chapter | `VBIAS` | Lower-pair differential drive | Result |
| --- | ---: | --- | --- |
| [01 - AM bias](<01 - AM bias/Gilbert cell AM.asc>) | 2.820 V | +9.2 mV to +39.0 mV, never crossing zero | AM |
| [02 - DSB-SC balanced bias](<02 - DSB-SC balanced bias/Gilbert cell DSB-SC.asc>) | 2.765 V | -14.4 mV to +13.8 mV, crossing zero twice per cycle | DSB-SC |

The six 2N3904 transistors, the 12 V supply, the 270 Ω collector loads and tail resistor, the 3.9 kΩ / 3.3 kΩ / 2.2 kΩ divider, the 2.2 kΩ base feeds, the 0.1 µF coupling and bias capacitors, the 2.2 µF divider bypass and the 50 Ω generator terminations all follow Alan's drawing. His notes give 50 mVpp drives and a 1.5 kHz modulating tone, and the bench carrier in the video is 18 kHz.

Two things are simulation choices rather than reported values. The LTspice 2N3904 model stands in for six physical transistors, which matters because carrier suppression depends on how well the quad matches. And **Alan never states the DC voltage on his bias control**, so the two `VBIAS` values here were found by simulating the input balance. They are not claims about his bench setting; what is claimed is the behaviour either side of the balance point.

## 01 - AM bias

![LTspice schematic of the Gilbert cell modulator at AM bias](<01 - AM bias/Gilbert cell AM schematic.png>)

![AM: collector difference above, lower-pair drive below](<01 - AM bias/Gilbert cell AM time response.png>)

The top pane is the differential collector output and the bottom pane is the differential drive on the lower pair, over four modulation cycles. The drive stays between +9.2 mV and +39.0 mV, so Q5 never hands conduction over to Q6, and the carrier is present through every envelope minimum. The output reaches 380 mV positive and 386 mV negative.

Both panes use the same scales in the two chapters, so the two figures can be compared directly.

![Fourier components of the AM output](<01 - AM bias/Gilbert cell AM Fourier components.png>)

The `.four 1.5k 13 15` directive asks LTspice for the first thirteen harmonics of the 1.5 kHz modulating tone over fifteen of its periods, which is a 10 ms window. That window happens to be the useful one here, because the carrier and both sidebands are themselves harmonics of 1.5 kHz: the 11th is 16.5 kHz, the 12th is 18 kHz, and the 13th is 19.5 kHz. Reading those three rows out of the table:

| Line | Frequency | Amplitude |
| --- | ---: | ---: |
| Lower sideband | 16.5 kHz | 70.9 mV |
| Carrier | 18 kHz | 250.0 mV |
| Upper sideband | 19.5 kHz | 70.8 mV |

Two sidebands of 70.9 mV against a 250.0 mV carrier is a modulation index of about 57%, which is what the visible envelope depth in the top pane corresponds to. The remaining rows of the table are the cell's own distortion products and sit three or more orders of magnitude lower. Ignore the harmonic distortion percentages LTspice prints under the table; they are computed against the 1.5 kHz row as if it were the fundamental, which it is not.

## 02 - DSB-SC balanced bias

![LTspice schematic of the Gilbert cell modulator at balanced bias](<02 - DSB-SC balanced bias/Gilbert cell DSB-SC schematic.png>)

![DSB-SC: collector difference above, lower-pair drive below](<02 - DSB-SC balanced bias/Gilbert cell DSB-SC time response.png>)

Lowering `VBIAS` by 55 mV is enough to move the drive down through zero. It now runs from -14.4 mV to +13.8 mV, and at each zero crossing the output pinches to almost nothing before building back up in the opposite phase. On the shared vertical scale the output peaks at 155 mV instead of 380 mV, because the carrier that made up most of the AM peak is gone.

![Fourier components of the DSB-SC output](<02 - DSB-SC balanced bias/Gilbert cell DSB-SC Fourier components.png>)

| Line | Frequency | Amplitude |
| --- | ---: | ---: |
| Lower sideband | 16.5 kHz | 78.7 mV |
| Carrier | 18 kHz | 2.94 mV |
| Upper sideband | 19.5 kHz | 78.6 mV |

The carrier has dropped from 250 mV to 2.94 mV, which is **28.5 dB below either sideband**. The sidebands have grown slightly, from 70.9 mV to 78.7 mV, because the power that was going into the carrier now goes into them. That is the point of suppressing it.

## Simulation against Alan's bench

The qualitative agreement is exact, and it is visible in the same two traces. In the video the baseband trace sits wholly above the zero reference for AM and straddles it for DSB-SC, which is precisely what the lower pane of each figure shows. The output pinches at the crossings in both.

The carrier suppression is where simulation and bench part company, and for a reason worth stating. Here the six transistors are six copies of one model, perfectly matched, and the suppression reaches 28.5 dB. Alan gets roughly 20 dB on a breadboard. Carrier feedthrough in a balanced modulator comes almost entirely from mismatch, in the quad's base-emitter voltages and in the collector load resistors, so a simulation with identical devices flatters the circuit. Trimming the bias on the bench compensates for some of that mismatch but cannot cancel all of it at once.

Note also that this is a **modulator only**. There is no detector in the circuit, so the lower pane of each plot is the baseband going in, not audio coming back out.
