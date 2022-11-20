#include <stdio.h>
#include <string.h>

/**
 * @brief How does a char loop work in assembler?
 * 
 * Generate assembly code for current platform: `gcc -S char-loop.c`
 * Generate assembly code for aarch64:          `aarch64-linux-gnu-gcc -S char-loop.c` 
 * 
 * Generate executable: `gcc char-loop.c` or `gcc char-loop.s`
 * Run: `./a.out`
 * 
 */
const char *text = "hallo welt ";
const long time_unit = 500;

void sleep(long t)
{
    printf("sleep %ld\n", t);
}

void on()
{
    printf("on\n");
}

void off()
{
    printf("off\n");
}

void space(int n)
{
    sleep(n * time_unit);
}

void light(int n, long t)
{
    while (n > 0)
    {
        n--;
        on();
        sleep(t);
        off();
        sleep(time_unit);
    }
}

void s(int n)
{
    light(n, time_unit);
}

void l(int n)
{
    light(n, time_unit * 2);
}

void blink(char c)
{
    if (c == 'a')
    {
        s(1);
        l(1);
    }

    else if (c == 'b')
    {
        l(1);
        s(3);
    }

    else if (c == 'c')
    {
        l(1);
        s(1);
        l(1);
        s(1);
    }

    else if (c == 'd')
    {
        l(1);
        s(2);
    }
    else if (c == 'e')
    {
        s(1);
    }
    else if (c == 'f')
    {
        s(2);
        l(1);
        s(1);
    }
    else if (c == 'g')
    {
        l(2);
        s(1);
    }
    else if (c == 'h')
    {
        s(4);
    }
    else if (c == 'i')
    {
        s(2);
    }
    else if (c == 'j')
    {
        s(1);
        l(3);
    }
    else if (c == 'k')
    {
        s(1);
        l(1);
        s(2);
    }
    else if (c == 'l')
    {
        s(1);
        l(1);
        s(2);
    }
    else if (c == 'm')
    {
        l(2);
    }
    else if (c == 'n')
    {
        l(1);
        s(1);
    }
    else if (c == 'o')
    {
        l(3);
    }
    else if (c == 'p')
    {
        s(1);
        l(2);
        s(1);
    }
    else if (c == 'q')
    {
        l(2);
        s(1);
        l(1);
    }
    else if (c == 'r')
    {
        s(1);
        l(1);
        s(1);
    }
    else if (c == 's')
    {
        s(3);
    }
    else if (c == 't')
    {
        l(1);
    }
    else if (c == 'u')
    {
        s(2);
        l(1);
    }
    else if (c == 'v')
    {
        s(3);
        l(1);
    }
    else if (c == 'w')
    {
        s(1);
        l(2);
    }
    else if (c == 'x')
    {
        s(1);
        l(2);
        s(1);
    }
    else if (c == 'y')
    {
        l(1);
        s(1);
        l(2);
    }
    else if (c == 'z')
    {
        l(2);
        s(2);
    }

    else
    {
        space(4); // 1 + 2 + 4 = 7
    }

    space(2); // 1 + 2 = 3
}

void char_loop()
{
    const char *t = text;

    while (*t)
    {
        blink(*t);
        t++;
    }
}

int main(int argc, char const *argv[])
{
    char_loop();
    return 0;
}
