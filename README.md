# HitZombi Documentation

## Introduction
HitZombi is a zombie-shooting game based on FPGA and LED matrix display technology, using the **PYNQ-Z2** development board and a **32×64 LED matrix screen** to present the game visuals.

<img src="https://github.com/user-attachments/assets/b9fcb5a3-5a06-4287-b6a9-1a841a4ed1f1" width="250" height="250">
ShotZombie is a casual game developed by Capsule+ (面白革命capsule+). The best platform to play ShotZombie on a computer is through the Thunder Emulator, which provides powerful features for an immersive gaming experience.

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
2. **Zombies appear from the top of the screen and move downward at a constant speed**.
3. **The game starts when button3 is pressed**, and the board is divided into three sections, each containing a zombie that randomly appears at the top.
4. **Players must press the corresponding button when a zombie reaches the bottom**:
   - If the correct button is pressed, the zombie disappears, and the score increases by 1.
   - If missed, the zombie remains on the screen until hit.
5. **Each game session lasts 30 seconds**, after which the game ends and can be restarted.

## System Architecture
- **The FPGA handles game logic computation and input processing**.
- **The LED matrix displays the game visuals**, providing real-time feedback.
- **Buttons serve as game control inputs**.
- **Required Components**:
  - Breadboard
  - RPG matrix
  - Resistors
  - FPGA board
  - Jumper wires

### **Program Structure**
- The game operates by converting the desired graphics into a bitmap format.
- **Core Components**:
  - **Data Driver**: Controls game stages (idle, ready, gaming, finish).
  - **Random Number Generator**: Generates six random values (1-3) to determine zombie positions.
  - **Picture Shifter**: Uses random numbers to print corresponding zombie images and shifts them onto the screen.
  - **Detector**: Detects button presses and determines if the correct zombie is hit.
  - **Zombie Timer**: Manages the 30-second game duration and signals game completion.

### **Game Flow**
1. The game initializes in the **idle state**.
2. The system enters the **ready state**, signaling readiness and generating six random numbers.
3. The **gaming state** begins:
   - Random numbers are sent to the picture shifter to display zombies.
   - Zombies shift down frame by frame.
   - Player input is detected through buttons.
   - If the correct zombie is hit, the score updates, and the screen refreshes.
4. After 30 seconds, the **finish state** triggers the game over sequence.

**Game Architecture Diagram:**

![Screenshot 3](upload:IMG_0728.png)

**Waveform Diagram:**

![Screenshot 1](upload:螢幕擷取畫面 2024-06-24 153232.png)

![Screenshot 2](upload:螢幕擷取畫面 2024-06-24 153304.png)

## Full Source Code
The complete source code is available in the **PZ_v2** folder.

## Future Improvements
- Add different types of zombies and difficulty settings.
- Integrate sound effects and richer game scenes.
- Optimize LED display refresh rate to enhance smoothness.

## References
- PYNQ-Z2 Official Documentation
- Vivado Verilog Design Guide
