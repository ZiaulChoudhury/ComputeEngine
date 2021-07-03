#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <fcntl.h>
#include <stdint.h>
#include <time.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <math.h>


int Cx;
int Tx;
int Dx;
int Ox;
int Wx;
int offset = 0;
#define MAX 16
int C [MAX];
int T [MAX];
int D [MAX];
int O [MAX];
int W [MAX];
int PF[MAX];
int PS[MAX];
int L [MAX];
int B [MAX];

unsigned int  *output;
unsigned char *input[MAX];
unsigned int FMAPS[224][224][1024];

void dumpFmaps(int r, int c)
{
    FILE *fp;
    fp = fopen("outFmaps.txt","w+");
    if(fp == NULL){
        printf("\n Error in creating file ");
        exit(0);
    }
    for(int i=0;i<512;i++){
        for(int j=0;j<r;j++){
            for(int k=0;k<c;k++){
                unsigned char* x = (unsigned char*)&FMAPS[j][k][i];
                for(int b = 0;b<4;b++)
                    fprintf(fp,"%d\n",x[b]);
            }
        }
    }
    fclose(fp);
}

void unpackFmaps(int PF, int PS, int R, int C, int BANKS, int offset){
        int idx[128];
        int idy[128];
        for(int i=0;i<128;i++){
                idx[i] = i%PS;
                idy[i] = i/PS;
        }
        int BankMap[2][8][16];
        for(int i=0;i<16; i++)
                for(int j=0;j<8;j++){
                        BankMap[0][j][i] = idx[i*8+j];
                        BankMap[1][j][i] = idy[i*8+j];
                }

        int count = 0;
        for(int b = 0; b <BANKS; b++){
               for(int r=0;r<(int)ceil((float)R/PS); r++)
                   for(int c=0;c<C;c++)
                        for(int i=0;i<8;i++){
                        int x = output[count++];
                        if(r*PS + BankMap[0][i][b] < R){
                           FMAPS[r*PS + BankMap[0][i][b]][c][BankMap[1][i][b]+offset] = x;
                         }

                    }
                for(int z=0;z<8;z++)
                        count++;
        }
}

extern "C" {
                void  initialize(int index)
                {
			int x;
			printf("\n Enter the data ");
			scanf("%d", &x);
			Cx = C[index];
			Tx = T[index];
			Dx = D[index];
			Ox = O[index];
			Wx = W[index];
                }

		void  layerInit()
		{
			output = (unsigned int*)malloc(sizeof(unsigned int)*100000000);                       
                        FILE *file = NULL;
                        FILE *file2 = NULL;
                        file = fopen ("input.txt", "r");
                        file2 = fopen ("config.txt", "r");
                        if(file == NULL || file2 == NULL)
                                printf("\n ERROR ");
                        
                        for(int iter = 0;iter < MAX; iter++)
                        {       
                                printf("\n Iteration %d \n", iter);
                                int i;
                                int count=0;
                                fscanf (file,  "%d", &C[iter]);
                                fscanf (file,  "%d", &T[iter]);
                                fscanf (file,  "%d", &D[iter]);
                                fscanf (file,  "%d", &O[iter]);
                                fscanf (file2, "%d", &PF[iter]);
                                fscanf (file2, "%d", &PS[iter]);
                                fscanf (file2, "%d", &L[iter]);
                                fscanf (file2, "%d", &B[iter]);
                                
                                printf ("\nC=%d", C[iter]);
                                printf ("\nT=%d", T[iter]);
                                printf ("\nD=%d", D[iter]);
                                printf ("\nO=%d", O[iter]);
                                printf ("\nPF=%d",PF[iter]);
                                printf ("\nPS=%d",PS[iter]);
                                printf ("\nL=%d", L[iter]);
                                printf ("\nB=%d", B[iter]);
                                
                                input[iter] = (unsigned char*)malloc(sizeof(char)*100000000);
                                while (count < C[iter]+T[iter]+D[iter])
                                {       
                                        fscanf (file, "%d", &i);
                                        unsigned char *x = (unsigned char*)&i;
                                        input[iter][count++] = x[0];
                                }
                        }
                        fclose(file);
		}

        int readC(){
                return Cx;
        }
        int readT(){
                return Tx;
        }
        int readD(){
                return Dx;
        }
        int readO(){
                return Ox;
        }
        int readW(){
                return Wx;
        }
        int readByte(int index, int layer){
                return input[layer][index];
        }
	void store32(int index, unsigned int d1, unsigned int d2, unsigned int d3, unsigned int d4, unsigned int d5, unsigned int d6, unsigned int d7, unsigned int d8){
		output[index]   = d1;
		output[index+1] = d2;
		output[index+2] = d3;
		output[index+3] = d4;
		output[index+4] = d5;
		output[index+5] = d6;
		output[index+6] = d7;
		output[index+7] = d8;
		
	}

	void storeFmaps(int batch)
	{
		unpackFmaps(PF[batch],PS[batch],L[batch],L[batch],B[batch], offset);
		offset += PF[batch];
		
	}	
	
	void dump(){
		dumpFmaps(L[0],L[0]);
	}

}


void unpackPooledFmaps(int PF, int PS, int R, int C, int BANKS){
        int idx[128];
        int idy[128];
        for(int i=0;i<128;i++){
                idx[i] = i%PS;
                idy[i] = i/PS;
        }
        int BankMap[2][4][16];
        for(int i=0;i<16; i++)
                for(int j=0;j<4;j++){
                        BankMap[0][j][i] = idx[i*4+j];
                        BankMap[1][j][i] = idy[i*4+j];
                }

        int count = 0;
        for(int b = 0; b <BANKS; b++){
               for(int r=0;r<R/2; r++)
                   for(int c=0;c<C/2;c++)
                        for(int i=0;i<8;i++){
                        int x = output[count++];
			if(i<4)
                        if(r*PS + BankMap[0][i][b] < R){
                           FMAPS[r*PS + BankMap[0][i][b]][c][BankMap[1][i][b]] = x;
                         }

                    }
                for(int z=0;z<8;z++)
                        count++;
        }
}

int main()
{
	layerInit();
	int offset = 0;
    	unsigned char *OutBuf = (unsigned char *)malloc(40000000 * sizeof(unsigned char*));
	for(int k=0;k<MAX;k++){
		int len  = C[k]+T[k]+D[k];
		int lenr = O[k]*32;
		output = (unsigned int *)OutBuf;
		unpackFmaps(PF[k],PS[k],L[k],L[k],B[k], offset);
		offset += PF[k];
		printf("\n Iteration done %d \n",k);
	}
	dumpFmaps(L[0],L[0]);
}
