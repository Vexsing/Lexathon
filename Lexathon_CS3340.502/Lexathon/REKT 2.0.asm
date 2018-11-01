		.data
welcome:	.asciiz "                        ~~~~~~~~~ Welcome to Lexathon! ~~~~~~~~~\n"
menu_0:		.asciiz "	                 {               Menu                 }\n"
menu_1:		.asciiz "                         ======================================\n"
menu_2:		.asciiz "	                              1. Start Game\n"
menu_3:		.asciiz "	                              2. Rules\n"
menu_4:		.asciiz "	                              3. Quit Game\n"
menu_prompt:	.asciiz "                                   Choose an option: "
ln:		.asciiz "\n"

rules_1:	.asciiz " Lexathon is a word game where you find as many 4 to 9 letter words before time runs out.\n"
rules_2:	.asciiz "                       Each letter must contain the central letter.\n"
rules_3:	.asciiz "                            Each tile can only be used once.\n"
rules_4:	.asciiz "                    You are given 60 seconds at the start of each game.\n"
rules_5:        .asciiz "                   Each new word found increases your time by 20 seconds.\n"
rules_6:	.asciiz "             The game ends when you give up (by typing 0) or the timer runs out.\n"

		.text
		.globl main
		
		 # include other project files
		.include "playGame.asm"
main:		
	li $v0, 4
	la $a0, welcome
	syscall
	
menu:
	li $v0, 4
	la $a0, menu_1
	syscall
	
	li $v0, 4
	la $a0, menu_0
	syscall

	li $v0, 4
	la $a0, menu_1
	syscall
	
	li $v0, 4
	la $a0, menu_2
	syscall
	
	li $v0, 4
	la $a0, menu_3
	syscall

	li $v0, 4
	la $a0, menu_4
	syscall

	li $v0, 4
	la $a0, menu_prompt
	syscall
	
	# menu choice (user input)
	li $v0, 5
	syscall
	
	beq $v0, 1, begin_game
	beq $v0, 2, print_rules		# input == 2; print rules 
	beq $v0, 3, quit		# input == 3; quit program
	
	j menu
	
begin_game:
	j pickWord
	
quit:	# exits program
	li $v0, 10
	syscall

print_rules:
	li $v0, 4
	la $a0, ln
	syscall

	li $v0, 4
	la $a0, rules_1
	syscall
	
	li $v0, 4
	la $a0, rules_2
	syscall
	
	li $v0, 4
	la $a0, rules_3
	syscall
	
	li $v0, 4
	la $a0, rules_4
	syscall
	
	li $v0, 4
	la $a0, rules_5
	syscall
	
	li $v0, 4
	la $a0, rules_6
	syscall
	
	li $v0, 4
	la $a0, ln
	syscall
	
	j menu
