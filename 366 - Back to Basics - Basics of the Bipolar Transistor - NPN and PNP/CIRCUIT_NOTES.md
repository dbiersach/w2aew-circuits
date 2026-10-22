# Video 366: Back to Basics: Basics of the Bipolar Transistor - NPN and PNP

Source: [Alan Wolke (W2AEW), video 366](https://www.youtube.com/watch?v=IrAUC4ZoNYY). His [handwritten video notes](W2AEW%20Video%20Notes%20-%20Bipolar_Transistor_Basics.pdf) show the NPN circuits discussed below. The video also explains PNP behavior, but the supplied circuit drawings for these two demonstrations use NPN transistors. The video's description corrects some mislabeled curve axes to `VCE`.

| Time | What Alan shows |
| --- | --- |
| [13:14](https://www.youtube.com/watch?v=IrAUC4ZoNYY&t=794s) | [01 - Linear NPN test](#01---linear-npn-test) |
| [19:04](https://www.youtube.com/watch?v=IrAUC4ZoNYY&t=1144s) | [02 - Saturated NPN LED switch](#02---saturated-npn-led-switch) |

An NPN transistor has base, collector, and emitter terminals. Forward bias of the base-emitter junction permits base current. In the active region, that small base current controls a larger collector current. If the collector load limits the current and the base is driven harder, the transistor enters saturation. The two LTspice circuits show those different operating conditions.

## 01 - Linear NPN test

[Video introduction at 13:14](https://www.youtube.com/watch?v=IrAUC4ZoNYY&t=794s) | [Open the LTspice schematic](01%20-%20Linear%20NPN%20test/Linear%20NPN%20test.asc) | [Saved plot settings](01%20-%20Linear%20NPN%20test/Linear%20NPN%20test.plt)

Alan's linear-operation drawing has a base resistor `RB`, a collector resistor `RC`, and a grounded emitter. The collector resistor matters: as collector current increases, it drops more voltage, so collector voltage falls.

The drawing does not give fixed resistor values or a specific NPN part. This LTspice example uses `RB = 30 kΩ`, `RC = 1 kΩ`, a 10 V collector supply, and the built-in 2N3904 model. These are stated simulation choices. The adjustable source `VBASE` sweeps from 0 to 1.5 V. The selected range keeps the transistor in its active region while showing base-emitter turn-on. The collector supply is `VCOL`; the collector *node* is labeled `COLLECTOR` for the voltage measurement.

![LTspice schematic with RB, RC, and an NPN transistor](01%20-%20Linear%20NPN%20test/Linear%20NPN%20schematic.png)

![LTspice DC sweep with collector current above base current](01%20-%20Linear%20NPN%20test/Linear%20NPN%20sweep.png)

The horizontal axis is the swept `VBASE` supply, not `VBE` itself. In the top pane, `Ic(Q1)` rises from essentially zero to about 8 mA. The bottom pane shows `I(RB)`, which is the base current and reaches about 27 µA. Each pane has its own current scale. Around the turn-on region, a small increase in base voltage produces more base current and a much larger increase in collector current. With `RC` in place, the collector voltage is `10 V - I(RC) x 1 kΩ` while Q1 is in the active region.

The SPICE Output Log measures one operating point at `VBASE = 1 V`:

- `IB_AT_1V` is `I(RB) = 10.4896 µA`.
- `IC_AT_1V` is `I(RC) = 3.30999 mA`. This equals collector current because RC and the collector are in series.
- `VCE_AT_1V` is `V(COLLECTOR) = 6.69001 V`. The emitter is grounded, so this is also `VCE`. Ohm's law checks the result: `10 V - (3.30999 mA)(1 kΩ) = 6.69001 V`.
- `BETA_AT_1V` divides collector current by base current: `3.30999 mA / 10.4896 µA = 315.55`.

![LTspice log showing the four measurements at a 1 V base supply](01%20-%20Linear%20NPN%20test/Linear%20NPN%20SPICE%20output%20log.png)

The calculated beta is the **DC current gain of this model at this operating point**, not a fixed property of all 2N3904 transistors. It is higher than the common 100 to 200 teaching estimate. LTspice's built-in 2N3904 model and the chosen collector current and voltage produce this result; a physical part can differ. Alan's point is the relationship between base and collector current, not that every transistor has this exact beta. The collector resistor also means the ratio stops describing active-region gain if Q1 is driven into saturation.

## 02 - Saturated NPN LED switch

[Video introduction at 19:04](https://www.youtube.com/watch?v=IrAUC4ZoNYY&t=1144s) | [Open the LTspice schematic](02%20-%20Saturated%20NPN%20LED%20switch/LED%20transistor%20switch.asc) | [Saved plot settings](02%20-%20Saturated%20NPN%20LED%20switch/LED%20transistor%20switch.plt)

Alan's switch drawing puts an LED and collector resistor in series with the collector. A base resistor connects an adjustable source to the base, and the emitter is grounded. The LTspice example uses a 9 V supply, `RC = 1.5 kΩ`, `RB = 10 kΩ`, the built-in 2N3904 model, and LTspice's `QTLP690C` LED model. The exact LED part is a simulation choice. The model's provenance and revision have not been verified against its manufacturer, so the simulated LED drop and switching threshold are illustrative rather than predictions for Alan's physical LED.

![LTspice LED switch schematic](02%20-%20Saturated%20NPN%20LED%20switch/LED%20switch%20schematic.png)

![LTspice sweep with LED current above collector voltage](02%20-%20Saturated%20NPN%20LED%20switch/LED%20switch%20sweep.png)

The horizontal axis is the swept `VBASE` supply from 0 to 5 V. The upper pane shows `I(RC)`, the current through the LED, resistor, and collector. It rises and then levels near 4.8 mA because the 9 V supply, LED drop, and `RC` limit it. The lower pane shows `V(collector)`, which also equals `VCE` because the emitter is grounded. This voltage falls near zero as Q1 saturates. Past that point, more base current cannot make the collector current rise in proportion to the transistor's active-region beta.

At `VBASE = 5 V`, the log reports `IC_ON = 4.78310 mA` and `VCE_ON = 38.58 mV`. The low `VCE` is the electrical sign of saturation in this model. For a real switch, choose enough base drive to ensure saturation across transistor variation; a forced `IC/IB` ratio around 10 to 20 is a design target, not the transistor's active-region beta.

![LTspice log showing the LED switch measurements](02%20-%20Saturated%20NPN%20LED%20switch/LED%20switch%20SPICE%20output%20log.png)

After pressing Run, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window opens autoscaled instead of showing the saved panes.