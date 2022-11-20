#include <stdio.h>
#include <string.h>

/**
 * @brief Arithmetic functions
 * 
 * Generate assembly code for current platform: `gcc -S arithmetic.c`
 * Generate assembly code for aarch64:          `aarch64-linux-gnu-gcc -S arithmetic.c` 
 * 
 * Generate executable: `gcc arithmetic.c` or `gcc arithmetic.s`
 * Run: `./a.out`
 * 
 */

int divide(int a, int b) {
    return a / b;
}

int multiply(int a, int b) {
    return a * b;
}

int main(int argc, char const *argv[])
{
    const int x = divide(1000, 100);
    return multiply(x, 500);
}


