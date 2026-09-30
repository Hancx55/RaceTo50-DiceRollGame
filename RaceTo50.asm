#Dice rolling game - race to 50
.data
     
welcome: .string "\nWELCOME TO THE DICE ROLLING GAME!\n this is a two player game in which you must aim to reach the castle before the other player"
instructions: .string "\nyou will take turns to roll a dice, but not all numbers are safe! rolling a 0 will cause a dragon to attack you! forcing you to move back 3 spaces.\n Rolling a 6 will give you a boost! moving forward by 8.\nFinally, rolling a 3 means you will settle in a small town for a night, missing a go."
start: .string "\nready to start? y/n"
round: .string "\nROUND "

p1: .string "\nPlayer 1"
p2: .string "\nPlayer 2"
roll: .string "'s turn: press r to roll"

result: .string " has rolled a "
score: .string "\nScore: "

normal: .string ", you move forward as usual."
six: .string " and has gained a boost! move forward by 8"
null: .string ", the dragon attacks... you are forces to retreat 3 spaces."
three: .string ", you settle at a small town for a nights rest. you do not move."

winner: .string " has won!!!"
restart: .string "\n play again? y/n"

.text

setup:
addi s0, zero, 121 #yes
addi s1, zero, 110 #no
addi s3, zero, 0 #round counter
addi s4, zero, 114 #roll
addi s6, zero, 50 #goal 

addi s7, zero, 6 #six
addi s8, zero, 3 #three
addi s9, zero, 0 # zero

#resetting scores
addi t5, zero, 0
addi t6, zero, 0

#instructions outputted
menu:
la a0, welcome
jal stringOutputs

la a0, instructions
jal stringOutputs

ready:
la a0, start
jal stringOutputs

#ready to play?
jal charInput
beq a0, s1, menu
beq a0, s0, startGame
b ready

startGame:

       
         
loop:
    #rounds
         addi s3, s3, 1
         la a0, round
         jal stringOutputs
         add a0, zero, s3
         jal intOutputs
         
         #player1 go
         la a2, p1
         addi s10, zero, 1
         j turn
p1Ret:
         #adding any changes
         add t5, t5, t0
         addi t0, zero, 0
         la a0, score
         jal stringOutputs
         add a0, zero, t5
         jal intOutputs
         
         #player2 go
         la a2, p2
         addi s10, zero, 2
         j turn
p2Ret:
         #adding any changes
         add t6,t6,t0
         addi t0,zero,0
         la a0, score
         jal stringOutputs
         add a0, zero, t6
         jal intOutputs
         
         bge t5, s6, p1Win
         bge t6, s6, p2Win
         
         b loop
         
exit:
li a7, 10
ecall

p2Win:
     la a0, p2
     jal stringOutputs
     j winMsg

p1Win:
     la a0, p1
     jal stringOutputs
     j winMsg

winMsg:
     la a0, winner
     jal stringOutputs
restarting:
     la a0, restart
     jal stringOutputs
     jal charInput
     beq a0, s0, setup
     beq a0, s1, exit
     b restarting

turn:
   mv a0, a2
   jal stringOutputs
   la a0, roll
   jal stringOutputs
playerRoll:
       jal charInput
       bne a0, s4, playerRoll
       
       #dice roll
       jal randNumGen
       add s5, zero, a0
       
       #results outputted
       mv a0, a2
       jal stringOutputs
       la a0, result
       jal stringOutputs
       add a0, zero, s5
       jal intOutputs
       
       #branching for outcomes
       beq s5, s7, boost
       beq s5, s9, back
       beq s5, s8, miss
       b addition

      
boost:
    la a0, six
    jal stringOutputs
    addi t0, zero, 8
    b returning
    
back:
   la a0, null
   jal stringOutputs
   addi t0, zero, -3
   b returning
   
miss:
   la a0, three
   jal stringOutputs
   b returning

addition:
   la a0, normal
   jal stringOutputs
   add t0, zero, s5 
   b returning

returning:
       addi s10, s10, -1
       bgtz s10, p2Ret
       b p1Ret

stringOutputs:
         li a7, 4
         ecall
         ret
         
intOutputs: 
         li a7, 1
         ecall
         ret

charInput:
      li a7, 12
      ecall
      ret
      
randNumGen:
        li a0, 0
        li a1, 7
        li a7, 42
        ecall
        ret
        
