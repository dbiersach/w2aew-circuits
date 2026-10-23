# Video 197: simple V-I curve tracer

Source: Alan Wolke (W2AEW), [#197:Simple V-I curve tracer using an oscilloscope and function generator](https://www.youtube.com/watch?v=WWY-pakm_OM). Alan's own page for the lesson is kept here as [W2AEW Video Notes - simplecurvetracer.pdf](<W2AEW Video Notes - simplecurvetracer.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:16](https://www.youtube.com/watch?v=WWY-pakm_OM&t=16s) | Draws the whole fixture: a function generator with a 50 ohm output, the device under test in series with a 10 ohm sense resistor, and a scope in X-Y mode taking X from the top of the DUT and Y from the sense resistor. Built as [01 - V-I curve tracer](<01 - V-I curve tracer/>). |
| [1:53](https://www.youtube.com/watch?v=WWY-pakm_OM&t=113s) | Works through the lower half of the page: his caveat that the sense voltage is added into X, and the three cleaner alternatives. See [Why the X channel is not the DUT voltage](#why-the-x-channel-is-not-the-dut-voltage). |
| [2:30](https://www.youtube.com/watch?v=WWY-pakm_OM&t=150s) | At the bench with the part on a breadboard, showing the triangle drive on the scope in ordinary time-base mode. |
| [3:15](https://www.youtube.com/watch?v=WWY-pakm_OM&t=195s) | The scope switched to X-Y, drawing the curve itself. |
| [4:15](https://www.youtube.com/watch?v=WWY-pakm_OM&t=255s) | Holds the page up beside the live display to tie the drawing and the trace together. |

## The fixture Alan draws

[01 - V-I curve tracer/Diode V-I tracer.asc](<01 - V-I curve tracer/Diode V-I tracer.asc>)

![Diode V-I tracer schematic](<01 - V-I curve tracer/Diode V-I tracer schematic.png>)

The whole tracer is four parts. `VGEN` is the function generator and `RSRC` is its 50 ohm output resistance. The device under test, here the diode `D1`, hangs from that node down to `RSENSE`, the 10 ohm sense resistor, which returns to ground. `SCOPE_X` and `SCOPE_Y` are the two scope probes in Alan's drawing: X at the top of the DUT, Y at the junction between the DUT and the sense resistor.

That ordering is the point of the circuit and the source of its one flaw. Because the sense resistor sits between the DUT and ground, the X probe is looking down through both parts in series, not across the DUT alone.

Alan's page gives the 50 ohm source and the 10 ohm sense resistor. It does not state the generator level or name the part, so the 5 V 500 Hz triangle and the 1N4148 are choices made here; the method does not depend on either. The run is `.tran 0 6m 0 1u`, three full triangle periods, which gives three sweeps up and back down the curve exactly as the repeating scope trace does.

![Diode V-I tracer sweep](<01 - V-I curve tracer/Diode V-I tracer sweep.png>)

The top pane holds the X channel, `V(scope_x)`, against the true voltage across the diode, `V(scope_x)-V(scope_y)`. On the negative half of the triangle the diode is reverse biased and carries nothing, so no voltage develops across the sense resistor and the two traces lie on top of each other all the way down to -5 V. On the positive half they separate: the lower trace flattens at about 0.82 V, the way a conducting silicon diode should, while the X channel keeps climbing to 1.51 V. The bottom pane is the diode current, a triangle with its tip clipped by the diode's own curvature, peaking at 69.7 mA. That current is what the Y channel actually reads, as 0.70 V across 10 ohm.

If the waveform window opens autoscaled with the wrong traces, press Ctrl+Space (Plot Settings > Reload Plot Settings) to pick up the saved `.plt`.

## Why the X channel is not the DUT voltage

Alan writes his own warning straight onto the page: the method is "NOT PERFECT BECAUSE CURRENT SENSE Y IS ADDED TO DUT VOLTAGE X". The four `.meas` directives measure exactly that, all sampled at 1 ms, the tip of the first triangle.

![Diode V-I tracer SPICE output log](<01 - V-I curve tracer/Diode V-I tracer SPICE output log.png>)

| Quantity | Value at the triangle peak |
| --- | --- |
| X channel, `V(scope_x)` | 1.513 V |
| Y channel, `V(scope_y)` | 0.697 V |
| Actual diode voltage, `V(scope_x)-V(scope_y)` | 0.816 V |
| Diode current, `I(D1)` | 69.7 mA |

At full current the X reading is 85 percent high. The error is not a fixed offset either: it is the Y reading itself, so it grows with current and the displayed curve is sheared to the right, pulling up into a straighter line than the diode really has. At low current, where Y is small, the display is close to honest; the discrepancy only matters once the part is conducting hard, which is precisely the region a curve trace is usually being read for.

The same arithmetic gives the three fixes Alan lists on his page, in his order:

- Use a current probe for Y, so nothing is in series with the DUT at all.
- Swap the DUT and the sense resistor, then read Y with a differential probe across the sense resistor. X then sits directly across the DUT.
- Leave the fixture alone and use the scope's math to subtract the Y channel from the X channel.

The third is the one the simulation does: `V(scope_x)-V(scope_y)` is that subtraction, and the lower trace in the top pane is what the corrected display would look like.

## The curve itself

[01 - V-I curve tracer/Diode V-I curve.asc](<01 - V-I curve tracer/Diode V-I curve.asc>)

![Diode V-I curve schematic](<01 - V-I curve tracer/Diode V-I curve schematic.png>)

This file is not a circuit from the video. It is the same 1N4148 with a source swept straight across it and nothing else in the loop, so the horizontal axis carries the diode's own terminal voltage. It is here to show what the fixture is reaching for, free of the sense resistor.

![Diode V-I curve plot](<01 - V-I curve tracer/Diode V-I curve plot.png>)

The lower pane is the whole -5 V to 0.82 V sweep, and it is mostly empty: a flat line along the voltage axis and then a hard knee at the right-hand end. That shape, not a graceful curve, is what the scope draws in X-Y mode, and it is why a curve trace is usually read with the horizontal gain turned well up. The upper pane does that, taking the same data from 400 mV to 850 mV, where the knee near 0.6 V and the climb to 69.7 mA are properly visible.

`.meas dc ID_AT_816MV` reports 69.63 mA at 0.816 V. The fixture measured 69.66 mA at the same diode voltage, a difference of 0.05 percent. The two agree because the sense resistor does not disturb the current at all, only the voltage the X channel reports. That is the whole character of the error: the vertical reading is right, the horizontal one is not.

## Getting Alan's X-Y display in LTspice

The waveform viewer can put a trace on the horizontal axis, which is what turns the time-domain run into Alan's curve display, but a `.plt` file cannot record that choice, so the saved plot comes up against time. To see the curve:

1. Run `Diode V-I tracer.asc` and plot `I(D1)`.
2. Move the pointer below the horizontal axis until it becomes a ruler, then left-click it.
3. Set the quantity plotted to `V(scope_x)`.

`I(D1)` is then drawn against the X channel, exactly as the scope draws Y against X, shear and all. Changing the quantity to `V(scope_x)-V(scope_y)` applies Alan's third fix and draws the corrected curve, which should land on the upper pane of the reference sweep.
