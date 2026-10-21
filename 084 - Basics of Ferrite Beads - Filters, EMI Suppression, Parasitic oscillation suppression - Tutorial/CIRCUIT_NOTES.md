# Video 84: Basics of ferrite beads

Source: Alan Wolke (W2AEW), [#84: Basics of Ferrite Beads: Filters, EMI Suppression, Parasitic oscillation suppression / Tutorial](https://www.youtube.com/watch?v=81C4IfONt3o).

| Time | What Alan shows |
| --- | --- |
| [1:31](https://www.youtube.com/watch?v=81C4IfONt3o&t=91s) | [What Alan demonstrates](#what-alan-demonstrates) |
| [1:31](https://www.youtube.com/watch?v=81C4IfONt3o&t=91s) | [01 - Swept signal through a ferrite bead](#01---swept-signal-through-a-ferrite-bead) |
| [4:49](https://www.youtube.com/watch?v=81C4IfONt3o&t=289s) | [02 - Fast edges through a ferrite bead](#02---fast-edges-through-a-ferrite-bead) |

## What Alan demonstrates

A ferrite bead is a lossy inductor. At low frequencies it is close to a piece of wire; as the frequency rises its impedance climbs, and over its working band the loss in the ferrite makes it behave less like an inductor and more like a resistor. That is the property that makes a bead useful: it absorbs high-frequency energy instead of reflecting it.

Alan shows this three ways on the bench:

- From [1:31](https://www.youtube.com/watch?v=81C4IfONt3o&t=91s) he runs his generator in a **sweep from 10 kHz to 40 MHz** through a wire into his scope, then slips a ferrite over the wire. The high-frequency end of the sweep collapses while the low end is untouched.
- From [4:49](https://www.youtube.com/watch?v=81C4IfONt3o&t=289s) he switches to a **continuous square wave with about 2 ns edges**, viewed at 5 ns/division. Adding a multi-turn ferrite takes the edges "right out of it" and leaves something closer to a sine wave.
- From about [7:03](https://www.youtube.com/watch?v=81C4IfONt3o&t=423s) he returns to the audio oscillator from his analog-scope-bandwidth video and uses a bead to suppress a **parasitic oscillation** riding on its output.

The two circuits here reproduce the first two demonstrations. The third is not simulated: it depends on the particular layout and stray coupling of that earlier breadboard, and the video does not give the circuit values needed to reproduce the parasitic honestly.

## The bead model used in both circuits

Alan never names a part number or gives an inductance, so no manufacturer model applies. Both schematics use the same three-element equivalent circuit, which is the standard way to represent a bead:

| Element | Value | What it represents |
| --- | --- | --- |
| `LBEAD` | 1 uH | the inductance of the turn (or turns) through the ferrite |
| `RCORE` | 150 ohm | the core loss, in parallel with the inductance |
| `CPAR` | 2 pF | the winding and terminal capacitance across the whole bead |

These three values are **illustrative**, chosen so the bead works over roughly the band Alan sweeps. They are not measurements of his ferrite. The parallel `RCORE` is what makes the model behave the way Alan describes: the impedance stops climbing and flattens out at a resistance, rather than rising without limit like an ideal inductor.

The bead sits in series between a 50 ohm generator (`RS`) and a 50 ohm scope input (`RSCOPE`), which is the signal path Alan slips the ferrite into.

## 01 - Swept signal through a ferrite bead

Introduced at [1:31](https://www.youtube.com/watch?v=81C4IfONt3o&t=91s). File: [`Ferrite bead frequency sweep.asc`](<01 - Swept signal through a ferrite bead/Ferrite bead frequency sweep.asc>).

![Ferrite bead in a swept 50 ohm signal path](<01 - Swept signal through a ferrite bead/Ferrite bead sweep schematic.png>)

*The fixture: generator, 50 ohm source resistance, the three-element bead between IN and OUT, and the 50 ohm scope input. The AC sweep runs from 10 kHz to 1 GHz, covering Alan's 10 kHz to 40 MHz sweep and continuing past the bead's self-resonance.*

![Bead impedance and the loss it causes](<01 - Swept signal through a ferrite bead/Ferrite bead impedance and loss.png>)

*Bottom pane: the bead's series impedance, `(V(in)-V(out))/I(RSCOPE)`. Below 1 MHz it is under 10 ohm, so the signal passes as if the bead were not there. It then climbs with frequency and flattens at about 150 ohm, the value of RCORE: over that stretch the bead is a resistor, absorbing energy rather than storing it. Top pane: the output compared with the same path without the bead. It is flat at the low end of Alan's sweep and falls to 0.44 at 40 MHz, the top of his sweep. Past self-resonance the winding capacitance CPAR shunts the bead and some signal gets through again, which is why a bead works over a band rather than everywhere.*

![Sweep measurements](<01 - Swept signal through a ferrite bead/Ferrite bead sweep SPICE output log.png>)

*The four `.meas` results. LTspice reports an AC magnitude in dB, so 42.4772 dB is 133 ohm of bead impedance at 40 MHz and 43.5218 dB is the 149.9 ohm peak. The loss at 40 MHz is -7.10 dB, and the path is 3 dB down at 11.46 MHz.*

This is the shape of the curve Alan describes: nothing at the low end, strong attenuation across the upper part of his sweep, and a maximum impedance equal to the core loss resistance.

## 02 - Fast edges through a ferrite bead

Introduced at [4:49](https://www.youtube.com/watch?v=81C4IfONt3o&t=289s). File: [`Ferrite bead fast edges.asc`](<02 - Fast edges through a ferrite bead/Ferrite bead fast edges.asc>).

![The same bead with a fast-edged square wave](<02 - Fast edges through a ferrite bead/Ferrite bead fast edges schematic.png>)

*The same fixture driven by a square wave with the 2 ns edges Alan measures. `LBEAD` is stepped: 1 nH stands in for the plain wire, 1 uH puts the bead back. The 10 MHz repetition rate is a simulation choice, picked so a few whole cycles and the edges are both visible in one view.*

![Edge rounding caused by the bead](<02 - Fast edges through a ferrite bead/Ferrite bead edge rounding.png>)

*Bottom pane: with the bead removed, the square wave arrives intact and the edge takes 1.6 ns from 10 percent to 90 percent. Top pane: with the bead in place the same edge takes 29.9 ns, and the waveform no longer reaches a flat top before the next transition. The fast edge is where a logic signal keeps its high-frequency energy, and that is exactly what the bead has removed.*

![Rise-time measurements](<02 - Fast edges through a ferrite bead/Ferrite bead edges SPICE output log.png>)

*`.meas tran TRISE` for both steps: 1.598 ns for the wire and 29.95 ns for the bead, a factor of nearly 19.*

The simulated waveform rounds into an exponential rather than the near-sinusoid Alan gets, because his multi-turn ferrite is a stronger bead than this model and his square wave is slower than 10 MHz. The effect being demonstrated is the same one: a bead in series with a fast signal strips the high-frequency content out of its edges, which is why beads appear on cables and supply pins where that content would otherwise escape as interference.

## Reading the plots

Open a schematic, press **Run**, and if the waveform window opens autoscaled press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`.

The fast-edge plot uses `V(out)@1` and `V(out)@2` to put each step in its own pane. LTspice draws such a trace once per step, which makes it look speckled; open **Plot Settings > Select Steps**, clear **Auto Range**, select a single step and click OK for the clean traces shown above.
