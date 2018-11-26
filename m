From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Mon, 26 Nov 2018 10:02:53 +0000
Subject: [PATCH] fbcon: use kvmalloc() for scrollback buffer
Message-Id: <20181126100253.3299-1-khorenko@virtuozzo.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

Scrollback frame buffer is rather big - 32K,
so it requires 3rd order page, so let's use kvmalloc() instead of
ordinary kmalloc() for it.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 drivers/video/fbdev/core/fbcon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8958ccc8b1ac..2b1a34d3f5e2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -992,7 +992,7 @@ static const char *fbcon_startup(void)
 			if (!softback_buf) {
 				softback_buf  				    (unsigned long)
-				    kmalloc(fbcon_softback_size,
+				    kvmalloc(fbcon_softback_size,
 					    GFP_KERNEL);
 				if (!softback_buf) {
 					fbcon_softback_size = 0;
@@ -1001,7 +1001,7 @@ static const char *fbcon_startup(void)
 			}
 		} else {
 			if (softback_buf) {
-				kfree((void *) softback_buf);
+				kvfree((void *) softback_buf);
 				softback_buf = 0;
 				softback_top = 0;
 			}
@@ -3665,7 +3665,7 @@ static void fbcon_exit(void)
 	}
 #endif
 
-	kfree((void *)softback_buf);
+	kvfree((void *)softback_buf);
 	softback_buf = 0UL;
 
 	for_each_registered_fb(i) {
-- 
2.15.1
