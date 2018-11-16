#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/mount.h>

int main(int argc, char *argv[])
{
	pid_t pid;
	pid_t pid2;

    mount("sysfs", "/sys", "sysfs", 0, NULL);
	pid = fork();
	switch(pid) {
		case -1:
		{
			printf("fail create child process \n");
			return -1;
		}
		case 0:
		{
			execl("/init","init", NULL);
		}
	}
	int status;
    waitpid(pid, &status, 0);
	return 0;
}
