From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Mar 2020 04:10:01 +0000
Subject: [PATCH 5/6] fbdev: pm[23]fb.c: fix -Wextra build warnings and errors
Message-Id: <20200315041002.24473-6-rdunlap@infradead.org>
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
This fixes build warnings when -Wextra is used and provides
printk format checking:

../drivers/video/fbdev/pm2fb.c:227:38: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/video/fbdev/pm3fb.c:1039:33: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]

Also drop one argument in two DPRINTK() macro uses to provide the
correct number of arguments and use the correct field in one case
to fix a build error:

../drivers/video/fbdev/pm3fb.c:353:9: error: ‘struct fb_info’ has no member named ‘current_par’
     info->current_par->depth);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
Alternative: use pr_debug() so that CONFIG_DYNAMIC_DEBUG can be used
at these sites.

 drivers/video/fbdev/pm2fb.c |    2 +-
 drivers/video/fbdev/pm3fb.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20200313.orig/drivers/video/fbdev/pm2fb.c
+++ linux-next-20200313/drivers/video/fbdev/pm2fb.c
@@ -54,7 +54,7 @@
 #define DPRINTK(a, b...)	\
 	printk(KERN_DEBUG "pm2fb: %s: " a, __func__ , ## b)
 #else
-#define DPRINTK(a, b...)
+#define DPRINTK(a, b...)	no_printk(a, ##b)
 #endif
 
 #define PM2_PIXMAP_SIZE	(1600 * 4)
--- linux-next-20200313.orig/drivers/video/fbdev/pm3fb.c
+++ linux-next-20200313/drivers/video/fbdev/pm3fb.c
@@ -44,7 +44,7 @@
 #define DPRINTK(a, b...)	\
 	printk(KERN_DEBUG "pm3fb: %s: " a, __func__ , ## b)
 #else
-#define DPRINTK(a, b...)
+#define DPRINTK(a, b...)	no_printk(a, ##b)
 #endif
 
 #define PM3_PIXMAP_SIZE	(2048 * 4)
@@ -306,7 +306,7 @@ static void pm3fb_init_engine(struct fb_
 					   PM3PixelSize_GLOBAL_32BIT);
 			break;
 		default:
-			DPRINTK(1, "Unsupported depth %d\n",
+			DPRINTK("Unsupported depth %d\n",
 				info->var.bits_per_pixel);
 			break;
 		}
@@ -349,8 +349,8 @@ static void pm3fb_init_engine(struct fb_
 					   (1 << 10) | (0 << 3));
 			break;
 		default:
-			DPRINTK(1, "Unsupported depth %d\n",
-				info->current_par->depth);
+			DPRINTK("Unsupported depth %d\n",
+				info->var.bits_per_pixel);
 			break;
 		}
 	}
