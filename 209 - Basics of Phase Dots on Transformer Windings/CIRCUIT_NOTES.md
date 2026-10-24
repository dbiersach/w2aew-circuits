# Video 209: basics of phase dots on transformer windings

Source: Alan Wolke (W2AEW), [#209: Basics of Phase Dots on Transformer Windings](https://www.youtube.com/watch?v=LuZh1QnegC4). His notes page is kept here as [W2AEW Video Notes - PhaseDots.pdf](<W2AEW Video Notes - PhaseDots.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:30](https://www.youtube.com/watch?v=LuZh1QnegC4&t=30s) | What the dots are for. They are used when the phase relationship between mutually coupled inductors matters, and they mark the polarity of the input and output signals. |
| [1:20](https://www.youtube.com/watch?v=LuZh1QnegC4&t=80s) | The two small figures that make it concrete: dots on the same side of the pair gives in-phase signals, dots on opposite sides gives signals 180 degrees out of phase. |
| [3:00](https://www.youtube.com/watch?v=LuZh1QnegC4&t=180s) | The trifilar example, and his rule for homebrew transformers: be consistent with your winding method and direction, and then every wire end on the same side of the core is in phase. Pick a side to be dotted and you are done. |
| [4:40](https://www.youtube.com/watch?v=LuZh1QnegC4&t=280s) | The actual trifilar wound toroid in his hand, with its three color-coded wires. |
| [6:20](https://www.youtube.com/watch?v=LuZh1QnegC4&t=380s) | The bench measurement from the bottom of his page, with a generator on one winding and three scope probes. Built as [01 - Trifilar transformer on the scope](<01 - Trifilar transformer on the scope/>). |
| [6:50](https://www.youtube.com/watch?v=LuZh1QnegC4&t=410s) | All three channels on the screen at once: two tracking each other and the third inverted, which is the point of the whole lesson. The readout beneath them gives the settings this chapter copies: 500 mV per division on every channel, 40.0 ns per division, DC coupled through TPP1000 probes with invert off, and a trigger frequency of 10.0000 MHz. |

## The measurement

[01 - Trifilar transformer on the scope/Trifilar transformer phase dots.asc](<01 - Trifilar transformer on the scope/Trifilar transformer phase dots.asc>)

![Trifilar transformer schematic](<01 - Trifilar transformer on the scope/Trifilar transformer schematic.png>)

Three identical windings, tightly coupled on one core, drawn the same way up so that their dots line up. That is not a drawing convenience: it is what trifilar winding gives you physically. Wind three wires together as one and every wire end that emerges on the same side of the core is in phase with the others, so the only decision left is which side you choose to call dotted.

The generator drives the first winding, and CH1 sits on its dotted end. The other two windings are wired deliberately differently, and the difference is the entire experiment:

- **L2** is grounded at its undotted end and probed at its dotted end. CH2 is therefore measured the same way round as CH1.
- **L3** is grounded at its *dotted* end and probed at its undotted end. CH3 is measured the other way round.

Nothing about the transformer changed between those two. Only the choice of which end to call ground changed, and that is enough to invert the trace.

A note on the LTspice symbol. The dot on `ind2` marks the terminal that SPICE's `K` statement treats as corresponding across all the coupled inductors, so three instances drawn the same way up have their dots on the same side of the core, as a trifilar winding does. Reading the dot is enough; which pin number it happens to be does not matter as long as every winding is drawn alike.

Alan's page gives no component values, but his scope readout gives the one that matters most. The trigger frequency at [6:50](https://www.youtube.com/watch?v=LuZh1QnegC4&t=410s) reads **10.0000 MHz**, so that is the drive frequency here, and the time axis of the plot below is set to his **40.0 ns per division** over ten divisions, which puts four cycles on the screen exactly as his does. His three channels are all on 500 mV per division, DC coupled, with invert off, which is worth noting because an inverted channel would have made the whole demonstration meaningless.

What remains a choice is the transformer itself: 47 uH windings with a coupling coefficient of 0.995, and a 1 V drive amplitude. Each winding also carries `Rser=0.1` for the resistance of a few turns of wire, which LTspice does not draw on the symbol and which is named in the schematic text instead. `Rgen` stands for the generator's own 50 ohm output resistance; Alan draws a bare generator symbol, but every function generator has one, and at 10 MHz the 47 uH winding presents about 2.95 kohm, so the loading is very light.

## What the channels do

![Trifilar transformer channel phases](<01 - Trifilar transformer on the scope/Trifilar transformer channel phases.png>)

Two panes, each showing the primary against one secondary across the same 400 ns his screen covers, four cycles of the 10 MHz drive at 40 ns per division. In the top pane CH2 lies on top of CH1 and the two are indistinguishable apart from a hair of amplitude. In the bottom pane CH3 is CH1 turned upside down.

![Trifilar transformer SPICE output log](<01 - Trifilar transformer on the scope/Trifilar transformer SPICE output log.png>)

| | Value at 325 ns | Peak to peak |
| --- | --- | --- |
| CH1, the driven winding | +0.988 V | 1.999 V |
| CH2, probed at its dotted end | +0.983 V | 1.989 V |
| CH3, probed at its undotted end | **-0.983 V** | 1.989 V |

CH2 and CH3 are identical to every digit in magnitude and differ only in sign. They have to be: they are the same winding voltage read with the two leads swapped. CH1 is half a percent larger than either, which is the 0.995 coupling and the winding resistance, not anything to do with the dots. At 500 mV per division, the setting Alan uses, that half percent is a hundredth of a division, which is why the top pane looks like a single trace on his screen as well as on this one.

The practical point is the one Alan makes with the two small figures on his page. If you wire a phase-sensitive circuit, a balun, a hybrid, a push-pull stage, a feedback winding in an oscillator, and you get a winding end wrong, nothing looks broken. The amplitude is right, the shape is right, and the sign is backwards. The dots exist so the drawing says which end is which before you pick up the soldering iron, and for a homebrew transformer his method is the whole answer: wind consistently, then mark one side.

If the waveform window opens autoscaled, press Ctrl+Space to reload the saved plot settings.
