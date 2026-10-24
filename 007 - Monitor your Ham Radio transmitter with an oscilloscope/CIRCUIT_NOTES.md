# Video 007 - Watching a transmitter on a scope

Source: Alan Wolke (W2AEW), [#7: Monitor your Ham Radio transmitter with an oscilloscope](https://www.youtube.com/watch?v=y4Zt_LJX1Tc). He draws the circuit on a notepad in the video rather than supplying a PDF, so the values below are read from the drawing he holds up between 0:47 and 1:57.

| Time | What Alan shows |
| --- | --- |
| [0:23](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=23s) | The finished board: a strip of copper-clad with three BNC connectors, marked demod, RF in and out, and sample. |
| [0:47](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=47s) | The drawing, starting at the sampler end: 47 k and 690 ohm, then 0.01 uF out to the scope. |
| [1:33](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=93s) | The whole thing, labeled RF sampler plus detector and demod, with the 10 pF, two 1N34A diodes, 1000 pF and 1 k of the detector branch. This is the circuit in [01 - RF sampler and AM detector](#01---rf-sampler-and-am-detector). |
| [2:20](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=140s) | The same parts on the board, pointed out one at a time. |
| [3:07](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=187s) | The board connected to his Tektronix scope. |
| [3:30](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=210s) | The unmodulated carrier, resolved into individual cycles. |
| [3:53](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=233s) | The carrier with modulation on it, the cycles merged into a band and the envelope visible along its edge. |
| [4:40](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=280s) | Voice modulation, the envelope now irregular. |
| [5:50](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=350s) | The modulation trapezoid, with the scope in X-Y. |

## What the board is for

A transmitter's output is far too large to put on a scope, and the interesting part of it is usually the envelope rather than the carrier. Alan's board answers both problems at once from a line he can leave in place between the transmitter and its load. One branch is a resistive divider that hands the scope a small copy of the RF itself. The other takes a much smaller bite through a 10 pF capacitor, rectifies it and smooths it, so a second scope channel sees the modulation on its own.

The three connectors on the board are the two ends of the through line plus the two outputs. In the schematic the center conductors are named nodes, `RF_LINE`, `SAMPLE_OUT` and `DEMOD_OUT`, and every connector shield is ground.

## 01 - RF sampler and AM detector

Open [RF transmitter sampler and detector.asc](01%20-%20RF%20sampler%20and%20AM%20detector/RF%20transmitter%20sampler%20and%20detector.asc); the [video shortcut](01%20-%20RF%20sampler%20and%20AM%20detector/Video%20007%20-%2001%20-%20RF%20sampler%20and%20AM%20detector.url) opens the drawing at [1:33](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=93s).

![LTspice schematic of the sampler and detector](01%20-%20RF%20sampler%20and%20AM%20detector/RF%20sampler%20and%20detector%20schematic.png)

*Alan's values throughout. The through line runs along the top from the transmitter to the 50 ohm load. `Rsampler` and `RsampleTerm`, his 47 k and 690 ohm, divide it down and `Csample` couples the result out. `CdetCouple`, his 10 pF, feeds the detector: `Dclamp` across the input, `Ddetect` in series, and his 1000 pF and 1 k smoothing the rectified output. `Rscope` is a 1 Meg scope input, which he does not draw.*

| On Alan's drawing | In the schematic |
| --- | --- |
| RF in, through the coax to RF out | `Btransmitter` behind `Rtx` into `RF_LINE`, terminated by `Rantenna` |
| 47 k, half watt, rising from the line | `Rsampler`, 47 k. LTspice has no notion of the power rating |
| 690 ohm to ground, and the 0.01 uF out | `RsampleTerm` and `Csample` into `SAMPLE_OUT` |
| 10 pF leaving the line | `CdetCouple` into `DET_IN` |
| 1N34A to ground and 1N34A in series | `Dclamp` and `Ddetect` |
| 1000 pF and 1 k to ground | `Cenvelope`, written 1 nF, and `RdetLoad` |
| AM demod output | `DEMOD_OUT` |

The transmitter itself is the one thing that cannot be a part: `Btransmitter` is a behavioral source whose expression is written out on the schematic, `200*(1+0.5*sin(2*pi*1k*t))*sin(2*pi*7.1Meg*t)`, a 7.1 MHz carrier with 50 percent modulation at 1 kHz. The amplitude is a choice, not a measurement of his rig.

### What the two outputs look like

![The carrier and the recovered envelope](01%20-%20RF%20sampler%20and%20AM%20detector/Carrier%20and%20recovered%20envelope.png)

*Three milliseconds, which is three cycles of the 1 kHz modulation. The top pane is the line itself: at this time scale the 7.1 MHz cycles merge into a solid band, and the shape of its edge is the modulation. That is exactly the picture on Alan's screen at 3:53. The bottom pane is what the diode detector recovers, the same envelope on a positive offset, with the residual RF ripple the 1 us detector time constant leaves behind.*

| Measured | Value |
| --- | --- |
| Peak on the line | 149.6 V |
| Peak at the sample output | 2.164 V |
| Detector output, maximum | 20.58 V |
| Detector output, minimum | 6.27 V |

The sampler's division checks out against the parts: 690 over 47690 is one part in 69.1, and 149.6 V divided by 69.1 is 2.16 V, which is what the measurement gives. The detector output swings between 6.27 V and 20.58 V, a ratio of 3.3 against the 3.0 of the envelope itself, because the diode's forward drop costs proportionally more at the bottom of the modulation than at the top.

### The trapezoid at the end

At [5:50](https://www.youtube.com/watch?v=y4Zt_LJX1Tc&t=350s) Alan switches the scope to X-Y and gets the modulation trapezoid. These two time plots establish what each of his scope inputs is carrying, which is the groundwork for that display, but they do not substitute for it. A trapezoid tests modulation linearity by plotting the RF envelope against the modulating signal itself, and both traces here are derived from the same RF output, so nothing in this simulation can show linearity. That measurement needs an independent sample of the audio going in.

## Models and assumptions

Both diodes use the `1N34A_LEGACY` germanium model shared from [LTspice/Models/Unverified](../LTspice/Models/Unverified/1N34A_legacy.lib), which states on its own first lines that its provenance is unverified and that it is not a manufacturer model. Detector output levels depend directly on it.

The 50 ohm source and load, the 1 Meg scope input and the carrier amplitude are all simulation choices. `Cenvelope` and `RdetLoad` give a 1 us time constant, which is about seven carrier periods and a thousandth of the modulation period: long enough to smooth the RF, short enough to follow the envelope, which is the compromise every envelope detector has to make.

After pressing Run, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window opens autoscaled instead of showing the saved panes.
