LWIP_DIR := core/lib/lwip

LWIP_SUB := \
	$(LWIP_DIR)/src/api \
	$(LWIP_DIR)/src/core \
	$(LWIP_DIR)/src/core/ipv4 \
	$(LWIP_DIR)/src/core/ipv6 \
	$(LWIP_DIR)/src/netif

LWIP_SRC := $(foreach dir,$(LWIP_SUB),$(wildcard $(dir)/*.c))
LWIP_OBJ := $(patsubst %.c,%.o,$(LWIP_SRC))
LWIP_DEP := $(patsubst %.c,%.d,$(LWIP_SRC))
-include $(LWIP_DEP)

CFLAGS += -DLING_WITH_LWIP=1
CFLAGS += -iquote $(LWIP_DIR)/src/include
CFLAGS += -iquote $(LWIP_DIR)/src/include/ipv4
CFLAGS += -iquote $(LWIP_DIR)/src/include/ipv6
CFLAGS += -iquote $(LWIP_DIR)/ling
#COMMON_CFLAGS := -fno-stack-protector -U_FORTIFY_SOURCE -fno-omit-frame-pointer

$(LWIP_OBJ): %.o: %.c .config
	$(CC) -MMD -MP $(CFLAGS) -Wno-char-subscripts -o $@ -c $<

ALL_OBJ += $(LWIP_OBJ)
