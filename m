From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Tue, 25 Aug 2020 10:21:16 +0000
Subject: [PATCH] video: fbdev: fix potential OOB read in vga_8planes_imageblit()
Message-Id: <20200825102116.6703-1-penguin-kernel@I-love.SAKURA.ne.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Since transl_l[16] is accessed via cdat[y] >> 4, cdat[y] needs to be
evaluated as an "unsigned char" value in order to fit 0...15 range.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/vga16fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index a20eeb8308ff..578d3541e3d6 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1121,7 +1121,7 @@ static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *i
         char oldop = setop(0);
         char oldsr = setsr(0);
         char oldmask = selectmask();
-        const char *cdat = image->data;
+	const unsigned char *cdat = image->data;
 	u32 dx = image->dx;
         char __iomem *where;
         int y;
-- 
2.18.4
