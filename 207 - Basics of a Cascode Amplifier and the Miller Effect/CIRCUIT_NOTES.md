# Video 207: the cascode amplifier and the Miller effect

[Full video](https://www.youtube.com/watch?v=Op_I3Ke7px0) · [Alan Wolke's notes, including Marcus Jenkins's board schematic](W2AEW%20Video%20Notes%20-%20cascodemiller.pdf)

| Time | What Alan shows |
| --- | --- |
| [8:21](https://www.youtube.com/watch?v=Op_I3Ke7px0&t=501s) | [01 - Q1 bypassed: plain common emitter](#01---q1-bypassed-plain-common-emitter) |
| [10:00](https://www.youtube.com/watch?v=Op_I3Ke7px0&t=600s) | [02 - Q1 installed: cascode](#02---q1-installed-cascode) |

Alan sweeps the same physical amplifier board twice: once with its upper transistor Q1 bypassed, so the board is a plain common-emitter stage, and once with Q1 installed, which turns it into a cascode. Q2 is the common-emitter input transistor in both cases and Q3 is an emitter-follower output buffer, so the only thing that changes between the two runs is Q1. The board is Marcus Jenkins's design, reproduced on page 3 of Alan's notes. Alan adds a 1 kΩ resistor in series with his 50 Ω generator so that the input capacitance has something to work against and its effect shows up on the sweep.

Both schematics run `.ac dec 200 10k 200Meg` with a 1 V AC source, so the plotted magnitude is the voltage gain directly: a trace at 10 means a gain of 10. Each one measures the peak gain, the frequency it peaks at, the upper 3 dB frequency referred to that peak, and the AC voltage on Q2's collector at 100 kHz. Both saved plots use the same axes. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - Q1 bypassed: plain common emitter

[Open the segment at 8:21](https://www.youtube.com/watch?v=Op_I3Ke7px0&t=501s) · [Schematic](01%20-%20Common%20emitter%20with%20Q1%20bypassed/Common%20emitter%20with%20Q1%20bypassed.asc) · [Saved plot settings](01%20-%20Common%20emitter%20with%20Q1%20bypassed/Common%20emitter%20with%20Q1%20bypassed.plt)

Q2's collector goes straight to the 6.8 kΩ load resistor R4, so the full inverted output swing appears on it.

![LTspice common-emitter schematic with Q1 bypassed](01%20-%20Common%20emitter%20with%20Q1%20bypassed/Common%20emitter%20with%20Q1%20bypassed%20schematic.png)

![Common-emitter response and Q2 collector swing](01%20-%20Common%20emitter%20with%20Q1%20bypassed/Common%20emitter%20with%20Q1%20bypassed%20LTspice%20AC%20plot.png)

![Common-emitter measurements](01%20-%20Common%20emitter%20with%20Q1%20bypassed/Common%20emitter%20with%20Q1%20bypassed%20SPICE%20output%20log.png)

The response peaks at 26.68 dB at 2.40 MHz and is 3 dB down by 4.04 MHz. The lower pane is the point of the chapter: at 100 kHz, Q2's own collector is swinging 6.51 V/V. Q2's base-to-collector capacitance is only a few picofarads, but one plate of it moves with the base while the other moves 6.51 times as far in the opposite direction, so the charge the source has to supply is that of a capacitor about 7.5 times larger. That multiplied capacitance, working into the 1 kΩ Alan added, is what rolls the response off.

## 02 - Q1 installed: cascode

[Open the segment at 10:00](https://www.youtube.com/watch?v=Op_I3Ke7px0&t=600s) · [Schematic](02%20-%20Cascode%20installed/Cascode%20installed.asc) · [Saved plot settings](02%20-%20Cascode%20installed/Cascode%20installed.plt)

Q1 now sits between Q2's collector and R4, with its base held at a fixed bias. Q2 still carries the signal current, but it now delivers it into Q1's emitter, which is a low impedance.

![LTspice cascode schematic with Q1 installed](02%20-%20Cascode%20installed/Cascode%20installed%20schematic.png)

![Cascode response and Q2 collector swing](02%20-%20Cascode%20installed/Cascode%20installed%20LTspice%20AC%20plot.png)

![Cascode measurements](02%20-%20Cascode%20installed/Cascode%20installed%20SPICE%20output%20log.png)

Q2's collector now swings 0.688 V/V at 100 kHz instead of 6.51, a factor of 9.5. With so little voltage swing across the base-collector capacitance, there is almost nothing to multiply, and the input no longer has a large effective capacitance to charge. The current Q2 steers still reaches R4 through Q1, so the overall gain is not given away: it rises slightly, to 28.02 dB.

| | Peak gain | Peak frequency | Upper 3 dB point | Q2 collector swing at 100 kHz |
| --- | ---: | ---: | ---: | ---: |
| Q1 bypassed, common emitter | 26.68 dB (21.6x) | 2.40 MHz | 4.04 MHz | 6.51 V/V |
| Q1 installed, cascode | 28.02 dB (25.2x) | 4.95 MHz | 10.38 MHz | 0.688 V/V |

The bandwidth improves by a factor of 2.6 while the gain goes up rather than down. Alan's bench sweep puts the common-emitter bandwidth at roughly 4 to 5 MHz and the cascode at roughly 8 to 9 MHz, so the model reproduces both the direction and the size of the improvement without calibrating his physical board.

## Model and source limits

- The resistor and capacitor values and the three 2N3904 part numbers come from page 3 of Alan's PDF. The added 1 kΩ input resistor and the 50 Ω generator impedance are described in the video. The supply is 12 V.
- The physical board has a ferrite bead between Q1 and Q2. Its impedance is not given in Alan's notes, so the cascode schematic bridges those nodes with a wire. The board's parasitics and its exact high-frequency shaping cannot be reconstructed from the notes.
- The simulations use LTspice's built-in 2N3904 model from `standard.bjt`, not a measurement of Marcus's actual samples.
- The operating points are sound in both configurations: Q2's collector current is about 0.80 mA with Q1 bypassed and 0.76 mA with Q1 installed, and the node at R4 sits at about 6.55 V and 6.83 V on the 12 V supply, so both stages have headroom for the comparison.
- The AC source amplitude of 1 V is only a scaling convenience; small-signal AC analysis linearises about the operating point, so no real 1 V input is implied.
