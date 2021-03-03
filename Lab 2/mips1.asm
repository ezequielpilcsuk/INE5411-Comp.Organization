.data
# Seção 1: variáveis f, g, h, i, j  armazenadas em memória (inicialização)
_f: .word 1
_g: .word 2
_h: .word 4
_i: .word 8
_j: .word 16

# Seção 2: jump address table
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
# Seção 3: registradores recebem valores inicializados 
lw $s0, _f
lw $s1, _g
lw $s2, _h
lw $s3, _i
lw $s4, _j

la $t4, jat # carrega em $t4 o endereco-base de jat

# Seção 4: testa se k no intervalo [0,4]
sltiu $t3, $s5,5
beq $t3, $zero, default
                                                                                
# Seção 5: calcula o endereço de jat[k]
sll $t2, $s5, 2
add $t2, $t2, $t4

# Seção 6: desvia para o endereço em jat[k]
lw $t2,0($t2)
jr $t2
# (f, g, h, i, j, k) ? ($s0, $s1, $s2, $s3, $s4, $s5).
# Seção 7: codifica as alternativas de execução
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
