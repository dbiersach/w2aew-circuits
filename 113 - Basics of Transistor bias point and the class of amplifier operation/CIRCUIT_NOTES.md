# Video 113: Transistor bias point and amplifier class

Source: [Alan Wolke, video #113](https://www.youtube.com/watch?v=c6cmkm3UPUI). Alan's two-page [handwritten notes](W2AEW%20Video%20Notes%20-%20Bias_point_and_Class_of_operation.pdf) show the DC operating-point circuit and the AC-coupled amplifier. Both demonstrations use a 2N2222A NPN transistor. The LTspice schematics use the bundled `2N2222` model, so measured thresholds and gain can differ from Alan's device.

| Time | What Alan shows |
| --- | --- |
| [0:56](https://www.youtube.com/watch?v=c6cmkm3UPUI&t=56s) | [01 - Cutoff, active region, and saturation](#01---cutoff-active-region-and-saturation) |
| [7:10](https://www.youtube.com/watch?v=c6cmkm3UPUI&t=430s) | [02 - The bias point sets the conduction angle](#02---the-bias-point-sets-the-conduction-angle) |

After running either simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - Cutoff, active region, and saturation

[Open the operating-point segment at 0:56](https://www.youtube.com/watch?v=c6cmkm3UPUI&t=56s) · [Schematic](01%20-%20BJT%20DC%20operating%20regions/BJT%20DC%20operating%20regions.asc) · [Saved plot](01%20-%20BJT%20DC%20operating%20regions/BJT%20DC%20operating%20regions.plt)

Alan varies the DC base-bias supply of a 5 V common-emitter stage. His sketch specifies 3.9 kΩ from that supply to the base, 2.7 kΩ from base to ground, and 680 Ω in both the collector and emitter branches.

![LTspice DC operating-region schematic](01%20-%20BJT%20DC%20operating%20regions/BJT%20DC%20operating%20regions%20schematic.png)

The `.dc Vbias 0 12 0.02` analysis sweeps the *supply* feeding the divider, so the horizontal axis is the bias supply voltage and not the base voltage; the base sits at roughly four tenths of it. The sweep runs to 12 V so that the stage reaches saturation against its fixed 5 V collector supply. That upper limit is a simulation choice, not a bench setting Alan states.

![LTspice sweep of collector, base, and emitter voltages against the bias supply](01%20-%20BJT%20DC%20operating%20regions/BJT%20DC%20operating%20regions%20sweep.png)

The single pane carries all three node voltages against the bias supply, with the three operating regions labeled where they occur:

- **Cutoff**, below about 1.3 V of bias supply. No base current flows, the emitter sits at ground, and the collector rests at the full 5 V supply.
- **Active region**, from about 1.3 V to 7.9 V. Collector voltage falls almost linearly as base drive grows, while base and emitter rise together one diode drop apart. This is the region an amplifier is biased into.
- **Saturation**, above about 7.9 V. Collector voltage reaches its minimum near 2.57 V and then climbs again, tracking the emitter as the base-collector junction forward-biases. Beyond this point extra base drive produces no extra collector swing.

At 12 V of bias supply the base reaches 3.50 V, the collector 2.81 V and the emitter 2.79 V, so barely 30 mV separates collector from emitter: the transistor is a closed switch rather than an amplifier. Alan's scope discussion at about 3:52 to 5:03 walks through the same sequence on the bench.

## 02 - The bias point sets the conduction angle

[Open the amplifier-class circuit at 7:10](https://www.youtube.com/watch?v=c6cmkm3UPUI&t=430s) · [Schematic](02%20-%20Amplifier%20classes%20A%20B%20C/Amplifier%20classes%20A%20B%20C.asc) · [Saved plot](02%20-%20Amplifier%20classes%20A%20B%20C/Amplifier%20classes%20A%20B%20C.plt)

Alan couples a 2 V peak-to-peak, 10 kHz sine wave through 470 nF into the base. His second sketch shows a 4.7 kΩ base-to-ground resistor with 680 Ω collector and emitter resistors, and a resistor of changing value from +5 V to the base. The video uses 36 kΩ for approximately class B, 10 kΩ for class A, and disconnects that resistor altogether for class C.

![LTspice amplifier-class schematic](02%20-%20Amplifier%20classes%20A%20B%20C/Amplifier%20classes%20A%20B%20C%20schematic.png)

`.step param RTOP list 10k 36k 1G` runs those three conditions in one simulation, the 1 GΩ value standing in for the disconnected resistor. Keeping one wired circuit lets the three bias conditions be compared directly.

![Collector and base waveforms for the three bias settings](02%20-%20Amplifier%20classes%20A%20B%20C/Amplifier%20classes%20A%20B%20C%20waveforms.png)

The plot shows three cycles of the 10 kHz drive. The top pane holds collector voltage and the bottom pane base voltage, and each pane carries its own step legend, because LTspice assigns step colors independently in each pane: the 10 kΩ run is drawn blue above and green below. Read each pane against the legend printed inside it.

- **10 kΩ, class A.** The base idles near 1.55 V and the collector swings continuously between about 3.1 V and 5.0 V. The transistor conducts through the whole cycle, a conduction angle of about 360°.
- **36 kΩ, class B.** The base idles near 0.55 V. The collector sits flat at the 5 V supply for roughly half of each cycle and only falls to about 4.1 V on the conducting half: a conduction angle near 180°.
- **Open, class C.** With no path from +5 V the base idles at 0 V and swings negative. The collector leaves 5 V only for a short crest, giving a conduction angle well under 180° and a correspondingly small output.

The bottom pane shows why: raising the top resistor lowers the quiescent base voltage, so less of the incoming sine wave clears the base-emitter threshold. Class AB, which Alan also describes, lies between the first two conditions and has no separate bench setting in the video.

Alan increases the collector resistor during his class-C demonstration to make the output swing larger. This comparison holds the collector resistor at 680 Ω so that only the bias changes, so the class-C pulse height here should not be read as Alan's final class-C measurement. Neither stage has an output filter; Alan explains that a tuned RF load rejects the strong class-C harmonics and recovers a sinusoidal fundamental.
