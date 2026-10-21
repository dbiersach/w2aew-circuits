# Video 172: Op amp gain-bandwidth product and slew rate limit

Source: [Alan Wolke, *Basics of Op Amp Gain Bandwidth Product and Slew Rate Limit*](https://www.youtube.com/watch?v=UooUGC7tNRg), with his [four-page handwritten notes](W2AEW%20Video%20Notes%20-%20opamp_GBWP_SlewRate.pdf). Two different limits are set against each other: the gain-bandwidth product, which is about small signals and frequency, and the slew rate, which is about large signals and how fast the output can move.

| Time | What Alan shows |
| --- | --- |
| [0:30](https://www.youtube.com/watch?v=UooUGC7tNRg&t=30s) | [The test circuit](#the-test-circuit) |

## The test circuit

[Alan draws his test circuit at 0:30](https://www.youtube.com/watch?v=UooUGC7tNRg&t=30s). Both simulations below use it, so they share one circuit folder: [01 - LM358 gain bandwidth and slew rate test circuit](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/).

A generator feeds an attenuator terminated in 50 Ω, a 220 µF capacitor couples that into a 1 kΩ input resistor, and an LM358N runs as an inverting amplifier with the feedback resistor RF setting the gain. The op-amp works from a single +5 V rail, so a 3.9 kΩ/3.9 kΩ divider holds its non-inverting input at mid-supply, bypassed by 470 µF and 0.1 µF. The output drives a 2.2 kΩ load. Alan's table gives three feedback values and their gains:

| RF | Gain | In dB |
| --- | ---: | ---: |
| 1 kΩ | -1x | 0 dB |
| 10 kΩ | -10x | 20 dB |
| 100 kΩ | -100x | 40 dB |

Every component value above is the one on Alan's drawing. The device is LTspice's bundled ON Semiconductor LM358 macro-model. The LTspice generator is an ideal source, so the 50 Ω termination draws current but does not attenuate the drive as the bench attenuator does; only the voltage reaching the 1 kΩ input resistor matters to the results.

After running either simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## Gain-bandwidth product

[Gain bandwidth product.asc](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Gain%20bandwidth%20product.asc) · [Saved plot settings](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Gain%20bandwidth%20product.plt)

![LTspice gain-bandwidth test circuit](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Gain%20bandwidth%20product%20schematic.png)

`.step param RFEEDBACK list 1k 10k 100k` sweeps Alan's three feedback resistors and `.ac dec 200 10 3Meg` plots the closed-loop response of each. The `.meas` directives take the low-frequency gain at 100 Hz and then find where the response has fallen to 0.7071 of it, the -3 dB bandwidth.

![Closed-loop response for the three feedback resistors](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Gain%20bandwidth%20product%20plot.png)

Three flat regions at 0, 20 and 40 dB, each rolling off at 20 dB per decade, and all three falling onto the same line once they do. That shared line is the amplifier's open-loop response, which is what Alan's fourth page plots for the LM358N: the feedback network can only hold the gain flat up to the point where the open-loop curve comes down to meet it.

![Measured gain and bandwidth for each step](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Gain%20bandwidth%20product%20SPICE%20output%20log.png)

| RF | Measured gain | -3 dB bandwidth | Gain x bandwidth |
| --- | ---: | ---: | ---: |
| 1 kΩ | 0.00 dB (1x) | 559 kHz | 0.56 MHz |
| 10 kΩ | 20.0 dB (10x) | 85.9 kHz | 0.86 MHz |
| 100 kΩ | 40.0 dB (100x) | 9.08 kHz | 0.91 MHz |

Ten times the gain buys about a tenth of the bandwidth, which is Alan's point: the product is the constant, so `BW = GBP / Av` predicts the bandwidth of any gain setting. The unity-gain row falls a little below the other two because at 0 dB the amplifier's second pole starts to matter, which is also why Alan's own graph marks the *small-signal* unity-gain bandwidth separately.

Alan's fourth page reads about 6 kHz at 40 dB and about 60 kHz at 20 dB for his LM358N, against 9.1 kHz and 85.9 kHz here. The simulated part is roughly half an octave faster than the one he measured; the 20 dB per decade slope and the constant product are identical.

## Slew rate limit

[Slew rate limit.asc](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Slew%20rate%20limit.asc) · [Saved plot settings](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Slew%20rate%20limit.plt)

![LTspice slew rate test circuit](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Slew%20rate%20limit%20schematic.png)

For this run RF is held at 1 kΩ, the widest-bandwidth setting, so that bandwidth is not what limits the result. The drive is a 300 kHz sine stepped through 0.1 V, 0.4 V and 0.8 V peak. Alan's third page gives the slope a sine wave demands:

`SR = Vp x 2π x f`

so the three steps ask for 0.19, 0.75 and 1.5 V/µs from an amplifier whose slope is fixed.

![Output waveforms for three drive amplitudes](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Slew%20rate%20limit%20plot.png)

The smallest drive comes through as a clean sine. The middle one already has visibly straightened edges. The largest one is a **triangle**: once the output is moving as fast as it can, the waveform between peaks is a straight ramp, and the peaks are cut short because the ramp runs out of time before it gets there. That is the shape Alan sketches on his second page and shows on the scope.

![Measured output swing and output slope for each step](01%20-%20LM358%20gain%20bandwidth%20and%20slew%20rate%20test%20circuit/Slew%20rate%20limit%20SPICE%20output%20log.png)

The `.meas` directives time the output through a 0.1 V window around mid-supply and divide, giving the slope directly:

| Drive | Output p-p | Output slope |
| --- | ---: | ---: |
| 0.1 V peak | 0.177 V | 0.154 V/µs |
| 0.4 V peak | 0.640 V | 0.507 V/µs |
| 0.8 V peak | 0.802 V | 0.565 V/µs |

Four times the drive gives four times the output and four times the slope: still linear. Doubling it again gives only a quarter more output and a twentieth more slope, because the slope has run into the limit at about 0.57 V/µs. This is the distinction worth taking away. Nothing about the frequency response changed between those last two steps; the amplifier simply cannot move its output any faster, so a bigger input produces a *distorted* output rather than a bigger one.

Alan reads 0.2 V/µs from his LM358N datasheet. The model used here slews about three times faster, which is why this simulation needs 300 kHz to reach the limit where his bench demonstration reaches it lower down. The mechanism, the triangle, and the way the output stops growing are the same.
