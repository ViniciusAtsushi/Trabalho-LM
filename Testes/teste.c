#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

int L = 2;

int main()
{

    int i,j;
    int a[L][L];
    int b[L][L];
    int R[L][L];

    int resultado;

    for(i=0;i<L;i++)                                        // Preencher as matrizes A,B e C com valores aleatórios de 0 a 10
    {
        for(j=0;j<L;j++)
        {
            a[i][j] = (rand()%5);                      
            b[i][j] = (rand()%5);
        }
    }

    for(i=0;i<L;i++) 
    {                                       
        for(j=0;j<L;j++)
        {
            R[i][j] = 0;
        }
    }

     printf("\n-------- Matriz A --------\n");

    for(i=0;i<L;i++) 
    {                                       
        for(j=0;j<L;j++)
        {
            printf("%d ",a[i][j]);
        }
        printf("\n");
    }

    printf("\n-------- Matriz B --------\n");

    for(i=0;i<L;i++) 
    {                                       
        for(j=0;j<L;j++)
        {
            printf("%d ",b[i][j]);
        }
        printf("\n");
    }




    extern int mul_matriz (int*,int*,int*,int);

    resultado = mul_matriz(*a,*b,*R,L);

    
    printf("\n-------- Matriz R --------\n");
    printf("%d ",resultado);
   
}