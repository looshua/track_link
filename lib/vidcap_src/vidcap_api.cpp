#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))

#include <opencv2/core.hpp>



EXPORT
int add(int a, int b) {
    return a + b;
}