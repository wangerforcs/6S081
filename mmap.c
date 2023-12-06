#include<stdio.h>
#include<stdlib.h>
#include<sys/mman.h>
#include<unistd.h>
#include<sys/wait.h>
int main()
{
    int *p;
    p=mmap(NULL,4,PROT_READ|PROT_WRITE,MAP_ANONYMOUS|MAP_SHARED,-1,0);
    if(fork()==0){
        *p=100;
        printf("child: %d\n",*p);
        exit(0);
    }else{
        wait(NULL);
        printf("parent: %d\n",*p);
    }
    int err=munmap(p,4);
    printf("err: %d\n",err);
    err = munmap(p-4096,4);
    printf("err: %d\n",err);
}
// child: 100
// parent: 100
// err: 0
// err: 0