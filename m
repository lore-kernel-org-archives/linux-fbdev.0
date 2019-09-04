From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 04 Sep 2019 12:01:32 +0000
Subject: [PATCH -next] fbdev: wm8505fb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <20190904120132.25524-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@prisktech.co.nz, b.zolnierkie@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/wm8505fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 17c7803..351d27b 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -261,7 +261,6 @@ static struct fb_ops wm8505fb_ops = {
 static int wm8505fb_probe(struct platform_device *pdev)
 {
 	struct wm8505fb_info	*fbi;
-	struct resource	*res;
 	struct display_timings *disp_timing;
 	void			*addr;
 	int ret;
@@ -299,8 +298,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	addr = addr + sizeof(struct wm8505fb_info);
 	fbi->fb.pseudo_palette	= addr;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fbi->regbase = devm_ioremap_resource(&pdev->dev, res);
+	fbi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbi->regbase))
 		return PTR_ERR(fbi->regbase);
 
-- 
2.7.4
