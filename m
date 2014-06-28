From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 28 Jun 2014 06:34:06 +0000
Subject: [PATCH 2/2] video: clps711x: Fix sparse warnings
Message-Id: <1403937246-14506-2-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes below warnings:
CHECK   drivers/video/fbdev/clps711x-fb.c
  drivers/video/fbdev/clps711x-fb.c:247:24: warning: incorrect type in argument 1 (different address spaces)
  drivers/video/fbdev/clps711x-fb.c:247:24:    expected void const *ptr
  drivers/video/fbdev/clps711x-fb.c:247:24:    got char [noderef] <asn:2>*screen_base
  drivers/video/fbdev/clps711x-fb.c:248:35: warning: incorrect type in argument 1 (different address spaces)
  drivers/video/fbdev/clps711x-fb.c:248:35:    expected void const *ptr
  drivers/video/fbdev/clps711x-fb.c:248:35:    got char [noderef] <asn:2>*screen_base
  drivers/video/fbdev/clps711x-fb.c:314:17: warning: incorrect type in initializer (different address spaces)
  drivers/video/fbdev/clps711x-fb.c:314:17:    expected void *__p
  drivers/video/fbdev/clps711x-fb.c:314:17:    got char [noderef] <asn:2>*screen_base
CC [M]  drivers/video/fbdev/clps711x-fb.o

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/fbdev/clps711x-fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 4d17fbb..bbf40fe 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -244,8 +244,8 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	info->screen_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(info->screen_base)) {
-		ret = PTR_ERR(info->screen_base);
+	if (IS_ERR((__force void *)info->screen_base)) {
+		ret = PTR_ERR((__force void *)info->screen_base);
 		goto out_fb_release;
 	}
 
@@ -311,7 +311,7 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 		/* Setup start FB address */
 		writeb(info->fix.smem_start >> 28, cfb->base + CLPS711X_FBADDR);
 		/* Clean FB memory */
-		memset(info->screen_base, 0, cfb->buffsize);
+		memset_io(info->screen_base, 0, cfb->buffsize);
 	}
 
 	cfb->lcd_pwr = devm_regulator_get(dev, "lcd");
-- 
1.8.5.5

