increase-default-macos-thread-stack-size.dylib: increase-default-macos-thread-stack-size.c
	clang -dynamiclib -arch arm64 -arch x86_64 -lpthread increase-default-macos-thread-stack-size.c -o increase-default-macos-thread-stack-size.dylib

clean:
	rm -f increase-default-macos-thread-stack-size.dylib test-x86_64 test-arm64

test: test-x86_64 test-arm64 increase-default-macos-thread-stack-size.dylib
	./test.sh

test-x86_64: test.c
	clang -arch x86_64 test.c -o test-x86_64

test-arm64: test.c
	clang -arch arm64 test.c -o test-arm64
