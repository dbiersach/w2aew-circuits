# W2AEW Videos in LTspice

Alan Wolke teaches electronics on [his W2AEW channel](https://www.youtube.com/@w2aew) with a sketch, a breadboard and a bench full of instruments. This repository rebuilds those circuits in LTspice, so you can run one yourself, change a value and watch what it does.

LTspice can simulate the power supplies, meters, oscilloscopes, and spectrum displays that Alan uses. The notes in each chapter connect the simulated results to his measurements and explain where the model differs from his hardware. This does not replace watching him explain the material; it simply lets you construct the same circuit even if you don't have the equipment.

If you haven't subscribed to [Alan's channel](https://www.youtube.com/@w2aew) yet, you should. More than 230,000 people already have, and with over 400 videos, it's easy to see why. He explains things clearly, takes his time, and knows his stuff. He makes you appreciate electronics, ham radio, and how to get the most out of test and diagnostic gear.

## What to expect

Video 167 is a fair sample of what a chapter holds. Alan builds a diode ring mixer on the bench and shows why it hands you the sum and difference of its two inputs. The same ring is drawn here in LTspice, driven by his 7 MHz local oscillator and 10 MHz RF.

![Diode ring mixer schematic copied from LTspice](<167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20spectrum%20schematic.png>)

*Four Schottky diodes in a ring between two center-tapped transformers, with the IF taken from the RF winding's center tap. Every part on the drawing is one you could wire up.*

![LTspice FFT of the mixer, with the 3 MHz difference, 7 MHz LO, 10 MHz RF and 17 MHz sum peaks labeled](<167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20LO%20RF%20and%20IF%20spectrum.png>)

*An FFT of that circuit. The local oscillator stands at 7 MHz and the RF at 10 MHz, while the IF output carries their 3 MHz difference and 17 MHz sum, which is what a mixer is for. Its [chapter notes](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/CIRCUIT_NOTES.md) identify each marked peak and separate Alan's values from the modeling assumptions.*

## Get started

1. Install [LTspice](https://www.analog.com/en/resources/design-tools-and-calculators/LTspice-simulator.html). It is free, and every schematic here is a plain `.asc` file.
2. Download or clone the repository and leave the folders where they are. Some schematics reach into the shared [LTspice folder](LTspice/README.md) by relative path, so rearranging things will break them.
3. Pick a video from the table at the bottom, then read that folder's `CIRCUIT_NOTES.md` alongside it.
4. Open a circuit's `.asc` and press **Run**. If the waveform window comes up autoscaled, press **Ctrl+Space** to load the view saved in the `.plt` file beside the schematic; stepped runs nearly always need this. Chapters that build an FFT say what else to do.

You only need LTspice if you want to run something. The notes and the captured plots read perfectly well on their own.

## How the repository is organized

Every video gets a numbered folder, and the `CIRCUIT_NOTES.md` inside it is the guide. It links to the video, says what the circuit is for, walks through what the simulation produces, and flags the assumptions worth knowing about before you compare any of it with Alan's bench. His own [video index PDF](W2AEW_video_index.pdf) is here as well.

Numbered subfolders such as `01 - Diode ring mixer/` hold the circuits in the order they appear in the video. Each circuit has at least one LTspice `.asc` schematic, PNG images captured from LTspice for the schematic and relevant plots, and a time-coded video link that takes you to the point where Alan introduces it. A circuit may have more than one `.asc` file when separate simulation views are useful, plus `.plt` plot settings and the `.log` holding its measured results. Waveform files are not stored here, so running a circuit writes its own `.raw`. The symbols and third-party models the schematics need are collected under [`LTspice/`](<LTspice/>). For example, [video 167's diode-ring mixer](<167 - How a Diode Ring Mixer works - Mixer operation theory and measurement/01 - Diode ring mixer/>) links to its demonstration [from 0:00](https://www.youtube.com/watch?v=junuEwmQVQ8&t=0s) and contains transient and spectrum examples. An optional alternative transformer model sits in its own clearly named subfolder.

| Chapter component | Video 167 example | Purpose |
| --- | --- | --- |
| Chapter guide | [CIRCUIT_NOTES.md](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/CIRCUIT_NOTES.md) | Explains the video, circuit operation, plots, results, and model assumptions. |
| Video and source notes | [video shortcut](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/Video%20167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement.url) and [Alan's handwritten PDF](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/W2AEW%20Video%20Notes%20-%20Diode_ring_mixer_operation.pdf) | Links to Alan's demonstration and provides his original notes when available. |
| Numbered circuit folder | [01 - Diode ring mixer/](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/) | Groups the files for the first circuit shown in the video. |
| Editable LTspice schematics | [transient .asc](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20conversion%20example.asc) and [spectrum .asc](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20spectrum.asc) | Run the circuit and inspect the time-domain or FFT setup. |
| LTspice PNG captures | [schematic](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20schematic.png), [transient](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%201%20us%20transient.png), and [FFT](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20LO%20RF%20and%20IF%20spectrum.png) | Show the circuit and representative results without opening LTspice. |
| Saved plot settings | [conversion example .plt](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20conversion%20example.plt) | Restores the selected traces and display settings for a simulation. |
| Circuit introduction link | [time-coded .url](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Video%20167%20-%2001%20-%20Diode%20ring%20mixer.url) ([watch from 0:00](https://www.youtube.com/watch?v=junuEwmQVQ8&t=0s)) | Jumps to the point where Alan introduces this circuit. |
| Optional variant | [Alternative T1-6T-X65+ model/](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Alternative%20T1-6T-X65%2B%20model/) | Keeps an illustrative transformer variation separate from the main circuit. |

Video 185 shows how a chapter with several circuits is arranged: [fixed base bias](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/01 - Fixed base bias/>), [collector feedback bias](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/02 - Collector feedback bias/>), and [voltage divider bias](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/03 - Voltage divider bias/>). Its [chapter notes](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/CIRCUIT_NOTES.md>) link to the point where Alan introduces each circuit.

The PNGs are there so you can see a result without opening anything, and the `.asc` files are there so you can change a value and watch it move. What comes back depends on the device models and the test conditions, so read the notes before taking a simulated number as Alan's.

## Quick reference card

[`ltspice-keyboard-shortcuts.pdf`](<ltspice-keyboard-shortcuts.pdf>) is Analog Devices' four-page quick-reference card for LTspice 26. Everything here is drawn and run in that editor, so it is worth keeping open: shortcuts for the schematic and waveform windows, the SPICE directives and netlist line types, the simulation commands, and the `.options` parameters.

Two entries on it are worth reading before typing any component value. LTspice parses suffixes case insensitively, so **`M` means milli and mega must be written `MEG`**, and a bare **`F` means femto rather than farad**. Both mistakes simulate without complaint and are wrong by orders of magnitude. A unit may follow the prefix and is ignored, so `10nF` is safe; only a bare `F` or `M` straight after the number is a trap.

The card is copyright Analog Devices.

## Mistakes, feedback, and pull requests

There are almost certainly mistakes in here.

I put these circuits together by watching Alan's videos and working from his notes, so sometimes I will simply have missed his point. A schematic can match his drawing and still be a poor illustration of what he is demonstrating. I can misread a value off the bench. A chapter can explain something clearly and confidently and still have it wrong. I am not an LTspice expert either, and a simulation that runs and draws a believable-looking plot is no proof that I have set the circuit up the way Alan sets up his.

So if the video and this repository ever disagree, trust Alan. The mistake will be mine.

I would genuinely like to hear about it when that happens. If something looks wrong, or you know a better way to model it, or an explanation just does not make sense, open an issue and say so. If you would rather fix it yourself, even better: clone the repository, make the change, and send a pull request. I will read every one. Schematics, chapter notes, plots, model assumptions, anything at all.

## Videos

| Alan's YouTube video | Folder in this repository |
| --- | --- |
| [#5: My ESR Meter project from 2006](https://www.youtube.com/watch?v=bmYAgat-sOQ) | [Video 005 folder](<005 - My ESR Meter project from 2006/>) |
| [#7: Monitor your Ham Radio transmitter with an oscilloscope](https://www.youtube.com/watch?v=y4Zt_LJX1Tc) | [Video 007 folder](<007 - Monitor your Ham Radio transmitter with an oscilloscope/>) |
| [#10: AC / DC Coupling on an Oscilloscope](https://www.youtube.com/watch?v=Hkq-fvb5-NI) | [Video 010 folder](<010 - AC-DC Coupling on an Oscilloscope/>) |
| [#25: Analog Oscilloscope bandwidth considerations](https://www.youtube.com/watch?v=oZ1Dv2dVGkU) | [Video 025 folder](<025 - Analog Oscilloscope bandwidth considerations/>) |
| [#31: Analog oscilloscope ALT, CHOP, ADD, INVERT vertical controls](https://www.youtube.com/watch?v=zsy-pxpfB4o) | [Video 031 folder](<031 - Analog oscilloscope - ALT, CHOP, ADD, INVERT vertical controls/>) |
| [#54: Back to Basics Tutorial: Voltage / Current in capacitors and inductors](https://www.youtube.com/watch?v=ykgmKOVkyW0) | [Video 054 folder](<054 - Back to Basics Tutorial - Current in Capacitors and Inductors/>) |
| [#55: Back to Basics: Tutorial on LC Resonant Circuits](https://www.youtube.com/watch?v=hqhV50852jA) | [Video 055 folder](<055 - Back to Basics Tutorial - LC Resonant Circuits/>) |
| [#56: Basics of Capacitor & Inductor self-resonance, parasitics, etc. - Tutorial](https://www.youtube.com/watch?v=vi24SpKYYoQ) | [Video 056 folder](<056 - Basics of Capacitor & Inductor self-resonance, parasitics, etc. - Tutorial/>) |
| [#60: Basics of Phase Locked Loop Circuits and Frequency Synthesis](https://www.youtube.com/watch?v=SS7z8WsXPMk) | [Video 060 folder](<060 - Basics of Phase Locked Loop Circuits and Frequency Synthesis/>) |
| [#61: Basics of RF Samplers, Sampling-Tees, RF-taps, etc.](https://www.youtube.com/watch?v=0Kk_N_TpDeo) | [Video 061 folder](<061 - Basics of RF Samplers, Sampling-Tees, RF-taps, etc/>) |
| [#67: Basics of Common Emitter Amplifier Gain and Frequency Response with Measurements](https://www.youtube.com/watch?v=NizrzRKQqII) | [Video 067 folder](<067 - Basics of Common Emitter Amplifier Gain and Frequency Response/>) |
| [#75: Basics of Opamp circuits - a tutorial on how to understand most opamp circuits](https://www.youtube.com/watch?v=K03Rom3Cs28) | [Video 075 folder](<075 - Basics of Op Amp Circuits/>) |
| [#77: Op Amp Peak Detector Tutorial, with peak detector basics](https://www.youtube.com/watch?v=Fn5kHhNRsz0) | [Video 077 folder](<077 - Op Amp Peak Detector Tutorial, with peak detector basics/>) |
| [#79: Op Amp Power Supply Considerations: split, single, virtual ground, etc. - a tutorial](https://www.youtube.com/watch?v=MtccB9K09ck) | [Video 079 folder](<079 - Op Amp Power Supply Considerations/>) |
| [#82: How to use a Diode as a Switch / Diodes as Switches / Basics of Diode Switches](https://www.youtube.com/watch?v=YBNIq_d56sA) | [Video 082 folder](<082 - Basics of Diode Switches - How to use a Diode as a Switch/>) |
| [#83: Basics of RF Mixers in Radio Receivers / Mixer Tutorial / Frequency Conversion](https://www.youtube.com/watch?v=Mm7WfVzr1ao) | [Video 083 folder](<083 - Basics of RF Mixers in Radio Receivers/>) |
| [#84: Basics of Ferrite Beads: Filters, EMI Suppression, Parasitic oscillation suppression / Tutorial](https://www.youtube.com/watch?v=81C4IfONt3o) | [Video 084 folder](<084 - Basics of Ferrite Beads - Filters, EMI Suppression, Parasitic oscillation suppression - Tutorial/>) |
| [#85: Basics of R2R Ladder DAC &#124; Digital Analog Conversion, Tutorial R-2R DAC Thevenin Superposition](https://www.youtube.com/watch?v=AulX1OM7RwE) | [Video 085 folder](<085 - Basics of R2R Ladder DAC/>) |
| [#87: Schmitt Trigger Oscillator / Tutorial / 74AC14 Inverter / squarewave generator](https://www.youtube.com/watch?v=NuXitMK3HSA) | [Video 087 folder](<087 - Schmitt Trigger Oscillator - Tutorial - 74AC14 Inverter - squarewave generator/>) |
| [#90: Measure Capacitors and Inductors with an Oscilloscope and some basic parts](https://www.youtube.com/watch?v=74fz9iwZ_sM) | [Video 090 folder](<090 - Measure Capacitors and Inductors with an Oscilloscope and some basic parts/>) |
| [#100: Capacitor self-resonance measured with an oscilloscope and signal generator - how to tutorial](https://www.youtube.com/watch?v=C3wYMZ_cjdQ) | [Video 100 folder](<100 - Capacitor self-resonance measured with an oscilloscope and signal generator - how to tutorial/>) |
| [#104: Circuit tutorial: sawtooth generator w/ current sources, diode switches, hysteresis comparator](https://www.youtube.com/watch?v=ibnz5UjQ4u0) | [Video 104 folder](<104 - Circuit tutorial - sawtooth generator with current sources, diode switches, hysteresis comparator/>) |
| [#105: More Circuit Fun: Simple 3 transistor sawtooth generator / oscillator](https://www.youtube.com/watch?v=2a1I1X3RV0g) | [Video 105 folder](<105 - More Circuit Fun - Simple 3 transistor sawtooth generator - oscillator/>) |
| [#110: Circuit Fun: Flexible Ramp Generator to create frequency sweeps using 555 timer and op amps](https://www.youtube.com/watch?v=bVahBmsvirE) | [Video 110 folder](<110 - Circuit Fun - Flexible Ramp Generator to create frequency sweeps using 555 timer and op amps/>) |
| [#113: Basics of Transistor bias point and the class of amplifier operation](https://www.youtube.com/watch?v=c6cmkm3UPUI) | [Video 113 folder](<113 - Basics of Transistor bias point and the class of amplifier operation/>) |
| [#114: Tutorial: Common Emitter, Common Collector, and Common Base Transistor amplifiers](https://www.youtube.com/watch?v=zXh5gMc6kyU) | [Video 114 folder](<114 - Common Emitter, Common Collector, and Common Base Amplifiers/>) |
| [#118: Basics of PIN diodes and their use in RF switch applications](https://www.youtube.com/watch?v=XpYsCM_Wf50) | [Video 118 folder](<118 - Basics of PIN diodes and their use in RF switch applications/>) |
| [#131: How to test transistors - NPN and PNP bipolar junction transistors, BJTs](https://www.youtube.com/watch?v=qM7_h8my8eA) | [Video 131 folder](<131 - How to test transistors - NPN and PNP bipolar junction transistors, BJTs/>) |
| [#140: Basics of an Op Amp Summing Amplifier](https://www.youtube.com/watch?v=juQtVIx1a8g) | [Video 140 folder](<140 - Basics of an Op Amp Summing Amplifier/>) |
| [#147: Basics of Varactor Diodes &#124; Voltage Controlled Oscillator VCO Example](https://www.youtube.com/watch?v=icw8terKP-M) | [Video 147 folder](<147 - Basics of Varactor Diodes - Voltage Controlled Oscillator VCO Example/>) |
| [#155: Circuit Fun: Auto-ranging Analog Voltmeter for a variable power supply](https://www.youtube.com/watch?v=7OLGswQ7ICI) | [Video 155 folder](<155 - Circuit Fun - Auto-ranging Analog Voltmeter for a variable power supply/>) |
| [#157: Circuit fun: Automatic audio leveling circuit &#124; audio compressor &#124; for scanning receiver](https://www.youtube.com/watch?v=1h0FZJYXQ_w) | [Video 157 folder](<157 - Circuit fun - Automatic audio leveling circuit - audio compressor - for scanning receiver/>) |
| [#161: Circuit Fun: a simple RF detector / demodulator probe for DMM or scope](https://www.youtube.com/watch?v=C8SKiyJUAlU) | [Video 161 folder](<161 - Circuit Fun - a simple RF detector - demodulator probe for DMM or scope/>) |
| [#167: How a Diode Ring Mixer works &#124; Mixer operation theory and measurement](https://www.youtube.com/watch?v=junuEwmQVQ8) | [Video 167 folder](<167 - How a Diode Ring Mixer works - Mixer operation theory and measurement/>) |
| [#172: Basics of Op Amp Gain Bandwidth Product and Slew Rate Limit](https://www.youtube.com/watch?v=UooUGC7tNRg) | [Video 172 folder](<172 - Basics of Op Amp Gain Bandwidth Product and Slew Rate Limit/>) |
| [#183: Why diodes are used around relay coils: Back to Basics on flyback or snubber diodes](https://www.youtube.com/watch?v=c6I7Ycbv8B8) | [Video 183 folder](<183 - Why diodes are used around relay coils - Back to Basics on flyback or snubber diodes/>) |
| [#185: Back to Basics: Bipolar Transistor bias circuits and Beta dependence](https://www.youtube.com/watch?v=YQlbPGNB-ys) | [Video 185 folder](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/>) |
| [#186: Circuit Fun: Control an RC Servo with an adjustable DC voltage](https://www.youtube.com/watch?v=iaGZOO33Z-o) | [Video 186 folder](<186 - Circuit Fun - Control an RC Servo with an adjustable DC voltage/>) |
| [#190: Back to Basics: Transistor Current Sources and Mirrors](https://www.youtube.com/watch?v=xR0RfmmRhDw) | [Video 190 folder](<190 - Back to Basics - Transistor Current Sources and Mirrors/>) |
| [#191: Beware of test equipment loading effects!! Learn from my error!](https://www.youtube.com/watch?v=JbCI4Lsnqho) | [Video 191 folder](<191 - Beware of test equipment loading effects!! Learn from my error!/>) |
| [#193: Back to Basics: the differential amplifier, aka long-tailed pair, diff-pair](https://www.youtube.com/watch?v=mejPNuPAHBY) | [Video 193 folder](<193 - Back to Basics - the differential amplifier aka long-tailed pair diff-pair/>) |
| [#197:Simple V-I curve tracer using an oscilloscope and function generator](https://www.youtube.com/watch?v=WWY-pakm_OM) | [Video 197 folder](<197 - Simple V-I curve tracer using an oscilloscope and function generator/>) |
| [#198: Basics of a Vbe Multiplier: what it is, how it works & where it is used](https://www.youtube.com/watch?v=Obh_PIC2qqo) | [Video 198 folder](<198 - Basics of a Vbe Multiplier - what it is, how it works & where it is used/>) |
| [#200: T/R Switch w/ PIN Diodes and Lumped Element Quarter-wavelength transmission line](https://www.youtube.com/watch?v=A1BAq0KxIdc) | [Video 200 folder](<200 - T-R Switch with PIN Diodes and Lumped Element Quarter-wavelength transmission line/>) |
| [#207: Basics of a Cascode Amplifier and the Miller Effect](https://www.youtube.com/watch?v=Op_I3Ke7px0) | [Video 207 folder](<207 - Basics of a Cascode Amplifier and the Miller Effect/>) |
| [#216: Back to Basics: 555 based monostable multivibrator &#124; 555 tutorial](https://www.youtube.com/watch?v=MbWc70ZzTlI) | [Video 216 folder](<216 - Back to Basics - 555 based monostable multivibrator - 555 tutorial/>) |
| [#219: Back to Basics: Introduction to Field Effect Transistors JFET MOSFET](https://www.youtube.com/watch?v=oambDFa0Pr8) | [Video 219 folder](<219 - Back to Basics - Introduction to Field Effect Transistors JFET MOSFET/>) |
| [#223: Basics of the Gilbert Cell &#124; Analog Multiplier &#124; Mixer &#124; Modulator](https://www.youtube.com/watch?v=7nmmb0pqTU0) | [Video 223 folder](<223 - Basics of the Gilbert Cell - Analog Multiplier - Mixer - Modulator/>) |
| [#224: AM & DSB-SC Modulation with the Gilbert Cell](https://www.youtube.com/watch?v=38OQub2Vi2Q) | [Video 224 folder](<224 - AM & DSB-SC Modulation with the Gilbert Cell/>) |
| [#231: Circuit Fun: Stairstep generator using 555 and op amps](https://www.youtube.com/watch?v=Kqb5zcrgv7s) | [Video 231 folder](<231 - Circuit Fun - Stairstep generator using 555 and op amps/>) |
| [#232: More Circuit Fun: Simple transistor curve tracer using Stairstep generator circuit](https://www.youtube.com/watch?v=ZOLLoa2fH24) | [Video 232 folder](<232 - More Circuit Fun - Simple transistor curve tracer using Stairstep generator circuit/>) |
| [#247: Circuit Fun: 5 Transistor ESR Meter circuit by EEVBlog user Jay_Diddy_B](https://www.youtube.com/watch?v=3fiUZZlveS0) | [Video 247 folder](<247 - Circuit Fun - 5 Transistor ESR Meter circuit by EEVBlog user Jay_Diddy_B/>) |
| [#273: Common Emitter Amplifier Design Tips](https://www.youtube.com/watch?v=VWY2WQcKJgk) | [Video 273 folder](<273 - Common Emitter Amplifier Design Tips/>) |
| [#281: Bipolar Transistor Switching Time Measurement](https://www.youtube.com/watch?v=XgSKLsWAWGs) | [Video 281 folder](<281 - Bipolar Transistor Switching Time Measurement/>) |
| [#289: Back to Basics: Zener Diodes - How to Use &#124; Applications &#124; not all created equal](https://www.youtube.com/watch?v=jfstUsnCmao) | [Video 289 folder](<289 - Back to Basics - Zener Diodes - How to Use - Applications - not all created equal/>) |
| [#303: What is a Pulse Counting FM Demodulator &#124; Detector &#124; Discriminator?](https://www.youtube.com/watch?v=jQlN2fc7LJc) | [Video 303 folder](<303 - What is a Pulse Counting FM Demodulator - Detector - Discriminator/>) |
| [#324: How to "calibrate" the Simpson 260 VOM - BONUS: 50 microamp current source](https://www.youtube.com/watch?v=TQ7w6_CgO0Q) | [Video 324 folder](<324 - How to calibrate the Simpson 260 VOM - BONUS - 50 microamp current source/>) |
| [#327: Bipolar Transistor Current Mirror output impedance, Early Effect, Wilson Current Mirror](https://www.youtube.com/watch?v=2IbWvq7Abv4) | [Video 327 folder](<327 - Bipolar Transistor Current Mirror output impedance, Early Effect, Wilson Current Mirror/>) |
| [#356: Back to Basics: the Emitter Follower, or Common-Collector Amplifier](https://www.youtube.com/watch?v=8f-nhjQ1jMk) | [Video 356 folder](<356 - Back to Basics - the Emitter Follower, or Common-Collector Amplifier/>) |
| [#366: Back to Basics: Basics of the Bipolar Transistor - NPN and PNP](https://www.youtube.com/watch?v=IrAUC4ZoNYY) | [Video 366 folder](<366 - Back to Basics - Basics of the Bipolar Transistor - NPN and PNP/>) |
| [#374: Back to Basics: JFET Current Source / Limiter circuits](https://www.youtube.com/watch?v=XJadPFYWglQ) | [Video 374 folder](<374 - Back to Basics - JFET Current Source - Limiter circuits/>) |
| [#380: Circuit Fun: Twin-Tee Oscillator - low distortion op amp sine waves](https://www.youtube.com/watch?v=KFVVozlXoOk) | [Video 380 folder](<380 - Circuit Fun - Twin-Tee Oscillator - low distortion op amp sine waves/>) |
| [#381: Circuit Fun Followup: Trimming out distortion on Twin-Tee Oscillator - FFT &THD measurement](https://www.youtube.com/watch?v=Dm1YjETg3rU) | [Video 381 folder](<381 - Circuit Fun Followup - Trimming out distortion on Twin-Tee Oscillator - FFT &THD measurement/>) |
| [#406: Current Regulator/Limiting Diodes (JFET) and their applications](https://www.youtube.com/watch?v=VXZH3UE-kSw) | [Video 406 folder](<406 - Current Regulator-Limiting Diodes (JFET) and their applications/>) |
| [#412: Common Emitter Amplifier - Input and Output Impedance](https://www.youtube.com/watch?v=yhuf2_Zu8T8) | [Video 412 folder](<412 - Common Emitter Amplifier - Input and Output Impedance/>) |
| [#413: Cascading Common-Emitter Amplifiers using an Emitter Follower](https://www.youtube.com/watch?v=pAUYDPwCMj4) | [Video 413 folder](<413 - Cascading Common-Emitter Amplifiers using an Emitter Follower/>) |
| [#417: What is the Transition Frequency (fT) of a transistor - and how to test it.](https://www.youtube.com/watch?v=PRzytyqwK5U) | [Video 417 folder](<417 - What is the Transition Frequency (fT) of a transistor - and how to test it/>) |
