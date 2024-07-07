#include <pthread.h>
#include <stdio.h>

#define DYLD_INTERPOSE(_replacment, _replacee)                                 \
  __attribute__((used)) static struct {                                        \
    const void *replacment;                                                    \
    const void *replacee;                                                      \
  } _interpose_##_replacee __attribute__((section("__DATA,__interpose"))) = {  \
      (const void *)(unsigned long)&_replacment,                               \
      (const void *)(unsigned long)&_replacee};

int pthread_create_interpose(pthread_t *thread, const pthread_attr_t *attr,
                             void *(*start_routine)(void *), void *arg) {
  int ret;
  pthread_attr_t defaultAttrs;
  if (!attr) {
    ret = pthread_attr_init(&defaultAttrs);
    if (ret != 0) {
      return ret;
    }

    ret = pthread_attr_setstacksize(&defaultAttrs, 8 * 1024 * 1024);
    if (ret != 0) {
      return ret;
    }

    ret = pthread_create(thread, &defaultAttrs, start_routine, arg);
    pthread_attr_destroy(&defaultAttrs);
  } else {
    ret = pthread_create(thread, attr, start_routine, arg);
  }

  return ret;
}

DYLD_INTERPOSE(pthread_create_interpose, pthread_create)
