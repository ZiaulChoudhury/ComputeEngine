#include <stdio.h>

#define K 5
int main()
{
	for(int i=0;i<8; i++)
		for(int j=0;j<8;j++){
			if(i<K && j<K){
				printf("%d ", (i*8+j));
			}
		}
}
