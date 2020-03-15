From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Mar 2020 04:09:57 +0000
Subject: [PATCH 1/6] fbdev: fbmon: fix -Wextra build warnings
Message-Id: <20200315041002.24473-2-rdunlap@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200315041002.24473-1-rdunlap@infradead.org>
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

When 'DEBUG' is not defined, modify the DPRINTK() macro to use the
no_printk() macro instead of using <empty>.
This fixes a build warning when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/core/fbmon.c:812:47: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/video/fbdev/core/fbmon.c:842:24: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../drivers/video/fbdev/core/fbmon.c:847:24: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/core/fbmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200313.orig/drivers/video/fbdev/core/fbmon.c
+++ linux-next-20200313/drivers/video/fbdev/core/fbmon.c
@@ -44,7 +44,7 @@
 #ifdef DEBUG
 #define DPRINTK(fmt, args...) printk(fmt,## args)
 #else
-#define DPRINTK(fmt, args...)
+#define DPRINTK(fmt, args...) no_printk(fmt, ##args)
 #endif
 
 #define FBMON_FIX_HEADER  1
