# Video 100: Capacitor self-resonance measured with an oscilloscope and signal generator

Source: Alan Wolke (W2AEW), [#100: Capacitor self-resonance measured with an oscilloscope and signal generator - how to tutorial](https://www.youtube.com/watch?v=C3wYMZ_cjdQ).

| Time | What Alan shows |
| --- | --- |
| [1:30](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=90s) | His notes on why a capacitor stops being a capacitor: at some frequency XL equals XC, and above it the part behaves as an inductor. |
| [2:44](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=164s) | Draws the measurement setup, the fixture built in [01 - Capacitor self-resonance fixture](<01 - Capacitor self-resonance fixture/>): signal generator, 10 dB pad, the capacitor across the line, scope probe on the junction. |
| [3:04](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=184s) | The impedance against frequency sketch, capacitive on the left, inductive on the right, bottoming out at roughly Rs. |
| [3:12](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=192s) | The 10 dB attenuator itself, a small box in line with the generator. |
| [5:36](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=336s) | A Leader LDC-821S frequency counter on the generator output. |
| [5:51](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=351s) | The Tektronix AFG 3252 set to 5.000 Vpp with Load High Z and zero offset. |
| [8:16](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=496s) | 2.36667 MHz on the scope's counter at 100 mV per division, the trace already small. |
| [8:46](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=526s) | 3.36278 MHz, where the trace has flattened to a line at the same sensitivity. |
| [9:10](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=550s) | 3.26506 MHz at 20 mV per division with the 20 MHz bandwidth limit on, hunting the bottom of the notch. |

## What is being measured and why it works

A capacitor is a capacitor in series with the inductance of its own leads and plates and with a small resistance. Below some frequency the capacitance dominates and the impedance falls as `1 / (2 pi f C)`. Above it the inductance dominates and the impedance climbs as `2 pi f L`. Between the two, at the self-resonant frequency, the two reactances cancel and all that is left is the resistance. That is the V-shaped curve Alan sketches at [3:04](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=184s).

His method turns that impedance into a voltage. The capacitor sits across the output of a 10 dB pad, which presents a steady 50 ohm source whatever the generator is doing, and the scope watches the voltage across the capacitor. A high impedance barely loads the pad, so the trace is large; at resonance the part is nearly a short and the trace collapses. Sweep the generator by hand, find the frequency where the trace is smallest, and that frequency is the self-resonant frequency. Nothing else needs to be calibrated.

## 01 - Capacitor self-resonance fixture

[`01 - Capacitor self-resonance fixture/Capacitor self-resonance fixture.asc`](<01 - Capacitor self-resonance fixture/Capacitor self-resonance fixture.asc>), introduced at [2:44](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=164s).

![Capacitor self-resonance fixture schematic](<01 - Capacitor self-resonance fixture/Capacitor self-resonance fixture schematic.png>)

Everything to the left of the capacitor is Alan's bench, built out of the parts he actually has in line:

- `Vgen` with `Rgen` is the AFG 3252 at 5 Vpp with Load set to High Z, which is the open-circuit amplitude, so 2.5 V peak behind the generator's own 50 ohms.
- `Rpad1`, `Rpad2` and `Rpad3` are the 10 dB pad as a resistive T, which is what is inside that little box. The values 25.98, 35.14 and 25.98 ohm are what a 10 dB T-pad needs in a 50 ohm system; the pad's job is to give the capacitor a clean 50 ohm source regardless of what the generator's output does.
- `Rprobe` and `Cprobe` are the 10x probe Alan has on the fixture, 10 Mohm and about 12 pF.

The capacitor itself is the three elements on the right. `Cdut` is 10 nF, the 103 part he shows. `Lesl` is 238 nH, which is not measured but derived: it is the inductance that puts self-resonance where his scope reads it. `Resr` is an assumption. He never measures ESR in this video, and 2 ohm puts the bottom of the notch in the same region as the few tens of millivolts he is looking at when he switches to 20 mV per division.

### The sweep

![Capacitor self-resonance fixture sweep](<01 - Capacitor self-resonance fixture/Capacitor self-resonance fixture sweep.png>)

The top pane is what the scope sees: the magnitude of the voltage across the capacitor, on a linear 0 to 0.9 V scale against a logarithmic frequency axis from 10 kHz to 100 MHz. Well below resonance the capacitor is a high impedance and the trace sits at 0.751 V peak, which is just the pad's open-circuit output. It falls away, bottoms out at 30 mV peak, and then climbs back as the part turns inductive. This is the same shape Alan walks down by hand between [8:16](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=496s) and [9:10](https://www.youtube.com/watch?v=C3wYMZ_cjdQ&t=550s).

The bottom pane is the same run expressed as the capacitor's own impedance, `V(out)/I(Cdut)`, on log axes. It is Alan's sketch: a straight capacitive slope falling to the left of resonance, a straight inductive slope rising to the right, and a sharp minimum between them at the value of the series resistance.

![Capacitor self-resonance fixture SPICE output log](<01 - Capacitor self-resonance fixture/Capacitor self-resonance fixture SPICE output log.png>)

| Measurement | Result in dB | As a value |
| --- | --- | --- |
| `vout_lf` at 100 kHz | -2.483 dB | 0.751 V peak |
| `vout_min` over the sweep | -30.337 dB | 30.4 mV peak |
| `vout_sr` at 3.262 MHz | -30.337 dB | 30.4 mV peak |
| `vout_hf` at 30 MHz | -5.324 dB | 0.542 V peak |
| `zdut_sr` at 3.262 MHz | 6.025 dB | 2.00 ohm |

Two of these are worth reading together. `vout_sr` and `vout_min` agree to six figures, which says the notch really does sit at 3.262 MHz rather than near it, and `zdut_sr` comes out at 2.00 ohm, which is `Resr` exactly. At resonance the inductive and capacitive reactances have cancelled completely and the resistance is all that remains, which is the claim the whole lesson rests on.

### How this relates to Alan's reading

The relationship between the three DUT values is fixed: given 10 nF and a measured 3.265 MHz, the inductance has to be about 238 nH, because `L = 1 / ((2 pi f)^2 C)`. That is the useful part of the measurement. Finding the self-resonant frequency of a capacitor tells you its parasitic inductance, and 238 nH is a reasonable figure for a leaded disc capacitor held in a clip fixture, where the leads and the fixture contribute as much as the part does.

The video's description is blunt about where this method stops working: the fixture's own inductance has to be much smaller than the capacitor's, which fails for small RF capacitors well under 1 nF. The same caveat applies to this model from the other direction. `Lesl` here is a single lumped number that absorbs the part, its leads and the fixture together, so it is not a property of the capacitor alone. What the simulation does show faithfully is the shape of the response and why the minimum of a voltage is a measurement of a resonance.
