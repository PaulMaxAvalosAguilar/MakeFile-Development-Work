#include <stdio.h>
#include "lib.h"
#include "a.h"
#include "Headers/header.h"
#include "Funcs.h"
#include "Static.h"

int main(){
	
	#ifdef DEBUG
		printf("DEBUG was defined through command line \n");
	#endif
	
	hello();
	printf("%s", "hello to everyone u fools\n");
	goodbye();

	static_function();

	return 0;
}
