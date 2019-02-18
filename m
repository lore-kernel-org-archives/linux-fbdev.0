From: Finn Thain <fthain@telegraphics.com.au>
Date: Mon, 18 Feb 2019 22:44:54 +0000
Subject: [PATCH] video/macfb: Always initialize DAFB colour table pointer register
Message-Id: <7396d7b11366fe9ee362cb140e74dd391e66e2d6.1550529894.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Don't skip the framebuffer CLUT pointer register initialization when
the first dafb_setpalette() invocation has regno equal to zero.

Cc: linux-m68k@lists.linux-m68k.org
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/video/fbdev/macfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index 37c56c45ee39..8820a556014c 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -148,7 +148,7 @@ static int dafb_setpalette(unsigned int regno, unsigned int red,
 			   unsigned int green, unsigned int blue,
 			   struct fb_info *info)
 {
-	static int lastreg = -1;
+	static int lastreg = -2;
 	unsigned long flags;
 
 	local_irq_save(flags);
-- 
2.19.2
