.data
# Se��o 1: vari�veis f, g, h, i, j  armazenadas em mem�ria (inicializa��o)
_f: .word 1
_g: .word 2
_h: .word 4
_i: .word 8
_j: .word 16

# Se��o 2: jump address table
jat: 
.word L0 
.word L1 
.word L2 
.word L3
.word L4
.word default

.text
.globl main
main:
# Se��o 3: registradores recebem valores inicializados 
lw $s0, _f
lw $s1, _g
lw $s2, _h
lw $s3, _i
lw $s4, _j

la $t4, jat # carrega em $t4 o endereco-base de jat

# Se��o 4: testa se k no intervalo [0,4]
sltiu $t3, $s5,5
beq $t3, $zero, default
                                                                                
# Se��o 5: calcula o endere�o de jat[k]
sll $t2, $s5, 2
add $t2, $t2, $t4

# Se��o 6: desvia para o endere�o em jat[k]
lw $t2,0($t2)
jr $t2
# (f, g, h, i, j, k) ? ($s0, $s1, $s2, $s3, $s4, $s5).
# Se��o 7: codifica as alternativas de execu��o
L0:    	add $s0, $s3, $s4		#f = i + j
	j Exit
L1:    	sub $s0, $s1, $s2  	#f = g - h; break;
	j Exit
L2:    	add $s0, $s1, $s2  	#f = g + h + j; break;
	add $s0, $s0, $s4 
	j Exit
L3:    	or $s0, $s3, $s2   	#f = i | h | j; break;
	or $s0, $s0, $s4 
	j Exit
L4:    	and $s0, $s2, $s5	#f = h & k; break; 
	j Exit
default:sub $s0, $s3, $s5 	#f = i - k + 5
        addi $s0, $s0, 5
Exit:   nop
