# Video 289: Zener diodes

Source: [Alan Wolke (W2AEW), *Back to Basics: Zener Diodes*](https://www.youtube.com/watch?v=jfstUsnCmao). Alan's hand-drawn notes are in [W2AEW Video Notes - Basics_of_Zener_Diodes.pdf](W2AEW%20Video%20Notes%20-%20Basics_of_Zener_Diodes.pdf).

| Time | What Alan shows |
| --- | --- |
| [3:15](https://www.youtube.com/watch?v=jfstUsnCmao&t=195s) | [01 - Shunt test and breakdown comparison](#01---shunt-test-and-breakdown-comparison) |
| [12:20](https://www.youtube.com/watch?v=jfstUsnCmao&t=740s) | [Zener against avalanche breakdown](#zener-against-avalanche-breakdown) |

## 01 - Shunt test and breakdown comparison

[Open the schematic](01%20-%20Zener%20shunt%20test%20and%20comparison/Zener%20shunt%20test%20and%20comparison.asc) · [Saved plot settings](01%20-%20Zener%20shunt%20test%20and%20comparison/Zener%20shunt%20test%20and%20comparison.plt) · [Video at 3:15](https://www.youtube.com/watch?v=jfstUsnCmao&t=195s)

At about 3:15 Alan sets up an adjustable DC supply, an ammeter, a **330 Ω series resistor**, and a reverse-biased Zener with a voltmeter across it. The schematic drives two such branches from one supply so that a 4.7 V and a 6.8 V device can be compared in a single DC sweep. The second branch is there for the comparison Alan makes later in the video; it is not a second branch on his breadboard.

![LTspice Zener shunt test schematic](01%20-%20Zener%20shunt%20test%20and%20comparison/Zener%20shunt%20test%20and%20comparison%20schematic.png)

After running the sweep, press Ctrl+Space (Plot Settings > Reload Plot Settings) if the waveform window does not pick up the saved `.plt`.

![Simulated Zener voltage and current against supply voltage](01%20-%20Zener%20shunt%20test%20and%20comparison/Zener%20voltage%20and%20current%20sweep.png)

The top pane holds the supply voltage and both Zener voltages, the bottom pane the current in each 330 Ω resistor. Below breakdown each diode passes almost nothing, so its voltage simply follows the supply and the three voltage traces lie on top of each other. Once a device breaks down its trace flattens: every further volt from the supply appears across the resistor instead, and the current rises as

`I = (V_supply - V_Z) / 330 Ω`

This is shunt regulation. It needs the series resistor to survive, and it draws current continuously whether or not anything is using the regulated voltage. The 6.8 V device needs a higher supply before it carries any appreciable current, and at a given supply it carries less, because more of the supply is dropped inside the diode and less across the resistor.

![Measured voltages and currents at a 10 V supply](01%20-%20Zener%20shunt%20test%20and%20comparison/Zener%20shunt%20SPICE%20output%20log.png)

| At a 10 V supply | Diode voltage | Resistor current |
| --- | ---: | ---: |
| 4.7 V branch | 4.621 V | 16.30 mA |
| 6.8 V branch | 6.761 V | 9.81 mA |

Alan's bench at about [6:50](https://www.youtube.com/watch?v=jfstUsnCmao&t=410s) reads approximately **4.70 V and 16.13 mA** from a 9.96 V supply. The simulated 4.7 V branch comes within 80 mV and 0.2 mA of that, which is as close as a generic model should be expected to get; it is not a reproduction of his individual diode.

## Zener against avalanche breakdown

Alan uses "Zener diode" as the ordinary name for the part but explains that two different mechanisms are at work. Lower-voltage devices break down mostly by Zener tunnelling; higher-voltage devices mostly by avalanche multiplication; around 5 V to 6 V both contribute, which is also where the temperature coefficient passes through zero. His curve-tracer comparison of 4.7 V and 6.8 V devices begins near [12:20](https://www.youtube.com/watch?v=jfstUsnCmao&t=740s).

The sweep above shows the two devices' different thresholds, which is all it can show. It does **not** establish which microscopic mechanism is present in either part, and it does not model the temperature-coefficient contrast at the centre of that part of his talk, because it is a 27 °C electrical model with no self-heating. For that distinction, use Alan's curve-tracer footage together with a [manufacturer data sheet](https://www.diodes.com/datasheet/download/1N4728A%20%28Discontinued%29.pdf), which lists the test current and the temperature-coefficient range for each voltage in the family.

## Source and model limits

The video and the notes give the Zener voltages and the 330 Ω resistor but do not identify the diode part numbers. The schematic therefore uses **representative** 1N4732A (4.7 V) and 1N4736A (6.8 V) subcircuits from the Diodes Inc. library, kept in the shared [model file](../LTspice/Models/Diodes-Inc/1N4732A_1N4736A.lib). They are not claimed to be Alan's devices. No instrument loading is modelled either; his voltmeter and ammeter draw current from the branch under test, and his supply has its own output impedance.
