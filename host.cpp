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


unsigned char *input;
unsigned int  *configuration;
#define total_config_words (32+5)
extern "C" 
{
        void  initialize()
        {
                        FILE *file = NULL;
			int index = 0;
                        file = fopen ("config.txt", "r");
			configuration = (unsigned int*)malloc(sizeof(int)*1000000);
			while(index < total_config_words){
				fscanf(file,"%d",&configuration[index++]);
			}

        }
        int readConfig(int id)
	{
		return configuration[id];
        }
        int readInput()
	{
		return 0;
        }
}

int main()
{
	initialize();
	for(int i=0;i<total_config_words; i++)
		printf("\n%d", configuration[i]);
	return 0;
}

