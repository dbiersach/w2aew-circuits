# Video 284: basics of RF bias tees

Source: Alan Wolke (W2AEW), [#284: Basics of RF Bias Tees including applications and examples](https://www.youtube.com/watch?v=lxgpm-UXTNY). His five-page notes set is kept here as [W2AEW Video Notes - Basics_of_Bias_Tees.pdf](<W2AEW Video Notes - Basics_of_Bias_Tees.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:40](https://www.youtube.com/watch?v=lxgpm-UXTNY&t=40s) | What a bias tee is for, with two commercial units sitting beside the page: powering a transistor, photodiode or LNA down the same coax that carries the signal, controlling remote hardware, and adding a DC offset to a high-speed signal. |
| [2:01](https://www.youtube.com/watch?v=lxgpm-UXTNY&t=121s) | Page 1 and the circuit itself: a series capacitor that passes RF and blocks DC, a shunt inductor that passes DC and blocks RF, and the formula for the low frequency limit. Built as [01 - Basic bias tee](<01 - Basic bias tee/>). |
| [3:22](https://www.youtube.com/watch?v=lxgpm-UXTNY&t=202s) | Page 2, the practical details: the capacitor's self-resonant frequency, and the inductor's parasitic capacitance, loss and core saturation, which he says are worse. Built as [02 - Where the parasitics set the band edges](<02 - Where the parasitics set the band edges/>). |
| [7:24](https://www.youtube.com/watch?v=lxgpm-UXTNY&t=444s) | The applications pages: a remote pre-amp at the far end of a long coax, biasing a laser diode or photodiode, adding DC offset to a serial signal, biasing an RF transistor, and feeding a control voltage to an antenna tuner. |
| [10:06](https://www.youtube.com/watch?v=lxgpm-UXTNY&t=606s) | At the bench, measuring a real bias tee on test equipment. |

## What the circuit is

Alan's page 1 reduces a bias tee to two parts. A capacitor in series with the RF path passes RF and blocks DC. An inductor from the DC supply to the junction passes DC and blocks RF. The port on the far side of the junction carries both.

He then gives the one piece of arithmetic in the lesson, the low frequency limit of the RF path:

> fL = 1 / (2 pi C (RL + RS))

Both files below use a 50 ohm source and a 50 ohm load, which is what that formula's RL and RS mean in an RF system, and both are swept from 1 kHz to 1 GHz. Alan gives no component values anywhere in his notes, so every number in these two schematics is a choice, chosen to put the band edges somewhere a sweep can show them.

The far end is drawn as 50 ohm in series with a 1 uF blocking capacitor rather than 50 ohm straight to ground. An ideal resistor to ground conducts DC as well as RF, which would have the 12 V supply driving a quarter of an amp through the RF termination. With the block in place the far port sits at the supply voltage, which is the point of the DC path, and the 1 uF is a short long before the frequencies where the measurement matters.

## The basic tee, with ideal parts

[01 - Basic bias tee/Basic bias tee.asc](<01 - Basic bias tee/Basic bias tee.asc>)

![Basic bias tee schematic](<01 - Basic bias tee/Basic bias tee schematic.png>)

C1 is 10 nF and L1 is 1 mH, with the supply at 12 V. Alan's formula with 10 nF between a 50 ohm source and a 50 ohm load predicts a low frequency limit of 159.2 kHz.

![Basic bias tee RF response](<01 - Basic bias tee/Basic bias tee RF response.png>)

![Basic bias tee SPICE output log](<01 - Basic bias tee/Basic bias tee SPICE output log.png>)

Mid-band the output is **0.500 V** of the 1 V drive, which the log reports as -6.02 dB. That is not loss in the bias tee; it is the 50 ohm source and the 50 ohm load dividing the open-circuit drive in half, as any matched system does. Half power is therefore 0.3536 V, and the sweep reaches it at **156.7 kHz** against Alan's predicted 159.2 kHz, a difference of 1.5 percent.

That small gap is worth understanding, because it is the assumption hidden in his formula. The formula treats the inductor as absent, but L1 also shunts the output back to the supply, which is an AC ground. At 159 kHz, 1 mH presents 1 kohm, twenty times the load, so it drags the corner up only slightly. Use a much smaller inductor and it is the inductor, not the capacitor, that sets the bottom of the band, and the formula stops applying.

With ideal parts there is nothing to set the top of the band at all. The response goes flat and stays flat to 1 GHz and beyond, which is exactly why Alan's page 2 exists.

## Where the band edges really come from

[02 - Where the parasitics set the band edges/Bias tee with parasitics.asc](<02 - Where the parasitics set the band edges/Bias tee with parasitics.asc>)

![Bias tee with parasitics schematic](<02 - Where the parasitics set the band edges/Bias tee with parasitics schematic.png>)

The same circuit with the two parasitics Alan names: `Lser`, 1 nH of series inductance inside C1, and `Cpar`, 10 pF of distributed capacitance across L1. Those are plausible figures for small parts rather than measurements of anything he shows, and they are the whole difference between this file and the last.

![Bias tee with parasitics RF response](<02 - Where the parasitics set the band edges/Bias tee with parasitics RF response.png>)

![Bias tee with parasitics SPICE output log](<02 - Where the parasitics set the band edges/Bias tee with parasitics SPICE output log.png>)

| | Mid-band | Low edge | High edge |
| --- | --- | --- | --- |
| Ideal parts | 0.500 V | 156.7 kHz | none |
| With the parasitics | 0.500 V | 156.8 kHz | **660 MHz** |

Inside the band the parasitics cost nothing measurable, and the low edge does not move: C1 still sets it. What they add is the top edge, and the two of them do not contribute equally, which is Alan's point about the inductor being the worse offender.

L1 and its 10 pF resonate at 1.59 MHz. At exactly that frequency the parallel pair is an open circuit, which is the best a feed inductor can be. Above it the pair behaves as a capacitor, so its impedance falls as frequency rises, and it starts shunting the signal into the supply. By 660 MHz it has taken half the power, and the band is over.

C1 and its 1 nH resonate at 50.3 MHz. Below that the branch is capacitive as intended; above it the branch is inductive, but 1 nH is only 6 ohm even at 1 GHz, against the 50 ohm it sits in series with. On these numbers the capacitor's parasitic never becomes the limit.

This is also the reason behind the chain Alan draws at the bottom of page 2, where the single feed inductor is replaced by several in series, from under a nanohenry up to over a microhenry, each covering part of the range. The catch he notes immediately is that a chain of inductors with capacitance between them has resonances of its own, so a real wideband bias tee carries extra parts whose only job is to de-Q those resonances away.

If the waveform window opens autoscaled, press Ctrl+Space to reload the saved plot settings.
