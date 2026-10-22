# Video 327 - Current mirror output impedance, the Early effect, and the Wilson mirror

Source: [Alan Wolke (W2AEW), #327: Bipolar Transistor Current Mirror output impedance, Early Effect, Wilson Current Mirror](https://www.youtube.com/watch?v=2IbWvq7Abv4), with his [three-page handwritten notes](<W2AEW Video Notes - CurrentMirrorEarlyEffect.pdf>).

| Time | What Alan shows |
| --- | --- |
| [1:09](https://www.youtube.com/watch?v=2IbWvq7Abv4&t=69s) | [01 - Basic current mirror](#01---basic-current-mirror) |
| [5:24](https://www.youtube.com/watch?v=2IbWvq7Abv4&t=324s) | [02 - Wilson current mirror](#02---wilson-current-mirror) |

**The question.** An ideal current source delivers the same current no matter what load it drives, so its output impedance is infinite. A real transistor's collector current rises a little as its collector-emitter voltage rises. This is the Early effect, which Alan shows on a curve tracer and on page 2 of his notes. The output resistance `r_out = change in output voltage / change in output current` measures how much the current moves. Alan builds a basic two-transistor PNP mirror and turns its load pot from 10k to 0 to show that the current changes. He then shows that a three-transistor Wilson mirror holds the current almost constant.

**Reading impedance as a goal.** Input and output impedance are easier to use as goals than as resistances. An ohm is a volt per amp, so every impedance figure describes a trade between voltage and current, and whether you want it high or low depends only on which of the two you are trying to protect.

| | Goal in plain words | Why you want it |
|---|---|---|
| High input impedance | Draw almost no current from whatever you are connected to | So you do not disturb the circuit you are reading, such as a scope probe, a voltmeter, or an amplifier input |
| Low input impedance | Develop almost no voltage across yourself | So you do not get in the way of current that has to pass through, such as an ammeter, this chapter's `VSENSE`, or a 50 ohm termination |
| Low output impedance | Hold your output voltage steady no matter how much current the load draws | A supply or amplifier output that stays at 5.00 V whether the load takes 10 mA or 1 A |
| High output impedance | Hold your output current steady no matter how far the load's voltage swings | A current mirror that stays at 1.06 mA whether the load sits at 0 V or 11 V |

The last two rows are the same sentence with voltage and current swapped, and the last row is what this video is about. Output impedance is the slope of the plots below. The basic mirror's current tilts as the load voltage climbs, and that tilt is its 89.5 kohm. The Wilson mirror's trace is flat, and flat is 8.58 Mohm. A perfect current source would be perfectly horizontal, which is the same statement as infinite output impedance.

Both circuits use 2N3906 transistors, a 12 V supply, a 10k R1 that sets the reference current, and a 10k potentiometer R2 as the load. Alan's voltmeter reads the voltage across R2, and ammeter M1 reads the output current.

| Circuit | R2 setting | Alan's voltmeter | Alan's ammeter |
|---|---|---|---|
| Basic mirror | 10k | 11.33 V | 1.11 to 1.12 mA |
| Basic mirror | about half | 5.03 V | 1.32 mA |
| Basic mirror | 0 | 0.003 V | 1.54 mA |
| Wilson mirror | 10k | 10.62 V | 1.04 mA |
| Wilson mirror | about half | about 5 V | 1.04 mA |
| Wilson mirror | 0 | 0 V | 1.04 mA |

**Transistor model.** Every schematic uses the `2N3906` model from LTspice's standard library. Its Early voltage is `VAF = 100 V`. Alan's basic-mirror readings imply a much lower Early voltage for his transistors, around 20 to 25 V. The simulated basic mirror therefore changes its current only about a third as much as his bench circuit did. The shape of the lesson is the same: the basic mirror's current moves with load voltage, and the Wilson mirror's barely moves.

## 01 - Basic current mirror

Introduced at [1:09](https://www.youtube.com/watch?v=2IbWvq7Abv4&t=69s).

[Basic current mirror.asc](<01 - Basic current mirror/Basic current mirror.asc>) follows Alan's page 1 drawing. Q1 and Q2 have their emitters on the 12 V rail and their bases joined. Q1's base is tied to its collector, so Q1 acts as a diode. R1 sets Q1's current to about `(12 V - 0.7 V) / 10k = 1.13 mA`, which is the estimate Alan gives, and Q2 copies that current into the load. The 0 V source `VSENSE` stands in for ammeter M1, so `I(VSENSE)` is the output current. The net label `Vload` is the point Alan's voltmeter reads.

Alan's R2 is a 10k pot with its wiper tied to its grounded end, so it acts as a variable resistor. The schematic draws it as two sections, `R2TOP` and `R2BOTTOM`, with a short wire across `R2BOTTOM` from the wiper to ground. `RSET` is the pot setting: the resistance left between the ammeter and ground. LTspice will not accept a 0 ohm resistor, so each section has a 1 milliohm floor, which has no visible effect.

![Basic current mirror LTspice schematic](<01 - Basic current mirror/Basic current mirror schematic.png>)

The simulation is a stepped operating-point analysis (`.step param RSET 0 10k 100` with `.op`). It solves the DC circuit at 101 pot settings from 0 to 10k, so the horizontal axis of the plot is the pot setting `RSET`, not time. This is Alan's experiment, with the knob turned in the opposite direction:

- **Top pane:** `I(VSENSE)`, the ammeter reading.
- **Bottom pane:** `V(vload)`, the voltmeter reading across R2. The emitter-to-collector voltage across Q2 is the remainder, `12 V - V(vload)`.

Both panes use the same scales as the Wilson plot in section 02, so the two can be compared directly.

![Basic current mirror output current and load voltage against pot setting](<01 - Basic current mirror/Basic current mirror pot sweep plot.png>)

Reading the plot at Alan's three settings:

| R2 setting | Simulated `V(vload)` | Simulated `I(VSENSE)` | Alan's bench |
|---|---|---|---|
| 10k | 11.24 V | 1.124 mA | 11.33 V, 1.11 to 1.12 mA |
| 4.2k (about 5 V) | 5.01 V | 1.194 mA | 5.03 V, 1.32 mA |
| 0 | 0 V | 1.250 mA | 0.003 V, 1.54 mA |

At R2 = 10k, Q2 has very little voltage across it, and the simulation agrees with Alan's readings to within 1 percent. As the pot is turned down, the voltage across Q2 rises toward 12 V and the current rises with it. Alan's current rose by 0.42 mA; the simulated current rises by 0.13 mA. The difference comes from the model's higher Early voltage, as explained above. Either way, the basic mirror is not an ideal current source.

### Controlled voltage-sweep experiment

[Basic mirror voltage-sweep experiment.asc](<01 - Basic current mirror/Basic mirror voltage-sweep experiment.asc>) is a separate simulation experiment, not a circuit from the video. It keeps the same two-transistor mirror but replaces the ammeter and pot with an ideal voltage source, `Vload`, connected to Q2's collector. `.dc Vload 0 11 0.1` sweeps the collector voltage directly over the range Alan's voltmeter covered. The plot shows `I(Vload)` against `Vload`; the voltage across Q2 is `12 V - Vload`, so it falls from left to right.

![Basic mirror voltage-sweep experiment schematic](<01 - Basic current mirror/Basic mirror voltage-sweep experiment schematic.png>)

![Basic mirror output current against collector voltage](<01 - Basic current mirror/Basic mirror voltage-sweep experiment plot.png>)

The `.meas` lines read the current at Alan's 0 V and 5 V voltmeter readings and divide the 5 V change by the current change:

- `I_AT_0V` = 1.249647 mA
- `I_AT_5V` = 1.193784 mA
- `ROUT_OHMS` = 89.5 kohm

Alan's readings give `5.03 V / (1.54 mA - 1.32 mA)`, about 23 kohm, over the same interval. For a simple mirror, `r_out` is roughly `(VA + VEC) / IC`, where VA is the Early voltage and VEC is Q2's emitter-collector voltage. With `VAF = 100 V`, that predicts about 90 kohm, which matches the simulation. Working backward from Alan's 23 kohm gives an Early voltage of roughly 20 to 25 V for his transistors.

![Basic mirror output-resistance LTspice measurements](<01 - Basic current mirror/Basic mirror voltage-sweep experiment SPICE measurements.png>)

## 02 - Wilson current mirror

Introduced at [5:24](https://www.youtube.com/watch?v=2IbWvq7Abv4&t=324s).

[Wilson current mirror.asc](<02 - Wilson current mirror/Wilson current mirror.asc>) follows Alan's page 3 drawing, with the same supply, R1, ammeter, voltmeter point, and 10k pot as section 01. Here Q2 is the diode-connected transistor. Q1's collector drives R1 and Q3's base. Q3's emitter sits on Q2's collector, and Q3's collector feeds the load.

Alan explains it this way. The voltage across R1 is `12 V - 2 VBE`, which stays essentially constant, so Q1's current is constant. Q2 shares Q1's base-emitter voltage, so it carries the same current. Q3 simply passes Q2's current to the load. Changing the load changes Q3's collector voltage, but the current is set by Q1 and Q2, whose voltages do not change.

![Wilson current mirror LTspice schematic](<02 - Wilson current mirror/Wilson current mirror schematic.png>)

The analysis and plot layout match section 01: the horizontal axis is the pot setting `RSET`, the top pane is the ammeter current `I(VSENSE)`, and the bottom pane is the voltmeter reading `V(vload)`. On the same current scale as the basic mirror, the Wilson current is a flat line.

![Wilson current mirror output current and load voltage against pot setting](<02 - Wilson current mirror/Wilson current mirror pot sweep plot.png>)

| R2 setting | Simulated `V(vload)` | Simulated `I(VSENSE)` | Alan's bench |
|---|---|---|---|
| 10k | 10.62 V | 1.0617 mA | 10.62 V, 1.04 mA |
| 4.7k (about 5 V) | 4.99 V | 1.0624 mA | about 5 V, 1.04 mA |
| 0 | 0 V | 1.0630 mA | 0 V, 1.04 mA |

Over the full 10.6 V swing, the simulated current changes by only 1.3 uA. Alan's meter shows no change at all in its last digit (10 uA). The Wilson mirror's current is lower than the basic mirror's because R1 now has two VBE drops in its path instead of one. Alan's 1.04 mA is about 2 percent below the simulated value; that difference is within normal VBE and beta variation between real 2N3906 transistors.

### Controlled voltage-sweep experiment

[Wilson mirror voltage-sweep experiment.asc](<02 - Wilson current mirror/Wilson mirror voltage-sweep experiment.asc>) is a separate simulation experiment. It applies the same ideal `Vload` sweep, `.dc Vload 0 11 0.1`, to Q3's collector. The plot uses the same axes as the basic-mirror experiment, so the nearly flat Wilson line can be compared directly with the basic mirror's slope.

![Wilson mirror voltage-sweep experiment schematic](<02 - Wilson current mirror/Wilson mirror voltage-sweep experiment schematic.png>)

![Wilson mirror output current against collector voltage](<02 - Wilson current mirror/Wilson mirror voltage-sweep experiment plot.png>)

- `I_AT_0V` = 1.062967 mA
- `I_AT_5V` = 1.062384 mA
- `ROUT_OHMS` = 8.58 Mohm

That is about 96 times the basic mirror's 89.5 kohm, using the same transistor model and the same voltage points. Alan's meter can only show that his Wilson mirror's output resistance is above about 1 Mohm (10.6 V with less than 10 uA of change). That lower limit is consistent with the simulation.

![Wilson mirror output-resistance LTspice measurements](<02 - Wilson current mirror/Wilson mirror voltage-sweep experiment SPICE measurements.png>)

## Summary

| Mirror | Simulated r_out (0 to 5 V) | From Alan's readings |
|---|---|---|
| Basic, two transistors | 89.5 kohm | about 23 kohm |
| Wilson, three transistors | 8.58 Mohm | above about 1 Mohm |

The absolute values depend on the transistors' Early voltage, which differs between the LTspice model and Alan's parts. Both the simulation and the bench show the improvement Alan set out to demonstrate: adding one transistor raises the mirror's output resistance by about two orders of magnitude.

Both pot sweeps are stepped runs, so the waveform window can open autoscaled with every step overlaid. Press Ctrl+Space (Plot Settings > Reload Plot Settings) after Run to pick up the saved panes and their step labels.