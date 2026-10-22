# Video 324 - Calibrating a Simpson 260 VOM and its 50 microamp current source

Source: Alan Wolke (W2AEW), [#324: How to "calibrate" the Simpson 260 VOM - BONUS: 50 microamp current source](https://www.youtube.com/watch?v=TQ7w6_CgO0Q). Alan's handwritten pages for the lesson are in [W2AEW Video Notes - Simpson260cal.pdf](W2AEW%20Video%20Notes%20-%20Simpson260cal.pdf).

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=20s) | The title page of his notes, with the Simpson 260 on the bench beside the scope, the Fluke and the Keithley. |
| [1:40](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=100s) | The disclaimers page: he is adjusting the voltage ranges only, not the current shunts, and the procedure applies to Series 4 and later meters. |
| [3:20](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=200s) | The factory Simpson 260 schematic: the range selector, the 50 uA movement marked "calibrated to 5000 ohms", and the diode bridge that gives the AC ranges. |
| [5:00](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=300s) | The test fixture for the first adjustment, with a 50 uA current source feeding the meter's 50 uA jack, one DMM in series to verify the current and a second DMM across the movement. This is the setup the [simulated circuit](#01---50-microamp-current-source) supplies. |
| [8:25](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=505s) | The bench reading at the end of that adjustment: the Fluke 8846A measures 50.0115 uA into the meter and the Keithley 2015 reads 0.248698 V across it. |
| [10:00](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=600s) | The AC page, showing the series multiplier resistor and the rectifier bridge wrapped around the movement. |
| [13:10](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=790s) | The AFG3252 set to 60 Hz and 5.656 Vpp, which is 2 V RMS, for the 2.5 VAC range check. |
| [13:52](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=832s) | The bonus section begins, and he picks up the breadboarded source he built for this job. See [01 - 50 microamp current source](01%20-%2050%20microamp%20current%20source/). |
| [14:04](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=844s) | His drawing of the source: a 1N4577 reference, three 2N3906 transistors in a Wilson mirror, and a 5 kilohm trim. |

## What the lesson covers

Almost all of this video is adjustment inside the meter itself, and none of that has an LTspice counterpart: Alan turns the meter's own shunt and series trimmers while watching external instruments. What makes the first adjustment possible is a reference instrument, and that reference is a circuit he built. It is the one part of the lesson that can be simulated, so it is the only schematic here.

The Simpson 260's accuracy rests on two properties of its 50 uA movement. Full-scale deflection has to happen at exactly 50 uA, and the core meter circuit on the 50 uA range has to present exactly 5000 ohms, because every other voltage range is a precision resistor placed in series with that 5000 ohms. Those two numbers fix the voltage across the movement at full scale: 50 uA into 5000 ohms is 250 mV. Alan's procedure follows from that. Feed in a known 50 uA, adjust the shunt until the needle sits on full scale, then adjust the series resistor until a DMM across the movement reads 250 mV. At 8:25 the two meters confirm the result, 50.0115 uA in and 0.248698 V across.

Feeding in a known 50 uA is the hard part, and a 9 V battery through a large resistor will not do it, because the voltage across the movement changes as the needle moves and as the series trimmer is turned. The source has to hold its current while its own output voltage wanders over the whole range the adjustment covers. That is what the bonus circuit does, and what the simulation below measures.

## 01 - 50 microamp current source

Open [50 microamp Wilson current source.asc](01%20-%2050%20microamp%20current%20source/50%20microamp%20Wilson%20current%20source.asc) and run it. The [video shortcut](01%20-%2050%20microamp%20current%20source/Video%20324%20-%2001%20-%2050%20microamp%20current%20source.url) in the same folder opens the bonus section at [13:52](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=832s), and Alan draws the circuit at [14:04](https://www.youtube.com/watch?v=TQ7w6_CgO0Q&t=844s).

![LTspice schematic of the 50 microamp Wilson current source](01%20-%2050%20microamp%20current%20source/50%20microamp%20Wilson%20current%20source%20schematic.png)

*The circuit as drawn on page 5 of Alan's notes: the 1N4577 reference on the left, the reference leg through Q1 in the middle, and the diode-connected Q3 above the output device Q2 on the right.*

### How it works

The left-hand leg sets up the reference voltage. `Dref` is reverse biased from the 9 V rail, so the node labelled `REF` sits about 6.4 V below it, near 2.6 V, and `Rref` at 1.3 kilohms draws the 2 mA of zener current that holds it there.

The three transistors form a Wilson current mirror built from PNPs, with the emitters at the top. `Q3` is diode connected, its collector tied to its own base, and it shares that base node with `Q1`; those two are the mirror pair, each with a 10 kilohm emitter resistor to the rail. `Q2` sits below `Q3` with its emitter on the shared base node, its base on `Q1`'s collector, and its collector as the output. The reference current is the one leaving `Q1`'s collector, which flows through `Rtrim` and `Rbias` down to the 2.6 V `REF` node, so the 91 kilohm resistor plus the trim setting is what sets the scale of the whole thing.

The Wilson arrangement is what makes the output flat. In a plain two-transistor mirror the output transistor's collector voltage moves with the load and drags its collector current along with it through the Early effect. Here `Q2` carries the output current, but its own collector-emitter voltage is held nearly constant by the loop through `Q3` and `Q1`, so movement at the output barely reaches the devices that set the current.

`Vdut` stands in for the meter movement. Sweeping it from 0 to 5 V and plotting the current through it maps the compliance range over which the source still delivers its 50 uA.

### Simulated result

`.dc Vdut 0 5 0.05` sweeps the output voltage, and two `.meas dc` directives report the current at the two voltages that matter: 250 mV, the movement's full-scale voltage, and 5 V, well past anything the adjustment will produce.

| Quantity | Directive | Result |
| --- | --- | --- |
| Output current at the movement's full-scale voltage | `IDUT_250MV` | 50.010 uA |
| Output current at 5 V of compliance | `IDUT_5V` | 49.978 uA |

Over that 4.75 V swing the output changes by 32 nA, which is 0.06 percent. Against the meter's own accuracy specification the source is a constant current, and that is the point: the needle can swing and the series trimmer can be turned without changing the current being fed in.

![Simulated output current against output voltage, shown full scale and magnified](01%20-%2050%20microamp%20current%20source/Current-source%20compliance.png)

*Both panes plot the same `I(Vdut)` against the swept output voltage. The top pane uses a 0 to 60 uA axis, the scale a reader of the meter cares about, where the trace is a flat line at 50 uA. The bottom pane magnifies a 0.05 uA window around that line so the residual slope is visible at all: 50.010 uA at 250 mV falling to 49.978 uA at 5 V. If the waveform window opens autoscaled instead, press Ctrl+Space to reload the saved plot settings.*

### Comparison with Alan's bench

At 8:25 the Fluke reads 50.0115 uA with 0.248698 V across the movement, and the simulation gives 50.010 uA at 250 mV. That agreement is arranged rather than predicted, because the trim setting was chosen to produce it, as described below. What the simulation establishes on its own is the shape of the curve, the near-total insensitivity to output voltage that makes the measurement trustworthy in the first place.

### Models and assumptions

`Q1`, `Q2` and `Q3` use LTspice's built-in `2N3906` model, the part Alan labels on his drawing.

The reference is a 1N4577, a temperature-compensated 6.4 V reference diode. No manufacturer SPICE model for it was found on Microchip's current pages or in the local `Components` and `Libraries` collections, so the schematic includes [1N4577_illustrative.lib](../LTspice/Models/Unverified/1N4577_illustrative.lib), a plain diode model fitted to the nominal 6.4 V at 2 mA. It is illustrative, not manufacturer supplied: it carries none of the real device's temperature compensation and none of its tolerance, so the simulated current must not be read as a prediction of what a physical 1N4577 would do over temperature. The [1N4565 to 1N4585A data sheet](https://ww1.microchip.com/downloads/aemDocuments/documents/HRDS/ProductDocuments/DataSheets/1N4565-1N4585A-1.pdf) carries the device's actual limits.

Alan draws the trim as a 5 kilohm potentiometer and does not say where he set it, so `Rtrim` is written as a rheostat with `TRIM` as a parameter. The schematic uses `TRIM=4.12k`, the setting that brings this model's output to the 50.0115 uA the Fluke reads at 8:25. That is a value fitted to the model, not a reading taken from the bench; a physical build would land somewhere else on the pot, because the real reference diode, the real transistors and the real supply all differ from the ones here.

Two other differences from the bench are worth naming. The supply is entered as the 9 V on Alan's drawing, while the Tektronix PWS4205 in the shots reads 9.029 V. And the simulation runs at LTspice's default 27 C, so it says nothing about the drift that the 1N4577's temperature compensation exists to prevent.
