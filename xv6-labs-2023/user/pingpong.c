#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h"

int main(){
    int pf[2], pc[2];
    if(pipe(pf)<0){
        fprintf(2, "Usage: sleep <clock circles>\n");
        exit(1);
    }
    if(pipe(pc)<0){
        fprintf(2, "Usage: sleep <clock circles>\n");
        exit(1);
    }
    if(fork()==0){
        close(pf[1]);
        close(pc[0]);
        char buf[1];
        read(pf[0], buf, 1);
        printf("%d: received ping\n", getpid());
        write(pc[1], buf, 1);
        close(pf[0]);
        close(pc[1]);
        exit(0);
    }
    else{
        close(pf[0]);
        close(pc[1]);
        char buf[1];
        write(pf[1], buf, 1);
        read(pc[0], buf, 1);
        printf("%d: received pong\n", getpid());
        close(pf[1]);
        close(pc[0]);
        exit(0);
    }
}