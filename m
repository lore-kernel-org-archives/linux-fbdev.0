From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Mar 2020 04:09:59 +0000
Subject: [PATCH 3/6] fbdev: matrox: fix -Wextra build warnings
Message-Id: <20200315041002.24473-4-rdunlap@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200315041002.24473-1-rdunlap@infradead.org>
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

When 'DEBUG' is not defined, modify the dprintk() macro to use the
no_printk() macro instead of using <empty>.
This fixes build warnings when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/matrox/matroxfb_base.c:635:77: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/video/fbdev/matrox/matroxfb_Ti3026.c:632:54: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
../drivers/video/fbdev/matrox/matroxfb_Ti3026.c:654:53: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/matrox/matroxfb_base.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200313.orig/drivers/video/fbdev/matrox/matroxfb_base.h
+++ linux-next-20200313/drivers/video/fbdev/matrox/matroxfb_base.h
@@ -86,7 +86,7 @@
 #ifdef DEBUG
 #define dprintk(X...)	printk(X)
 #else
-#define dprintk(X...)
+#define dprintk(X...)	no_printk(X)
 #endif
 
 #ifndef PCI_SS_VENDOR_ID_SIEMENS_NIXDORF
