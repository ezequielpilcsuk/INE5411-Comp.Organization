.data
_teste1: .word 13
.text
.globl main
main:	lw $a0, _teste1
	jal	Fib
	j	Exit
Fib:	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$s0, 0($sp)
	beq	$a0, $zero, Fib0
	addi	$t0, $zero, 1
	beq	$a0, $t0, Fib1
	addi 	$a0, $a0, -1
	jal	Fib
	add	$s0, $zero, $v0
	addi 	$a0, $a0, -1
	jal	Fib
	add	$v0, $s0, $v0
	lw 	$s0, 0($sp)
	lw	$a0, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra
	
Fib0:	add 	$v0, $zero, $zero
	lw 	$s0, 0($sp)
	lw	$a0, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra
	
Fib1:	addi	$v0, $zero, 1
	lw 	$s0, 0($sp)
	lw	$a0, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra

Exit:



	
#int fib(int n){ 
#	if (n==0) return 0; 
#	else if (n == 1) return 1;
#	else return fib(n?1) + fib(n?2);}
