From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 19 Nov 2018 01:36:42 +0000
Subject: [PATCH v2 -next] video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"
Message-Id: <20181119013642.18080-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, daniel@zonque.org, robert.jarzmik@free.fr
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, yuehaibing@huawei.com, stable@kernel.org

'info->modes' got allocated with devm_kcalloc in of_get_pxafb_display.

This gives this error message:
  ./drivers/video/fbdev/pxafb.c:2238:2-7: WARNING: invalid free of devm_ allocated data

Fixes: c8f96304ec8b4 ("video: fbdev: pxafb: switch to devm_* API")
Cc: stable@kernel.org [v4.19+]
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Daniel Mack <daniel@zonque.org>
---
 drivers/video/fbdev/pxafb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index bbed039..d59c8a5 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2234,10 +2234,8 @@ static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 	ret = of_get_pxafb_mode_info(dev, info);
-	if (ret) {
-		kfree(info->modes);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	/*
 	 * On purpose, neither lccrX registers nor video memory size can be
-- 
2.7.0
