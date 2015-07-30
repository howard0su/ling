#include "ling_common.h"

#include "console.h"
#include "outlet.h"

#include "syscalls.h"

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

#define constwrite1(s) write(1, (s), sizeof(s)-1)

static outlet_t *attached_outlet;

void
console_init(void)
{
#if CONSOLE_DEBUG
	constwrite1("console hello\n");
#endif
	int flag = O_NONBLOCK;
	fcntl(STDIN_FILENO, F_SETFL, flag);
}

int
console_is_initialized(void)
{
	return 1;
}

void
console_attach(outlet_t *ol)
{
#if CONSOLE_DEBUG
	constwrite1("console attach\n");
#endif
	attached_outlet = ol;
}

void
console_detach(outlet_t *ol)
{
#if CONSOLE_DEBUG
	constwrite1("console detach\n");
#endif
	attached_outlet = NULL;
}

int
console_write(char *buf, int len)
{
	return write(STDOUT_FILENO, buf, len);
}

int
ser_cons_write(char *buf, int len)
{
	return write(STDOUT_FILENO, buf, len);
}

int
console_do_pending(void)
{
	char buf[1];
	int total = 0;

	while (read(STDIN_FILENO, buf, 1) == 1) {
		if (attached_outlet)
			outlet_pass_new_data(attached_outlet, (uint8_t *)buf, 1);
		total++;
	}
	return total;
}

#if LING_DEBUG

#include <stdarg.h>

int debug(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    int ret = vfprintf(stderr, fmt, ap);
    va_end(ap);
    return ret;
}
#endif
