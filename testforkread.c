#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
int main()
{
    int pid = fork();
    char buf[100];
    if(pid == 0)
    {
        read(0, buf, 3);
        buf[3] = '\0';
        printf("child: %s\n", buf);
    }
    else
    {
        read(0, buf, 3);
        buf[3] = '\0';
        printf("parent: %s\n", buf);
    }
    return 0;
}