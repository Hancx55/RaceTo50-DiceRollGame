# **Dice Rolling Game - RISC-V Assembly**

A two-player dice-rolling race-to-50 game written in RISC-V assembly as part of my Computer Architecture module in university. 

This game runs in RARS simulator and involves random number generation, state management, system calls and branching at a low level. I gained inspiration for this game from the text adventure game genre and have created a simplistic dungeons and dragons style game.

## Gameplay
- The aim of this game is to be the first of two players to reach 50.
- Each player takes turns rolling the dice
- Some rolls will move the player forward normally, while others will prevent movement or cause them to backtrack.
**Special Outcomes**
- 6 = "you have gained a boost! move forward by 8."
- 0 = "the dragon attacks... you are forces to retreat 3 spaces."
- 3 =  "you settle at a small town for a nights rest. you do not move."

## Tech Stack:
- RISC-V Assembly
- RARS Simulator

## Features:
- Two-player turn-based game, players alternate rolling the dice
- Random number generation using RARS system call 42 for the dice rolls
- Certain numbers trigger special outcomes
- Replay option at the end of the game without player needing top exit the program
- Game ending win detection
- Score tracking for both players
- Round counter which increments by 1 at each loop

## Skills Gained:
- Low-level programming experience working with registers and memory directly
- Understanding of RISC-V
- Gained an understanding in assembly state management through score tracking/round progression using registers
- Low-level branching and jump instructions to navigate to different subroutines
- Debugging assembly code by tracing registers as the program steps through instructions
- Games design in a low-level environment with a constrained instruction set

## How To Play:
1. Download RARS: https://github.com/TheThirdOne/rars
2. Open 'dice_game.s'
3. Run the program
4. press r to roll the dice

---
