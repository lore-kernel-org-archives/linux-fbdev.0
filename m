From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 17 Jan 2020 03:22:41 +0000
Subject: [PATCH -next] video: fbdev: pxa168fb: remove unnecessary platform_get_irq
Message-Id: <20200117032241.59148-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, yuehaibing@huawei.com, arnd@arndb.de, daniel.vetter@ffwll.ch, christophe.jaillet@wanadoo.fr, jani.nikula@intel.com, hslester96@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

commit 640ba2444fa9 ("drivers/video/pxa168fb.c: use devm_ functions")
left behind this, it can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/pxa168fb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 706c6943..aef8a30 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -779,7 +779,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
 {
 	struct pxa168fb_info *fbi = platform_get_drvdata(pdev);
 	struct fb_info *info;
-	int irq;
 	unsigned int data;
 
 	if (!fbi)
@@ -799,8 +798,6 @@ static int pxa168fb_remove(struct platform_device *pdev)
 	if (info->cmap.len)
 		fb_dealloc_cmap(&info->cmap);
 
-	irq = platform_get_irq(pdev, 0);
-
 	dma_free_wc(fbi->dev, info->fix.smem_len,
 		    info->screen_base, info->fix.smem_start);
 
-- 
2.7.4
