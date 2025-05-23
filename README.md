# 🚦 Smart Traffic Light Simulator (EMU8086 Assembly)

This is a **Smart Traffic Controller** program written in low-level 8086 assembly, simulating real-world traffic lights using EMU8086. It supports pedestrian signals, high-traffic scenarios, and emergency overrides.

## 🧠 Features

- 🔄 Cycles through pre-defined traffic light patterns.
- 🚨 Emergency lane control (Lanes 1–4).
- 🚗 High traffic mode (prioritizes Lanes 1+4 or 2+3).
- 🚶 Pedestrian signal system ("WALK" or "DON'T WALK").
- ⌛ Real-time delays using BIOS interrupt.

## 🛠️ Technologies

- EMU8086 Assembly
- BIOS & DOS interrupts (`INT 15h`, `INT 16h`, `INT 21h`)
- Port programming with `OUT` instruction

## 🖥️ Screenshots

### 🔄 Normal Operation
![image](https://github.com/user-attachments/assets/40d57d31-80e4-4939-a00b-da78c10f0bb3)

### 🚶 Walk and Don't Walk Prompts
![image](https://github.com/user-attachments/assets/91287224-f79b-4343-b584-1902cbf2e705)


### 🚗 High Traffic Mode (Lanes 1+4 or 2+3)
![image](https://github.com/user-attachments/assets/3662372d-cd29-4cb5-91e5-ebb10496b0f0)


### 🚨 Emergency Override
![image](https://github.com/user-attachments/assets/8ffbe84c-7ec0-47ea-a9a3-6d571b894577)

## 🕹️ Controls

| Key | Function                         |
|-----|----------------------------------|
| `R` | Enter Emergency Mode             |
| `H` | Enter High Traffic Mode          |
| Any | Continue default traffic cycle   |

## 📥 How to Run

1. Open **EMU8086**.
2. Load the `Traffic simulator.asm` file.
3. Compile & run the simulation.
4. Interact using keyboard as per controls.

## 📦 Code Highlights

- Predefined traffic patterns are stored as binary words.
- `OUT 4, AX` sends the pattern to port to control traffic lights.
- Timers use BIOS delay (`INT 15h`).
- Keyboard handled using `INT 16h`.

## 📘 Educational Value

This project is ideal for learning:
- Embedded systems simulation
- Real-time programming
- Assembly-level hardware interfacing
- I/O port control

## 🔖 License

MIT License
