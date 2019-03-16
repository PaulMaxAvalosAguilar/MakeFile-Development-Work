#include <stdlib.h>
#include <stdio.h>
#include "lib.h"
#include "a.h"
#include "Headers/header.h"
#include "Funcs.h"
#include "Static.h"
#include "Dylib.h"

int main(){

  FILE *file;
  int numero1;
  int numero2;
  int numero3;
	
#ifdef DEBUG
  printf("DEBUG was defined through command line \n");
#endif

#ifdef RELEASE
  printf("Release was defined through command line \n");
#endif
  
  hello();
  printf("%s", "Using printf\n");
  printf("Printing constant from header %d\n", NUMBER);
  goodbye();
  
  static_function();
  dylib();

  printf("\nFile opening "
	 "for Resources absolute path Macro working "
	 "and installation demonstration:\n");

  char directory[100]="";
  sprintf(directory, "%sResourceTest",RESOURCES);
  if((file = fopen(directory, "r"))==NULL){
    printf("File %s couldn't be opened\n",directory);
  }else{
    fscanf(file, "%d %d %d", &numero1, &numero2, &numero3 );
    fclose(file);

    printf("Introduced numbers were "
	   "%d %d %d\n", numero1, numero2, numero3);

  }

  return 0;
}
