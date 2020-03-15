From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Mar 2020 04:10:00 +0000
Subject: [PATCH 4/6] fbdev: savage: fix -Wextra build warning
Message-Id: <20200315041002.24473-5-rdunlap@infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200315041002.24473-1-rdunlap@infradead.org>
In-Reply-To: <20200315041002.24473-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

When 'SAVAGEFB_DEBUG' is not defined, modify the DBG() macro to use the
no_printk() macro instead of using <empty>.
This fixes a build warning when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/savage/savagefb_driver.c:2411:13: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/savage/savagefb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200313.orig/drivers/video/fbdev/savage/savagefb.h
+++ linux-next-20200313/drivers/video/fbdev/savage/savagefb.h
@@ -21,7 +21,7 @@
 #ifdef SAVAGEFB_DEBUG
 # define DBG(x)		printk (KERN_DEBUG "savagefb: %s\n", (x));
 #else
-# define DBG(x)
+# define DBG(x)		no_printk(x)
 # define SavagePrintRegs(...)
 #endif
 
