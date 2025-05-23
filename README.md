# 🚦 Smart Traffic Light Simulator (EMU8086 Assembly)

This project is a **Smart Traffic Light Controller** implemented in **8086 Assembly Language** using the **EMU8086** emulator. It simulates real-world traffic scenarios with support for normal cycling, emergency overrides, high-traffic optimizations, and pedestrian walk signals.

## 🧠 Features

- 🚗 **Normal Traffic Mode**: Cycles through predefined traffic light states.
- 🚶 **Pedestrian Support**: Displays "WALK" or "DON'T WALK" based on light signals.
- 🚨 **Emergency Mode**: Overrides traffic to allow emergency passage in lanes 1–4.
- 🛣️ **High Traffic Mode**: Prioritizes heavy-flow lanes (1+4 or 2+3).
- ⏲️ Real-time simulation with time delays for realism.

## 🛠️ Technologies Used

- **EMU8086** Assembly Language
- DOS Interrupts (`INT 21h`, `INT 15h`, `INT 16h`)
- I/O Port Handling with `OUT` Instruction

## 📂 File Overview

- `Traffic simulator.asm` — Main source file containing all simulation logic.

## 📸 Screenshots (optional)
You can add screenshots or a GIF from EMU8086 showing:
- Startup red light state
- Emergency lane switching
- Walk signal message display

## 🧪 How It Works

### Startup
All traffic lights are set to **RED** using:
```asm
MOV AX, all_red
OUT 4, AX
