#include <pthread.h>
#include <stdio.h>

void *threadFunc(void *arg) { return NULL; }

int main(int argc, const char *argv[]) {
  pthread_t thread;
  pthread_create(&thread, NULL, threadFunc, NULL);

  fprintf(stdout, "%zu\n", pthread_get_stacksize_np(thread));

  void *ret;
  pthread_join(thread, &ret);
  return 0;
}
