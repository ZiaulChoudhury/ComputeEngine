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

#define L0 64
#define L1 32
#define L2 16
#define L3 8
#define L4 4
#define L5 2


unsigned char *input;
unsigned int  *configuration;
unsigned int  *image;
#define IMG 256
#define total_config_words (4+4+10+L0+L0+L0+L1+L2+L3+L4+1)
extern "C" 
{
        void  initialize()
        {
                        FILE *file = NULL;
                        FILE *file2 = NULL;
			int index = 0;
                        file = fopen ("config_new.txt", "r");
                        file2 = fopen ("data.txt", "r");
			configuration = (unsigned int*)malloc(sizeof(int)*1000000);
			while(index < total_config_words){
				fscanf(file,"%d",&configuration[index++]);
			}
				
			index = 0;
			image = (unsigned int*)malloc(sizeof(int)*1000000);
			while(index < (IMG*IMG)){
				fscanf(file2,"%d",&image[index++]);
			}


        }
        int readConfig(int id)
	{
		return configuration[id];
        }
        int readInput(int id)
	{
		return image[id];
        }
}

int main()
{
	initialize();
	for(int i=0;i<total_config_words; i++)
		printf("\n%d", configuration[i]);
	return 0;
}

