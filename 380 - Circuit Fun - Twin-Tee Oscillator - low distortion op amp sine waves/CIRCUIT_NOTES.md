# Video 380 - The twin-tee oscillator

Source: Alan Wolke (W2AEW), [#380: Circuit Fun: Twin-Tee Oscillator - low distortion op amp sine waves](https://www.youtube.com/watch?v=KFVVozlXoOk). His three handwritten pages are in [W2AEW Video Notes - twintee_oscillator.pdf](W2AEW%20Video%20Notes%20-%20twintee_oscillator.pdf): the other RC oscillators on page 1, the twin-tee network on page 2, and the 5 V circuit on page 3.

| Time | What Alan shows |
| --- | --- |
| [0:20](https://www.youtube.com/watch?v=KFVVozlXoOk&t=20s) | A printed application note on op amp sine-wave oscillator design, as the background for what follows. |
| [2:40](https://www.youtube.com/watch?v=KFVVozlXoOk&t=160s) | Page 1: the relaxation, phase-shift and Wien-bridge oscillators, and why each of the sinusoidal ones needs careful gain control or an outright AGC. |
| [4:00](https://www.youtube.com/watch?v=KFVVozlXoOk&t=240s) | Page 2: a low-pass tee and a high-pass tee overlaid into one network, and the notch that appears where their outputs cancel. |
| [5:26](https://www.youtube.com/watch?v=KFVVozlXoOk&t=326s) | The notch with component values on it, which is what [circuit 01](#01---passive-twin-tee-notch) reproduces. |
| [6:40](https://www.youtube.com/watch?v=KFVVozlXoOk&t=400s) | The notch measured on his network analyser. |
| [8:07](https://www.youtube.com/watch?v=KFVVozlXoOk&t=487s) | Page 3: the same network moved into an op amp's feedback loop, where the notch becomes a peak. See [circuit 02](#02---op-amp-twin-tee-oscillator). |
| [11:00](https://www.youtube.com/watch?v=KFVVozlXoOk&t=660s) | The oscillator's output on the scope. |
| [11:40](https://www.youtube.com/watch?v=KFVVozlXoOk&t=700s) | Its spectrum, with the harmonics far down. |
| [12:07](https://www.youtube.com/watch?v=KFVVozlXoOk&t=727s) | A Keithley 2015 THD meter on the output, reading 0.129 percent. |

## Why this oscillator

Page 1 is a survey of what else is available, and it is there to make a point. A relaxation oscillator is simple but gives a triangle and a square, not a sine. A phase-shift oscillator gives a sine but only with careful gain adjustment. A Wien bridge gives a sine but wants real gain control, a lamp or an AGC, to keep it clean.

The twin tee is Alan's answer: resistors and capacitors only, no inductors, a sinusoidal output, and "easy to get much less than 1 percent THD". The cost, written on the same page, is that it is not easily tunable and needs some minor trimming for lowest distortion. That trimming is the whole of video 381, and the simulation below shows why it is needed.

## 01 - Passive twin-tee notch

Open [Passive twin-tee notch.asc](01%20-%20Passive%20twin-tee%20notch/Passive%20twin-tee%20notch.asc); the [video shortcut](01%20-%20Passive%20twin-tee%20notch/Video%20380%20-%2001%20-%20Passive%20twin-tee%20notch.url) opens the filter at [5:26](https://www.youtube.com/watch?v=KFVVozlXoOk&t=326s).

![LTspice schematic of the passive twin-tee notch](01%20-%20Passive%20twin-tee%20notch/Passive%20twin-tee%20notch%20schematic.png)

*The network alone, driven by an AC source and left unloaded, so the plot is the voltage transfer. Two 10 k resistors form the upper series path with 2C to ground at its midpoint, and two 10 nF capacitors form the lower path with R/2 to ground at its midpoint. `CTOP` at 20 nF is the two parallel 0.01 uF capacitors in Alan's drawing, and `RSHUNT` at 5 k is the nominal setting of his 4.7 k plus 500 ohm trim.*

Each tee on its own is unremarkable: the resistive one is a low pass and the capacitive one a high pass. Put in parallel, their outputs are out of phase over a band in the middle, and at one frequency they cancel exactly. That frequency is `1/(2*pi*R*C)`, which for 10 k and 10 nF is 1592 Hz.

![Simulated transfer of the twin tee](01%20-%20Passive%20twin-tee%20notch/Notch%20response.png)

*Flat at unity either side of a sharp null near 1585 Hz. The trace recovers to 0 dB in both directions, which is what lets the network pick a frequency when it goes in a feedback loop.*

How deep the null looks needs a word of caution, because it is not a property of the circuit as drawn. With ideal components the two paths cancel perfectly and the null has no floor at all. What you see is set by how finely the sweep samples it: at 200 points per decade the deepest sample `NOTCH_DEPTH` finds is -100.4 dB, while the drawn trace bottoms near -54 dB because the null is narrower than one pixel of the plot. In a real build the depth is set instead by how closely the resistor and capacitor tolerances hold the `2C` and `R/2` relationships, which is why there is a trim on the shunt at all.

## 02 - Op-amp twin-tee oscillator

Open [Op-amp twin-tee oscillator.asc](02%20-%20Op-amp%20twin-tee%20oscillator/Op-amp%20twin-tee%20oscillator.asc); the [video shortcut](02%20-%20Op-amp%20twin-tee%20oscillator/Video%20380%20-%2002%20-%20Op-amp%20twin-tee%20oscillator.url) opens the design at [8:07](https://www.youtube.com/watch?v=KFVVozlXoOk&t=487s).

![LTspice schematic of the op-amp twin-tee oscillator](02%20-%20Op-amp%20twin-tee%20oscillator/Op-amp%20twin-tee%20oscillator%20schematic.png)

*Page 3 built as drawn: the twin tee returns the output to the inverting input, two 2.2 k resistors hold the non-inverting input at half the 5 V supply, and 0.1 uF bypasses the rail. The shunt is Alan's 4.7 k in series with `RTRIM` standing for his 500 ohm adjustment.*

The move from filter to oscillator is one idea. Negative feedback through a notch means the feedback is weakest at the notch frequency, so the closed-loop gain is highest there. Alan calls it turning the notch into a peaking circuit. Make that peak tall enough and the loop sustains itself at that frequency.

### What the simulation shows, and what it cannot

| Trim | `VPP_EARLY` at 20 to 40 ms | `VPP_LATE` at 280 to 300 ms | `FREQ` |
| ---: | ---: | ---: | ---: |
| 300 ohm | 4.99 V | 4.99 V | 1574 Hz |
| 330 ohm | 4.17 V | 0.154 V | 1584 Hz |
| 380 ohm | 2.53 V | 0.15 mV | 1580 Hz |

![Simulated output at three trim settings](02%20-%20Op-amp%20twin-tee%20oscillator/Oscillator%20trim%20boundary.png)

*Four cycles at each trim setting, taken at 10 ms after start so all three are still visible. At 300 ohm the output is already flat-topped against both rails. At 330 ohm it is a clean sine, but one that is on its way down. At 380 ohm it is further down the same slope.*

The frequency is right in all three cases: 1574 to 1584 Hz, against the notch's 1585 Hz and the 1592 Hz the component values predict. What the model cannot do is settle at an amplitude in between. Below about 325 ohm the loop gain exceeds one and the output grows until the supply rails stop it; above it the gain is below one and the oscillation dies away. The boundary is narrower than 10 ohm on a 500 ohm trim.

That is not a defect in the simulation so much as the thing Alan is warning about on page 1 when he writes "some minor trimming for lowest distortion". An oscillator with no amplitude control has only one stable amplitude, the one its own nonlinearity imposes, and in a linear macromodel that nonlinearity is the rails. On his bench the real op amp's gain falls gently as the output approaches the rails, so there is a settling amplitude below clipping, and at 12:07 his THD meter reads 0.129 percent there.

So the honest reading of this chapter is: the simulation establishes the frequency and shows why the trim exists, and the distortion figure belongs to the bench. Running an FFT on the clipped trace above would measure the clipping, not Alan's oscillator. Video 381 is the follow-up where he trims it while watching the spectrum.

## Models and limits

Both circuits use ideal resistors and capacitors. The oscillator uses the collection's [Microchip MCP6001/2/4 family model, revision E as modified by Bordodynov](../LTspice/Models/Microchip/MCP6001_family_RevE_Bordodynov.lib), standing for one channel of the MCP6002 Alan names. Its own header states that detailed distortion behaviour is not supported, and [Microchip's data sheet](https://ww1.microchip.com/downloads/en/DeviceDoc/MCP6001-1R-1U-2-4-1-MHz-Low-Power-Op-Amp-DS20001733L.pdf) treats modelling as an initial design aid that bench work has to confirm. Any distortion figure from this model would be a property of the model.

`.ic V(out)=2.6` puts 100 mV of offset on the output at t=0 to start the otherwise perfectly balanced circuit. It is a simulator initial condition, not a component, and nothing in the real circuit corresponds to it.
