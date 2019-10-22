//
// Created by Keith Chua on 22/10/19.
//
#include "fcntl.h"
#include "types.h"
#include "user.h"
#include "stat.h"

void swap(char *first, char *last) {
    char x = *first; *first = *last; *last = x;
}

char* my_itoa(int value, char* buffer) {
    int x = 0;
    while (value) {
        int r = value % 10;
        buffer[x++] = 48 + r;
        value = value / 10;
    }

    if (x == 0) {
        buffer[x++] = '0';
    }
    buffer[x] = '\0';

    int i = 0, j = i - 1;
    while (i < j) {
        swap(&buffer[i++], &buffer[j--]);
    }
    return buffer;
}

char* strcat(char* src, char* dst) {
    char* ptr = dst;
    while (*ptr != '\0')
        ptr++;
    while (*src != '\0')
        *ptr++ = *src++;
    *ptr = '\0';
    return dst;

}

int my_atoi(char* str) {
    int num = 0;
    for (int i = 0; str[i] != '\0'; i++) {
        num = num * 10 + str[i] - '0';
    }
    return num;
}

int main(int argc, char* argv[] ) {
    if (argc < 3) {
        printf(1, "error: too few arguments\n");
        exit();
    }
    //argv[1] = pid
    //argv[2] = priority

    int pid = my_atoi(argv[1]);
    int priority = my_atoi(argv[2]);

    printf(1, "input pid: %d\n", pid);
    printf(1, "input priority: %d\n", priority);

    setpri(pid, priority);

    printf(1, "new pid: %d\n", pid);
    printf(1, "new priority: %d\n", getpri(pid));

//    char fileName[10];
//    char buffer[10];
//    for (int i = 0; i < my_atoi(argv[1]); i++) {
//        strcpy(fileName, "ofile");
//        my_itoa(i, buffer);
//        strcat(buffer, fileName);
//        int filedesc = open(fileName, O_RDWR | O_CREATE);
//        if (filedesc < 0) {
//            printf(1, "error opening/creating file: %s\n", fileName);
//            exit();
//        }
//    }
//
//    // Loop to close file numbers specified
//    int numToClose = argc - 2;
//    if ((numToClose) > 0) {
//        for (int j = 2; j < argc; j++) {
//            close(my_atoi(argv[j]) + 3);
//
//            strcpy(fileName, "ofile");
//            strcpy(buffer, argv[j]);
//            strcat(buffer, fileName);
//
//            if (unlink(fileName) < 0){
//                printf(1, "error faied to delete %s\n", fileName);
//                exit();
//            }
//        }
//    }
//
//    printf(1, "%d %d\n", getofilecnt(getpid()), getofilenext(getpid()));
    exit();
}

// original
//    // Loop to open number of files specified
//    char fileName[10];
//    char buffer[10];
//    int openFileCount = my_atoi(argv[0]);
//    for (int i = 0; i < openFileCount; i++) {
//        strcpy(fileName, "ofile");
//        my_itoa(i, buffer);
//        strcat(buffer, fileName);
//        printf(1, "creating %s...\n", fileName); //FIXME
//        int filedesc = open(fileName, O_RDWR | O_CREATE);
//        if (filedesc < 0) {
//            printf(1, "error opening/creating file %s\n", fileName);
//            exit();
//        }
//    }