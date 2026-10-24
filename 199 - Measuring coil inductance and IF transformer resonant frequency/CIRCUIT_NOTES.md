# Video 199: measuring coil inductance and IF transformer resonant frequency

Source: Alan Wolke (W2AEW), [#199: Measuring coil inductance and IF transformer resonant frequency](https://www.youtube.com/watch?v=Ff5xOENID7w). The instrument is not Alan's design. It is "The Coil Tester" by Michael A. Covington, N4TMI, published in 73 Magazine, September 1990, page 48, which Alan shows on camera and links in his description; Covington in turn adapted it from a cathode-coupled oscillator F. C. Alexander, Jr. described in QST for September 1946, crediting F. Butler.

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=Ff5xOENID7w&t=20s) | Holds up the 73 Magazine article the circuit comes from, and explains what the instrument is for: hang any LC circuit on it and it oscillates at that circuit's resonant frequency. |
| [1:52](https://www.youtube.com/watch?v=Ff5xOENID7w&t=112s) | Figure 1 of the article, close enough to read every value. This is the circuit built as [01 - Coil tester](<01 - Coil tester/>). |
| [2:20](https://www.youtube.com/watch?v=Ff5xOENID7w&t=140s) | The board he built on perfboard, with test leads out to the part under test and a scope probe on the output jack. |
| [4:22](https://www.youtube.com/watch?v=Ff5xOENID7w&t=262s) | The scope's frequency readout on his first coil, 7.3126 MHz. |
| [5:20](https://www.youtube.com/watch?v=Ff5xOENID7w&t=320s) | The ARRL L/C/F slide calculator, his quick way of turning a measured frequency and a known capacitance into an inductance. |
| [7:22](https://www.youtube.com/watch?v=Ff5xOENID7w&t=442s) | A different part under test, reading 13.451 MHz. |
| [7:50](https://www.youtube.com/watch?v=Ff5xOENID7w&t=470s) | An IF transformer on the input with the built-in capacitor switched out, reading 449.25 kHz. This is the part reproduced in [the second file](#parallel-tuned-circuit-with-the-built-in-capacitor-out). |
| [8:40](https://www.youtube.com/watch?v=Ff5xOENID7w&t=520s) | The first coil on an AADE L/C Meter IIB for an independent check, which reads `Lx= 3.152 uHy`. That is the inductance used in [the first file](#coil-with-the-built-in-capacitor-switched-in). |
| [10:08](https://www.youtube.com/watch?v=Ff5xOENID7w&t=608s) | Back near the first reading, 7.2822 MHz. |

## What the instrument is

The tester is a source-coupled JFET oscillator whose frequency is set entirely by whatever tuned circuit is clipped to its input. J1 is a source follower and J2 a common-gate stage; they share the source resistor R2, which is what couples them. C2 carries positive feedback from J2's drain back to J1's gate, and the tuned circuit on that gate is the only thing that makes the loop gain high enough to sustain oscillation. Put a tank on it and it runs at that tank's resonance, anywhere from below 20 kHz to above 20 MHz. The output, taken across R2, is a train of half sine waves rich in harmonics, which suits a frequency counter perfectly.

Covington's 18 V supply, two 9 V batteries in series, is deliberate: the headroom extends the frequency range and keeps the circuit working with low-Q tuned circuits. R3 isolates the output jack, because without it the capacitance of a long cable can stop the oscillation outright.

Two things about this chapter's fidelity are worth stating plainly. First, Alan says in his description that he changed some values because he used a different N-channel JFET than the article called for; he does not show his modified schematic, so these files are built from Figure 1 exactly as it appears on screen, with the article's 2N5245. Second, the 2N5245 is long obsolete and the model used here, in [LTspice/Models/Unverified/2N5245_standard_jft.lib](<../LTspice/Models/Unverified/2N5245_standard_jft.lib>), has no established provenance. Its parameters are representative of the part rather than a manufacturer's characterization, so treat the simulated amplitudes as indicative. The frequencies are another matter: they are set by L and C, not by the device.

The parts on the input are Alan's own. He measures his first coil on an AADE L/C Meter IIB at [8:40](https://www.youtube.com/watch?v=Ff5xOENID7w&t=520s), where the display reads `Lx= 3.152 uHy`, so that is the inductance in the first file and the tester's simulated frequency can be set against the 7.3124 MHz his scope reads at [4:22](https://www.youtube.com/watch?v=Ff5xOENID7w&t=262s). The IF transformer in the second file is reconstructed from the other direction: he reads 449.25 kHz off the scope at [7:50](https://www.youtube.com/watch?v=Ff5xOENID7w&t=470s) but never opens the can, so its 180 pF internal capacitor is the usual value for a 455 kHz can and the winding inductance follows from his frequency.

## Coil with the built-in capacitor switched in

[01 - Coil tester/Coil tester with the built-in capacitor.asc](<01 - Coil tester/Coil tester with the built-in capacitor.asc>)

![Coil tester with the built-in capacitor schematic](<01 - Coil tester/Coil tester with the built-in capacitor schematic.png>)

This is S1 closed, which is how an unknown coil gets measured: the known 150 pF goes across it, the oscillator runs, and the frequency gives the inductance. `Lx` is **3.152 uH**, the value Alan's L/C meter puts on his first coil, with `Rser=1.5` for a Q near 95 at 7 MHz. LTspice does not draw `Rser` on the symbol, so it is named in the schematic text as well.

The 18 V battery is written as a source that ramps in 1 microsecond rather than a fixed 18 V. That represents closing S2, and the step is what starts the loop; a tank with no initial disturbance will sit at its operating point indefinitely in a simulator. The `.meas` window opens at 150 microseconds, long after the amplitude has settled.

![Coil tester with the built-in capacitor waveforms](<01 - Coil tester/Coil tester with the built-in capacitor waveforms.png>)

The top pane is the tank itself, a clean 13.71 Vpp sine. The bottom pane is the output jack, and the difference between the two is the lesson about where you measure: the tank is almost sinusoidal because it is a resonator, while the output across R2 is the sum of two source currents and comes out as narrow positive humps. That shape is exactly what Covington photographed as Photo A, and it is why a counter has no trouble with it.

![Coil tester with the built-in capacitor SPICE output log](<01 - Coil tester/Coil tester with the built-in capacitor SPICE output log.png>)

`fosc` is taken from ten zero crossings of the tank and comes out at **7.2358 MHz**, against the **7.3124 MHz** Alan's scope reads on the same coil at [4:22](https://www.youtube.com/watch?v=Ff5xOENID7w&t=262s). The two agree to 1.0 percent, which is as close as this comparison can get: the model of the obsolete 2N5245 sets the device capacitances that pull the tank, and it has no established provenance.

The direction of the error is the same in both. The textbook value for 3.152 uH and 150 pF is 7.3190 MHz, and the simulation runs 1.1 percent below it, because the tank is not just L and C: J1's gate-source capacitance is about 3.4 pF, C2's 33 pF adds a share through the drain circuit, and together they put a few picofarads across the 150 pF. Alan's bench reading sits 0.09 percent below the same textbook figure, so his instrument has far less stray than this model gives it, but it has stray all the same.

That error runs the other way when you use the instrument. Reading 7.2358 MHz and solving for L with a clean 150 pF gives 3.225 uH for a coil the L/C meter says is 3.152 uH, a 2.3 percent over-read. This is the reason an instrument like this gets checked against a coil of known value first, and it is also why Alan reaches for the slide calculator rather than worrying about the last digit.

One detail of the simulation rather than the circuit: C3 is 0.04 uF into the 1 Meg of Rmon, a 40 millisecond time constant, so in a 200 microsecond run the coupling capacitor has barely begun to charge and the output still sits on a pedestal near 1 V. On the bench, after the instrument has been switched on for a second, that pedestal is gone. The frequency and the waveform shape are unaffected.

## Parallel tuned circuit with the built-in capacitor out

[01 - Coil tester/Coil tester on a parallel tuned circuit.asc](<01 - Coil tester/Coil tester on a parallel tuned circuit.asc>)

![Coil tester on a parallel tuned circuit schematic](<01 - Coil tester/Coil tester on a parallel tuned circuit schematic.png>)

This is S1 open, with the built-in 150 pF taken out of circuit. Covington's caption for Figure 1 says exactly what that is for: it "removes C1 from the circuit to enable testing of tuned circuits or self-resonant coils". An IF transformer already has its own capacitor inside the can, so adding another one would only drag the reading down. `Lif` and `Cif` are not parts of the tester; they are the tuned winding and internal capacitor of the transformer under test. The can Alan puts on the input at [7:50](https://www.youtube.com/watch?v=Ff5xOENID7w&t=470s) is never opened, so its 180 pF is the usual internal capacitor for a 455 kHz can and the 698.5 uH winding is what his 449.25 kHz reading implies with it. `Rser=24` gives a loaded Q near 80.

Wanting a parallel-tuned oscillator was Covington's reason for building this circuit in the first place. A series-tuned oscillator cannot test a ready-made tuned circuit, and it cannot find a coil's self-resonant frequency, where the coil is parallel-resonant with its own winding capacitance.

![Coil tester on a parallel tuned circuit waveforms](<01 - Coil tester/Coil tester on a parallel tuned circuit waveforms.png>)

Same two traces, and the same two shapes, 16 times slower. The oscillator does not care which decade it is working in; only the tank changed.

![Coil tester on a parallel tuned circuit SPICE output log](<01 - Coil tester/Coil tester on a parallel tuned circuit SPICE output log.png>)

`fosc` is **449.37 kHz**, which lands on the **449.25 kHz** Alan reads at [7:50](https://www.youtube.com/watch?v=Ff5xOENID7w&t=470s) to within 0.03 percent, and sits 0.12 percent above the textbook 448.83 kHz for 698.5 uH and 180 pF.

The contrast with the 1.1 percent error in the HF case is the practical point of the two files together, and it is the one place in this chapter where the simulation and the bench can be held side by side with confidence, because the frequency here is set by the tank rather than by the device model. The tester's few picofarads of stray are 2 percent of a 150 pF tank and almost nothing beside a 180 pF one, and the inductance is two hundred times larger, so the same instrument is far more accurate on a 455 kHz IF can than on a small HF coil. If the reading matters at HF, subtract the stray, or calibrate with a coil you already know.
