# Video 183: why diodes are used around relay coils

Source: Alan Wolke (W2AEW), [#183: Why diodes are used around relay coils: Back to Basics on flyback or snubber diodes](https://www.youtube.com/watch?v=c6I7Ycbv8B8). His two notes pages are kept here as [W2AEW Video Notes - Diodes_around_relay_coils.pdf](<W2AEW Video Notes - Diodes_around_relay_coils.pdf>), and the second of them is the circuit both schematics are built from.

| Time | What Alan shows |
| --- | --- |
| [2:40](https://www.youtube.com/watch?v=c6I7Ycbv8B8&t=160s) | Draws the test circuit, which is the one built in both [01 - Relay without flyback diode](<01 - Relay without flyback diode/>) and [02 - Relay with flyback diode](<02 - Relay with flyback diode/>). The two differ only in whether the diode is fitted, so they share this one entry. |
| [7:11](https://www.youtube.com/watch?v=c6I7Ycbv8B8&t=431s) | Back at the drawing, pointing out where each of the four scope channels attaches: the input pulse, the collector, the coil current and the emitter. |
| [9:20](https://www.youtube.com/watch?v=c6I7Ycbv8B8&t=560s) | The switch-off transient on the MDO3104 at 100 V per division and 10 mA per division, with the timebase down at 4 us per division. |
| [10:40](https://www.youtube.com/watch?v=c6I7Ycbv8B8&t=640s) | A far slower decay at the same point, now taking milliseconds rather than microseconds. |
| [12:41](https://www.youtube.com/watch?v=c6I7Ycbv8B8&t=761s) | The drawing once more while he draws the lesson together. |

## The argument, in Alan's own order

The first page of his notes sets it out in four steps, and the whole lesson follows from them:

- Current flow induces a magnetic field around a wire, and a changing magnetic field induces current flow.
- So when a relay coil is turned off, the drop in current collapses the magnetic field.
- That collapse induces a current, and it is in the same direction the current was already flowing.
- If no diode is present, that current can generate a very high voltage at the switch or transistor.

The third step is the one that is easy to get backwards. The coil does not try to reverse its current, it tries to keep it. With the transistor off there is no path for it, so the collector rises until something gives it one, and what usually gives it one is the transistor failing.

## The circuit both schematics share

Alan's notes give the drive precisely and it is reproduced exactly: a pulse generator putting out a 5 V, 200 ms pulse behind 50 ohm, 3.9 kohm into the base of an **MPSA42**, and 20 ohm in the emitter as a current monitor. The MPSA42 is not an incidental choice. It is a 300 V part, which is a great deal more than the 5 V the circuit runs on, and that margin is the point.

The transistor model is `MPSA42_LEGACY` from [`LTspice/Models/Unverified/MPSA42_legacy.lib`](<../LTspice/Models/Unverified/MPSA42_legacy.lib>). No manufacturer SPICE model for this part could be found, so it is a legacy card of unverified provenance; its BF of 70.4 is at least consistent with the onsemi datasheet's minimum hFE of 40. **It carries no breakdown parameters**, which matters below.

Two things are estimates because Alan never states them. `RCOIL` at 70 ohm and `LCOIL` at 50 mH stand for the relay winding. With the transistor and the 20 ohm dropping about 1.3 V, 70 ohm passes 53 mA, which sits inside the range his 10 mA per division current trace covers, so the resistance is at least the right size. The inductance sets how long the decay takes and nothing else in the lesson depends on its exact value.

His drawing also puts an LED and resistor on the relay contacts, so you can see the relay actually pull in. The contact is not modelled here, so that branch is left out.

## 01 - Relay without flyback diode

[`01 - Relay without flyback diode/Relay without flyback diode.asc`](<01 - Relay without flyback diode/Relay without flyback diode.asc>)

![Relay without flyback diode schematic](<01 - Relay without flyback diode/Relay without flyback diode schematic.png>)

![Relay without flyback diode turn-off](<01 - Relay without flyback diode/Relay without flyback diode turn-off.png>)

The plot is a six microsecond window around the falling edge of the drive pulse. The lower pane is the coil current, which starts at the 52.6 mA it has been carrying and falls to zero in about two microseconds. The upper pane is what that costs: the collector is driven up through two and a half kilovolts while it happens.

![Relay without flyback diode SPICE output log](<01 - Relay without flyback diode/Relay without flyback diode SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `vc_pk` | 2584.7 V |
| `vc_on` | 1.318 V |
| `icoil_on` | 52.59 mA |
| `ie_on` | 53.41 mA |

**That 2585 V is not a prediction of anything physical, and should not be read as one.** The model has no breakdown parameters, so SPICE will let the collector go as high as the arithmetic takes it. A real MPSA42 is a 300 V device and would avalanche somewhere near that figure, dumping the coil's energy through the junction instead; a smaller transistor would do so sooner and might not survive it. The useful content of this run is not the number but its shape: the voltage is limited by nothing in the circuit, so it is limited by whatever breaks down first. That is precisely the sentence Alan ends his first notes page with.

What the circuit does have is a fixed amount of energy to get rid of. Half of L times I squared, with 50 mH and 52.6 mA, is about 69 microjoules. It has to go somewhere, and without a diode the only place is the transistor.

## 02 - Relay with flyback diode

[`02 - Relay with flyback diode/Relay with flyback diode.asc`](<02 - Relay with flyback diode/Relay with flyback diode.asc>)

![Relay with flyback diode schematic](<02 - Relay with flyback diode/Relay with flyback diode schematic.png>)

The only change is a 1N4148 across the coil, cathode to the supply and anode to the collector. While the relay is driven it is reverse biased and does nothing at all. The moment the collector rises above the supply, it conducts.

![Relay with flyback diode turn-off](<02 - Relay with flyback diode/Relay with flyback diode turn-off.png>)

The time axis here is three milliseconds, a thousand times wider than the previous plot, because that is how long the same energy now takes to leave.

![Relay with flyback diode SPICE output log](<02 - Relay with flyback diode/Relay with flyback diode SPICE output log.png>)

| Measurement | Result |
| --- | --- |
| `vc_pk` | 5.793 V |
| `idfly_pk` | 52.47 mA |
| `vc_on` | 1.318 V |
| `icoil_on` | 52.59 mA |
| `ie_on` | 53.41 mA |

Three of these are worth reading side by side with the first table.

`vc_on`, `icoil_on` and `ie_on` are identical in both circuits to four figures. The diode changes nothing whatever about normal operation, which is why it costs nothing to fit.

`idfly_pk` is 52.47 mA, and `icoil_on` was 52.59 mA. The diode picks up almost exactly the current the coil was already carrying, in the same direction, which is Alan's third step made visible.

`vc_pk` falls from 2584.7 V to 5.793 V. That is the 5 V rail plus one forward drop, and it is a hard ceiling rather than an estimate: the collector cannot go higher than the supply plus a diode, whatever the coil does.

The cost is time. The current now circulates round the coil and the diode and decays with the coil's own L over R, roughly 700 microseconds here, and is essentially gone after a millisecond and a half. The same 69 microjoules is dissipated in the winding resistance over milliseconds instead of in the transistor over microseconds. That slow release is also why a relay with a plain flyback diode drops out more slowly than one without, which is the trade the snubber variants in other designs exist to adjust.
