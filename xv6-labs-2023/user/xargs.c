#include "kernel/types.h"
#include "user/user.h"
#include "kernel/fcntl.h"
#include "kernel/stat.h"
#include "kernel/param.h"

int main(int argc,char* argv[]){
    /*
    xargs echo bye hello
    char* mask = (char*)argv;
    mask[49] = 0;
    exec(argv[1], argv+1);
    exit(0);
    48 : hello
    64 : bye
    80 : echo
    
    out: bye h    
    */
    // cant use argv as newargv, or you will modify memory in stack and get unexpected result like A= hello bye
    // because you modify string of argv[0], argv[1] and so on
    char buf[512], c;
    char* newargv[MAXARG];
    char *pleft = buf, *pright = buf, **pargv = newargv, **pargv0 = argv;
    while(*pargv0 != 0) {
        *pargv++ = *pargv0;
        pargv0++;
    }
    pargv0 = pargv;
    while(read(0, &c, 1) != 0){
        if(c == ' '){
            *pright++ = 0;
            *pargv++ = pleft;
            pleft = pright;
        }
        else if (c == '\n'){
            *pright = 0;
            *pargv++ = pleft;
            *pargv = 0;
            if(fork() == 0){
                if(exec(newargv[1], newargv+1) < 0){
                    fprintf(2, "exec error\n");
                    exit(1);
                }
            }
            else{
                wait(0);
            }
            pargv = pargv0;
            pleft = pright = buf;
        }
        else{
            *pright++ = c;
        }
    }
    exit(0);
}