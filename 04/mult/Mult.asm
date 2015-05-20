// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
    @R1 // How many times to loop
    D=M // Load point into D
    @R3 // @R3 is our counter
    M=D // Put the counter in place
    @R2
    M=0 // Reset memory for result holder
(LOOP)
    // Check for end condition
    @R3
    D=M
    @END
    D;JEQ // Jump to end if counter is
        // completed
    @R3
    M=D-1 // Decrement counter

    @R0
    D=M // Load number
    @R2
    M=D+M
    @LOOP
    0;JEQ
(END)
    @END
    0;JMP
