# Video 387: building and tuning traps for a multi-band EFHW antenna

Source: Alan Wolke (W2AEW), [#387: How to build and tune traps for a multi-band End Fed Half Wave (EFHW) antenna](https://www.youtube.com/watch?v=KIEZmwB8AHw).

| Time | What Alan shows |
| --- | --- |
| [0:36](https://www.youtube.com/watch?v=KIEZmwB8AHw&t=36s) | The antenna kit as it arrives, and what the traps are there to do: make one wire behave as a half wave on more than one band by cutting it electrically at the right place on each. |
| [1:47](https://www.youtube.com/watch?v=KIEZmwB8AHw&t=107s) | The parts laid out, two toroids and two capacitors, one trap for each band. Both [01 - 20m parallel resonant trap](<01 - 20m parallel resonant trap/>) and [02 - 30m parallel resonant trap](<02 - 30m parallel resonant trap/>) come from this one pair of kits of parts; they differ only in the capacitor and the number of turns. |
| [2:58](https://www.youtube.com/watch?v=KIEZmwB8AHw&t=178s) | Winding the toroid, which is where the inductance actually gets decided. |
| [5:20](https://www.youtube.com/watch?v=KIEZmwB8AHw&t=320s) | The finished trap in a test jig, with the capacitor attached across the winding. |
| [6:32](https://www.youtube.com/watch?v=KIEZmwB8AHw&t=392s) | Tuning it on a NanoVNA, watching the resonance move as the turns are spread or squeezed, which is the whole reason the inductance is not a number you can look up. |

## What a trap is, and what these two files are

A trap is an inductor and a capacitor in parallel, inserted in series with the antenna wire. At its resonant frequency that pair is a very high impedance, so the wire beyond it is effectively disconnected and the antenna behaves as if it ended there. Well away from resonance the pair is a much lower impedance and the wire carries on through, so the longer section works on the lower band.

Both files measure one trap the way the bench does: a 50 ohm source on one side, a 50 ohm load on the other, and the trap in series between them. That is what a NanoVNA presents when you measure through a component, and it is the measurement Alan is watching while he adjusts the winding. In the antenna itself the trap sees the wire's impedance rather than 50 ohm, so the depth of the notch on the bench is not the depth it produces in the air.

Three things in these schematics are not from the video and are worth naming individually.

The **capacitor values and the core type**, 15 pF and 33 pF on a T50-2, come from the kit's own [component listing](https://ko-fi.com/s/dd65bda269) rather than from anything said or shown on screen.

The **inductance** is not a given at all, and that is the point of the lesson. Alan sets it by winding and then by spreading or compressing the turns while the analyser watches, so there is no finished value to transcribe. The figures here are simply what each capacitor needs to resonate on the band: 8.3748 uH with 15 pF puts it at 14.2 MHz, and 7.5246 uH with 33 pF puts it at 10.1 MHz, both from f = 1 / (2 pi sqrt(LC)).

The **coil Q** is an assumption, written as `Rser` on the inductor, and it matters more than it looks. A Q of 150 at resonance is plausible for a hand-wound T50-2 trap, which makes `Rser` 5 ohm on the 20 m coil and 3.2 ohm on the 30 m one. With a lossless coil the notch would be infinitely deep and the simulation would be saying nothing; with a finite Q the depth becomes a statement about the winding. The resonant frequency, by contrast, barely depends on it.

## The 20 m trap

[01 - 20m parallel resonant trap/20m trap.asc](<01 - 20m parallel resonant trap/20m trap.asc>)

![20m trap schematic](<01 - 20m parallel resonant trap/20m trap schematic.png>)

![20m trap response](<01 - 20m parallel resonant trap/20m trap response.png>)

![20m trap SPICE output log](<01 - 20m parallel resonant trap/20m trap SPICE output log.png>)

The notch bottoms out at **0.45 mV, or -67 dB**, at 14.2 MHz. The vertical axis is logarithmic because a linear one would show the notch as a line touching zero and nothing else.

Two features of the curve are worth reading rather than skipping. First, the response away from resonance is nowhere near the 0.5 V a plain wire link would pass, because a parallel LC is never a short circuit: it only approaches one at DC through the inductor and at very high frequency through the capacitor, and at 5 MHz the pair still presents a few hundred ohm. Second, the notch is extremely narrow. At 14.35 MHz, the top of the 20 m band and only 150 kHz away, the rejection has already come back by 10 dB to **-56.6 dB**.

## The 30 m trap

[02 - 30m parallel resonant trap/30m trap.asc](<02 - 30m parallel resonant trap/30m trap.asc>)

![30m trap schematic](<02 - 30m parallel resonant trap/30m trap schematic.png>)

![30m trap response](<02 - 30m parallel resonant trap/30m trap response.png>)

![30m trap SPICE output log](<02 - 30m parallel resonant trap/30m trap SPICE output log.png>)

Same circuit, a bigger capacitor and a slightly smaller coil, and the notch lands at 10.1 MHz instead, **0.70 mV or -63 dB**. It is a few dB shallower than the 20 m one because the L to C ratio is lower, which lowers the impedance the pair reaches at resonance for the same Q.

| | Capacitor | Inductance for resonance | Deepest point | At the top of the band |
| --- | ---: | ---: | ---: | ---: |
| 20 m | 15 pF | 8.3748 uH | -67.0 dB at 14.2 MHz | -56.6 dB at 14.35 MHz |
| 30 m | 33 pF | 7.5246 uH | -63.1 dB at 10.1 MHz | -58.1 dB at 10.15 MHz |

The narrowness in both rows is what makes Alan's tuning step necessary rather than optional. A trap whose resonance is a few hundred kilohertz off does not simply work a little less well; it stops cutting the wire where the design intended, and the band it was supposed to create goes with it. That is why the inductance gets adjusted against an analyser on the bench and not calculated and wound once.

If the waveform window opens autoscaled, press Ctrl+Space to reload the saved plot settings.
