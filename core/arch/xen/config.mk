LING_PLATFORM := xen
LING_OS := ling
ifdef LING_LINUX
CC := gcc
else ifdef LING_DARWIN
HOST_TOOLCHAIN = x86_64-pc-linux
CC := x86_64-pc-linux-gcc
endif

XEN_INTERFACE_VERSION := 0x00030205
CFLAGS   += -DLING_XEN
#CFLAGS += -DLING_CONFIG_DISK
CFLAGS   += -D__XEN_INTERFACE_VERSION__=$(XEN_INTERFACE_VERSION)

CFLAGS   += -std=gnu99
CFLAGS   += -fexcess-precision=standard -frounding-math -mfpmath=sse -msse2
CFLAGS   += -Wno-nonnull -Wno-strict-aliasing

LDFLAGS  += -T core/arch/xen/ling.lds
LDFLAGS  += -static
LDFLAGS  += -Xlinker --build-id=none
LDFLAGS  += -Xlinker --cref -Xlinker -Map=core/ling.map
LDFLAGS  += -nostdlib
LDFLAGS_FINAL += -lgcc

STARTUP_OBJ     := core/arch/xen/startup.o
STARTUP_SRC_EXT := S

LING_WITH_LWIP := 1
