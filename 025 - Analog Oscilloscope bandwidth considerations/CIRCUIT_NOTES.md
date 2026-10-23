# Video 25: Analog Oscilloscope bandwidth considerations

Source: Alan Wolke (W2AEW), [#25: Analog Oscilloscope bandwidth considerations](https://www.youtube.com/watch?v=oZ1Dv2dVGkU).

| Time | What Alan shows |
| --- | --- |
| [0:45](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=45s) | Draws "SIMPLE PHASE SHIFT OSCILLATOR", the circuit in [01 - Simple phase shift oscillator](<01 - Simple phase shift oscillator/>). This is the drawing he corrects in the video description. |
| [1:20](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=80s) | The oscillator's output on a Tektronix 2467, a 350 MHz analog scope, looking like an ordinary audio sine. |
| [1:50](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=110s) | The same signal at a slow sweep, many cycles across the screen. |
| [2:30](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=150s) | Back to the drawing to walk through the RC sections and the feedback path. |
| [2:55](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=175s) | The waveform is no longer a clean sine: notches and steps have appeared in it. |
| [3:20](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=200s) | Fast spikes clearly riding on the sine, the "hidden evils" the description promises. |
| [4:50](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=290s) | Both versions on screen at once: the smooth trace and the spiky one, the same circuit seen two ways. |
| [5:30](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=330s) | The drawing once more while he explains where the fast content comes from. |
| [6:25](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=385s) | The breadboard itself, which is where the fast content actually lives. |

## The question the video answers

The description sets it out: people ask what bandwidth of scope they need, and the answer is more than you think, even for audio. Alan's example is a 2.5 kHz transistor oscillator. Look at it with modest bandwidth and it is a sine wave. Look at it with 350 MHz and there is something fast sitting on top of it that was never visible before.

## Alan's correction to the drawing

The schematic on the paper is drawn wrong, and Alan says so in the video description:

> the phase shift oscillator schematic was drawn incorrectly. Please short the 200K resistor (connect 10nF to collector), and replace the vertical link to the base with the 200K resistor (200k from collector to base).

He redraws it correctly in [#26: Answering viewer questions, and Digital Oscilloscope Considerations](https://www.youtube.com/watch?v=IcrnXRbkLpc). Both versions are built here, because the difference between them is the difference between a circuit that oscillates and one that does nothing.

## 01 - Simple phase shift oscillator

Both schematics are in [01 - Simple phase shift oscillator](<01 - Simple phase shift oscillator/>), introduced at [0:45](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=45s).

Alan writes five values on the paper and no others: three 10 nF capacitors, two 2.2 kohm resistors to ground, a 200 kohm, and a 2.2 kohm collector load. He marks the supply with a terminal and no voltage, and does not name the transistor. The 5 V rail and the 2N2222 are therefore choices made here; a 2N2222 is a stock LTspice model and any small-signal NPN with reasonable beta behaves the same way.

### As the video draws it

[`Phase shift oscillator as drawn.asc`](<01 - Simple phase shift oscillator/Phase shift oscillator as drawn.asc>)

![Phase shift oscillator as drawn schematic](<01 - Simple phase shift oscillator/Phase shift oscillator as drawn schematic.png>)

Follow the drawing literally and the three capacitors do not form a chain at all. C2 comes down onto the base, C3 comes onto the base as well, and the 200 kohm bridges base and collector. The collector therefore reaches the RC network only through 200 kohm, and nothing drives the far end of it. What is left is a common-emitter stage with a passive RC network hanging off its base.

![Phase shift oscillator as drawn output](<01 - Simple phase shift oscillator/Phase shift oscillator as drawn output.png>)

![Phase shift oscillator as drawn SPICE output log](<01 - Simple phase shift oscillator/Phase shift oscillator as drawn SPICE output log.png>)

The collector settles at 2.0055 V and stays there. `vout_pp` is exactly 0: not a small oscillation, none at all. That is what Alan's note is about.

### As Alan corrects it

[`Phase shift oscillator.asc`](<01 - Simple phase shift oscillator/Phase shift oscillator.asc>)

![Phase shift oscillator schematic](<01 - Simple phase shift oscillator/Phase shift oscillator schematic.png>)

Apply the correction and C2's right-hand end moves from the base to the collector. Now there is a chain: collector, C2, the 2.2 kohm at R2, C1, the 2.2 kohm at R1, C3, base. Three RC sections, each contributing part of a 180 degree phase shift, feeding an inverting stage that supplies the other 180 degrees. The 200 kohm from collector to base is still there, now doing the job it should have been doing all along, which is setting the bias.

The run is `.tran 0 62m 60m 100n startup`. `startup` ramps the supply so the circuit has a disturbance to start from, and the save window is the last 2 ms of 62 ms, by which time the amplitude has settled.

![Phase shift oscillator output](<01 - Simple phase shift oscillator/Phase shift oscillator output.png>)

![Phase shift oscillator SPICE output log](<01 - Simple phase shift oscillator/Phase shift oscillator SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `vout_avg` | 2.536 V |
| `vout_max` | 4.714 V |
| `vout_min` | 0.060 V |
| `vout_pp` | 4.654 V |
| `freq` | 2460 Hz |

`freq` is taken from three periods between rising crossings of 2.5 V, which is close enough to the average for the timing to be clean. The textbook figure for this topology is `1 / (2 pi R C sqrt(6 + 4 Rc/R))`, which with R = Rc = 2.2 kohm and C = 10 nF gives 2.29 kHz, within 8 percent of the simulated 2.46 kHz.

The amplitude is worth noticing: 4.65 Vpp on a 5 V rail, running from 60 mV to 4.71 V. An RC phase-shift oscillator has no amplitude control, so it grows until the transistor itself limits it, and the peaks are visibly squared off against both rails. That matches the rounded, flat-topped shape on Alan's screen at [1:20](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=80s), and it is the reason the waveform has strong harmonic content well above 2.46 kHz.

## Why the simulation does not show the spikes

The fast content Alan finds at [3:20](https://www.youtube.com/watch?v=oZ1Dv2dVGkU&t=200s) does not appear in either simulation, and that absence is the honest result rather than a failure to look hard enough.

A parasitic oscillation at tens of megahertz needs something to resonate with. On Alan's breadboard that is lead inductance, the contact springs in the board, the probe ground lead, and the transistor's own junction capacitances all acting together. This netlist contains three capacitors, four resistors, a transistor model and an ideal 5 V source. There is no inductance anywhere in it, so there is no resonator, and nothing in the model can produce a megahertz-scale ring.

That is worth stating plainly because it is the same lesson from the other direction. A simulation of what you drew will show you the circuit you drew. The fast trouble lives in the part you did not draw: the wiring. Finding it takes a scope with the bandwidth to see it, which is exactly Alan's answer to the question people keep asking him.
