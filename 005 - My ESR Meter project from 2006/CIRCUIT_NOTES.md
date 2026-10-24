# Video 005 - An ESR meter built in 2006

Source: Alan Wolke (W2AEW), [#5: My ESR Meter project from 2006](https://www.youtube.com/watch?v=bmYAgat-sOQ). He walks through his own hand-drawn schematic, which is kept here as [W2AEW Video Notes - W2AEW_ESRmeter.pdf](W2AEW%20Video%20Notes%20-%20W2AEW_ESRmeter.pdf), then shows the finished instrument measuring real capacitors.

| Time | What Alan shows |
| --- | --- |
| [0:10](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=10s) | The hand-drawn schematic, dated March 2006, which is the circuit in [01 - ESR meter](#01---esr-meter). |
| [1:00](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=60s) | The oscillator end of it: two 4049 inverters, then four more in parallel through 390 ohm resistors into a 10 ohm shunt. |
| [1:30](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=90s) | The rest of the chain: the transistor amplifier, the DC restore around the first AD8032 section, and the meter network. |
| [2:00](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=120s) | The enclosure the instrument lives in. |
| [2:30](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=150s) | The perfboard build, with the 4049 and its resistors visible. |
| [3:05](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=185s) | A closer look at the board, including the 8032. |
| [3:40](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=220s) | The front panel: a 0 to 200 microampere movement, the calibration knob, and the BNC. |
| [4:10](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=250s) | Connecting a capacitor to the BNC and watching the needle. |
| [6:20](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=380s) | The capacitor he is about to measure, held to the camera long enough to read the sleeve: a Rubycon KY series, 470 uF, 16 V. That is the part `Cdut` carries. |
| [7:25](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=445s) | The needle sitting near 100 microamperes with that capacitor on the test leads. |

## What the instrument measures

Every real capacitor has some resistance in series with its capacitance, its equivalent series resistance. At a high enough frequency the capacitance is nearly a short circuit and that resistance is most of what is left, so a meter that pushes a fast test signal through the part and looks at what comes back is really looking at the ESR.

Alan's circuit does exactly that, and the direction of its reading is worth getting straight before looking at the plot. The capacitor sits in series between the oscillator and a 100 ohm load, so the two form a divider. A perfect capacitor passes the test signal and the meter reads high; a capacitor with ESR drops part of it and the meter reads lower. The scale therefore runs backwards, with full deflection meaning a good part.

## 01 - ESR meter

Open [Alan drawing ESR meter.asc](01%20-%20ESR%20meter/Alan%20drawing%20ESR%20meter.asc); the [video shortcut](01%20-%20ESR%20meter/Video%20005%20-%2001%20-%20ESR%20meter.url) opens the drawing at [0:10](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=10s).

![LTspice schematic of the ESR meter](01%20-%20ESR%20meter/ESR%20meter%20schematic.png)

*Alan's circuit with his values, read left to right in the order he draws it: the two-inverter 4049 oscillator with its 47 k, 2.2 k and 0.001 uF, four more inverters paralleled through 390 ohm each, the 10 ohm shunt, the capacitor under test reached through the BNC, the 0.1 uF and 100 ohm sense load, the 2N2222 common-emitter stage, the diode-feedback DC restore around the first AD8032 section, the buffer and rectifier of the second, and the 4.7 k, 2.2 k and calibration network feeding the 200 microampere movement. The 9 V battery, switch and 7805 are drawn below, as he draws them.*

### What the simulation varies

`Resr` is stepped through 0.1, 1 and 10 ohm in series with a **470 uF** test capacitor. The capacitance is Alan's: at [6:20](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=380s) he turns the part he is measuring to the camera and the sleeve reads Rubycon KY, 470 uF, 16 V. The series resistance is the thing being varied, because that is what the instrument is for and no healthy capacitor would show all three values. `.tran 0 10m 8m 1u uic` runs for 10 ms and saves the last 2 ms, because the 0.1 uF smoothing capacitor and the meter network take several milliseconds to settle; measurements are taken over the final millisecond, by which time all three steps are steady.

![Meter current and sense voltage at three ESR values](01%20-%20ESR%20meter/ESR%20meter%20sweep.png)

*Sixty microseconds from the settled part of the run, with one trace per ESR value named in the step legend. The top pane is the current in the meter branch, which is what the needle shows, and it separates cleanly into three levels. The bottom pane is the sense voltage the capacitor divides down against the 100 ohm load, and its amplitude shrinks the same way. Both panes say the same thing: more ESR, less reading.*

![The measured frequency, sense voltage and meter current](01%20-%20ESR%20meter/ESR%20meter%20SPICE%20output%20log.png)

| Series resistance | Oscillator frequency | Sense voltage, peak to peak | Meter current |
| --- | --- | --- | --- |
| 0.1 ohm | 142.1 kHz | 172.7 mV | 149.2 uA |
| 1 ohm | 167.4 kHz | 169.1 mV | 142.5 uA |
| 10 ohm | 159.8 kHz | 131.7 mV | 86.8 uA |

The frequency is the first thing worth noticing. Alan's 47 k, 2.2 k and 0.001 uF put the 4049 oscillator between about 142 and 167 kHz, which is the right region for an ESR meter: at 150 kHz a 470 uF capacitor is two milliohms of reactance, so anything the meter sees is series resistance. The frequency moves with the part under test because the gates see a different load, and it moves most at the low-ESR step, where the capacitor is closest to a short across them.

The meter current then falls from 149 uA to 87 uA as the series resistance goes from 0.1 ohm to 10 ohm, against a 200 uA movement. That is the whole instrument in one line.

### Against Alan's bench

The part is now known, so the comparison can be made properly. At [7:25](https://www.youtube.com/watch?v=bmYAgat-sOQ&t=445s), with the 470 uF Rubycon KY on the leads, his needle sits close to **100 microamperes** on a 200 microampere movement, about half scale. The simulation with the same capacitance gives 149 uA at 0.1 ohm of series resistance and 143 uA at 1 ohm, so a healthy part of that size should be sitting nearer three quarters of scale here.

The gap is the calibration control, not the sensing. His front-panel knob sets where full scale falls and he turns it to suit the part and the battery; this model fixes that rheostat at 10 kohm because the drawing gives no setting, and that one resistor moves the meter current directly. Nothing else in the chain can account for a difference of that size when the capacitance matches. So read the table for its span and its direction, which do describe his instrument, and not for the absolute needle position, which only he can set.

## Models and assumptions

The 4049 is TI's CD4049UB model, kept in this folder with the symbol that wraps it. The op amp symbol is named for the AD8032 Alan draws, but the model behind it is LTspice's AD8031 section, which is the nearest part in the installed library; the two are not the same device, and the rectified levels depend on which one is used. The 7805 is a generic legacy model, and the switch is a 1 milliohm resistor.

Two numbers in the meter network are assumptions rather than Alan's: the movement is represented by a 1 kohm coil resistance, and the calibration rheostat is fixed at 10 kohm. His drawing marks the movement as 200 uA full scale but gives neither its coil resistance nor a rheostat setting, and those two choices move the meter current directly. The test capacitor is no longer among them, because he shows it on camera. Read the table as a demonstration of the sensing principle and its direction, not as a calibration of his instrument.

After pressing Run, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window opens autoscaled instead of showing the saved panes; the stepped run otherwise arrives with all three steps overlaid.
