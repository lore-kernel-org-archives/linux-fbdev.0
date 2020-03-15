From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Mar 2020 04:10:02 +0000
Subject: [PATCH 6/6] fbdev: via: fix -Wextra build warning and format warning
Message-Id: <20200315041002.24473-7-rdunlap@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200315041002.24473-1-rdunlap@infradead.org>
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

When 'VIAFB_DEBUG' and 'VIAFB_WARN' are not defined, modify the
DEBUG_MSG() &WARN_MSG() macros to use the no_printk() macro instead of
using <empty>.
This fixes a build warning when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/via/ioctl.c:88:47: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Also use %lu to print an unsigned long instead of just %l, to fix
a printk format warning:

../drivers/video/fbdev/via/viafbdev.c: In function ‘viafb_dvp0_proc_write’:
../drivers/video/fbdev/via/viafbdev.c:1148:14: warning: unknown conversion type character ‘]’ in format [-Wformat=]
    DEBUG_MSG("DVP0:reg_val[%l]=:%x\n", i,

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/via/debug.h    |    6 ++++--
 drivers/video/fbdev/via/viafbdev.c |    2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20200313.orig/drivers/video/fbdev/via/debug.h
+++ linux-next-20200313/drivers/video/fbdev/via/debug.h
@@ -7,6 +7,8 @@
 #ifndef __DEBUG_H__
 #define __DEBUG_H__
 
+#include <linux/printk.h>
+
 #ifndef VIAFB_DEBUG
 #define VIAFB_DEBUG 0
 #endif
@@ -14,14 +16,14 @@
 #if VIAFB_DEBUG
 #define DEBUG_MSG(f, a...)   printk(f, ## a)
 #else
-#define DEBUG_MSG(f, a...)
+#define DEBUG_MSG(f, a...)   no_printk(f, ## a)
 #endif
 
 #define VIAFB_WARN 0
 #if VIAFB_WARN
 #define WARN_MSG(f, a...)   printk(f, ## a)
 #else
-#define WARN_MSG(f, a...)
+#define WARN_MSG(f, a...)   no_printk(f, ## a)
 #endif
 
 #endif /* __DEBUG_H__ */
--- linux-next-20200313.orig/drivers/video/fbdev/via/viafbdev.c
+++ linux-next-20200313/drivers/video/fbdev/via/viafbdev.c
@@ -1144,7 +1144,7 @@ static ssize_t viafb_dvp0_proc_write(str
 		if (value != NULL) {
 			if (kstrtou8(value, 0, &reg_val) < 0)
 				return -EINVAL;
-			DEBUG_MSG(KERN_INFO "DVP0:reg_val[%l]=:%x\n", i,
+			DEBUG_MSG(KERN_INFO "DVP0:reg_val[%lu]=:%x\n", i,
 				  reg_val);
 			switch (i) {
 			case 0:
