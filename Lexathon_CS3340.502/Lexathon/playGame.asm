			.data
wordList:		.space 		5500
words:			.ascii 	 	"abrogated", "altruisms", "broodmare", "careening", "causative",
					"contusing", "courteous", "dislocate", "druidisms", "frumpiest",
					"gateposts", "gawkiness", "guideline", "hamburger", "humorless",
					"jiggliest", "misshapen", "mugginess", "optically", "physicist",
					"polishers", "repugnant", "resorters", "restricts", "sanitaria",
					"scentless", "sebaceous", "spectrums", "uncovered", "underlays",
					"uprooting", "allotment", "announcer", "blubbered", "chaunters",
					"cinnabars", "congruity", "dignifies", "euphonium", "fuselages",
					"hooraying", "lifebuoys", "liverymen", "megacycle", "mundanely",
					"perplexed", "photocell", "referring", "relearned", "seditions",
					"sixteenth", "synthesis", "trillions", "upsurging", "acoustics",
					"augmented", "bickerers", "bolstered", "citations", "conformer",
					"conspired", "dashboard", "defectors", "deviating", "dissipate",
					"evaluates", "faceplate", "harebells", "interline", "interrupt",
					"mackerals", "massacred", "mediators", "misquoted", "mulattoes",
					"mullioned", "paradoxes", "parallels", "paramecia", "pattering",
					"peepshows", "postpones", "protector", "recouping", "redbreast",
					"restrings", "retracted", "saintlier", "satanical", "shackling",
					"snakelike", "strangely", "waterline"
textFile:		.asciiz 	".txt"
startTime:		.word		1
fileName:		.space		20
nineLetters:		.space		10
buffer:			.space		100
loadMsg:		.asciiz 	"\nLoading... Please wait for a prompt message...\n"
readErrorMsg:		.asciiz 	"\nError in reading file\n"
openErrorMsg:		.asciiz		"\nError in opening file\n"
instr:			.asciiz 	"Enter 0 to give up or 1 to shuffle the board."
timeUpMsg:		.asciiz		"Time is up!!!\n"
newLine:		.asciiz		"\n"
notFound:		.asciiz 	"\nWords not found:"
allWordsFound:		.asciiz 	"\nCongratulations! You win!"

box_0:			.asciiz 	"	 ___________\n"
box_1:			.asciiz 	"	|   |   |   |\n"
box_2:			.asciiz 	"	| "
box_3:			.asciiz 	" | "
box_4:			.asciiz 	" |\n"
box_5:			.asciiz 	"	|___|___|___|\n"
askString:		.asciiz		"Enter a word: "
inputArray:		.asciiz		"         \n"
nonexistWord:		.asciiz		"Word does not exist or word does not contain middle letter or word has already been found"
wrongLength:		.asciiz		"Error. Word must be between 4 and 9 letters"
goodJob:		.asciiz		"\nYou found a valid word!\n"
scoreResult:		.asciiz		"\nYour Score: "
test:			.asciiz		"\nGame over!"
timeRem:		.asciiz		"Time remaining: "
sec:			.asciiz		" seconds\n"
ofMsg:			.asciiz		" of "
foundMsg:		.asciiz		" words found\n"

			.text
		
pickWord: 

	li $v0, 42		# generate random number from 0-30 (to pick which 9 letter word)
	li $a1, 93
	syscall
	
	la $t1, words		# load address of words (the array of 9 letter words)
	mul $a0, $a0, 9		# multiply random number by 9 to start at the beginning of word
	add $t1, $t1, $a0	# bytewise where to start
	
	la $t9, fileName	# $t9 has fileName address. 
	li $t2, 0		# $t2 is counter variable
	li $t3, 9		# $t3 is upper bound/limit
	
storeNineWord:
	beq $t2, $t3, endLoop	# condition if counter equal limit
	lb $t4, ($t1)		# load byte of the 9-letter word into $t4
	sb $t4, ($t9)		# store byte $t4 into the contents of fileName
	addi $t9, $t9, 1	# iterate fileName
	addi $t1, $t1, 1	# iterate words array
	addi $t2, $t2, 1	# iterate counter
	
	j storeNineWord
endLoop:
	
	li $t2, 0		# rest counter
	li $t3, 5		# change upper bound/limit
	la $t6, textFile	# $t6 is address of textFile (.txt)
	
addTextFile:
	beq $t2, $t3, endLoop2	# condition if counter equals limit
	
	lb $a0, 0($t6)		# load byte of textFile into $a0
	sb $a0, ($t9)		# store byt $a0 into contents of fileName
	addi $t9, $t9, 1	# iterate fileName
	addi $t6, $t6, 1	# iterate textFile
	addi $t2, $t2, 1	# iterate counter
	
	j addTextFile
endLoop2:
	li $a0, '\0'		# load null char to $a0
	sb $a0, ($t9)		# store null char into fileName

	li $t2, 0		# reset counter to 0
	li $t3, 9		# change limit to 9
	la $t4, fileName	# $t4 has index 0/address of fileName
	la $t5, nineLetters	# $t5 has address of nineLetters
	
genGrid:
	beq $t2, $t3, endLoop4	# condition if counter equals limit
	
	lb $t1, ($t4)		# load byte of fileName into $t1
	sb $t1, ($t5)		# store byte of $t1 into nineLetters
	addi $t4, $t4, 1	#iterate fileName
	addi $t5, $t5, 1	# iterate nineLetters
	addi $t2, $t2, 1	# iterate counter
	
	j genGrid
endLoop4:
	li $t2, 0		# reset counter to 0
	la $t5, nineLetters	# $t5 has index 0/address of nineLetters

firstShuf: 
	beq $t2, $t3, endLoop5	# condition if counter equals limit
	
	li $v0, 42		# generate random number from 0 - 8
	li $a1, 9
	syscall
	
	lb $t6, ($t5)		# shuffle stuff
	la $t8, nineLetters
	add $t8, $t8, $a0	
	lb $t7, ($t8)
	sb $t6, ($t8)
	sb $t7, ($t5)
	
	addi $t5, $t5, 1	# iterate nineLetters
	addi $t2, $t2, 1	# iterate counter
	j firstShuf
	
endLoop5:
	la $t5, nineLetters
	lb $s2, 4($t5)		# store/track middle letter. 
	
	jal displayBoard
	li $s5, 0		# score counter
	li $v0, 4
	la $a0, loadMsg
	syscall

setupYo:
	li $s6, 0		# Counter for total words
	li $s7, 0		# Counter for words found
	
	jal openFile
	
	li $a0, '*'		
	sb $a0, wordList($t0)		# Storing * at end of wordFile
	
	li $v0, 4
	la $a0, instr
	syscall	
		
	li $s3, 60			# start the game with 60 seconds
	li $v0, 30			# initial system time
	syscall
	sw $a0, startTime		# store in direct memory
	
	j readString
	j endProgram

# Open the file
openFile:
	li $v0, 13
	la $a0, fileName
	li $a1, 0
	li $a2, 0
	syscall
	bltz $v0, openError
	move $s0, $v0	
	
# Set array
	add  $t0, $zero, $zero 	# Index of array

# Read one word in
readFile:
	li $v0, 14		# Read in a word
	move $a0, $s0
	la $a1, buffer
	li $a2, 10
	syscall
	bltz $v0, readError
	
	move $s1, $a0
	
# See if end of file has been reached
	xor $a0, $a0, $a0
	lbu $a3, buffer($a0)
	beq $a3, '*', astFound
	j letterValidation
astFound:
	j closeFile
	
# Input validation for middle letter ... $s2 contains middle letter
letterValidation:
	xor $a0, $a0, $a0
search:
	lbu $a3, buffer($a0)
	beq $a3, $s2, found
	addiu $a0, $a0, 1
	bne $a0, $a2, search
not_found:
	j readFile
found:
	xor $a0, $a0, $a0
	addi $s6, $s6, 1		# Increment total words
	
storeWord:
	lbu $a3, buffer($a0)
	sb $a3, wordList($t0)
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	beq $a0, $a2, readFile
	j storeWord
	
closeFile:
	li $v0, 16
	move $a0, $s0
	syscall
	jr $ra
	
openError:
	la $a0, openErrorMsg
	li $v0, 4
	syscall
	j endProgram
	
readError:
	la $a0, readErrorMsg
	li $a0, 4
	syscall
	j endProgram
	
# USER ENTERS A STRING
readString:
	li $v0, 4		# put new line
	la $a0, newLine
	syscall

	li $v0, 4		# print askString prompt
	la $a0, askString
	syscall
	
	li $v0, 8		# read input string
	la $a0, buffer
	la $a1, 64
	syscall 

checkTime:
	lw $t0, startTime	# initial system time
	li $v0, 30		# current system time
	syscall
	
	sub $t0, $a0, $t0
	div $t0, $t0, 1000	# convert ms to seconds
	sub $t0, $s3, $t0

	blez $t0, timeUp	# jump to the end if time is up
	j zeroOrOne

timeUp:
	li $v0, 4		# print error message
	la $a0, timeUpMsg
	syscall	
	
	li $v0, 10		# exit the program
	syscall

zeroOrOne:
	lb $t0, buffer($0)		# gets first char in buffer
	li $t1, '0'			# ends if user inputs 0
	beq $t0, $t1, endProgram
	li $t1, '1'			
	bne $t0, $t1, lenCountReset	# continues executing code if first char is neither 0 or 1
	jal shuffleLetters		# shuffles board if user inputs 1
	j readString			# returns from shuffling to prompt user for a new input
	
lenCountReset:
	li $t0, 0			# set length count to 0 for lengthLoop
	
lengthLoop:				# loops and counts string length until \n is found
	lb $t1, buffer($t0)
	li $t2, '\n'
	beq $t1, $t2, checkLength	# branches if character in buffer is \n
					# (last char of user input in buffer)
	addi $t0, $t0, 1
	j lengthLoop
	
checkLength:
	blt $t0, 4, wrongLen	# input string is too short
	bgt $t0, 9, wrongLen	# input string is too long
				# otherwise, continue bc string length is valid
	li $t0, 0		
	la $t2, inputArray
clearLoop:
	beq $t0, 9, continStore
	li $t1, ' '
	sb $t1, inputArray($t0)
	addi $t0, $t0, 1
	j clearLoop

continStore:	
	li $t0, 0		# array index
	li $t1, 0		# array index for inputArray

	j storeString

wrongLen:
	li $v0, 4
	la $a0, wrongLength	# print error message for 
	syscall			# wrong string length
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4			# display time
	la $a0, timeRem
	syscall
				# find time remaining
	lw $t0, startTime	# initial system time
	li $v0, 30		# current system time
	syscall
	
	sub $t0, $a0, $t0
	div $t0, $t0, 1000	# convert ms to seconds
	sub $t0, $s3, $t0
	
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, sec
	syscall
	
	j readString	
	
storeString:
	lbu $a1, buffer($t0)		# Put input-word letter into $a1
	beq $a1, '\n', reset		# If $a1 = \n, end editting array (so that inputArray will still have spaces and \n)
	sb $a1, inputArray($t0)		# Store input-word letter into inputArray
	addi $t0, $t0, 1		# Increment array index
	j storeString

reset:
	li $t0, 0		# array index
	li $t1, 0		# array index for inputArray

compareStrings:
	lbu $a1, inputArray($t1)
	lbu $a2, wordList($t0)
	beq $a1, $a2, incrementIndex	# branch if first letters equal
	beq $a2, '*', endOfFile
	addi $t0, $t0, 10
	j compareStrings
	
incrementIndex:
	# Once you get here, $t4 = next index in inputArray 	$t3 = addr of word + next index
	li $t2, 0 		# Array size counter
	move $t4, $t1		# To save $t1
	move $t3, $t0		# To save $t0
	addi $t4, $t4, 1
	addi $t3, $t3, 1
	
character:
	beq $t2, 9, setEmptyTheWord	# Branch when end of word has been reached
	lbu $a1, inputArray($t4)
	lbu $a2, wordList($t3)
	addi $t2, $t2, 1
	addi $t4, $t4, 1
	addi $t3, $t3, 1
	beq $a1, $a2, character		# Branch if word is still same
	add $t0, $t0, 10		# Executes if word isn't same
	j compareStrings		# Executes if word isn't same
	
setEmptyTheWord:
	li $t5, 0	# 0 to clear word
	li $t6, 0	# counter to 9
	addi $t3, $t3, -1
	addi $t0, $t0, 10
	
emptyTheWord:
	beq $t6, 10, incrementPoints
	sb $t5, wordList($t3)
	addi $t3, $t3, -1
	addi $t6, $t6, 1
	j emptyTheWord
	
incrementPoints:
	addi $s5, $s5, 10		# Increment score if word is in dictionary
	addi $s3, $s3, 20		# Add twenty seconds to time if word is in dictionary
	addi $s7, $s7, 1		# Increments words found
	
	li $v0, 4
	la $a0, goodJob
	syscall
	
	li $v0, 4			# display time
	la $a0, timeRem
	syscall
				# find time remaining
	lw $t0, startTime	# initial system time
	li $v0, 30		# current system time
	syscall
	
	sub $t0, $a0, $t0
	div $t0, $t0, 1000	# convert ms to seconds
	sub $t0, $s3, $t0
	
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, sec
	syscall
	
	li $v0, 1				# display words found of words possible
	move $a0, $s7
	syscall
	li $v0, 4
	la $a0, ofMsg
	syscall
	li $v0, 1
	move $a0, $s6
	syscall
	li $v0, 4
	la $a0, foundMsg
	syscall
	
	beq $s6, $s7, allFound
	
	j readString
	
endOfFile:
	li $v0, 4
	la $a0, nonexistWord
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4			# display time
	la $a0, timeRem
	syscall
				# find time remaining
	lw $t0, startTime	# initial system time
	li $v0, 30		# current system time
	syscall
	
	sub $t0, $a0, $t0
	div $t0, $t0, 1000	# convert ms to seconds
	sub $t0, $s3, $t0
	
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 4
	la $a0, sec
	syscall
	
	j readString
	
endProgram:
	li $v0, 4		
	la $a0, scoreResult		# Prints score prompt
	syscall
	
	li $v0, 1
	move $a0, $s5			# Prints the score
	syscall

	li $v0, 4
	la $a0, newLine
	syscall

	li $v0, 4
	la $a0, notFound		# Prints notFound prompt
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $t2, 0
	
print_notFound:				# Prints all possible words that weren't found
	la $t6, wordList
	
	lb $t4, wordList($t2)		
	beq $t4, '*', endProgram2	# Branches if reaches end of array
	beq $t4, 0, contLoop
	
	li $v0, 11
	lb $a0, wordList($t2)		# Prints word at that index
	syscall

contLoop:
	addi $t2, $t2, 1		# Iterates the index
	j print_notFound
	
endProgram2:
	li $v0, 4			# tells us we're at the end... *ominous music*
	la $a0, test
	syscall

	li $v0, 10
	syscall

# SHUFFLE method	
shuffleLetters:
	la $t5, nineLetters
	li $v0, 4
	la $a0, newLine
	syscall
	
	lb $t7, 8($t5)			# swaps middle letter with last letter
	sb $t7, 4($t5)
	sb $s2, 8($t5)
	
	li $t3, 7			# set $t3 upper bound/limit to 7
	li $t2, 0			# counter
shuf:					# printing stuff 
	beq $t2, $t3, endLoop6
	
	li $v0, 42			# generate random number from 0-7
	li $a1, 8
	syscall
	
	lb $t6, ($t5)			# loads contents at index
	la $t8, nineLetters		
	add $t8, $t8, $a0		# jumps index to random spot in array
	lb $t7, ($t8)			# loads the contents at that index
	sb $t6, ($t8)			# swaps the two values
	sb $t7, ($t5)
	
	addi $t5, $t5, 1		# iterates the initial index
	addi $t2, $t2, 1		# iterates the loop
	j shuf
endLoop6:				# switch middle letter from index 8 back into the middle spot
	la $t5, nineLetters
	lb $t7, 4($t5)		
	sb $t7, 8($t5)
	sb $s2, 4($t5)
	
	li $t3, 9
	li $t2, 0
	
displayBoard:
	la $t1, nineLetters

	li $v0, 4
	la $a0, box_0
	syscall
	
	li $t2, 0
	li $t3, 3
	
dis_loop:
	li $v0, 4
	la $a0, box_1
	syscall
	
	li $v0, 4
	la $a0, box_2
	syscall
	li $v0, 11
	lb $a0, 0($t1)
	syscall
	addi $t1, $t1, 1	# increment index of char printed
	li $v0, 4
	la $a0, box_3
	syscall
	li $v0, 11
	lb $a0, 0($t1)
	syscall
	addi $t1, $t1, 1
	li $v0, 4
	la $a0, box_3
	syscall
	li $v0, 11
	lb $a0, 0($t1)
	syscall
	addi $t1, $t1, 1
	li $v0, 4
	la $a0, box_4
	syscall
	
	li $v0, 4
	la $a0, box_5
	syscall
	
	addi $t2, $t2, 1
	bne $t2, $t3, dis_loop
	
	jr $ra

allFound:
	li $v0, 4
	la $a0, allWordsFound
	syscall

	j endProgram
