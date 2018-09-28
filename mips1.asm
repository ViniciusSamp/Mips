.data
array: .word 10,9,8,7,6,5,4,3,2,1
contador: .word 0,0,9,0,0,0 # i, j,max i /j, reset i, aux,aux

	.text 				
	.globl main
main:
	#salvando o array e variáveis uteis em seus locais
	la $s0, array
	la $s1, contador 
	
	lw $s5, 8($s1)
	lw $s4,0($s1)
	lw $s5, 8($s1)
	
	#contadores
	lw $s4,0($s1)
	lw $s6,4($s1)
	lw $s7,12($s1)
	lw $t4,12($s1)
	
	
comparar:
	#converter o indice para multp de 4(lembrando que no primeiro caso s4=0, logo essa primeira seção não faz nada
	add $t4,$s4,$s4
	add $t4,$t4,$t4
	#somar o indice convertido ao array para contabilizar incremento
	add $t4,$t4,$s0
	lw $t1,0($t4)
	lw $t2,4($t4)
	#verificar se t2 é menor que t1, se sim t3=1, se n t3=0
	slt $t3,$t2,$t1	
	#se t3 for 1, jmp para troca, se não for continua o codigo
	bgtz $t3 troca
	j loop1
loop1:	
	#incremento no indice
	addi $s4,$s4,1
	sw $s4,0($s1)
	#caso indice s4 for menor que 9 jmp para comparar
	bne $s4,$s5,comparar
	j loop2
loop2:
	#incremento do segundo indice do for
	addi $s6,$s6,1
	sw $s6,4($s1)
	#zerar indice do primeiro for (s4)
	lw $s4,12($s1)
	#se o segundo indice(s6), do segundo for for menor q 9 (guardado em s5) jump pra comparar
	bne $s6,$s5,comparar
	j fim
troca:
	#salva os valores armazenados em t2 e t1, nas posições trocadas do vetor, ou seja t2 na posição de t1 no vetor, e t1 na posição de t2 no vetor
	sw $t2,0($t4)
	sw $t1,4($t4)
	#jump para loop após troca para que o indice numero um (s5) seja incrementado
	j loop1	
	
	
fim:
	li $v0,5
	syscall
