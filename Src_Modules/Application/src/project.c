#include <stdio.h>
#include "lib.h"
#include "a.h"
#include "Headers/header.h"
#include "Funcs.h"
#include "Static.h"
#include "Dylib.h"

int main(){
	
	#ifdef DEBUG
		printf("DEBUG was defined through command line \n");
	#endif
	
	hello();
	printf("%s", "hello to everyone u fools\n");
	goodbye();

	static_function();
	dylib();

	printf("We are gonna open a file"
	       "to demonstrate the use through Resources absolute"
	       "path Macro for working and installing resources\n");
	
	return 0;
}
