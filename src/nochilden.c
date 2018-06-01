#define _GNU_SOURCE
#include <sys/prctl.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char *argv[]) {
  (void) argc;

  prctl(PR_SET_CHILD_SUBREAPER, 1, 0, 0, 0, 0);

  pid_t p;
  switch ((p = fork())) {
    case -1: return 255;
    case  0: execvp(argv[1], argv+1); _exit(127);
  }

  // try to be a good parent
  int status;
  do { waitpid(p, &status, 0); } while (!WIFEXITED(status) && !WIFSIGNALED(status));

  // slaughter those fucking kids
  siginfo_t s;
  while (waitid(P_ALL, 0, &s, WEXITED|WSTOPPED|WCONTINUED|WNOHANG) != -1)
    kill(s.si_pid, 9);

  return WEXITSTATUS(status);
}
