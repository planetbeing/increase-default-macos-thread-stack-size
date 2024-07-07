#!/bin/sh

DEFAULT_X86_64=$(./test-x86_64)
if [ "${DEFAULT_X86_64}" -ge "8388608" ]; then
    echo "test-x86_64 (default): ${DEFAULT_X86_64}"
    exit 1
fi

INCREASED_X86_64=$(DYLD_INSERT_LIBRARIES=increase-default-macos-thread-stack-size.dylib ./test-x86_64)
if [ "${INCREASED_X86_64}" -lt "8388608" ]; then
    echo "test-x86_64 (increased): ${INCREASED_X86_64}"
    exit 1
fi

DEFAULT_ARM64=$(./test-arm64)
if [ "${DEFAULT_ARM64}" -ge "8388608" ]; then
    echo "test-arm64 (default): ${DEFAULT_ARM64}"
    exit 1
fi

INCREASED_ARM64=$(DYLD_INSERT_LIBRARIES=increase-default-macos-thread-stack-size.dylib ./test-arm64)
if [ "${INCREASED_ARM64}" -lt "8388608" ]; then
    echo "test-arm64 (increased): ${INCREASED_ARM64}"
    exit 1
fi
