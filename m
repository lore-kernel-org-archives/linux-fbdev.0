From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Sat, 27 Jul 2013 10:05:13 +0000
Subject: [PATCH] video: remove unused variable dev
Message-Id: <1374919513-15356-1-git-send-email-wangkefeng.wang@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jingoo Han <jg1.han@samsung.com>, guohanjun@huawei.com

Due to commit: e21d2170f [video: remove unnecessary platform_set_drvdata()],
variable dev is unused, so remove it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/video/vga16fb.c | 1 -
 1 file changed, 1 deletion(-)

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
1.8.2.2


