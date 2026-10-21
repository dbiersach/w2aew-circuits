# Video 140: op-amp summing amplifiers

Source: [Alan Wolke, *Basics of an Op Amp Summing Amplifier*](https://www.youtube.com/watch?v=juQtVIx1a8g), with his [two-page handwritten notes](W2AEW%20Video%20Notes%20-%20Opamp_summing_amplifier.pdf). He calls the lesson an exercise in superposition: work out what each input would do on its own, then add the results.

| Time | What Alan shows |
| --- | --- |
| [2:00](https://www.youtube.com/watch?v=juQtVIx1a8g&t=120s) | [01 - Inverting summer](#01---inverting-summer) |
| [6:17](https://www.youtube.com/watch?v=juQtVIx1a8g&t=377s) | [02 - Non-inverting summer](#02---non-inverting-summer) |

Both schematics use the resistor values and the two input voltages written on his drawings, 0.5 V on V1 and 1.0 V on V2, on ±15 V supplies. Rather than apply both at once, each simulation steps V1 on at 1 ms and V2 on at 3 ms, so the plot shows one contribution, then the sum, exactly as the superposition argument builds it up. The op-amp is LTspice's bundled OP07 macro-model, selected explicitly in `Value2` because the OP07 symbol otherwise resolves to an LT1001 alias; Alan does not name a part. A `.meas` directive averages the output between 4 ms and 5 ms, after both steps have settled.

After running either simulation, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

## 01 - Inverting summer

[Open the inverting configuration at 2:00](https://www.youtube.com/watch?v=juQtVIx1a8g&t=120s) · [Schematic](01%20-%20Inverting%20summer/Inverting%20summer.asc) · [Saved plot settings](01%20-%20Inverting%20summer/Inverting%20summer.plt)

V1 reaches the inverting input through R1 = 5 kΩ and V2 through R2 = 10 kΩ, with RF = 20 kΩ around the amplifier and the non-inverting input grounded.

![LTspice inverting summer schematic](01%20-%20Inverting%20summer/Inverting%20summer%20schematic.png)

Because the non-inverting input is held at ground and the feedback loop keeps the two inputs at the same voltage, the junction of R1, R2 and RF is a *virtual ground*. Each source therefore drives its own resistor into a fixed 0 V point and neither source can see the other. That is the property Alan lists first: each input sees a fixed load, and there is no interaction between inputs. The current each one pushes into the node has to return through RF, so

`Vout = -RF(V1/R1 + V2/R2) = -20k(0.5/5k + 1.0/10k) = -4 V`

![Inverting summer output above its two inputs](01%20-%20Inverting%20summer/Inverting%20summer%20waveforms.png)

The bottom pane shows the two inputs stepping on; the top pane shows the output. V1 alone drives the output to -2 V, which is -(0.5 V)(20k/5k). When V2 adds its own -(1.0 V)(20k/10k) = -2 V at 3 ms, the output moves to -4 V. The small spikes at each step edge are the amplifier's slew-limited response to a 1 µs edge, not ringing in the summing network.

![Measured final output](01%20-%20Inverting%20summer/Inverting%20summer%20SPICE%20output%20log.png)

The measured average between 4 ms and 5 ms is -3.99971 V against the ideal -4 V, the difference being the OP07's finite gain and offset.

## 02 - Non-inverting summer

[Open the non-inverting configuration at 6:17](https://www.youtube.com/watch?v=juQtVIx1a8g&t=377s) · [Schematic](02%20-%20Non-inverting%20summer/Non-inverting%20summer.asc) · [Saved plot settings](02%20-%20Non-inverting%20summer/Non-inverting%20summer.plt)

The same two sources now drive the *non-inverting* input through R1 = 5 kΩ and R2 = 10 kΩ, while the inverting input carries the usual gain-setting pair, RI = 10 kΩ to ground and RF = 10 kΩ from the output.

![LTspice non-inverting summer schematic](02%20-%20Non-inverting%20summer/Non-inverting%20summer%20schematic.png)

Here there is no virtual ground. R1 and R2 meet at a single node that is free to move, so the two sources form a resistive divider against each other and the node settles at the conductance-weighted average of the two inputs. The non-inverting gain `1 + RF/RI = 2` then multiplies it:

`Vout = (1 + RF/RI)(V1·R2 + V2·R1)/(R1 + R2) = 2 × (0.5×10k + 1.0×5k)/15k = 1.333 V`

![Non-inverting summer output above its two inputs](02%20-%20Non-inverting%20summer/Non-inverting%20summer%20waveforms.png)

V1 alone brings the output to 2 × (0.5 V)(10k/15k) = 0.667 V, and adding V2 takes it to 1.333 V.

![Measured final output](02%20-%20Non-inverting%20summer/Non-inverting%20summer%20SPICE%20output%20log.png)

The measured average is 1.33339 V.

Note what the arithmetic says about the two inputs. V1's contribution contains R2 and V2's contains R1, so each input's weight depends on the *other* resistor, and the load each source sees depends on what the other source is doing. Those are the two drawbacks Alan lists on his second page, together with the fact that any real source impedance adds itself to R1 or R2 and changes both weights. His suggested way out is also on that page: build the sum in the inverting configuration, where the inputs stay independent, and follow it with a unity-gain inverting stage to restore the sign.

Both circuits use ideal voltage sources with no series resistance, which is why the simulated results land on the ideal arithmetic. On a bench, decouple the supplies close to the op-amp package.
