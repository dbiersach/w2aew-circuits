# Video 054 - Back to Basics Tutorial: Voltage / Current in capacitors and inductors

[Watch Alan Wolke's video](https://www.youtube.com/watch?v=ykgmKOVkyW0) alongside his [handwritten notes](<W2AEW Video Notes - Voltage_Current_Capacitors_Inductors.pdf>), which cover this video and video 055.

| Time | What Alan shows |
| --- | --- |
| [0:39](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=39s) | A capacitor passes current only while its voltage changes. The current is largest where the voltage changes fastest (its zero crossings), so the current peak arrives before the voltage peak: current **leads** voltage. |
| [3:46](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=226s) | An inductor's voltage is set by how fast its current changes, so the current peak arrives after the voltage peak: current **lags** voltage. |
| [6:35](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=395s) | The measurement setup. A function generator drives the part under test in series with a 100 Ohm current-sense resistor. Channel 1 probes the applied voltage, and channel 2 probes the sense resistor. Because the voltage across a resistor is always in phase with its current, channel 2 shows the current. |
| [8:03](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=483s) | A 1 kOhm resistor: voltage and current in phase. |
| [8:40](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=520s) | A capacitor with about 1 kOhm of reactance at the test frequency: the current leads. |
| [9:38](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=578s) | An inductor with about 1 kOhm of reactance: the current lags. |

## The test setup in LTspice

All three schematics use the same fixture, drawn the way Alan draws it:

- **V1** is the generator.
- **The part under test** (R1, C1 or L1) connects from the generator to node `CH2`.
- **R2** (100 Ohm) runs from `CH2` to ground and acts as the current sense.
- **`CH1`** is the applied voltage, Alan's channel 1.
- **`CH2`** is 100 Ohm times the current, Alan's channel 2.

Alan chose the sense resistor about ten times smaller than the part's resistance or reactance, so it hardly disturbs the measurement.

| Value | Source | Used in the simulation |
| --- | --- | --- |
| Sense resistor | Stated at 7:05 | 100 Ohm |
| Resistor under test | Stated at 8:03 | 1 kOhm |
| Capacitor and inductor | "About 1 kilohm" of reactance at the test frequency (8:42; notes page 1); part values not given | 220 pF and 220 uH, standard values with 976 Ohm and 1024 Ohm of reactance at 741 kHz |
| Test frequency | Scope frequency readout at 8:25: 740.8 kHz | 741 kHz (`.param f=741k`) |
| Generator amplitude | Channel 1 at 8:25: about 3.4 div at 500 mV/div | 1.7 V p-p (0.85 V peak), with Rser = 50 Ohm as the generator's output resistance |

Each schematic runs `.tran 0 20u 0 1n`. The plots show the last 5 us, matching the 500 ns/div timebase on Alan's scope. Three `.meas` lines find the phase. `TV` and `TI` are the first rising zero crossings of `CH1` and `CH2` after 15.6 us, and `LEAD_DEG = (TV - TI) x f x 360` converts their time difference into degrees. A positive value means the current crosses zero, and so peaks, before the voltage. `CH1_PP` and `CH2_PP` give the two peak-to-peak amplitudes.

Each plot shows `V(ch1)` and `V(ch2)*10` in one pane. Scaling channel 2 by ten plays the role of Alan's more sensitive channel 2 setting: it puts both waves at a similar height so their timing can be compared. Labels mark each trace and the peaks to compare.

If the waveform window opens autoscaled or without the labels after you click **Run**, press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`.

## 01 - Current in a resistor

[Open the schematic](<01 - Current in a Resistor/Current in a Resistor.asc>) or [watch the setup from 6:57](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=417s).

![LTspice current in a resistor schematic](<01 - Current in a Resistor/Current in a resistor schematic.png>)

![LTspice voltage and current in a resistor](<01 - Current in a Resistor/Current in a resistor voltage and current.png>)

The two waves rise, peak and fall together, as on Alan's scope at 8:25. A resistor has no stored energy to delay the current, so Ohm's law holds at every instant.

![LTspice resistor measurements](<01 - Current in a Resistor/Current in a resistor SPICE output log.png>)

`LEAD_DEG` is 0 degrees (the residual 1e-8 is numerical noise). `CH1_PP` is 1.63 V and `CH2_PP` is 0.148 V. Their ratio is 11, the 1100 Ohm to 100 Ohm divider ratio.

## 02 - Current in a capacitor

[Open the schematic](<02 - Current in a Capacitor/Current in a Capacitor.asc>) or [watch from 8:40](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=520s).

![LTspice current in a capacitor schematic](<02 - Current in a Capacitor/Current in a capacitor schematic.png>)

![LTspice voltage and current in a capacitor](<02 - Current in a Capacitor/Current in a capacitor voltage and current.png>)

The current (`CH2`) reaches its peak 0.32 us before the applied voltage (`CH1`) reaches its own peak. This matches Alan's scope at 9:10: "the peak of that current is occurring before the peak of the voltage."

![LTspice capacitor measurements](<02 - Current in a Capacitor/Current in a capacitor SPICE output log.png>)

`LEAD_DEG` is +84.2 degrees. Across C1 alone the lead is exactly 90 degrees. Channel 1 also includes the 100 Ohm sense resistor, which pulls the measured angle down to arctan(976 / 100) = 84 degrees. That small error is why Alan keeps the sense resistor about ten times smaller than the reactance.

## 03 - Current in an inductor

[Open the schematic](<03 - Current in an Inductor/Current in an Inductor.asc>) or [watch from 9:38](https://www.youtube.com/watch?v=ykgmKOVkyW0&t=578s).

![LTspice current in an inductor schematic](<03 - Current in an Inductor/Current in an inductor schematic.png>)

![LTspice voltage and current in an inductor](<03 - Current in an Inductor/Current in an inductor voltage and current.png>)

Now the current peaks 0.32 us after the voltage, as on Alan's scope at 9:46.

![LTspice inductor measurements](<03 - Current in an Inductor/Current in an inductor SPICE output log.png>)

`LEAD_DEG` is -84.4 degrees: the current lags by 84 degrees in the measurement and by 90 degrees across L1 alone. L1 is an ideal inductor. A real coil's winding resistance would reduce the lag a little further.

## Circuit files

| File | Purpose |
| --- | --- |
| `01 - Current in a Resistor/Current in a Resistor.asc` and `.plt` | 1 kOhm resistor with the 100 Ohm current sense. |
| `02 - Current in a Capacitor/Current in a Capacitor.asc` and `.plt` | 220 pF capacitor (about 1 kOhm at 741 kHz). |
| `03 - Current in an Inductor/Current in an Inductor.asc` and `.plt` | 220 uH inductor (about 1 kOhm at 741 kHz). |
| `Video 054 - 01 - Current in a resistor.url` and the matching 02 and 03 shortcuts | Open the video where each part is measured. |

Video 055 continues from here, combining an inductor and a capacitor into series and parallel resonant circuits.
