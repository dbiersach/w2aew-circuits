# Video 328: op amp signal conditioning, a practical example

Source: Alan Wolke (W2AEW), [#328: Circuit Fun: Op Amp Signal Conditioning - a Practical Example](https://www.youtube.com/watch?v=OlhN7ADpKds). His four-page design walkthrough is kept here as [W2AEW Video Notes - OpAmpSignalConditioning.pdf](<W2AEW Video Notes - OpAmpSignalConditioning.pdf>).

| Time | What Alan shows |
| --- | --- |
| [0:27](https://www.youtube.com/watch?v=OlhN7ADpKds&t=27s) | The problem, stated as two numbers: a sensor that puts out 2.5 V has to become 0 V, and one that puts out 0.5 V has to become 5 V. He draws it as a pair of lines crossing, which makes the inversion obvious at a glance. |
| [2:15](https://www.youtube.com/watch?v=OlhN7ADpKds&t=135s) | Choosing R1 and R2. A 2 V fall at the input has to become a 5 V rise at the output, so the gain is -2.5. He picks R1 = 33k for the sensor loading he wants, which makes R2 = 82k at the nearest standard value, then works out what the non-inverting input has to sit at. |
| [4:04](https://www.youtube.com/watch?v=OlhN7ADpKds&t=244s) | Finishing the design: a single 5 V rail, why that forces a rail-to-rail op amp whose input common-mode range includes 1.78 V, the MCP6002 he settles on, and the 27k over 15k divider that makes the 1.78 V. |
| [5:52](https://www.youtube.com/watch?v=OlhN7ADpKds&t=352s) | The circuit built on a breadboard and measured. |
| [7:40](https://www.youtube.com/watch?v=OlhN7ADpKds&t=460s) | Page 4, the final circuit drawn out in one piece, which is what [01 - Sensor signal conditioner](<01 - Sensor signal conditioner/>) transcribes. |

## How the design falls out

This chapter is unusual in having nothing to assume: Alan derives every value on camera, and all five of them are here.

The requirement is two points on a line. The input falls by 2 V while the output rises by 5 V, so the stage inverts with a gain of 2.5, and an inverting op amp gets that from R2 / R1. He picks R1 = 33k on the grounds of how much the amplifier loads the sensor, which makes R2 = 33k x 2.5 = 82.5k, and 82k is the nearest standard value.

An inverting stage on a single supply needs its non-inverting input lifted off ground, and the amount is fixed by either end of the required mapping. Taking the 2.5 V in, 0 V out case, the input node is a plain divider between the 2.5 V sensor and the 0 V output, so the voltage there is 2.5 V x 82 / (33 + 82) = **1.78 V**. That is the number the non-inverting input has to match, and 27k over 15k across the 5 V rail gives 1.7857 V.

Only then does the op amp get chosen, and the choice follows from the numbers rather than preceding them. The supply is 5 V, the output has to reach both rails, and the input common-mode range has to include 1.78 V. The MCP6002 does all three in a DIP package.

## The final circuit

[01 - Sensor signal conditioner/Sensor signal conditioner.asc](<01 - Sensor signal conditioner/Sensor signal conditioner.asc>)

![Sensor signal conditioner schematic](<01 - Sensor signal conditioner/Sensor signal conditioner schematic.png>)

Page 4's circuit exactly: R1 33k into the inverting input, R2 82k around the op amp, the 27k and 15k divider holding the non-inverting input at `VOFFSET`, and a single 5 V rail.

The sensor itself is a swept voltage source here. On the bench Alan makes one out of 12k, a 10k pot and 2.2k across the 5 V rail, buffered by the MCP6002's second channel; those end resistors are what set the range, giving 5 V x 2.2 / 24.2 = 0.45 V at one end of the pot's travel and 5 V x 12.2 / 24.2 = 2.52 V at the other, which brackets the 0.5 V to 2.5 V he needs. Sweeping a source directly does the same job and makes the sweep itself the measurement.

The model is the single-channel MCP6001 from Microchip's MCP6001/2/4 family library, which is one channel of the dual MCP6002. `.options gminsteps=0` is there because without it the macromodel takes several hundred lines of the log to converge at each sweep point; the results are the same either way, and LTspice suggests that option itself.

![Sensor signal conditioner transfer](<01 - Sensor signal conditioner/Sensor signal conditioner transfer.png>)

A straight line between two flat ends, which is what a conditioner should look like. The output saturates at the rails outside the sensor's range, which is the behaviour the rail-to-rail part was chosen for.

![Sensor signal conditioner SPICE output log](<01 - Sensor signal conditioner/Sensor signal conditioner SPICE output log.png>)

| Sensor input | Alan's target | Simulated |
| --- | --- | --- |
| 0.5 V | 5 V | **4.979 V** |
| 2.5 V | 0 V | **8.9 mV** |
| Offset at the non-inverting input | 1.78 V | **1.7857 V** |

Both endpoints land about 20 mV from target, and the reason is standard values rather than the op amp. 82k over 33k is a gain of 2.4848 rather than 2.5, and 27k over 15k gives 1.7857 V rather than 1.783 V. Put those two into the stage's equation, output = VOFFSET x (1 + R2/R1) - Vin x R2/R1, and it predicts 4.981 V and 11 mV, which is what the simulation returns to within a couple of millivolts. The amplifier is doing exactly what the resistors tell it to.

That is worth noticing because 20 mV out of 5 V is 0.4 percent, and it is the error you inherit by rounding to the E24 series. Alan's own closing list on page 4 names the fix among the things a real build wants: trimmers to adjust the gain and the offset, along with supply decoupling, attention to input bias current, and input offset trimming.

If the waveform window opens autoscaled, press Ctrl+Space to reload the saved plot settings.
