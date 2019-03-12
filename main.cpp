
using namespace std;
#include "iostream"
#include <pthread.h>
int var = 0 ;
void* test (void* arg){
var++;
return NULL;

}

int main()
{
///////memory leak//////////
 int * foo;
foo = new int [50];
//free(foo);
////////race////////
// pthread_t child;
// pthread_create(&child,NULL,test,NULL);
// var++;
// pthread_join(child,NULL);
return 0;



}