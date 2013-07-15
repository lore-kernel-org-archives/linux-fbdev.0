From: Yijing Wang <wangyijing@huawei.com>
Date: Mon, 15 Jul 2013 06:29:25 +0000
Subject: [PATCH] video: remove unused variable "dev" in vga16fb_destroy()
Message-Id: <1373869765-52572-1-git-send-email-wangyijing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com, Yijing Wang <wangyijing@huawei.com>, Jingoo Han <jg1.han@samsung.com>

Delete unused variable "dev" to fix build warning in
drivers/video/vga16fb.c

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Jingoo Han <jg1.han@samsung.com>
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
1.7.1


