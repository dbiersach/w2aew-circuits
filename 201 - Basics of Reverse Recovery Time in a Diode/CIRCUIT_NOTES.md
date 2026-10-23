# Video 201: basics of reverse recovery time in a diode

Source: Alan Wolke (W2AEW), [#201: Basics of Reverse Recovery Time in a Diode](https://www.youtube.com/watch?v=SBqLOrlA7QI). His notes page for the lesson is kept here as [W2AEW Video Notes - reverserecovery.pdf](<W2AEW Video Notes - reverserecovery.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:40](https://www.youtube.com/watch?v=SBqLOrlA7QI&t=40s) | The top of his notes page, and the one sentence the whole lesson rests on: switch a diode from forward to reverse bias and a reverse current flows for a short time. In his words, it does not block like a diode. |
| [3:00](https://www.youtube.com/watch?v=SBqLOrlA7QI&t=180s) | Where that current comes from, stored charge in the junction that takes time to remove and recombine, and how wide the range is: from a few nanoseconds or less to a few microseconds or more, depending on the device and the current level. Also where it costs you, in switching regulators, and where it is useful, in PIN diode RF switches. |
| [5:20](https://www.youtube.com/watch?v=SBqLOrlA7QI&t=320s) | The "quick measurement setup" at the bottom of the page: a generator with its 50 ohm source resistance, the device under test in series, and a 50 ohm termination at the scope end. Built as [01 - Reverse recovery fixture](<01 - Reverse recovery fixture/>). |
| [6:30](https://www.youtube.com/watch?v=SBqLOrlA7QI&t=390s) | That fixture wired up on the bench, with the generator, the part under test, and a scope probe on the termination. |
| [7:40](https://www.youtube.com/watch?v=SBqLOrlA7QI&t=460s) | The recovery itself on the scope: forward current, then the step down past zero into reverse, then the return to zero. |

## The fixture

[01 - Reverse recovery fixture/Reverse recovery rectifier versus switching diode.asc](<01 - Reverse recovery fixture/Reverse recovery rectifier versus switching diode.asc>)

![Reverse recovery fixture schematic](<01 - Reverse recovery fixture/Reverse recovery fixture schematic.png>)

Alan's measurement fixture is four parts and nothing else: a pulse generator, its own 50 ohm source resistance, the diode under test in series, and 50 ohm to ground at the far end. The termination does two jobs. It gives the generator the load it expects, and because everything is in series, the voltage across it is the diode current multiplied by 50 ohm. Put a probe there and the trace on the screen is the diode current with no current probe required. His page offers three ways to build it: a 50 ohm resistor with a 10x probe, a 50 ohm feed-through termination, or the scope's own 50 ohm input.

The schematic is that fixture drawn twice, so a rectifier and a switching diode can be driven by identical pulses in one run and compared directly. Each row on its own is Alan's circuit unchanged.

The pulse swings between -1 V and +1 V, a few microseconds wide, as drawn on his page. The 5 ns edges are a choice, and a consequential one, as the measurement below shows. The two devices are examples; the parts on Alan's bench are not identified in these files. Both models are published by Diodes Incorporated and live in [LTspice/Models/Diodes-Inc](<../LTspice/Models/Diodes-Inc/>): the 1N4007G is a 1 A general-purpose rectifier and the 1N4148W a small-signal switching diode.

With 50 ohm each side of the diode, the forward current is only a few milliamps. That is what Alan's drawn amplitude gives, and it is deliberately gentle: reverse recovery depends on how much charge was stored, so a low forward current keeps the recovery short enough to fit on a fast timebase.

## What the measurement shows

![Reverse recovery currents](<01 - Reverse recovery fixture/Reverse recovery currents.png>)

The lower pane is the stimulus, reversing at 3.505 microseconds. The upper pane is both diode currents on one axis, and the difference between them is the entire lesson.

Before the edge, both diodes carry a few milliamps forward. At the edge both currents plunge through zero into reverse, which is the part a diode is not supposed to do. The switching diode is back to almost nothing immediately. The rectifier sits at 16 mA in the wrong direction for the better part of half a microsecond, and only then does the current snap back to zero as the last of the stored charge is removed.

![Reverse recovery SPICE output log](<01 - Reverse recovery fixture/Reverse recovery SPICE output log.png>)

Reverse recovery time is conventionally measured from the moment the current crosses zero to the moment it has come back to 10 percent of its peak reverse value. The reverse peak in this fixture is about 16 mA, so the directives look for the current returning through -1 mA.

| | Forward current | Peak reverse current | Recovery to -1 mA |
| --- | --- | --- | --- |
| 1N4007G rectifier | 3.86 mA | -16.1 mA | **446 ns** |
| 1N4148W switching diode | 3.23 mA | -8.63 mA | **3.34 ns** |

Two numbers in that table deserve a second look, because neither means quite what it appears to.

The rectifier's **-16.1 mA** is larger than the fixture should allow. With -1 V driving two 50 ohm resistors in series, the most that can flow is 10 mA. The extra comes from the diode itself: while it is still full of charge it holds a small forward voltage, and that voltage is in series with the generator and adds to the reverse drive. The circuit is briefly being pushed by the supply and the diode together. Once the charge is gone and the diode starts to block, the current collapses.

The switching diode's **3.34 ns** is not a property of the 1N4148W. The generator's falling edge is 5 ns long, so the diode has finished recovering before the stimulus has finished arriving. What that row actually records is the edge rate of the fixture. To measure a fast diode you need a faster edge than the recovery you are looking for, which is why Alan's notes say recovery times can be "a few ns or less": below a few nanoseconds an ordinary function generator simply cannot see them. Its peak reverse current is lower than the rectifier's for the same reason, not because it stores less charge, but because it stops conducting before the drive has fully developed.

The rectifier's 446 ns is a real measurement of the model under these conditions, and the comparison is honest in the direction that matters: the two differ by more than two orders of magnitude. A datasheet trr is specified at its own forward current, reverse current and edge rate, so neither number here is a datasheet qualification. Change the pulse amplitude, the resistors or the edge rate and both will change.

If the waveform window comes up autoscaled, press Ctrl+Space to reload the saved plot settings.
