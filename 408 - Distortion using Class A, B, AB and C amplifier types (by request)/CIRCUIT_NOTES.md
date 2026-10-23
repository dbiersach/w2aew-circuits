# Video 408: distortion in class A, B, AB and C

Source: Alan Wolke (W2AEW), [#408: Distortion using Class A, B, AB and C amplifier types (by request)](https://www.youtube.com/watch?v=jMmCB8MOICE). His notes page is kept here as [W2AEW Video Notes - ClassABCdistortion.pdf](<W2AEW Video Notes - ClassABCdistortion.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:33](https://www.youtube.com/watch?v=jMmCB8MOICE&t=33s) | The definition the whole lesson rests on, as a table of conduction angles: class A conducts for all 360 degrees of the input cycle, class B for 180, class C for less than 180, and class AB for somewhere between 180 and 360. Beside it he sketches what each one does to the waveform. |
| [1:40](https://www.youtube.com/watch?v=jMmCB8MOICE&t=100s) | The test circuit: a 2N2222 common emitter stage on 12 V with a 3.9 k collector resistor and 330 ohm in the emitter, driven through 1 k from a function generator whose offset knob is what sets the class. Built as [01 - Bias and distortion test](<01 - Bias and distortion test/>). |
| [3:52](https://www.youtube.com/watch?v=jMmCB8MOICE&t=232s) | At the bench with the collector on CH1, the base on CH2 and an FFT running, starting with the stage biased into class A. |
| [6:05](https://www.youtube.com/watch?v=jMmCB8MOICE&t=365s) | Winding the generator's offset down and watching the collector waveform flatten while the harmonics climb out of the noise on the FFT. |
| [10:31](https://www.youtube.com/watch?v=jMmCB8MOICE&t=631s) | Still at the bench, working through the remaining bias settings on the scope and the spectrum together. |

## The circuit, and what the bias knob does

Alan's test circuit is deliberately plain: one 2N2222, 12 V, 3.9 k in the collector and 330 ohm in the emitter, with the generator reaching the base through 1 k. There is no bias network at all. The generator's own DC offset is the bias, which is exactly why the circuit is built this way, because turning one knob walks the stage through every class in order.

[01 - Bias and distortion test/Amplifier class distortion.asc](<01 - Bias and distortion test/Amplifier class distortion.asc>)

![Amplifier class distortion schematic](<01 - Bias and distortion test/Amplifier class distortion schematic.png>)

Every component value is Alan's. The source is a 1 kHz sine of 0.25 V amplitude on a DC offset stepped through four values, which is his generator with the amplitude left alone and the offset turned. Those four offsets are not transcribed from the video; he adjusts his by hand, so they were picked to land one run in each of the four regimes. `.step` runs them in ascending order, so step 1 is the lowest bias and step 4 the highest. He probes the collector on CH1 and the base on CH2; this file plots the collector, which is where the classes show themselves.

## What each bias does to the waveform

![Amplifier class distortion collector waveforms](<01 - Bias and distortion test/Amplifier class distortion collector waveforms.png>)

Four panes, one run each, top to bottom from class A down to class C, each labelled with its bias so no colour has to be decoded.

Reading down the four is reading Alan's conduction-angle table in reverse. At 1.10 V the collector traces a clean sine through most of the range available to it, which is 360 degrees of conduction. At 0.70 V the top of the waveform has flattened against the 12 V rail, because the transistor is cutting off for part of the cycle. At 0.65 V the flat region takes about half the cycle. At 0.45 V the transistor only conducts in short bursts near the peaks of the drive, and the collector sits at the supply for most of the period. The collector is inverted relative to the base, so cut-off appears as the waveform pressing up against 12 V rather than down against ground.

## The numbers

`.four 1k V(COLLECTOR)` runs on each step, and the log reports a Fourier table and a THD figure for all four.

![Class C Fourier result](<01 - Bias and distortion test/Class C Fourier result.png>)

That is step 1, the class C run, and the harmonic ladder is worth reading line by line. The second harmonic is 66 percent of the fundamental and the third is 30 percent, which is what adds up to 73.5 percent total harmonic distortion. A stage that conducts in short bursts is not producing a slightly imperfect sine wave; it is producing a pulse train whose spectrum happens to contain the wanted frequency.

| Bias | Class | Collector DC | Fundamental at 1 kHz | THD |
| ---: | --- | ---: | ---: | ---: |
| 0.45 V | C | 11.78 V | 0.380 V | **73.49%** |
| 0.65 V | B | 10.95 V | 1.512 V | **30.57%** |
| 0.70 V | AB | 10.65 V | 1.815 V | **22.38%** |
| 1.10 V | A | 6.89 V | 2.706 V | **0.84%** |

The THD column alone makes class A look like the only sensible choice, and the other two columns are why it is not.

The collector's DC level says how much current the stage draws on average, because it sits at 12 V minus that current through 3.9 k. In class A the collector is at 6.89 V, so the stage pulls 1.31 mA the whole time, whether there is a signal or not. In class C it is at 11.78 V, which is 0.056 mA, more than twenty times less. Meanwhile the fundamental only falls by a factor of seven, from 2.706 V to 0.380 V. Divide one by the other and class C delivers about three times as much wanted output per milliamp drawn as class A does.

That is the whole trade, and it is why the choice depends on what the amplifier is for. An audio stage has to reproduce its input, so class A or AB and their low distortion are worth the standing current. An RF power stage drives a tuned circuit that only passes the fundamental, so the harmonics are filtered out downstream and class C's efficiency comes nearly free. The classes are not a quality ranking; they are four answers to the same question.

Alan's page points at his video 113 for how a bias point sets the operating region in the first place, which is the chapter behind this one.

If the waveform window opens autoscaled, press Ctrl+Space to reload the saved plot settings.
