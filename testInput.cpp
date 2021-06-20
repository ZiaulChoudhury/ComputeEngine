#include <stdio.h>

int arr[100];
int main()
{
	unsigned int img = 16;
	unsigned int kernel = 5;

	unsigned int data = (img << 6) | kernel;

	printf("%d", data);
	/*int A[16][18];
	for(int i=0;i<256;i++){
		for(int j=0;j<256;j++){
			printf("%d\n", (i*j+10)%255);
		}
	}*/
	
}
