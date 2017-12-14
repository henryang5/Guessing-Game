# Henry Ang
# 1/30/17
# CSC 3760
# HW 3 Programming

# Single player guessing game. The program will ask player to try and guess secret number. 
# Player has 10 guesses. The program will indicate if the number guessed is too high or too low. 
# If a player guesses correctly, a congratulatory message will be displayed, followed by the number 
# to attempts to guess the secret number. If the maximum guesses(10) is reached a “you lose”
# message will appear and the program will end.   

.data

welcome_text:		.asciiz "Welcome to the Guessing Game, Created By Henry Ang \n"
goodbye_text:		.asciiz "Thank you for playing, goodbye"
youLose_text:		.asciiz "Maximum guesses of 10 reached, you lose \n"
congrat_text:		.asciiz "Congratulation, you’ve guessed the secret number \n"
guess_prompt:		.asciiz "Please enter a guess: "
tooHigh_text:		.asciiz "Guess is too high \n"
tooLow_text:		.asciiz "Guess is too low \n"
secretNumber_text: 	.asciiz "Secret Number: "
guesses_text: 		.asciiz "Guesses: "
new_line:		.asciiz	"\n"
secretNumber: 		.word 	11

.text

main:		
		lw   $t2, secretNumber		# load secret number in $t2

		#code to print welcome_text
		li	$v0, 4			# code for print_string
		la	$a0, welcome_text	# point $a0 to welcome_text string
		syscall				# print the string	

		addi $t0, $t0, 0  		# load constant into t0 (i = 0)
LOOP:		slti $t1, $t0, 10  		# t1 = 1 if i < 10, t1 = 0 if i >= 10
		beq $t1, $0, LOSE  		# if i >= 10, goto LOSE

		# display guess_prompt
		li	$v0, 4			# code for print_string
		la	$a0, guess_prompt	# point $a0 to guess_prompt string
		syscall				# print the string

		# get an integer from the user
		li	$v0,5			# code for read_int
		syscall				# get an int from user --> returned in $v0
		move	$s0,$v0			# move the resulting int to $s0	

		#code to print new_line
		li	$v0, 4			# code for print_string
		la	$a0, new_line		# point $a0 to new_line string
		syscall				# print the string

		addi $t0, $t0, 1		# i++	

		beq	$s0, $t2, WIN		# if (user input == secretNum) goto WIN

		slt 	$t3, $t2, $s0		# t3 = 0 if userinput < secretNum, t3 = 1 if userinput >= secretNum
		beq     $t3, $0, LOW		# if t3 = 0 go to LOW
		j 	HIGH 			# else jump to HIGH	

LOW: 		#code to print tooLow_text
		li	$v0, 4			# code for print_string
		la	$a0, tooLow_text	# point $a0 to tooLow_text string
		syscall				# print the string
		j LOOP				# jump to LOOP

HIGH: 		#code to print tooHigh_text
		li	$v0, 4			# code for print_string
		la	$a0, tooHigh_text	# point $a0 to tooHigh_text string
		syscall				# print the string
		j LOOP				# jump to LOOP

LOSE: 		#code to print youLose_text
		li	$v0, 4			# code for print_string
		la	$a0, youLose_text	# point $a0 to youLose_text string
		syscall				# print the string
		j 	END 			# jump to END

WIN:		#code to print congrat_text	
		li	$v0, 4			# code for print_string
		la	$a0, congrat_text	# point $a0 to congrat_text string
		syscall		 		# print the string 

		#code to print secretNumber_text	
		li	$v0, 4			# code for print_string
		la	$a0, secretNumber_text	# point $a0 to secretNumber_text string
		syscall		 		# print the string 

		#code to print secretNumber
		li	$v0, 1			# code for print_int
		add	$a0, $0, $t2		# copy secretNum($t2) into $a0
		syscall				# print the string	

		#code to print new_line
		li	$v0, 4			# code for print_string
		la	$a0, new_line		# point $a0 to new_line string
		syscall				# print the string

		#code to print guesses_text	
		li	$v0, 4			# code for print_string
		la	$a0, guesses_text	# point $a0 to guesses_text string
		syscall		 		# print the string 

		#code to print numGuesses
		li	$v0, 1			# code for print_int
		add	$a0, $0, $t0		# copy $t0 (i) into $a0
		syscall				# print the string

		#code to print new_line
		li	$v0, 4			# code for print_string
		la	$a0, new_line		# point $a0 to new_line string
		syscall				# print the string
						
END:		#code to print goodbye_text
		li	$v0, 4			# code for print_string
		la	$a0, goodbye_text	# point $a0 to goodbye_text string
		syscall				# print the string

		# exit the program
		li	$v0,10			# code for exit
		syscall				# exit program
