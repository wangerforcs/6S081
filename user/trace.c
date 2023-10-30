#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

int main(int argc, char*argv[])
{
    if(argc < 3){
        fprintf(2, "usage: trace mask command\n");
        exit(1);
    }
    int mask = atoi(argv[1]);
    trace(mask);
    exec(argv[2], argv+2);
    exit(0);
}