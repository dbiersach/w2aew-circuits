# Video 60: Basics of Phase Locked Loop Circuits and Frequency Synthesis

Source: Alan Wolke (W2AEW), [#60: Basics of Phase Locked Loop Circuits and Frequency Synthesis](https://www.youtube.com/watch?v=SS7z8WsXPMk). Alan's handwritten notes for the lesson are kept here as [W2AEW Video Notes - Basics_of_PLLs.pdf](<W2AEW Video Notes - Basics_of_PLLs.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:00](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=0s) | **Loop block diagram** - Phase detector, loop filter, VCO, and the feedback path. |
| [2:08](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=128s) | **VCO on the board** - A bench supply on the tune input is turned up and down and the output frequency follows. No tune voltages or frequencies are stated. |
| [5:28](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=328s) | **Type I phase detector (XOR, pin 2)** - A generator drives both comparator inputs at 45, 90, and 180 degrees of phase shift; a meter acts as the low-pass filter. Average output rises with the amount of phase difference. |
| [10:12](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=612s) | **Type II phase detector (phase-frequency, pin 13)** - Two equal resistors from VCC to ground hold the high-impedance output at midrail; the output pulses above or below that level depending on which input leads. |
| [13:46](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=826s) | **Closing the loop** - The VCO output is wired back to the comparator input. The reference is set to 10 kHz and then 8 kHz, the VCO follows, and the loop filter was purposely chosen to take a while to settle. Four scope traces show VCO, reference, PC2, and PC1 at 50 us per division (15:15 to 15:39). |
| [16:05](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=965s) | **Frequency synthesis** - A divide-by-two stage is placed in the feedback path. A 6 kHz reference produces a 12 kHz VCO output. The divider part is not named. |
| [19:18](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=1158s) | **The chip** - Alan shows the chip: a Motorola MC14046B with a 1979 date code, the Motorola-numbered equivalent of the CD4046B. |
| [19:57](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=1197s) | **Extra credit** - Injecting a supply into the tune input through a resistor makes the loop hold frequency with a phase offset: when the VCO leads, the type II detector pulls down, and when it lags, it pulls up. |

Alan explains a phase locked loop (PLL) as three blocks: a phase detector, a low-pass loop filter, and a voltage controlled oscillator (VCO). He demonstrates each block on a small board built around a CMOS 4046 PLL chip, closes the loop, then adds a divide-by-two stage between the VCO and the phase detector to synthesize twice the reference frequency. The five numbered subfolders follow that sequence. Four of them reproduce what Alan shows; the fifth is a clearly labeled experiment that follows his "extra credit" discussion at the end of the video.

## What the simulations share

Every schematic uses the same CD4046B macromodel, the same 5 V supply, and the same external timing parts: R1 = 100 k, R2 = 1 Meg, and C1 = 180 pF. The video shows the board but never gives its wiring or component values, so these parts, the 10 k and 100 nF loop filter, the two 470 k bias resistors, and the pulse sources that stand in for Alan's bench generator are simulation choices. They produce a VCO range and a loop settling time that resemble the video; they are not Alan's values. Alan's stated reference frequencies (10 kHz, 8 kHz, and 6 kHz producing 12 kHz) are used exactly.

| Item | In the video | In the simulation |
| --- | --- | --- |
| PLL chip | Motorola MC14046B (1979 date code) | Geoff Western's CD4046B macromodel, corrected locally; see [Model notes](#model-notes) |
| Supply | Not stated | 5 V |
| VCO timing parts | Not stated | R1 = 100 k, R2 = 1 Meg, C1 = 180 pF |
| Loop filter | "Takes a while to settle"; values not stated | RFILT = 10 k, CFILT = 100 nF |
| Type II output bias | Two equal resistors from VCC to ground | Two 470 k resistors (100 k in the open-loop comparator test) |
| Divider | Not named | CD4013B D flip-flop wired as a toggle; see [Model notes](#model-notes) |
| Reference frequencies | 10 kHz, 8 kHz; 6 kHz for the synthesizer | 10 kHz, 8 kHz; 6 kHz |
| Scope time base in lock | 50 us per division | 500 us windows with a 50 us grid |

Each subfolder holds the schematic, its saved plot settings, the LTspice output files, PNG captures of the schematic, plots, and measurement lines, and a shortcut that opens the video where Alan introduces that circuit.

Every saved plot carries its own labels: a line of text in each pane says what that pane is showing, and the stepped plots name each step next to its trace, so you do not have to decode trace colors. LTspice assigns colors to stepped runs in sequence, pane by pane, and the same step can appear in different colors in different panes; the labels are the reliable guide.

To see a plot as it appears in these notes: open the `.asc`, click **Run**, and when the waveform window opens press **Ctrl+Space** (Plot Settings > Reload Plot Settings). LTspice often opens a stepped run autoscaled with every step overlaid and ignores the saved `.plt` until you reload it. For circuits 3 and 4, which have two saved views, use Plot Settings > Open Plot Settings File to load the `- acquisition.plt` view; the file named after the schematic is the lock-detail view. For the stepped runs in circuits 1, 2, and 3, Plot Settings > Select Steps shows one step at a time, as the captures here do.

## 1. VCO response

Files: [VCO Response.asc](<01 - VCO response/VCO Response.asc>) with [VCO Response.plt](<01 - VCO response/VCO Response.plt>). Video entry: [2:08](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=128s).

The CD4046B VCO runs open loop. VTUNE drives the VCO control input (pin 9) directly, in place of the bench supply Alan turns by hand. The `.step` directive runs the circuit three times with VTUNE at 1.5, 2.5, and 3.5 V. Two `.meas` directives find the 40th and 41st rising edges of the VCO output and compute the frequency from their separation, after the oscillator has had time to settle.

![VCO Response schematic](<01 - VCO response/VCO Response schematic.png>)

![VCO Response plot](<01 - VCO response/VCO Response plot.png>)

The plot shows the first 500 us of the VCO output for each step in its own pane, using LTspice's step selector: `V(vco)@1` is the 1.5 V run, `V(vco)@2` the 2.5 V run, and `V(vco)@3` the 3.5 V run. Each pane is labeled with its control voltage, measured frequency, and period, and a small arrow marks one edge of the waveform. Reading down the stack, each higher control voltage gives a shorter period. The `.meas` results give the frequencies:

![VCO Response measurements](<01 - VCO response/VCO Response SPICE measurements.png>)

| VTUNE | F_VCO |
| ---: | ---: |
| 1.5 V | 3.56 kHz |
| 2.5 V | 9.94 kHz |
| 3.5 V | 18.94 kHz |

This is the behavior Alan demonstrates at 2:08: a higher tune voltage gives a higher frequency. The three voltages are illustrative. Alan does not read out his supply setting or the resulting frequency, so these numbers describe the model with these timing parts, not his board. The range matters for the later examples: 8, 10, and 12 kHz all fall inside it, near the middle of the control range.

### VCO ramp sweep (illustrative experiment)

Files: [VCO ramp sweep.asc](<01 - VCO response/VCO ramp sweep.asc>) with [VCO ramp sweep.plt](<01 - VCO response/VCO ramp sweep.plt>). Same video entry.

This variant replaces the stepped DC source with a PWL ramp from 1.5 V to 3.5 V over 2 ms, which mimics Alan slowly turning the bench supply up. There is no `.step` and no `.meas`.

![VCO ramp sweep schematic](<01 - VCO response/VCO ramp sweep schematic.png>)

![VCO ramp sweep plot](<01 - VCO response/VCO ramp sweep plot.png>)

The VCO output chirps: the cycles get visibly shorter from left to right as the control voltage in the bottom pane rises. Nothing in the video has this exact form; it is a way of seeing the whole tuning curve in one trace.

## 2. Phase detector tests

Files: [Phase Detector Tests.asc](<02 - Phase detector tests/Phase Detector Tests.asc>) with [Phase Detector Tests.plt](<02 - Phase detector tests/Phase Detector Tests.plt>). Video entries: type I at [5:28](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=328s), type II at [10:12](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=612s).

This is an open-loop comparator test, not a PLL. Two independent 10 kHz pulse sources drive the signal input (pin 14, net REF) and the comparator input (pin 3, net FB). VTUNE holds the VCO control input at 2.5 V so the VCO runs but has no effect on either input. The `.step` directive delays the FB source by 0, 25, and 75 us. One cycle is 100 us, so 25 us is FB lagging REF by 90 degrees, and 75 us is FB lagging by 270 degrees, which for a repeating square wave is the same as FB leading by 90 degrees.

![Phase Detector Tests schematic](<02 - Phase detector tests/Phase Detector Tests schematic.png>)

Two small networks stand in for Alan's instruments. RAVG and CAVG (10 k and 100 nF, a 1 ms time constant) average the XOR output the way his meter did. RPU and RPD (two 100 k resistors from VDD to ground) hold the high-impedance type II output at 2.5 V between corrections, which is the two-resistor arrangement Alan adds at 12:21. The `.meas` directives average V(xoravg) and V(pc2) from 4 to 5 ms, after the averaging capacitor has charged.

The two plots show one step at a time over 4.0 to 4.5 ms, five cycles after the averages have settled. Top pane: the two inputs. Middle pane: the type I output on pin 2 and its RC average. Bottom pane: the type II output on pin 13.

![Phase Detector Tests, FB lags REF by 90 degrees](<02 - Phase detector tests/Phase Detector Tests plot - FB lags 90 deg.png>)

With FB lagging (the 25 us step), the XOR output is a 10 kHz square wave with a 50 percent duty cycle, so its average sits at half the supply. PC2 rests at 2.5 V and pulses up to 5 V for the 25 us between each REF rising edge and the FB rising edge that follows it: the comparator input is late, so the detector pushes the control voltage up to make the VCO run faster.

![Phase Detector Tests, FB leads REF by 90 degrees](<02 - Phase detector tests/Phase Detector Tests plot - FB leads 90 deg.png>)

With FB leading (the 75 us step), the XOR output and its average are the same as before. PC2 now pulses down to 0 V for 25 us after each FB rising edge, until the REF edge arrives: the comparator input is early, so the detector pulls the control voltage down.

![Phase Detector Tests measurements](<02 - Phase detector tests/Phase Detector Tests SPICE measurements.png>)

| Step | FB delay | Phase relationship | XOR_AVG | PC2_AVG |
| ---: | ---: | --- | ---: | ---: |
| 1 | 0 us | Edges aligned | 0.00 V | 2.50 V |
| 2 | 25 us | FB lags REF by 90 degrees | 2.47 V | 3.12 V |
| 3 | 75 us | FB leads REF by 90 degrees | 2.47 V | 1.88 V |

This is the lesson of the two segments. The type I average reports how far apart the edges are but gives the same 2.47 V for both directions, so it cannot say which input leads. Alan shows the same thing with his meter at 45, 90, and 180 degrees: the reading grows with the phase difference. The type II output distinguishes direction: its average lands above midrail when FB lags and below midrail when FB leads, which is exactly the up-or-down behavior Alan describes at 10:12. The aligned case gives essentially 0 V from the XOR and 2.5 V from PC2, because the type II detector is designed to lock with its two inputs in phase while the type I detector locks at 90 degrees.

The slow rise of V(xoravg) during the first few milliseconds of the run is the averaging capacitor charging through RAVG. It is not lock acquisition; nothing in this circuit adjusts either input.

## 3. Direct PLL lock

Files: [Direct PLL Lock.asc](<03 - Direct PLL lock/Direct PLL Lock.asc>) with [Direct PLL Lock.plt](<03 - Direct PLL lock/Direct PLL Lock.plt>) (lock detail) and [Direct PLL Lock - acquisition.plt](<03 - Direct PLL lock/Direct PLL Lock - acquisition.plt>). Video entry: [13:46](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=826s).

The loop is closed the way Alan closes it: the VCO output (pin 4) is wired straight back to the comparator input (pin 3). The type II output (pin 13) feeds the loop filter RFILT and CFILT, and the filtered node CTRL drives the VCO control input (pin 9). RBIAS1 and RBIAS2 (470 k each) hold CTRL near 2.5 V before lock, when the type II output is high impedance. VREF is a 0 to 5 V square wave at FREF, and `.step param FREF list 8k 10k` runs Alan's two settings. The `.meas` directives measure the VCO frequency from the 700th and 701st rising edges, late in the 120 ms run.

![Direct PLL Lock schematic](<03 - Direct PLL lock/Direct PLL Lock schematic.png>)

The simulation starts with CTRL at the 2.5 V bias point, where the free-running VCO is near 9.9 kHz. The acquisition plot shows V(ctrl) over the whole run for both steps:

![Direct PLL Lock acquisition](<03 - Direct PLL lock/Direct PLL Lock acquisition plot.png>)

For the 10 kHz reference (upper trace) the loop only has to move the VCO a little, and V(ctrl) settles just above 2.5 V within a few milliseconds. For the 8 kHz reference (lower trace) the VCO has to slow down: V(ctrl) swings between about 2.1 and 2.5 V, rings at a few hundred hertz, and takes about 80 ms to settle near 2.29 V. That slow, ringing approach is the behavior Alan built into his board on purpose; he says at 15:39 that he set the loop filter up so the loop takes a while to settle, which makes the acquisition visible on the scope.

![Direct PLL Lock lock detail](<03 - Direct PLL lock/Direct PLL Lock lock detail plot.png>)

The lock detail view mirrors Alan's four scope traces. It shows the 10 kHz step from 100.0 to 100.5 ms with a 50 us grid. Top pane: V(ref) and V(vco). Second pane: PC2. Third pane: PC1. Bottom pane: V(ctrl), autoranged so its tiny ripple is visible. In lock, the reference and VCO edges coincide (the VCO rising edge lands about 0.1 us before the reference edge, so the two traces overlap and the red reference is hidden behind the blue VCO). PC2 sits at the control voltage, which is its high-impedance state, and emits only a short pulse every few cycles. PC1 shows narrow spikes rather than the 50 percent square wave of circuit 2, because the type II detector has locked the inputs in phase and the XOR output is only active for the fraction of a microsecond of edge mismatch.

The bottom pane explains the PC2 pulses. In lock, PC2 is high impedance and the capacitor voltage drifts very slowly through the 470 k bias divider, which pulls CTRL toward 2.5 V. Each time the drift accumulates enough phase error, PC2 emits one short pulse to top the capacitor back up, and V(ctrl) steps back by a few tens of microvolts.

![Direct PLL Lock measurements](<03 - Direct PLL lock/Direct PLL Lock SPICE measurements.png>)

| FREF | F_VCO | Settled V(ctrl) |
| ---: | ---: | ---: |
| 8 kHz | 7.97 kHz | about 2.29 V |
| 10 kHz | 10.00 kHz | about 2.51 V |

The measured VCO frequencies match the reference within a fraction of a percent, which is what lock means. The 8 kHz value is measured at about 87 ms, while the loop is still ringing slightly, so it is a little low; the 10 kHz value is measured at about 70 ms, long after that step settled. Alan's bench shows the VCO following his 10 kHz and 8 kHz settings in the same way at 15:15 to 15:27.

## 4. Divide-by-two synthesis

Files: [Divide-by-Two PLL.asc](<04 - Divide-by-two synthesis/Divide-by-Two PLL.asc>) with [Divide-by-Two PLL.plt](<04 - Divide-by-two synthesis/Divide-by-Two PLL.plt>) (lock detail) and [Divide-by-Two PLL - acquisition.plt](<04 - Divide-by-two synthesis/Divide-by-Two PLL - acquisition.plt>). Video entry: [16:05](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=965s); the bench example runs from [17:22](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=1042s).

The loop is the same as circuit 3 with one change: the VCO output no longer returns directly to pin 3. It clocks a CD4013B D flip-flop whose inverted output QN (pin 2) is wired back to its own D input (pin 5), so the flip-flop toggles on every VCO rising edge and its Q output (pin 1) runs at half the VCO frequency. That Q output, net FB, is what the comparator input sees. The reference is 6 kHz, Alan's value.

![Divide-by-Two PLL schematic](<04 - Divide-by-two synthesis/Divide-by-Two PLL schematic.png>)

The phase detector only knows about pin 14 and pin 3. It drives the VCO until FB matches the 6 kHz reference, and since FB is the VCO frequency divided by two, the VCO must run at 12 kHz. That is the whole principle of frequency synthesis in this video: the loop multiplies the reference by the division ratio.

![Divide-by-Two PLL acquisition](<04 - Divide-by-two synthesis/Divide-by-Two PLL acquisition plot.png>)

From the 2.5 V starting point the VCO is near 9.9 kHz and must speed up. V(ctrl) overshoots to about 2.94 V, rings at a few hundred hertz, and settles near 2.73 V after roughly 90 ms. The settling is slower than in circuit 3 because the divider halves the loop gain: a change in control voltage moves the comparator input frequency by only half as much.

![Divide-by-Two PLL lock detail](<04 - Divide-by-two synthesis/Divide-by-Two PLL lock detail plot.png>)

The lock detail view covers 100.0 to 100.5 ms with the same four panes as circuit 3, plus the divided feedback. Top pane: V(ref) and V(fb) coincide at 6 kHz (the magenta FB trace hides the green REF trace), and V(vco) runs at twice their rate, with one VCO rising edge aligned to each FB edge and one falling in between. PC2 rests at the control voltage and emits a short pulse on every reference cycle. PC1 shows only edge spikes. The bottom pane shows V(ctrl) within a 3 mV band: a slow downward drift between correction pulses, as the bias divider pulls the node toward 2.5 V, and an upward step at each PC2 pulse. The sawtooth is larger than in circuit 3 because CTRL sits 0.23 V away from the divider's midpoint here, so more current leaks away between pulses.

![Divide-by-Two PLL measurements](<04 - Divide-by-two synthesis/Divide-by-Two PLL SPICE measurements.png>)

| FREF | Division | F_VCO |
| ---: | ---: | ---: |
| 6 kHz | 2 | 11.97 kHz |

The measurement is taken at about 58 ms, while V(ctrl) is still ringing, so the value is a little under 12 kHz. After settling the VCO runs at exactly twice the reference, as the lock detail shows: FB sits on top of REF at 6 kHz, and there are two VCO cycles per FB cycle. Alan shows the same 6 kHz in, 12 kHz out relationship at 17:27 to 18:03.

## 5. Injected tune offset (illustrative experiment)

Files: [Injected tune offset.asc](<05 - Injected tune offset/Injected tune offset.asc>) with [Injected tune offset.plt](<05 - Injected tune offset/Injected tune offset.plt>) (overview) and [Injected tune offset - phase detail.plt](<05 - Injected tune offset/Injected tune offset - phase detail.plt>). Video entry: [19:57](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=1197s).

At the end of the video Alan describes an extra-credit experiment: feed a second supply into the tune input through a resistor. The loop keeps the VCO on frequency, but the type II detector now has to supply a steady current to cancel the injected one, and it can only do that by holding a phase offset between the reference and the feedback. He does not give the resistor or supply values, so this circuit is an experiment in his spirit rather than a reproduction. It is the divide-by-two loop of circuit 4 with one addition: ROFS (100 k) from CTRL to VOFS, a PWL source that sits at 2.5 V for 50 ms, steps to 5 V at 50 ms, and steps to 0 V at 100 ms.

![Injected tune offset schematic](<05 - Injected tune offset/Injected tune offset schematic.png>)

The `.meas` directives measure the VCO frequency and, at 40, 90, and 140 ms, the time from a reference rising edge to the next feedback rising edge, converted to degrees of the 6 kHz cycle and wrapped to the range -180 to +180. A positive angle means FB rises after REF (FB lags); a negative angle means FB rises first (FB leads).

![Injected tune offset overview plot](<05 - Injected tune offset/Injected tune offset plot.png>)

Top pane: V(ctrl) over the whole 150 ms. Bottom pane: the current ROFS pushes into the loop filter node, plotted as -I(Rofs) so that current flowing into CTRL is positive. Until 50 ms VOFS sits at 2.5 V and ROFS draws about 2 uA out of CTRL (the node is at 2.73 V). At 50 ms VOFS jumps to 5 V and ROFS pushes about 23 uA in; at 100 ms VOFS drops to 0 V and ROFS pulls about 27 uA out. Each step disturbs V(ctrl), the loop rings for about 40 ms, and V(ctrl) returns to the same 2.73 V as before. It has to: the VCO frequency is fixed by the reference, and the control voltage that produces 12 kHz does not change. What changes is the band of ripple on V(ctrl), which grows after each step because PC2 must now pulse every cycle, for longer, to cancel the injected current.

![Injected tune offset phase detail](<05 - Injected tune offset/Injected tune offset phase detail plot.png>)

The phase detail view shows 90.0 to 90.5 ms, in the middle of the 5 V injection. Top pane: V(ref) and V(fb). Bottom pane: PC2. The feedback edges now arrive about 13.5 us before the reference edges, and PC2 pulls down to 0 V for that interval on every cycle, sinking the injected current through RFILT. The phase offset is the price the loop pays for canceling the extra current.

![Injected tune offset measurements](<05 - Injected tune offset/Injected tune offset SPICE measurements.png>)

| Time | VOFS | Current into CTRL through ROFS | Phase of FB relative to REF | PC2 action |
| ---: | ---: | ---: | ---: | --- |
| 40 ms | 2.5 V | about -2 uA | +2.3 degrees (FB lags slightly) | brief pull-ups |
| 90 ms | 5 V | about +23 uA | -29.3 degrees (FB leads) | pulls down each cycle |
| 140 ms | 0 V | about -27 uA | +45.7 degrees (FB lags) | pulls up each cycle |

F_VCO measures 12.00 kHz at 58 ms, during the ringing that follows the first step: the loop holds the VCO on frequency even while the control node is being disturbed. The sign pattern is the one Alan describes at 20:36: when the VCO (and therefore FB) leads, PD2 pulls down; when it lags, PD2 pulls up. The small positive offset at 40 ms is the same effect in miniature: even with VOFS at 2.5 V, ROFS and the 470 k divider together draw a few microamps out of the 2.73 V control node, and the loop holds a 2 degree lag to replace it. The two larger angles are not proportional to the injected currents because CTRL sits at 2.73 V, not at midrail. A pull-down pulse drives 2.73 V across RFILT (about 270 uA) while a pull-up pulse drives only 2.27 V across it (about 220 uA), so canceling 23 uA with pull-downs needs about an 8 percent duty cycle (29 degrees) while canceling 28 uA with pull-ups needs about 13 percent (46 degrees).

## Model notes

### CD4046B macromodel and the local correction

The four main circuits and the experiment use Geoff Western's (Alec-T) CD4046B macromodel. The unmodified file is kept at [LTspice/Models/Community/CD4046Bg.sub](<../LTspice/Models/Community/CD4046Bg.sub>) and the corrected file the circuits actually simulate at [LTspice/Models/Community/CD4046Bg-corrected.sub](<../LTspice/Models/Community/CD4046Bg-corrected.sub>). All six schematics place the shared [LTspice/Symbols/CD4046_board.asy](<../LTspice/Symbols/CD4046_board.asy>) symbol, whose `ModelFile` attribute reaches the corrected file by a relative path, so the circuits simulate from a clean checkout without a symbol search path.

The correction, recorded in the header of the corrected file, fixes the polarity of the signal input inside the model. The original file passes pin 14 through a CMOS inverter and then takes the true output of a Schmitt trigger, so both phase comparators see the complement of the signal input. The type II detector therefore locks with pins 14 and 3 180 degrees apart and pulses in the wrong direction, and the model's author compensated the type I detector by cross-wiring its output switches to the complement of the XOR. The corrected file takes the Schmitt trigger's complementary output instead and returns the type I output switches to the XOR's true and complement outputs. With that change the model behaves as the CD4046B datasheet (Texas Instruments SCHS043B) describes: phase comparator II locks with its two inputs in phase, drives its output toward VDD while the comparator input (pin 3) lags the signal input (pin 14), and drives it toward VSS while pin 3 leads; phase comparator I is a plain XOR that locks at 90 degrees. Circuit 2 checks that polarity directly, circuit 3 shows the 0 degree lock, and circuit 5 shows the pull-down for a leading feedback edge that Alan describes.

The model's header permits copying for private noncommercial use. Both the original and the corrected file keep Geoff Western's attribution and that notice, and this collection is a noncommercial teaching resource. [LTspice/README.md](<../LTspice/README.md>) records the provenance of every shared model here.

### CD4013B divider

Alan does not name his divider. The CD4013B is a reasonable CMOS choice from the same 4000-series family as the 4046, and the schematic shows its package pin numbers so the toggle connection can be wired on a bench. Its model comes from Helmut Sennewald's CD4000-series library for LTspice (revision 0.62, 2007), kept at [LTspice/Models/Community/cd4000.lib](<../LTspice/Models/Community/cd4000.lib>) and included by the circuit 4 and circuit 5 schematics. Both place the shared [LTspice/Symbols/CD4013_board.asy](<../LTspice/Symbols/CD4013_board.asy>) symbol. The instance parameters VDD=5, SPEED=1, and TRIPDT=5n are that library's defaults for a 5 V supply.

### What the models do and do not represent

The macromodels reproduce the logic, the comparator outputs, and the VCO's dependence on its timing parts closely enough to show the loop's behavior. They abstract the silicon: supply current, output drive strength, input thresholds, temperature, and part-to-part spread are not modeled, and the VCO frequency for a given R1, R2, C1, and control voltage will differ from a real MC14046B or CD4046B. Capture range, lock time, and ripple on the control voltage therefore illustrate Alan's lesson rather than predict his board. Texas Instruments' [CD4046B phase-locked loop application note (SCHA002A)](https://www.ti.com/lit/an/scha002a/scha002a.pdf) covers the component-selection calculations for a real design.

## Circuit files and video entry points

Each link opens the relevant video segment. Files beneath the same numbered circuit are LTspice test or model variants of that circuit; they share its video entry point.

| Schematic | Circuit or variant | Video entry |
| --- | --- | --- |
| [VCO Response.asc](<01 - VCO response/VCO Response.asc>) | Loop components and VCO | [2:08](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=128s) |
| [VCO ramp sweep.asc](<01 - VCO response/VCO ramp sweep.asc>) | VCO ramp sweep, illustrative experiment | [2:08](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=128s) |
| [Phase Detector Tests.asc](<02 - Phase detector tests/Phase Detector Tests.asc>) | Type I and type II phase detectors | [5:28](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=328s) |
| [Direct PLL Lock.asc](<03 - Direct PLL lock/Direct PLL Lock.asc>) | Closing the loop | [13:46](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=826s) |
| [Divide-by-Two PLL.asc](<04 - Divide-by-two synthesis/Divide-by-Two PLL.asc>) | Frequency synthesis | [16:05](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=965s) |
| [Injected tune offset.asc](<05 - Injected tune offset/Injected tune offset.asc>) | Extra credit, illustrative experiment | [19:57](https://www.youtube.com/watch?v=SS7z8WsXPMk&t=1197s) |

