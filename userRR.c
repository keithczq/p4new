#include "stdio.h"
#include "stdlib.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "syscall.h"

int atoi(char* str) {
    int num = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        num = num * 10 + str[i] - '0';
    }
    return num;
}

int main( int argc, const char* argv[] )
{
    if (argc != 6)
    {
        printf(1, "%s\n", "Incorrect number of arguments");
        exit(1);
    }
    
//    int timeslice = atoi(argv[1]);
//    int iters = atoi(argv[2]);
//    char jobname[50] = argv[3];



    printf(1, "%s", "test");
}