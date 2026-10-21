# W2AEW Videos in LTspice

This repository is a hands-on companion to Alan Wolke’s [W2AEW YouTube videos](https://www.youtube.com/@w2aew). Alan explains electronics with clear sketches, bench demonstrations, and measurements. Here, you can open the corresponding circuits in LTspice, run the simulations yourself, and follow the ideas at your own pace.

The schematics aim to follow the circuits and test setups Alan shows. LTspice can stand in for power supplies, meters, oscilloscopes, spectrum displays, and other bench equipment, including instruments that are expensive or hard to obtain. The circuit notes connect the simulated readings to what Alan demonstrates and explain any modeling assumptions or differences from his hardware. The goal is to make his straightforward explanations easier to explore, not to replace the video or treat a simulated device as a measurement of Alan’s particular components.

## Get started

1. Install [LTspice from Analog Devices](https://www.analog.com/en/resources/design-tools-and-calculators/LTspice-simulator.html). The schematics use LTspice’s `.asc` format.
2. Download or clone this repository and keep its directory structure intact. Some schematics refer to files in the shared [LTspice models folder](LTspice/README.md) using relative paths.
3. Choose a video from the table below. Watch Alan’s video alongside that folder’s `CIRCUIT_NOTES.md`.
4. Open a circuit’s `.asc` file in LTspice and click **Run**. Use its saved `.plt` settings, when present, to reproduce the intended traces and scales. If the waveform window opens autoscaled instead, press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load them; stepped simulations in particular need this. The chapter notes explain any additional viewing steps, such as reloading the plot settings after creating an FFT.

You need LTspice to run the circuits. The Markdown notes and PNG figures can be read without it. Some schematics use additional model or symbol files supplied in this repository; their location and scope are documented in [LTspice/README.md](LTspice/README.md).

## How the repository is organized

Each numbered video has a folder named for its topic. Inside it, `CIRCUIT_NOTES.md` is the guide for that video. It links to the video for that chapter and walks through the circuit’s purpose, operation, simulated results, and any assumptions needed to compare LTspice with Alan’s demonstration. The repository also includes Alan’s [W2AEW video index PDF](W2AEW_video_index.pdf).

Numbered subfolders such as `01 - Diode ring mixer/` hold the circuits in the order they appear in the video. Each circuit has at least one LTspice `.asc` schematic, PNG images captured from LTspice for the schematic and relevant plots, and a time-coded video link that takes you to the point where Alan introduces it. A circuit may have more than one `.asc` file when separate simulation views are useful, plus `.plt` plot settings and the `.log` holding its measured results. The symbols and third-party models the schematics need are collected under [`LTspice/`](<LTspice/>). For example, [video 167’s diode-ring mixer](<167 - How a Diode Ring Mixer works - Mixer operation theory and measurement/01 - Diode ring mixer/>) links to its demonstration [from 0:00](https://www.youtube.com/watch?v=junuEwmQVQ8&t=0s) and contains transient and spectrum examples. An optional alternative transformer model sits in its own clearly named subfolder.

| Chapter component | Video 167 example | Purpose |
| --- | --- | --- |
| Chapter guide | [CIRCUIT_NOTES.md](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/CIRCUIT_NOTES.md) | Explains the video, circuit operation, plots, results, and model assumptions. |
| Video and source notes | [video shortcut](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/Video%20167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement.url) and [Alan’s handwritten PDF](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/W2AEW%20Video%20Notes%20-%20Diode_ring_mixer_operation.pdf) | Links to Alan’s demonstration and provides his original notes when available. |
| Numbered circuit folder | [01 - Diode ring mixer/](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/) | Groups the files for the first circuit shown in the video. |
| Editable LTspice schematics | [transient .asc](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20conversion%20example.asc) and [spectrum .asc](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20spectrum.asc) | Run the circuit and inspect the time-domain or FFT setup. |
| LTspice PNG captures | [schematic](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20schematic.png), [transient](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%201%20us%20transient.png), and [FFT](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20LO%20RF%20and%20IF%20spectrum.png) | Show the circuit and representative results without opening LTspice. |
| Saved plot settings | [conversion example .plt](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Diode%20ring%20mixer%20conversion%20example.plt) | Restores the selected traces and display settings for a simulation. |
| Circuit introduction link | [time-coded .url](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Video%20167%20-%2001%20-%20Diode%20ring%20mixer.url) ([watch from 0:00](https://www.youtube.com/watch?v=junuEwmQVQ8&t=0s)) | Jumps to the point where Alan introduces this circuit. |
| Optional variant | [Alternative T1-6T-X65+ model/](167%20-%20How%20a%20Diode%20Ring%20Mixer%20works%20-%20Mixer%20operation%20theory%20and%20measurement/01%20-%20Diode%20ring%20mixer/Alternative%20T1-6T-X65%2B%20model/) | Keeps an illustrative transformer variation separate from the main circuit. |

Video 185 shows how a chapter with several circuits is arranged: [fixed base bias](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/01 - Fixed base bias/>), [collector feedback bias](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/02 - Collector feedback bias/>), and [voltage divider bias](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/03 - Voltage divider bias/>). Its [chapter notes](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/CIRCUIT_NOTES.md>) link to the point where Alan introduces each circuit.

The PNGs show LTspice output; they provide a quick reference while the `.asc` files let you change values, rerun the circuit, and inspect other nodes. Simulation results depend on the chosen device models and test conditions, so read the chapter notes when comparing them with the measurements in the video.

## Quick reference card

[`ltspice-keyboard-shortcuts.pdf`](<ltspice-keyboard-shortcuts.pdf>) is Analog Devices' four-page LTspice 26 quick-reference card, kept here because every circuit in this repository is drawn, simulated and captured in that editor. It covers the schematic and waveform editing shortcuts, the SPICE directives and netlist line types, the simulation command syntax, and the `.options` parameters.

Two entries on it are worth reading before typing any component value. LTspice parses suffixes case insensitively, so **`M` means milli and mega must be written `MEG`**, and a bare **`F` means femto rather than farad**. Both mistakes simulate without complaint and are wrong by orders of magnitude. A unit may follow the prefix and is ignored, so `10nF` is safe; only a bare `F` or `M` straight after the number is a trap.

The card is copyright Analog Devices.

## If you commit simulation output

Waveform files are not kept here. A `.raw` holds every sample of a simulation and a `.fft` every sample of an exported FFT view, and LTspice rewrites them in full on every run, so tracking them made each clone show hundreds of megabytes of modified binaries as soon as anyone pressed Run. The repository keeps what a reader needs instead: the `.asc` to simulate, the `.plt` to restore the saved view, the `.log` with the `.meas` results the chapter notes quote, and PNG captures of the schematic and plots. Press Run to regenerate a waveform file, then **Ctrl+Space** in the plot window to reload its saved settings.

Rerunning a circuit does rewrite its `.log`, and LTspice records the absolute path of the simulated netlist there. A git clean filter reduces those paths to bare filenames as a log is staged, so the committed form never carries the folder layout of whoever ran the simulation. The filter is declared in `.gitattributes`, but git stores the command itself in local configuration, which a clone does not carry. Set it once, from the repository root:

```sh
git config filter.ltspicelog.clean "sh tools/strip-ltspice-log-paths.sh"
```

Git silently ignores a filter whose command is unset, so run this before staging a `.log`. It leaves the results themselves untouched: the `.meas` lines pass through byte for byte.

`tools/check-asset-paths.sh` checks the other half of the arrangement, that every symbol and model a schematic needs sits under [`LTspice/`](<LTspice/>) and is reached by a relative path. Run it after moving or adding one.

## Videos

| Alan's YouTube video | Folder in this repository |
| --- | --- |
| [#54: Back to Basics Tutorial: Voltage / Current in capacitors and inductors](https://www.youtube.com/watch?v=ykgmKOVkyW0) | [Video 054 folder](<054 - Back to Basics Tutorial - Current in Capacitors and Inductors/>) |
| [#55: Back to Basics: Tutorial on LC Resonant Circuits](https://www.youtube.com/watch?v=hqhV50852jA) | [Video 055 folder](<055 - Back to Basics Tutorial - LC Resonant Circuits/>) |
| [#56: Basics of Capacitor & Inductor self-resonance, parasitics, etc. - Tutorial](https://www.youtube.com/watch?v=vi24SpKYYoQ) | [Video 056 folder](<056 - Basics of Capacitor & Inductor self-resonance, parasitics, etc. - Tutorial/>) |
| [#60: Basics of Phase Locked Loop Circuits and Frequency Synthesis](https://www.youtube.com/watch?v=SS7z8WsXPMk) | [Video 060 folder](<060 - Basics of Phase Locked Loop Circuits and Frequency Synthesis/>) |
| [#61: Basics of RF Samplers, Sampling-Tees, RF-taps, etc.](https://www.youtube.com/watch?v=0Kk_N_TpDeo) | [Video 061 folder](<061 - Basics of RF Samplers, Sampling-Tees, RF-taps, etc/>) |
| [#67: Basics of Common Emitter Amplifier Gain and Frequency Response with Measurements](https://www.youtube.com/watch?v=NizrzRKQqII) | [Video 067 folder](<067 - Basics of Common Emitter Amplifier Gain and Frequency Response/>) |
| [#75: Basics of Opamp circuits - a tutorial on how to understand most opamp circuits](https://www.youtube.com/watch?v=K03Rom3Cs28) | [Video 075 folder](<075 - Basics of Op Amp Circuits/>) |
| [#77: Op Amp Peak Detector Tutorial, with peak detector basics](https://www.youtube.com/watch?v=Fn5kHhNRsz0) | [Video 077 folder](<077 - Op Amp Peak Detector Tutorial, with peak detector basics/>) |
| [#82: How to use a Diode as a Switch / Diodes as Switches / Basics of Diode Switches](https://www.youtube.com/watch?v=YBNIq_d56sA) | [Video 082 folder](<082 - Basics of Diode Switches - How to use a Diode as a Switch/>) |
| [#83: Basics of RF Mixers in Radio Receivers / Mixer Tutorial / Frequency Conversion](https://www.youtube.com/watch?v=Mm7WfVzr1ao) | [Video 083 folder](<083 - Basics of RF Mixers in Radio Receivers/>) |
| [#84: Basics of Ferrite Beads: Filters, EMI Suppression, Parasitic oscillation suppression / Tutorial](https://www.youtube.com/watch?v=81C4IfONt3o) | [Video 084 folder](<084 - Basics of Ferrite Beads - Filters, EMI Suppression, Parasitic oscillation suppression - Tutorial/>) |
| [#85: Basics of R2R Ladder DAC &#124; Digital Analog Conversion, Tutorial R-2R DAC Thevenin Superposition](https://www.youtube.com/watch?v=AulX1OM7RwE) | [Video 085 folder](<085 - Basics of R2R Ladder DAC/>) |
| [#87: Schmitt Trigger Oscillator / Tutorial / 74AC14 Inverter / squarewave generator](https://www.youtube.com/watch?v=NuXitMK3HSA) | [Video 087 folder](<087 - Schmitt Trigger Oscillator - Tutorial - 74AC14 Inverter - squarewave generator/>) |
| [#90: Measure Capacitors and Inductors with an Oscilloscope and some basic parts](https://www.youtube.com/watch?v=74fz9iwZ_sM) | [Video 090 folder](<090 - Measure Capacitors and Inductors with an Oscilloscope and some basic parts/>) |
| [#113: Basics of Transistor bias point and the class of amplifier operation](https://www.youtube.com/watch?v=c6cmkm3UPUI) | [Video 113 folder](<113 - Basics of Transistor bias point and the class of amplifier operation/>) |
| [#114: Tutorial: Common Emitter, Common Collector, and Common Base Transistor amplifiers](https://www.youtube.com/watch?v=zXh5gMc6kyU) | [Video 114 folder](<114 - Common Emitter, Common Collector, and Common Base Amplifiers/>) |
| [#131: How to test transistors - NPN and PNP bipolar junction transistors, BJTs](https://www.youtube.com/watch?v=qM7_h8my8eA) | [Video 131 folder](<131 - How to test transistors - NPN and PNP bipolar junction transistors, BJTs/>) |
| [#140: Basics of an Op Amp Summing Amplifier](https://www.youtube.com/watch?v=juQtVIx1a8g) | [Video 140 folder](<140 - Basics of an Op Amp Summing Amplifier/>) |
| [#167: How a Diode Ring Mixer works &#124; Mixer operation theory and measurement](https://www.youtube.com/watch?v=junuEwmQVQ8) | [Video 167 folder](<167 - How a Diode Ring Mixer works - Mixer operation theory and measurement/>) |
| [#172: Basics of Op Amp Gain Bandwidth Product and Slew Rate Limit](https://www.youtube.com/watch?v=UooUGC7tNRg) | [Video 172 folder](<172 - Basics of Op Amp Gain Bandwidth Product and Slew Rate Limit/>) |
| [#185: Back to Basics: Bipolar Transistor bias circuits and Beta dependence](https://www.youtube.com/watch?v=YQlbPGNB-ys) | [Video 185 folder](<185 - Bipolar Transistor Bias Circuits and Beta Dependence/>) |
| [#190: Back to Basics: Transistor Current Sources and Mirrors](https://www.youtube.com/watch?v=xR0RfmmRhDw) | [Video 190 folder](<190 - Back to Basics - Transistor Current Sources and Mirrors/>) |
| [#191: Beware of test equipment loading effects!! Learn from my error!](https://www.youtube.com/watch?v=JbCI4Lsnqho) | [Video 191 folder](<191 - Beware of test equipment loading effects!! Learn from my error!/>) |
| [#193: Back to Basics: the differential amplifier, aka long-tailed pair, diff-pair](https://www.youtube.com/watch?v=mejPNuPAHBY) | [Video 193 folder](<193 - Back to Basics - the differential amplifier aka long-tailed pair diff-pair/>) |
| [#198: Basics of a Vbe Multiplier: what it is, how it works & where it is used](https://www.youtube.com/watch?v=Obh_PIC2qqo) | [Video 198 folder](<198 - Basics of a Vbe Multiplier - what it is, how it works & where it is used/>) |
| [#207: Basics of a Cascode Amplifier and the Miller Effect](https://www.youtube.com/watch?v=Op_I3Ke7px0) | [Video 207 folder](<207 - Basics of a Cascode Amplifier and the Miller Effect/>) |
| [#219: Back to Basics: Introduction to Field Effect Transistors JFET MOSFET](https://www.youtube.com/watch?v=oambDFa0Pr8) | [Video 219 folder](<219 - Back to Basics - Introduction to Field Effect Transistors JFET MOSFET/>) |
| [#223: Basics of the Gilbert Cell &#124; Analog Multiplier &#124; Mixer &#124; Modulator](https://www.youtube.com/watch?v=7nmmb0pqTU0) | [Video 223 folder](<223 - Basics of the Gilbert Cell - Analog Multiplier - Mixer - Modulator/>) |
| [#273: Common Emitter Amplifier Design Tips](https://www.youtube.com/watch?v=VWY2WQcKJgk) | [Video 273 folder](<273 - Common Emitter Amplifier Design Tips/>) |
| [#289: Back to Basics: Zener Diodes - How to Use &#124; Applications &#124; not all created equal](https://www.youtube.com/watch?v=jfstUsnCmao) | [Video 289 folder](<289 - Back to Basics - Zener Diodes - How to Use - Applications - not all created equal/>) |
| [#303: What is a Pulse Counting FM Demodulator &#124; Detector &#124; Discriminator?](https://www.youtube.com/watch?v=jQlN2fc7LJc) | [Video 303 folder](<303 - What is a Pulse Counting FM Demodulator - Detector - Discriminator/>) |
| [#327: Bipolar Transistor Current Mirror output impedance, Early Effect, Wilson Current Mirror](https://www.youtube.com/watch?v=2IbWvq7Abv4) | [Video 327 folder](<327 - Bipolar Transistor Current Mirror output impedance, Early Effect, Wilson Current Mirror/>) |
| [#356: Back to Basics: the Emitter Follower, or Common-Collector Amplifier](https://www.youtube.com/watch?v=8f-nhjQ1jMk) | [Video 356 folder](<356 - Back to Basics - the Emitter Follower, or Common-Collector Amplifier/>) |
| [#366: Back to Basics: Basics of the Bipolar Transistor - NPN and PNP](https://www.youtube.com/watch?v=IrAUC4ZoNYY) | [Video 366 folder](<366 - Back to Basics - Basics of the Bipolar Transistor - NPN and PNP/>) |
| [#374: Back to Basics: JFET Current Source / Limiter circuits](https://www.youtube.com/watch?v=XJadPFYWglQ) | [Video 374 folder](<374 - Back to Basics - JFET Current Source - Limiter circuits/>) |
| [#412: Common Emitter Amplifier - Input and Output Impedance](https://www.youtube.com/watch?v=yhuf2_Zu8T8) | [Video 412 folder](<412 - Common Emitter Amplifier - Input and Output Impedance/>) |
