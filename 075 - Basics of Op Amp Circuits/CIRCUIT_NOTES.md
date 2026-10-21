# Video 75: Basics of op amp circuits

Source: Alan Wolke (W2AEW), [#75: Basics of Opamp circuits - a tutorial on how to understand most opamp circuits](https://www.youtube.com/watch?v=K03Rom3Cs28). Alan's [handwritten notes](<W2AEW Video Notes - Basics_of_opamps.pdf>) carry both circuits and the voltages he works out on them.

| Time | What Alan shows |
| --- | --- |
| [2:14](https://www.youtube.com/watch?v=K03Rom3Cs28&t=134s) | [01 - Inverting amplifier around a 5 V reference](#01---inverting-amplifier-around-a-5-v-reference) |
| [5:08](https://www.youtube.com/watch?v=K03Rom3Cs28&t=308s) | [What Alan teaches](#what-alan-teaches) |
| [6:44](https://www.youtube.com/watch?v=K03Rom3Cs28&t=404s) | [02 - Biased integrator](#02---biased-integrator) |

## What Alan teaches

The video is not about designing op amp circuits; it is about reading them. Alan starts from two idealisations - the inputs draw no current, and the voltage gain is huge - and turns them into one rule that does nearly all the work:

> The output will do whatever it can to make the two input voltages equal.

Once you accept that, a circuit is solved with Ohm's law and nothing else. Both circuits below are the ones he draws, with his component values, and both are built around the **LM358** he names on the bench at [5:08](https://www.youtube.com/watch?v=K03Rom3Cs28&t=308s) and again at [8:56](https://www.youtube.com/watch?v=K03Rom3Cs28&t=536s).

## The parts and supply

The op amp model is Texas Instruments' [LMx58B/LM2904B macromodel](<../LTspice/Models/Texas-Instruments/lmx58b_lm2904b.lib>), the manufacturer's model for the B-grade member of the LM358 family. Alan does not draw the op amp's supply pins, but the 2.2k pair runs from +10 V to ground to make the 5 V reference, so both schematics run the part from a single +10 V rail, which is how an LM358 is normally used.

Everything else comes straight from his drawing: 10 k and 20 k around the first amplifier, 2.2 k and 2.2 k for the reference, and 20 k with 0.01 uF for the integrator. The one value he does not give is the resistor across the integrating capacitor, which he draws circled and tells us to ignore because it only sets the DC bias point; 1 Meg is a modelling choice.

## 01 - Inverting amplifier around a 5 V reference

Introduced at [2:14](https://www.youtube.com/watch?v=K03Rom3Cs28&t=134s). File: [`Inverting amplifier.asc`](<01 - Inverting amplifier/Inverting amplifier.asc>).

![Inverting amplifier with a 5 V reference](<01 - Inverting amplifier/Inverting amplifier schematic.png>)

*Alan's circuit. The 2.2 k pair divides the 10 V supply to put 5 V on the + input. R1 is 10 k from the input, R2 is 20 k from the output back to the - input.*

His analysis runs like this. The + input is at 5 V, so the - input is at 5 V too. With 4 V at the input there is 1 V across R1, which is 100 uA. None of it enters the op amp, so the same 100 uA flows through R2, dropping 2 V across it. Starting from the 5 V at the - input and going up 2 V gives **7 V at the output**.

The simulation sweeps the input either side of the reference instead of sitting at one value, so the whole relationship is visible at once.

![Transfer characteristic of the inverting amplifier](<01 - Inverting amplifier/Inverting amplifier transfer.png>)

*Top pane: the output against the input. It is a straight line of slope -2, exactly the -R2/R1 the resistors set, passing through Alan's worked point. Bottom pane: the - input, which sits at 5.000 V across almost the whole sweep. That flat line is the rule doing its job; the output moves wherever it must to keep it there.*

![Measured operating points](<01 - Inverting amplifier/Inverting amplifier SPICE output log.png>)

*The `.meas` results. At Alan's 4 V input the output is 7.0006 V and the - input is 5.0003 V.*

The sweep also shows the one thing the ideal rule cannot predict, and which Alan lists on the last page of his notes: **the output might not be able to swing to the supply rails**. At a 3 V input the arithmetic asks for 9 V, but the LM358 output stops at 8.79 V, about 1.2 V short of its 10 V rail. Where that happens the - input stops being 5 V and sags to about 4.93 V, because the output has run out of room to hold the two inputs equal. At the other end, 7 V in gives 1.0008 V out, which the part manages comfortably.

## 02 - Biased integrator

Introduced at [6:44](https://www.youtube.com/watch?v=K03Rom3Cs28&t=404s). File: [`Biased integrator.asc`](<02 - Biased integrator/Biased integrator.asc>).

![Biased integrator](<02 - Biased integrator/Biased integrator schematic.png>)

*The same reference and the same rule, with the feedback resistor replaced by a 0.01 uF capacitor. R2 is the DC bias path Alan draws and tells us to ignore.*

The analysis barely changes. The - input is still held at 5 V, so an input above 5 V pushes a constant current through R1, and that current has nowhere to go but into C1. A constant current into a capacitor is a constant rate of change of voltage, so the output ramps instead of stepping. When the input drops below 5 V the current reverses and so does the ramp. A square wave in therefore gives a triangle out, which is the classic way to make one.

![Square wave in, triangle out](<02 - Biased integrator/Biased integrator waveforms.png>)

*Bottom pane: a 10 kHz square wave between 4 V and 6 V, balanced about the 5 V reference, which is what Alan draws. Top pane: the output ramping down while the input is high and up while it is low. The small steps at each transition are the input edge reaching the output through C1 before the op amp can respond.*

![Measured amplitudes](<02 - Biased integrator/Biased integrator SPICE output log.png>)

*A 2 V input square produces a 354 mV triangle. The output averages 4.908 V rather than 5.000 V: R2 and R1 give this stage a DC gain of 50, so the LM358's couple of millivolts of input offset becomes about 90 mV at the output.*

### Comparing with Alan's scope

The shape matches his bench screen exactly, but the size does not. On his scope, at 1 V per division, the triangle is about as tall as the square wave driving it. With the 20 k and 0.01 uF in his drawing, a 1 V step either side of the reference moves the output at 1 V / (20 k x 0.01 uF) = 5 mV per microsecond, so a 50 us half period can only produce about 250 mV of ramp. To get a triangle as large as the one he measures, the resistor-capacitor product on his breadboard must have been roughly eight times smaller than the values in his sketch. The sketch is the teaching circuit and the values quoted here are his, so that is what this schematic uses; the lesson, the polarity and the shape are unaffected.

## Reproducing the plots

Open a schematic, press **Run**, and if the waveform window opens autoscaled press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`.

The integrator run is 60 ms long but only the last 200 us is saved. That is deliberate: the 1 Meg bias resistor and the 0.01 uF capacitor give the DC path a 10 ms time constant, so the output needs several of those to settle around the reference before the triangle is clean.
