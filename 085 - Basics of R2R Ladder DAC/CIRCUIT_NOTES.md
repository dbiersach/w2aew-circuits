# Video 85: Basics of R-2R ladder DACs

Source: Alan Wolke (W2AEW), [#85: Basics of R2R Ladder DAC | Digital Analog Conversion, Tutorial R-2R DAC Thevenin Superposition](https://www.youtube.com/watch?v=AulX1OM7RwE). Alan's [handwritten R-2R notes](<W2AEW Video Notes - Basics_of_R-2R_Ladder_DACs.pdf>) show the ladder, the Thevenin reductions, and the superposition derivation.

| Time | What Alan shows |
| --- | --- |
| [1:20](https://www.youtube.com/watch?v=AulX1OM7RwE&t=80s) | [What the video teaches](#what-the-video-teaches) |
| [1:20](https://www.youtube.com/watch?v=AulX1OM7RwE&t=80s) | [01 - Four-bit ladder with a ripple counter](#01---four-bit-ladder-with-a-ripple-counter) |
| [12:15](https://www.youtube.com/watch?v=AulX1OM7RwE&t=735s) | [02 - Six-bit ladder, the port Alan instruments](#02---six-bit-ladder-the-port-alan-instruments) |

## What the video teaches

At [1:20](https://www.youtube.com/watch?v=AulX1OM7RwE&t=80s) Alan draws a four-bit ladder: one resistance R along each horizontal step, 2R at every bit input, and a 2R termination at the left end. Shorting the ideal bit sources and reducing the ladder from left to right gives a constant output resistance of R no matter how many bits are added, which is the property that makes the ladder practical.

Superposition then gives the unloaded four-bit output:

`Vout = Vb0/16 + Vb1/8 + Vb2/4 + Vb3/2`

The bit nearest the output carries the greatest weight, and each bit to its left is worth half as much. Alan builds both an eight-bit and a six-bit ladder on one board, then instruments the **six-bit** port from about [12:15](https://www.youtube.com/watch?v=AulX1OM7RwE&t=735s). His counter walks through codes 0 to 63 while the oscilloscope shows the changing bits and the rising analog staircase.

## 01 - Four-bit ladder with a ripple counter

Introduced at [1:20](https://www.youtube.com/watch?v=AulX1OM7RwE&t=80s). File: [`R-2R Ladder DAC.asc`](<01 - Four-bit R-2R illustration/R-2R Ladder DAC.asc>).

![Four-bit R-2R ladder and its counter](<01 - Four-bit R-2R illustration/Four-bit R-2R schematic.png>)

*The resistor ladder Alan draws, with R = 1 k and 2R = 2 k. R4 is the 2R termination at the left end; R0 to R3 are the 2R bit resistors; R5 to R7 are the R steps between them. Below the ladder, four D flip-flops are wired as a ripple counter so the four bit inputs walk through codes 0 to 15 on their own.*

The counter is a simulation convenience, not part of Alan's drawing: he drives his board from an Arduino. The flip-flops are LTspice's behavioral `Digital\dflop` primitives (Vhigh = 3.3 V, Vlow = 0, 10 ns edges), clocked by a 100 us pulse train from V1, and C1 (1 nF) rounds off the glitches that a ripple counter produces when its stages change at slightly different times. A real design would clock all the bits together instead.

![Four-bit staircase](<01 - Four-bit R-2R illustration/Four-bit R-2R staircase.png>)

*Top pane: the ladder output climbs through 16 levels of 206 mV and wraps back to zero, twice inside the 4 ms run. Bottom pane: B0, the fastest bit, changes once per 100 us clock. The narrow spikes on the staircase are the ripple counter's stages changing a few nanoseconds apart, not extra DAC levels.*

![Four-bit measurement](<01 - Four-bit R-2R illustration/Four-bit R-2R SPICE output log.png>)

*`.meas tran VOUT_MAX` reports 3.0938 V, which is 3.3 V x 15/16 to within a microvolt: the top code of a four-bit ladder is one step short of full supply.*

## 02 - Six-bit ladder, the port Alan instruments

Introduced at [12:15](https://www.youtube.com/watch?v=AulX1OM7RwE&t=735s). File: [`Six-bit R-2R ladder.asc`](<02 - Six-bit R-2R ladder/Six-bit R-2R ladder.asc>).

![Six-bit R-2R ladder](<02 - Six-bit R-2R ladder/Six-bit R-2R schematic.png>)

*The same ladder pattern extended to six bits: RBIT0 to RBIT5 are the 2 k bit resistors, RSTEP0 to RSTEP4 the 1 k steps, and RTERM the 2 k termination. Six independent sources stand in for six digital output pins, each one's pulse period twice the one before it, so together they count 0 to 63 in 100 us steps.*

![Six-bit staircase and bits](<02 - Six-bit R-2R ladder/Six-bit R-2R staircase.png>)

*Top pane: the staircase Alan sees on his scope, 64 equal steps of 51.6 mV. Middle pane: B5, the most significant bit, stays low for the first half of the count and high for the second, switching once at 3.2 ms. Bottom pane: B0, the least significant bit, changes at every code. Reading the three panes together shows how the binary weights add up to a linear ramp.*

![Six-bit measurement](<02 - Six-bit R-2R ladder/Six-bit R-2R SPICE output log.png>)

*`.meas tran FULL_SCALE` samples the output at 6.35 ms, in the middle of code 63, and reports 3.2484374 V.*

For an unloaded six-bit ladder driven by a common high level, `Vout = Vhigh x code/64`, so code 63 predicts `3.3 x 63/64 = 3.2484375 V`. The simulation matches that to the seventh digit, which is a direct check that the ladder weights are 1:2:4:8:16:32 as the superposition derivation says.

## Values and assumptions

The video gives the resistance ratio and the bit sequence but not the component values on Alan's board or his step timing. These schematics use 1 k for R, 2 k for 2R, 0 to 3.3 V logic levels and a 100 us code step; all four of those are simulation choices. The ladder output is also unloaded here, so it shows the ideal weights without the loading a real buffer or scope probe would add.

Both circuits drive the ladder from ideal sources, which is what makes the steps exactly equal. A physical DAC adds the output resistance of its logic pins to each 2R branch, and that mismatch is the main source of differential nonlinearity in a real R-2R converter.

## Reproducing the plots

Open a schematic, press **Run**, and if the waveform window opens autoscaled press **Ctrl+Space** (Plot Settings > Reload Plot Settings) to load the saved `.plt`. Each plot puts the analog output on top and the bit waveforms below it, with the vertical limits saved so the steps keep their proportions.
