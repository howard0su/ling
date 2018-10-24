LING_PLATFORM := unix
ifdef LING_LINUX
CC := gcc
LDFLAGS += -no-pie -nostdlib
LING_OS := linux
else ifdef LING_DARWIN
CC := clang
LING_OS := darwin
endif

CFLAGS += -DLING_POSIX
CFLAGS += -Wno-unknown-pragmas -Wno-int-conversion -Wno-empty-body
STARTUP_OBJ :=
ifdef LING_DARWIN
# assuming Apple LLVM version 6.0 (clang-600.0.57)
CFLAGS += -Wno-tautological-compare -Wno-typedef-redefinition -Wno-self-assign
endif
LING_WITH_LIBUV := 1