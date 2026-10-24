# Video 61: RF samplers, sampling tees and RF taps

Source: Alan Wolke (W2AEW), [#61: Basics of RF Samplers, Sampling-Tees, RF-taps, etc.](https://www.youtube.com/watch?v=0Kk_N_TpDeo).

| Time | What Alan shows |
| --- | --- |
| [0:40](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=40s) | Why you want one: a handheld transmitter and a through-line wattmeter, where the measurement has to happen without interrupting the signal. |
| [2:08](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=128s) | He draws the resistive sampler, reproduced in [01 - Resistive sampler](#01---resistive-sampler). |
| [3:30](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=210s) | A resistive sampler built on copper strip, with the tap resistors between the connectors. |
| [4:20](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=260s) | He draws the capacitive sampler, reproduced in [02 - Capacitive sampler](#02---capacitive-sampler). |
| [5:40](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=340s) | A capacitive sampler made as a coaxial fitting, where the coupling is set by the probe's size and spacing. |
| [6:40](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=400s) | Commercial sampling-tee hardware. |
| [7:50](https://www.youtube.com/watch?v=0Kk_N_TpDeo&t=470s) | A sampler inserted in line ahead of the wattmeter. |

## What the lesson establishes

A sampler sits in the signal path and takes a small, known fraction of it to a measuring instrument, while nearly all of the power continues to the load. That is the opposite of a test point on a low-frequency circuit, where a probe can simply be clipped on: at RF, anything bridged across a transmission line changes the line, so the tap has to be small enough that the through path barely notices and repeatable enough that the sample means something.

Alan draws two ways to build one. A **resistive** tap divides the line with a pair of resistors and couples the midpoint out through a blocking capacitor; its division is flat with frequency, but the resistors load the line continuously. A **capacitive** tap couples through a small capacitance alone; it loads the line far less, but the coupling rises with frequency, so a given fitting is calibrated for a band rather than being flat.

Neither drawing carries a single component value, which was checked against the video rather than assumed. Every value in the two schematics below is therefore illustrative, chosen to put the sample at a sensible level for a 50 ohm instrument. The topology is Alan's; the numbers are not his.

Both circuits drive the through line from a 1 V peak, 10 MHz source behind 50 ohm and terminate it in 50 ohm, so the undisturbed through signal would be 353.6 mV RMS. Each uses `.tran 0 20u 10u 0.5n`, saving the last 10 us, and `.meas` reports the RMS of the through and sampled nodes over that interval.

## 01 - Resistive sampler

[Schematic](<01 - Resistive sampler/Resistive sampler.asc>) - [Saved plot settings](<01 - Resistive sampler/Resistive sampler.plt>) - [Video at 2:08](<01 - Resistive sampler/Video 061 - 01 - Resistive sampler.url>)

`Rtap` taps the through line, `Rshunt` returns it to ground, and `Cblock` couples the divider midpoint to a 50 ohm sampling port. This is the arrangement in Alan's drawing, including the blocking capacitor between the divider and the sample connector.

![Resistive sampler schematic copied from LTspice](<01 - Resistive sampler/Resistive sampler schematic.png>)

![Resistive sampler through path and tap, copied from LTspice](<01 - Resistive sampler/Resistive sampler through and tap.png>)

The top pane is the through path and the bottom pane the tap, each on its own axis because they differ by a factor of forty. Both are the same 10 MHz sine; the lesson is in the amplitudes, not the shapes.

| Node | Simulated RMS | Relative to the through signal |
| --- | ---: | --- |
| `V(RF_THROUGH)` | 345.0 mV | the main path |
| `V(SAMPLE_OUT)` | 8.50 mV | 40.6:1, or -32.2 dB |

The through signal is 345.0 mV rather than the undisturbed 353.6 mV, so the tap costs the main path 0.21 dB. That is the price of the resistive divider being permanently across the line, and it is the number to watch when deciding how large `Rtap` has to be.

## 02 - Capacitive sampler

[Schematic](<02 - Capacitive sampler/Capacitive sampler.asc>) - [Saved plot settings](<02 - Capacitive sampler/Capacitive sampler.plt>) - [Video at 4:20](<02 - Capacitive sampler/Video 061 - 02 - Capacitive sampler.url>)

`Ctap` couples the through line straight into the 50 ohm sampling port, with no resistor bridging the line at all.

![Capacitive sampler schematic copied from LTspice](<02 - Capacitive sampler/Capacitive sampler schematic.png>)

![Capacitive sampler through path and tap, copied from LTspice](<02 - Capacitive sampler/Capacitive sampler through and tap.png>)

| Node | Simulated RMS | Relative to the through signal |
| --- | ---: | --- |
| `V(RF_THROUGH)` | 353.4 mV | the main path |
| `V(SAMPLE_OUT)` | 5.55 mV | 63.7:1, or -36.1 dB |

Here the through signal is 353.4 mV against the undisturbed 353.6 mV, a loss of 0.0045 dB, which is the point of the capacitive tap: at 10 MHz a 5 pF coupling is about 3.2 kohm of reactance and the line hardly sees it.

The trade is frequency flatness. The reactance of `Ctap` falls as frequency rises, so the same fitting couples more at 30 MHz than at 10 MHz, and a capacitive sampler is specified for a band. The resistive divider in circuit 01 has no such slope. In the coaxial fittings Alan shows from 5:40, the coupling capacitance is set by how large the internal probe is and how close it sits to the center conductor, which is why those samplers are built rather than assembled from discrete parts.

## Running these in LTspice

Open either schematic and press Run. If the waveform window opens autoscaled, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up the saved `.plt`, which sets the two panes and the separate voltage scales. Note that because the `.tran` directive carries a maximum timestep, the waveform viewer's time axis starts at 0 for the saved interval, while the `.meas` results are reported at their absolute times of 10 us to 20 us. The `.meas` values appear in View > SPICE Output Log.
