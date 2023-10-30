#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h"

void prime_seive(int fd[2]){
    int prime;
    if(read(fd[0], &prime, sizeof(prime)) == 0){
        close(fd[0]);
        exit(0);
    }
    printf("prime %d\n", prime);
    int pright[2];
    if(pipe(pright)<0){
        fprintf(2, "pipe error\n");
        exit(1);
    }
    if(fork() == 0){
        close(fd[0]);
        close(pright[1]);        
        prime_seive(pright);
        exit(0);
    }else{
        close(pright[0]);
        int num;
        while(read(fd[0], &num, sizeof(num)) != 0){
            if(num%prime != 0){
                write(pright[1], &num, sizeof(num));
            }
        }
        close(fd[0]);
        close(pright[1]);
        wait(0);
        exit(0);
    }
}
int main(){
    int pp[2];
    if(pipe(pp)<0){
        fprintf(2, "pipe error\n");
        exit(1);
    }
    if(fork() ==0 ){
        close(pp[1]);
        prime_seive(pp);
        exit(0);
    }else{
        close(pp[0]);
        for(int i = 2; i <= 35; i++){
            write(pp[1], &i, sizeof(i));
        }
        close(pp[1]);
        wait(0);
        exit(0);
    }
}