# Video 215: crossover distortion, with the LM358 as the example

Source: Alan Wolke (W2AEW), [#215: Basics of crossover distortion | LM358 op amp example](https://www.youtube.com/watch?v=VgodYtiD_F0). His notes page is kept here as [W2AEW Video Notes - crossoverdistortion.pdf](<W2AEW Video Notes - crossoverdistortion.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:31](https://www.youtube.com/watch?v=VgodYtiD_F0&t=31s) | The top of his notes page and the condition that causes it: crossover distortion appears when the output has to alternate between sourcing and sinking current, which happens as soon as the load is AC coupled and the output swings either side of the load's reference point. |
| [1:33](https://www.youtube.com/watch?v=VgodYtiD_F0&t=93s) | The test circuit itself, with its two jumpers. Both [01 - AC-coupled load and crossover notch](<01 - AC-coupled load and crossover notch/>) and [02 - DC output bias suppresses notch](<02 - DC output bias suppresses notch/>) come from this one drawing; the jumpers are what choose between them. |
| [2:34](https://www.youtube.com/watch?v=VgodYtiD_F0&t=154s) | At the bench with the circuit built, looking at the output on an analog scope. |
| [3:16](https://www.youtube.com/watch?v=VgodYtiD_F0&t=196s) | His answer to "why?": the schematic of the LM358's own output stage, worked through over the next couple of minutes. |
| [6:41](https://www.youtube.com/watch?v=VgodYtiD_F0&t=401s) | Back at the bench, working through what changes the notch and what does not. |

## The circuit, and the two jumpers

Alan's test circuit is one LM358 section wired as a voltage follower on a single 5 V supply. A 20 k and 10 k divider sets the non-inverting input to 1.67 V, the generator is coupled in through 0.47 uF at 1 Vpp and 5 kHz, and the output drives a 1 k load through another 0.47 uF. Two jumpers on his board change the experiment: one shorts out the output coupling capacitor, and one connects a DC load of 1 k in series with a 10 k pot from the output to ground. The two schematics here are the jumpers open and the DC load jumper closed, with the pot at its minimum.

Every value in both files is Alan's. The op amp model is onsemi's LM358, which carries the class B output stage the lesson is about, so the notch is produced by the model rather than drawn in by hand.

## With the load AC coupled

[01 - AC-coupled load and crossover notch/AC-coupled load and crossover notch.asc](<01 - AC-coupled load and crossover notch/AC-coupled load and crossover notch.asc>)

![AC-coupled load schematic](<01 - AC-coupled load and crossover notch/AC-coupled load schematic.png>)

The coupling capacitor is what creates the problem. It blocks DC, so the only current in the load is the signal current, and signal current reverses. On the positive half cycle the op amp pushes current out into the load; on the negative half it has to pull the same current back in. A class B output stage does that with two transistors, one for each direction, and neither conducts in the handover region.

![AC-coupled load crossover notch](<01 - AC-coupled load and crossover notch/AC-coupled load crossover notch.png>)

Both panes show it, which is the point of plotting them together. The lower pane is the load current, a clean sine passing through zero twice per cycle. The upper pane is the voltage at the scope probe, and at each of those zero crossings the trace stops, holds flat for a moment, then drops abruptly to catch up. That step is the handover: for a few microseconds neither output transistor is driving and the feedback loop is open.

![AC-coupled load SPICE output log](<01 - AC-coupled load and crossover notch/AC-coupled load SPICE output log.png>)

`.four` puts a number on it: **4.26 percent total harmonic distortion** on a signal whose amplitude is otherwise correct at 0.9999 Vpp. Look at which harmonics carry it. The third is 1.52 percent of the fundamental and the fifth 1.44 percent, while the second is only 0.30 percent. Odd harmonics dominating is the signature of a symmetrical defect, one that does the same thing on both halves of the wave, and a crossover notch is exactly that.

## With a DC load on the output

[02 - DC output bias suppresses notch/DC output bias suppresses notch.asc](<02 - DC output bias suppresses notch/DC output bias suppresses notch.asc>)

![DC output bias schematic](<02 - DC output bias suppresses notch/DC output bias schematic.png>)

`Rdc` is the only change: 1 k from the op amp output to ground, which is Alan's second jumper with the pot at zero. The output sits at 1.67 V, so that resistor draws a steady 1.67 mA whatever the signal does.

![DC output bias notch removed](<02 - DC output bias suppresses notch/DC output bias notch removed.png>)

The lower pane makes the mechanism visible. The load current, in magenta, still swings plus and minus half a milliamp exactly as before; nothing about the AC-coupled load changed. The red trace is the sum of both load currents, which is what the op amp output actually has to supply, and it never comes near zero: it swings between 0.66 mA and 2.67 mA, all in the same direction. The 1.67 mA standing current is more than three times the 0.5 mA peak the signal demands, so the sourcing transistor stays on through the whole cycle and the handover never happens.

![DC output bias SPICE output log](<02 - DC output bias suppresses notch/DC output bias SPICE output log.png>)

`itotal_min` reports that minimum as **0.663 mA**, and the distortion falls from 4.26 percent to **0.128 percent**, a factor of 33. The third harmonic drops from 1.52 percent to 0.055 percent. The output amplitude is unchanged at 0.9989 Vpp, so this costs nothing but the 1.67 mA of standing current, which is the trade a class AB stage makes deliberately and which this single-supply LM358 does not make for you.

| | Output | THD | 3rd harmonic | Lowest output current |
| --- | --- | --- | --- | --- |
| AC-coupled load alone | 0.9999 Vpp | 4.257% | 1.52% | reverses through zero |
| With a 1 k DC load | 0.9989 Vpp | 0.128% | 0.055% | +0.663 mA |

The general lesson is the one Alan starts from, and it is about the load rather than the op amp. An op amp driving a load referenced to the middle of its own output swing has to work both ways round, and whether that shows up depends entirely on what its output stage does at the handover. Give it a reason to keep conducting in one direction and the problem disappears.

If the waveform window opens autoscaled, press Ctrl+Space to reload the saved plot settings.
