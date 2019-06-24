#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/mount.h>

#define NXQUICKREARCAM

int main(int argc, char *argv[])
{
	pid_t pid;
	int status;
	int access_ret = 0;

    mount("sysfs", "/sys", "sysfs", 0, NULL);
#ifndef NXQUICKREARCAM
	mkdir("/svmdata", 0755);
    mount("/dev/mmcblk0p9", "/svmdata", "ext4", 0, NULL);
#endif
	pid = fork();
	switch(pid) {
		case -1:
		{
			printf("fail create child process \n");
			return -1;
		}
		case 0:
		{
#ifdef NXQUICKREARCAM
			execl("/sbin/NxQuickRearCam", "NxQuickRearCam", "-m1", "-b1", "-c26", "-r704x480", NULL);
#endif
			break;
		}
		default:
		{
			sleep(1);
			execl("/init","init", NULL);
			break;
		}
	}
    waitpid(pid, &status, 0);
	return 0;
}
