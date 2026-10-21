# Video 198: the Vbe multiplier

Source: Alan Wolke (W2AEW), [Basics of a Vbe Multiplier](https://www.youtube.com/watch?v=Obh_PIC2qqo), with his [circuit notes](W2AEW%20Video%20Notes%20-%20vbemultiplier.pdf).

| Time | What Alan shows |
| --- | --- |
| [6:31](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=391s) | [01 - The adjustable multiplier on its own](#01---the-adjustable-multiplier-on-its-own) |
| [8:48](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=528s) | [02 - A DC level shift in a common-emitter stage](#02---a-dc-level-shift-in-a-common-emitter-stage) |
| [9:47](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=587s) | [03 - Biasing a push-pull output stage](#03---biasing-a-push-pull-output-stage) |

A Vbe multiplier is one transistor and two resistors that behaves like an adjustable diode string. Feedback holds the transistor's base-emitter junction at one Vbe, and the resistor divider across the device multiplies that into whatever voltage the divider ratio asks for:

`Vx ≈ Vbe x (1 + RTOP/RBOT)`

The three circuits below follow Alan's order: the multiplier on its own, the multiplier as a DC level shift in a common-emitter stage, and the multiplier biasing a complementary output pair.

Each circuit steps the potentiometer wiper with `.step param W` and every pane carries its own step legend, because LTspice assigns step colours separately in each pane. After running a simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - The adjustable multiplier on its own

[Open the segment at 6:31](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=391s) · [Schematic](01%20-%20Adjustable%20Vbe%20multiplier/Adjustable%20Vbe%20multiplier.asc) · [Saved plot settings](01%20-%20Adjustable%20Vbe%20multiplier/Adjustable%20Vbe%20multiplier.plt)

Alan shows an 820 Ω resistor in series with a potentiometer, the wiper going to the transistor base; his notes label the potentiometer 1 kΩ. The LTspice schematic splits that pot into `RTOP` from collector to wiper and `RBOT` from wiper to emitter, with the fixed 820 Ω included in `RBOT`. As the wiper moves, `RTOP` grows while the pot part of `RBOT` shrinks, and their total stays at 1.82 kΩ. The 2N3904 is an illustrative built-in model; the video does not name a part.

![Adjustable Vbe multiplier schematic](01%20-%20Adjustable%20Vbe%20multiplier/Adjustable%20Vbe%20multiplier%20schematic.png)

The multiplier is fed through a 3.9 kΩ resistor from a supply that ramps from 8 V to 12 V during the run. The supply ramp and the feed resistor are illustrative test choices, chosen to answer one question: does the multiplier drop depend on what is driving it?

![Multiplier drop above the stepped supply](01%20-%20Adjustable%20Vbe%20multiplier/Adjustable%20Vbe%20multiplier%20waveforms.png)

The top pane is the multiplier drop `V(vx)` for the three wiper positions, and the bottom pane is the supply. The answer is that it hardly does: the supply changes by 4 V and each of the three traces stays almost flat. Moving the wiper, on the other hand, moves the drop a long way.

![Measured mean multiplier drop](01%20-%20Adjustable%20Vbe%20multiplier/Adjustable%20Vbe%20multiplier%20measurements.png)

| Wiper `W` | Measured mean `V(vx)` |
| --- | ---: |
| 0 (wiper at the emitter end) | 0.680 V |
| 0.5 (midpoint) | 0.938 V |
| 1 (wiper at the collector end) | 1.497 V |

At `W=0` the drop is a single Vbe, because the divider ratio is one. As the wiper climbs, the ratio and the drop climb with it. The measured values run a little below the simple formula because base current flows through `RTOP` as well as the divider current.

## 02 - A DC level shift in a common-emitter stage

[Open the segment at 8:48](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=528s) · [Schematic](02%20-%20Common-emitter%20DC%20level%20shift/Common-emitter%20DC%20level%20shift.asc) · [Saved plot settings](02%20-%20Common-emitter%20DC%20level%20shift/Common-emitter%20DC%20level%20shift.plt)

Alan inserts the multiplier between a common-emitter amplifier's 1 kΩ collector load and the gain transistor's collector. His notes give the 20 kΩ/2.2 kΩ base divider, the 100 Ω emitter resistor, the 10 µF input coupling capacitor, and the same 1 kΩ pot with its 820 Ω series resistor. The 12 V supply, the 50 mV 1 kHz source, and the 2N3904 model are simulation choices; his notes offer the 2N3904 as an example of a general-purpose NPN but give no supply for this build.

![Common-emitter level-shift schematic](02%20-%20Common-emitter%20DC%20level%20shift/Common-emitter%20DC%20level%20shift%20schematic.png)

![Multiplier drop above the two shifted nodes](02%20-%20Common-emitter%20DC%20level%20shift/Common-emitter%20DC%20level%20shift%20waveforms.png)

The top pane is `V(shift_top,shift_bottom)`, the voltage the multiplier is holding. Below it are the two nodes themselves. `SHIFT_TOP`, at the collector resistor, is the same waveform in all three runs: its three traces lie exactly on top of each other, so the multiplier has not disturbed the amplifier at all. `SHIFT_BOTTOM` carries that same waveform shifted down, and its three traces sit in three separate bands set by the wiper.

That is the whole point of the application. The multiplier passes the signal through unchanged while subtracting an adjustable DC amount from it, which is what is needed to feed the next stage at a different operating point.

![Measured mean offset](02%20-%20Common-emitter%20DC%20level%20shift/Common-emitter%20DC%20level%20shift%20measurements.png)

The measured mean separation is 0.693 V, 0.962 V and 1.544 V for `W` = 0, 0.5 and 1, within a few per cent of the standalone values from circuit 01.

## 03 - Biasing a push-pull output stage

[Open the segment at 9:47](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=587s) · [Schematic](03%20-%20Push-pull%20output%20bias/Push-pull%20output%20bias.asc) · [Saved plot settings](03%20-%20Push-pull%20output%20bias/Push-pull%20output%20bias.plt)

Alan adds complementary emitter followers so the stage can drive a low impedance. His diagram specifies two 10 Ω emitter resistors, a 220 µF output coupling capacitor, and a 10 Ω load; circuit 03 adds those to circuit 02. The 12 V supply and the 50 mV 1 kHz drive remain test choices, and the 2N3904 and 2N3906 are the general-purpose parts his notes name as examples.

![Push-pull bias schematic](03%20-%20Push-pull%20output%20bias/Push-pull%20output%20bias%20schematic.png)

The multiplier now sits between the two output bases and holds them apart by whatever voltage the wiper sets. That voltage has to cover two base-emitter junctions plus the drop across the two emitter resistors before both output devices conduct at the same time.

![Load voltage above the base-to-base bias voltage](03%20-%20Push-pull%20output%20bias/Push-pull%20output%20bias%20waveforms.png)

The top pane is the base-to-base voltage, flat at about 0.70 V, 1.25 V and 1.55 V for the three wiper settings. The bottom pane is the load voltage, and the three runs are nothing alike:

- at `W=0` the bias is one Vbe, nowhere near two, so neither output device conducts near the zero crossing. The waveform collapses to about 50 mV peak with a flat notch at every crossing, which is the crossover distortion Alan shows [near 11:39](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=699s);
- at `W=0.8`, 1.25 V closes most of the gap and the output reaches about 150 mV peak;
- at `W=1`, 1.55 V keeps both devices conducting through the crossing and the output is a clean 205 mV peak.

![Measured mean supply current](03%20-%20Push-pull%20output%20bias/Push-pull%20output%20bias%20measurements.png)

| Wiper `W` | Base-to-base bias | Mean supply current | Load waveform |
| --- | ---: | ---: | --- |
| 0 | 0.70 V | 6.03 mA | Broad crossover notch |
| 0.8 | 1.25 V | 9.63 mA | Small notch |
| 1 | 1.55 V | 13.64 mA | Smooth |

The supply current more than doubles between the first and last settings. That is the trade Alan describes: enough bias to close the notch, but not so much that the two output devices sit there conducting into each other and wasting power. A real amplifier sets the multiplier so it tracks the output transistors' temperature, which is why the multiplier transistor is usually mounted on their heatsink.
