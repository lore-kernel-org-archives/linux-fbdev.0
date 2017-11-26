From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 13:00:16 +0000
Subject: [PATCH] video: sh_mobile_lcdcfb: Delete an error message for a failed memory allocation in two funct
Message-Id: <478c51ab-b4ef-47e1-0b53-8b4e1f3b931a@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kees Cook <keescook@chromium.org>, Wei Yongjun <weiyongjun1@huawei.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 13:48:55 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c3a46506e47e..0f9b37034eaf 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -2149,10 +2149,8 @@ sh_mobile_lcdc_channel_fb_register(struct sh_mobile_lcdc_chan *ch)
 	if (info->fbdefio) {
 		ch->sglist = vmalloc(sizeof(struct scatterlist) *
 				     ch->fb_size >> PAGE_SHIFT);
-		if (!ch->sglist) {
-			dev_err(ch->lcdc->dev, "cannot allocate sglist\n");
+		if (!ch->sglist)
 			return -ENOMEM;
-		}
 	}
 
 	info->bl_dev = ch->bl;
@@ -2718,10 +2716,8 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "cannot allocate device data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	priv->dev = &pdev->dev;
 	priv->meram_dev = pdata->meram_dev;
-- 
2.15.0

