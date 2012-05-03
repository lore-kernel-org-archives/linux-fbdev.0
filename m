From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Thu, 03 May 2012 00:23:40 +0000
Subject: [PATCH] video: fb_defio.c: local functions should not be exposed globally
Message-Id: <201205021723.40801.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, jayalk@intworks.biz, FlorianSchandinat@gmx.de

Functions not referenced outside of a source file should be marked
static to prevent them from being exposed globally.

Quiets the sparse warning:

warning: symbol 'fb_deferred_io_page' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Jaya Kumar <jayalk@intworks.biz>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

---

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index 070f26f..1ddeb11 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -23,7 +23,7 @@
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
-struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
+static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
 	void *screen_base = (void __force *) info->screen_base;
 	struct page *page;
