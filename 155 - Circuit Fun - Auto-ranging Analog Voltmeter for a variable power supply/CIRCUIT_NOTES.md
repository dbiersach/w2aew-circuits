# Video 155 - An analog voltmeter that changes its own range

Source: Alan Wolke (W2AEW), [#155: Circuit Fun: Auto-ranging Analog Voltmeter for a variable power supply](https://www.youtube.com/watch?v=7OLGswQ7ICI). His drawing for it is in [W2AEW Video Notes - Automatic_dualrange_analog_voltmeter.pdf](W2AEW%20Video%20Notes%20-%20Automatic_dualrange_analog_voltmeter.pdf).

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=20s) | The finished meter on the bench: a 100 uA movement reading the output of a variable supply, with a DMM alongside for comparison. |
| [1:30](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=90s) | The LM10 data sheet, and the part of it the circuit depends on: an op amp and a 200 mV reference in the same 8-pin package. |
| [3:00](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=180s) | The circuit drawing, which is what [circuit 01](#01---lm10-automatic-dual-range-meter) reproduces. |
| [4:20](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=260s) | The input divider and the 2.4 M feedback resistor that gives the comparison its hysteresis. |
| [7:00](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=420s) | The 2N7000 that shunts the movement, and the LED that tells you which range you are on. |
| [8:32](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=512s) | 4.17 V on the DMM, the LED dark, and the needle about four fifths of the way up a 5 V scale. |
| [9:07](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=547s) | 19.61 V on the DMM, the LED lit, and the needle back in almost the same place, now reading on the 25 V scale. |

## The problem it solves

A bench supply that runs from a fraction of a volt to twenty-odd volts is awkward to read on one analog meter. Scale it for 25 V and the bottom of the range is a twitch off the stop; scale it for 5 V and the needle pins the moment you turn the supply up.

Alan's answer is a meter that picks its own scale. Below about 5 V it reads 0 to 5 V, and above that it switches a shunt across the movement so the same needle travel now means 0 to 25 V, with an LED to say which. The pair of frames at 8:32 and 9:07 is the whole demonstration: 4.17 V and 19.61 V put the needle in the same place, and only the LED distinguishes them.

The circuit also has to run from the supply it is measuring, with no second battery, which is why the LM10 is the right part: it works down to a volt or so and brings its own 200 mV reference with it.

## 01 - LM10 automatic dual-range meter

Open [Automatic dual-range voltmeter.asc](01%20-%20LM10%20automatic%20dual-range%20meter/Automatic%20dual-range%20voltmeter.asc); the [video shortcut](01%20-%20LM10%20automatic%20dual-range%20meter/Video%20155%20-%2001%20-%20LM10%20automatic%20dual-range%20meter.url) opens the drawing at [3:00](https://www.youtube.com/watch?v=7OLGswQ7ICI&t=180s).

![LTspice schematic of the automatic dual-range voltmeter](01%20-%20LM10%20automatic%20dual-range%20meter/Automatic%20dual-range%20voltmeter%20schematic.png)

*Alan's circuit with his values. `VTEST` stands for the supply being measured, and it also powers everything. The LM10's reference output is tied back to its reference feedback pin, which makes it a 200 mV follower, and that 200 mV is what the op amp section compares against.*

### How the range switch works

`RUP` and `RDOWN` divide the measured supply by 240 k over 9.1 k, so the op amp's non-inverting input sees about 3.65 percent of it. When that crosses the 200 mV reference the output swings up, and `VSWITCH` measures the crossing at 5.59 V of supply.

`RFEEDBACK`, the 2.4 M from the output back to the non-inverting input, is positive feedback: once the comparison tips, it drags the input further the same way, so the switch is decisive rather than hovering around the threshold.

The output drives the 2N7000's gate through `RDRIVE`, with `DZENER` clamping the gate at 5.1 V so the full supply never reaches it, and `RLED` lighting the indicator from the same node. The MOSFET puts `RSHUNT` across the movement, and most of the current that was going through the meter goes through the 1 k instead.

### Simulated result

`.dc VTEST 0 30 0.1` sweeps the measured supply across both ranges.

| Quantity | Directive | Result |
| --- | --- | --- |
| Meter current at 5 V | `I_AT_5V` | 100.0 uA |
| Supply voltage at the switch | `VSWITCH` | 5.59 V |
| Meter current at 25 V | `I_AT_25V` | 131.4 uA |
| Meter current at 30 V | `I_AT_30V` | 157.6 uA |

![Simulated meter current and gate voltage over the full sweep](01%20-%20LM10%20automatic%20dual-range%20meter/Automatic%20dual-range%20voltmeter%20DC%20sweep.png)

*The top pane is the meter current, which is what the needle shows. It climbs straight to exactly 100 uA at 5 V, carries on a little past it, then drops to a third of scale as the shunt comes in, after which it climbs again on the new range. The bottom pane is the gate: zero until 5.59 V, then up to the zener clamp.*

The low range comes out exactly right. The movement sees the supply through `RSERIES` and its own resistance, 47 k plus 3 k, so 5 V gives precisely 100 uA, and Alan's 4.17 V would put the needle at 83 percent of scale. His needle at 8:32 is about there.

The high range is where the simulation and his bench part company, and the reason is written on his drawing. With the shunt in, the movement and the 1 k divide the current four ways to one, so 25 V gives 131 uA rather than the 100 uA the range is supposed to mean, and 30 V drives it to 158 uA. His build does not do that: at 19.61 V his needle sits around four fifths of scale rather than past the end of it.

That is not a disagreement about the circuit. It is the two asterisks he puts on the 47 k and the 1 k, marking them for calibration to the actual movement, and the movement's own resistance is the number neither of us has. This simulation assumes 3 kohm for a 100 uA meter and says so on the schematic. Working the shunt backwards from the same assumption, 100 uA at 25 V wants about 680 ohm rather than 1 k. The model reproduces the switching and the two ranges; the scale factor on the upper one is a bench adjustment, exactly as the asterisks say.

## Models and assumptions

The LM10 uses the `LM10C` subcircuit bundled with LTspice in `LTC.lib`, placed through a [local symbol](../LTspice/Symbols/LM10C-combined.asy) that presents its seven external pins in the order the library expects, matching the drawing's pins 3, 2, 7, 4, 6, 1 and 8. It is a model of the LM10 family rather than of Alan's specific LM10CN, and nothing here establishes that it tracks that part over temperature or at startup. [Texas Instruments lists the LM10CN](https://www.ti.com/product/LM10/part-details/LM10CN/NOPB) as a member of that family.

The 2N7000 comes from [onsemi's model](../LTspice/Models/onsemi/2N7000.REV0.LIB) in this repository. The 5.1 V zener and the LED use named parts from LTspice's own diode library; Alan's drawing gives only "5.1 V" and a generic LED, so those two are representative choices rather than his parts.

The movement's resistance, `R_METER_INTERNAL`, is set to 3 kohm and is marked on the schematic as an assumption. It is the single number that most affects the upper range, and it is not in the video.
