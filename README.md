# HitZombi Documentation

## Introduction
HitZombi is a zombie-shooting game based on FPGA and LED matrix display technology, using the **PYNQ-Z2** development board and a **32×64 LED matrix screen** to present the game visuals.

## Main Features
- **FPGA Control**: Game logic is designed using Verilog.
- **LED Display**: The game screen is displayed on a 32×64 LED matrix.
- **Game Controls**: The game is controlled using the buttons on the FPGA board.

## Development Tools
- **Hardware**: PYNQ-Z2 FPGA Development Board
- **Software**: Vivado Development Environment
- **Programming Language**: Verilog

## Game Mechanics
1. **The player controls a character to shoot bullets** at zombies.
2. **Zombies appear from one side of the screen and move gradually**.
3. **Players earn points when zombies are hit**, which are displayed on the LED screen.

## System Architecture
- **The FPGA handles game logic computation and input processing**.
- **The LED matrix displays the game visuals**, providing real-time feedback.
- **Buttons serve as game control inputs**.

## Future Improvements
- Add different types of zombies and difficulty settings.
- Integrate sound effects and richer game scenes.
- Optimize LED display refresh rate to enhance smoothness.

## References
- PYNQ-Z2 Official Documentation
- Vivado Verilog Design Guide
