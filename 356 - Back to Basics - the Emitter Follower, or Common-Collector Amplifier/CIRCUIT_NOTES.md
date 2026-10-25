# Video 356: Back to Basics: the Emitter Follower, or Common-Collector Amplifier

Source: [Alan Wolke (W2AEW), video 356](https://www.youtube.com/watch?v=8f-nhjQ1jMk). The circuits are also drawn in [Alan's handwritten notes](W2AEW%20Video%20Notes%20-%20Basics_of_emitter_follower.pdf), especially pages 5 through 8.

| Time | What Alan shows |
| --- | --- |
| [2:46](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=166s) | [01 - Basic emitter follower](#01---basic-emitter-follower) |
| [11:08](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=668s) | [02 - Common-emitter driver and loaded follower](#02---common-emitter-driver-and-loaded-follower) |
| [16:12](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=972s) | [03 - AC-coupled 16 ohm speaker load](#03---ac-coupled-16-ohm-speaker-load) |
| [18:11](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=1091s) | [04 - Complementary push-pull followers](#04---complementary-push-pull-followers) |
| [20:22](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=1222s) | [05 - Negative clipping limit of a single NPN](#05---negative-clipping-limit-of-a-single-npn) |

An emitter follower takes its output from the transistor's emitter. As the base voltage changes, the emitter moves in the same direction, usually about one base-emitter junction drop below the base for an NPN transistor that is conducting. Its voltage gain is a little less than one. Its value is current drive: the output can supply much more current than the preceding signal source provides to the base. The transistor still needs the right DC bias and enough current capability for the load.

## 01 - Basic emitter follower

[Watch the circuit introduction at 2:46](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=166s) | [Open the zero-bias schematic](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower.asc) | [Open its plot settings](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower.plt)

[Open the DC-biased schematic](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower%20DC%20biased.asc) | [Open its plot settings](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower%20DC%20biased.plt)

Alan uses a 9 V collector supply, a 2N2222A NPN transistor, a 1 kΩ emitter resistor, and a 1 kHz generator set to 1 V peak to peak. He varies the generator's DC offset. The two LTspice files keep the same topology and show the offset settings in separate plots. LTspice's built-in 2N2222 is a documented substitute for the 2N2222A in Alan's notes. The 1.5 V offset is an illustrative setting for Alan's adjustable control.

**Zero offset.** The magenta input, `V(in)`, swings from -0.5 V to +0.5 V. That is below the roughly 0.6 to 0.7 V needed to turn Q1 on. The green emitter output, `V(out)`, stays nearly at 0 V because the 1 kΩ emitter resistor connects it to ground. The flat output is the point of this first plot: without suitable DC bias, this NPN follower does not reproduce the small input signal.

![Zero-bias emitter follower schematic copied from LTspice](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower%20schematic.png)

![Zero-bias emitter follower waveforms copied from LTspice](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower%20waveforms.png)

**With 1.5 V DC offset.** The magenta input now swings from 1.0 V to 2.0 V, so Q1 conducts throughout the cycle. The green emitter output swings at approximately the same amplitude, about one base-emitter drop below the input. The output is not an amplified voltage; it follows the input at a lower DC level. Compare this plot with the flat zero-offset output above. Both plots show one offset setting only, so no color or curve represents a hidden simulation step.

![DC-biased emitter follower schematic copied from LTspice](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower%20DC%20biased%20schematic.png)

![DC-biased emitter follower waveforms copied from LTspice](01%20-%20Basic%20emitter%20follower/Basic%20emitter%20follower%20DC%20biased%20waveforms.png)

## 02 - Common-emitter driver and loaded follower

[Watch the circuit introduction at 11:08](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=668s) | [Open the schematic](02%20-%20CE%20driver%20and%20loaded%20follower/CE%20driver%20and%20loaded%20follower.asc) | [Open its saved plot settings](02%20-%20CE%20driver%20and%20loaded%20follower/CE%20driver%20and%20loaded%20follower.plt)

Alan's page 7 circuit sends a 1 V peak-to-peak, 1 kHz input through 2.2 µF into a common-emitter stage. The 27 kΩ and 10 kΩ resistors bias its base; the collector and emitter resistors are 10 kΩ and 4.7 kΩ. Its collector drives the base of a second NPN, which has a 1 kΩ emitter resistor. Alan then attaches a 100 Ω external load. The first LTspice step sets `RL=1T`, an effectively open external load, so only the 1 kΩ emitter resistor remains. The second sets `RL=100` to reproduce Alan's added load. This distinction matters because a 1 kΩ external resistor in the baseline would already load the follower.

![Common-emitter driver and loaded follower schematic copied from LTspice](02%20-%20CE%20driver%20and%20loaded%20follower/CE%20driver%20and%20loaded%20follower%20schematic.png)

The plot uses green for the common-emitter collector, `V(ce_out)`, and blue for the follower emitter, `V(out)`. **The upper green/blue pair is the effectively unloaded `RL=1T` step. The lower pair is the `RL=100 Ω` step.** Adding 100 Ω pulls down both the follower's DC level and its available output swing. The collector node also changes because the follower draws more base current from the preceding stage. Each color identifies a node, while upper versus lower identifies the load case.

![Unloaded and 100 ohm loaded follower waveforms copied from LTspice](02%20-%20CE%20driver%20and%20loaded%20follower/CE%20driver%20and%20loaded%20follower%20waveforms.png)

## 03 - AC-coupled 16 ohm speaker load

[Watch the speaker circuit introduction at 16:12](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=972s) | [Open the schematic](03%20-%20AC%20coupled%20speaker%20load/AC%20coupled%20speaker%20load.asc) | [Open its saved plot settings](03%20-%20AC%20coupled%20speaker%20load/AC%20coupled%20speaker%20load.plt)

Alan's page 8 circuit keeps the single NPN follower and 1 kΩ emitter resistor, then couples the emitter through 47 µF to a 16 Ω speaker. The generator is 2 V peak to peak at 1 kHz. **Alan begins with a 1.0 V offset, raises it to about 1.7 V so the unloaded emitter follows properly, and only then connects the 16 Ω load.** The saved schematic uses the loaded test's approximately 1.7 V offset. Its 16 Ω resistor models the speaker's nominal electrical load, without speaker inductance or acoustics.

![AC-coupled speaker-load schematic copied from LTspice](03%20-%20AC%20coupled%20speaker%20load/AC%20coupled%20speaker%20load%20schematic.png)

The **top pane** is the voltage across the speaker, `V(speaker)`. It contains small positive pulses rather than a complete sine wave. The **lower pane** compares the magenta generator `V(in)` with the red transistor emitter `V(emitter)`. The input still makes a full sine wave, but the emitter stays close to its bias voltage for much of the cycle under the heavy load. The coupling capacitor removes DC from the speaker; it does not give the single NPN the ability to sink the speaker current required for a symmetric AC waveform.

![Speaker voltage above input and emitter voltages, copied from LTspice](03%20-%20AC%20coupled%20speaker%20load/AC%20coupled%20speaker%20load%20waveforms.png)

## 04 - Complementary push-pull followers

[Watch the push-pull introduction at 18:11](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=1091s) | [Open the schematic](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower.asc) | [Open its saved plot settings](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower.plt)

Alan's second page 8 drawing adds a PNP below the NPN. The generator drives their tied bases directly, their emitters share the output node, and the same 47 µF capacitor feeds the 16 Ω load. The NPN supplies current on one half-cycle; the PNP provides a path to sink current on the other. This schematic uses the same 2 V peak-to-peak, 1 kHz input with approximately 1.7 V offset as the preceding speaker demonstration.

![Complementary push-pull follower schematic copied from LTspice](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower%20schematic.png)

The **top pane** is `V(speaker)`. Unlike circuit 03, it now has both positive and negative pulses. Its flat stretch near zero is crossover distortion: around that point, neither transistor has enough base-emitter voltage to conduct strongly. The **lower pane** shows the full sine-wave input, `V(in)`, so the missing portions of the output are easy to see. Alan does not draw a corrected bias circuit in this video. On page 8 of his notes, he points to his separate video about the VBE multiplier as an example of correcting crossover distortion.

![Push-pull speaker voltage and input copied from LTspice](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower%20waveforms.png)

### Optional VBE multiplier extension

[Open the separate VBE-biased schematic](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower%20Vbe%20bias.asc) | [Open its saved plot settings](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower%20Vbe%20bias.plt) | [Watch Alan introduce this bias method in video 198 at 9:47](https://www.youtube.com/watch?v=Obh_PIC2qqo&t=587s)

This second schematic is an **extension**, not a circuit shown in video 356. It adapts the output-bias arrangement in Alan's video 198 to this chapter's 9 V supply, 47 µF output capacitor, and 16 Ω load. It uses a 50 mV peak, 1 kHz input and a common-emitter gain stage to drive the bias circuit. Those input and driver choices differ from the tied-base demonstration above, so the two output amplitudes are not a direct gain comparison. The NPN output device is LTspice's 2N2222 substitute; the PNP is the same illustrative 2N3906 used in the baseline. Each output emitter has a 10 Ω resistor, following the video 198 bias example.

![Optional VBE multiplier push-pull schematic copied from LTspice](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower%20Vbe%20bias%20schematic.png)

The tied-base circuit leaves both transistors nearly off while the signal crosses zero. In the extension, `QMULT`, `RTOP`, and `RBOT` form a VBE multiplier with fixed 1 kΩ and 820 Ω resistors. They hold the NPN base above the PNP base by about **1.468 V** on average. This provides roughly one forward junction drop for each output transistor, allowing both to conduct lightly near the zero crossing. The two 10 Ω emitter resistors limit current and provide local negative feedback: rising transistor current increases the resistor drop, which reduces that transistor's effective base-emitter drive. Too little base-to-base bias brings back the notch; too much wastes power and can overheat the transistors. A practical build also needs bias adjustment and thermal tracking of the output devices.

In the LTspice plot, the **top green trace** is the voltage across the 16 Ω load, `V(load_out)`. It now passes smoothly through zero, without the broad flat dead band of the original plot. The **lower magenta trace** is the voltage from `UPPER_BASE` to `LOWER_BASE`; its small variation about 1.468 V reflects signal-dependent operation of the bias stage. The plotted time is the final 5 ms of the 10 ms run. LTspice reports `VBIAS_AVG = 1.46799591386 V`, `ISUPPLY_AVG = 8.12771908613 mA`, and approximately **2.00% total harmonic distortion** for `V(load_out)` at 1 kHz. A smooth crossing does not imply zero distortion; the remaining distortion includes the complete driver and output stage.

![VBE-biased speaker waveform and base-to-base voltage copied from LTspice](04%20-%20Complementary%20push-pull%20follower/Complementary%20push-pull%20follower%20Vbe%20bias%20waveforms.png)

## 05 - Negative clipping limit of a single NPN

[Watch Alan's final circuit at 20:22](https://www.youtube.com/watch?v=8f-nhjQ1jMk&t=1222s) | [Open the schematic](05%20-%20Negative%20clipping%20limit/Negative%20clipping%20limit.asc) | [Open its saved plot settings](05%20-%20Negative%20clipping%20limit/Negative%20clipping%20limit.plt)

Page 5 of Alan's handwritten notes shows an NPN with its collector at +10 V, a 1 kΩ emitter resistor to -10 V, and a 1 kΩ load from the emitter output to ground. The input is intended to reach approximately +10 V and -10 V. The saved 1 kHz sine source is a simulation choice to show several cycles; its frequency does not determine the clipping voltage.

![Negative-clipping emitter follower schematic copied from LTspice](05%20-%20Negative%20clipping%20limit/Negative%20clipping%20limit%20schematic.png)

Follow the negative half-cycle step by step:

1. As the base goes negative, the emitter initially follows.
2. The NPN turns off when it can no longer supply current into the emitter node. A lone NPN follower cannot pull that node farther negative by sinking current.
3. With the transistor off, the two 1 kΩ resistors form a divider from ground to -10 V. Because they are equal, their junction, `OUT`, sits at -5 V.
4. The input keeps falling toward -10 V, but the output stays near -5 V. That is the flat bottom of the green output trace. The magenta input trace continues to -10 V.

![Negative output clipping near -5 V, copied from LTspice](05%20-%20Negative%20clipping%20limit/Negative%20clipping%20limit%20waveforms.png)

LTspice's `.meas tran VOUT_MIN MIN V(OUT)` reports `vout_min = -5.00079679489 V`. The small difference from exactly -5 V comes from the transistor model and transient solution; the resistor-divider explanation predicts the limiting level.

![Only the VOUT_MIN result line from the LTspice SPICE output log](05%20-%20Negative%20clipping%20limit/Negative%20clipping%20limit%20SPICE%20output%20log.png)

## Models and interpretation

Alan's NPN is a **2N2222A**. LTspice's bundled **2N2222** is used here as a declared substitute, so exact current and voltage levels can differ from his physical transistor. Alan does not specify a PNP part number for circuit 04; LTspice's bundled **2N3906** is an illustrative complement. The 16 Ω speaker is an ideal resistor in circuits 03 and 04. These simulations reproduce the connections and the lesson, while omitting the speaker's inductance, mechanical behavior, and acoustic output.
