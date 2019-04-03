From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 03 Apr 2019 07:24:45 +0000
Subject: [PATCH -next] video: fbdev: atmel_lcdfb: remove set but not used variable 'pdata'
Message-Id: <20190403072445.42983-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/atmel_lcdfb.c: In function 'atmel_lcdfb_remove':
drivers/video/fbdev/atmel_lcdfb.c:1255:28: warning:
 variable 'pdata' set but not used [-Wunused-but-set-variable]

It's not used since commit 42110e91de7f ("video: atmel_lcdfb: introduce
atmel_lcdfb_power_control")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index b8786ff62b87..e67dfd94bf1d 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1252,12 +1252,10 @@ static int __exit atmel_lcdfb_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct atmel_lcdfb_info *sinfo;
-	struct atmel_lcdfb_pdata *pdata;
 
 	if (!info || !info->par)
 		return 0;
 	sinfo = info->par;
-	pdata = &sinfo->pdata;
 
 	cancel_work_sync(&sinfo->task);
 	exit_backlight(sinfo);
