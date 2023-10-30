#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h"

int main(int argc, char *argv[]){
    if(argc < 2){
        fprintf(2, "Usage: sleep <clock circles>\n");
        exit(1);
    }
    int n = atoi(argv[1]);
    if(sleep(n) < 0){
        fprintf(2, "sys_sleep call error\n");
        exit(1);
    }
    exit(0);
}