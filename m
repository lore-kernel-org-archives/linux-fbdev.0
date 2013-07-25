From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Thu, 25 Jul 2013 10:06:05 +0000
Subject: [PATCH V2] driver/vga16fb.c: remove the unused variable "dev" of function vga16fb_destroy()
Message-Id: <51F0F88D.8060903@cn.fujitsu.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Commit e21d2170f36602ae2708 ("video: remove unnecessary
platform_set_drvdata()") removed the unnecessary platform_set_drvdata(),
but left the variable "dev" unused, delete it.

v2:
   Following Geert's suggestion to make change log easier reading.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 drivers/video/vga16fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 830ded4..2827333 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1265,7 +1265,6 @@ static void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image
 
 static void vga16fb_destroy(struct fb_info *info)
 {
-	struct platform_device *dev = container_of(info->device, struct platform_device, dev);
 	iounmap(info->screen_base);
 	fb_dealloc_cmap(&info->cmap);
 	/* XXX unshare VGA regions */
-- 
1.7.7

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

