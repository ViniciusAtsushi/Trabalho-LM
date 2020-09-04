.section .data

menor_elemento : 
.int 0

ik: 
.int 0
aux_L : 
.int 0

cont_col : 
.int 0

cont_lin : 
.int 0

contador_R: 
.int 0

soma: 
.int 0

inteiro: 
.int 4

var: 
.int 0

.macro organiza cont_lin,cont_col,aux_L,inteiro
#----------------------- INICIO MACRO -----------------------------
    # [cont_lin] = %1 / [cont_col] = %2 / [aux_L] = %3 / [int] = %4

    pushl %eax
    pushl %edx

    movl \cont_lin, %eax
    movl \aux_L, %edx

    mul %edx 

    addl %eax,%ecx

    xorl %eax,%eax
    xorl %edx,%edx

    movl \cont_col, %eax
    movl \inteiro, %edx

    mul %edx

    addl %eax,%ebx

    popl %edx
    popl %eax

# ----------------------- FIM MACRO --------------------------------
.endm

.macro multiplica ik,soma,aux_L,inteiro,var
# ----------------------- INICIO MACRO -----------------------------

    # [ik] = %1 / [soma] = %2 / [aux_L] = %3 / [int] = %4 / [var] = %5

    loop1:
    
    movl (%ecx), %eax            # x = tamanho do int = 4
    movl (%ebx), %edx             # y = aux_L

    addl \inteiro, %ecx               
    addl \aux_L, %ebx
 
    mul %edx

    addl %eax, \soma

    xorl %eax,%eax
    incl \ik

    movl \ik, %eax
    cmpl \var, %eax
    jb loop1

    xorl %eax,%eax
  
# ----------------------- FIM MACRO --------------------------------

.endm

.text
.globl mul_matriz

mul_matriz:


    pushl %ebp
    movl %esp,%ebp

    movl 20(%ebp),%eax
    movl %eax,(aux_L)                 
    movl  %eax,(var)

    movl (aux_L),%eax
    mov $4,%bl
    mul %bl

    movl %eax, (aux_L)       
    
    # var = numero de elementos da linha
    # aux_L =  L * 4
    # int = 4

    movl 8(%ebp),%ecx        #ecx tem o endereço da primeira casa da matriz A
    movl 12(%ebp),%ebx       #ebx tem o endereço da primeira casa da matriz B
jmp loop_linha_cond
loop_linha:
    movl $0,(cont_col) 
loop_coluna:                    
    movl 8(%ebp),%ecx         #ecx tem o endereço da primeira casa da matriz A
    movl 12(%ebp),%ebx        #ebx tem o endereço da primeira casa da matriz B

    organiza (cont_lin),(cont_col),(aux_L),(inteiro)

   # inc %edx            #%edx sendo usado p/ testar quantas vezes entra no loop coluna
    movl $0, (ik)
 
    multiplica (ik),(soma),(aux_L),(inteiro),(var)
    
    pushl %eax
    pushl %ebx
  
    
    movl 16(%ebp), %eax                    # passando o endereço da primeira casa da matriz R
    add (contador_R), %eax
    mov (soma),%ebx
    mov %ebx,(%eax)
    movl $0,(soma)
    addl $4,(contador_R)

    popl %ebx
    popl %eax

    addl $1, (cont_col)
   

loop_coluna_cond:           
    xor %eax,%eax
    mov (cont_col),%eax
    cmp (var),%eax
    jl loop_coluna
    add $1,(cont_lin) 
    
loop_linha_cond:    
    xor %eax,%eax
    mov (cont_lin),%eax
    cmp (var),%eax
    jl loop_linha
    
    


# Fim do loop p/  multiplicar linhas por colunas

fim:

    movl 16(%ebp),%eax
# --------------------------------------------------------------------------

    movl %ebp, %esp
    popl %ebp
    ret