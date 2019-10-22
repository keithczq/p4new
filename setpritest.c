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

    exit();
}
