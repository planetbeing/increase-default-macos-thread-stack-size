#!/bin/sh
export DYLD_INSERT_LIBRARIES="$(pwd)/increase-default-macos-thread-stack-size.dylib"
exec "$(pwd)/stellaris.app/Contents/MacOS/stellaris" "$@" 
