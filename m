From: Bo Shen <voice.shen@atmel.com>
Date: Wed, 19 Mar 2014 07:47:55 +0000
Subject: [PATCH] Video: atmel: avoid the id of fix screen info is overwritten
Message-Id: <1395215275-14345-1-git-send-email-voice.shen@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Correct passing parameter sequence, which will avoid the id of
fix screen info is overwritten.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/video/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index cd96162..695f28a 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -1190,12 +1190,12 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	if (!sinfo->config)
 		goto free_info;
 
-	strcpy(info->fix.id, sinfo->pdev->name);
 	info->flags = ATMEL_LCDFB_FBINFO_DEFAULT;
 	info->pseudo_palette = sinfo->pseudo_palette;
 	info->fbops = &atmel_lcdfb_ops;
 
 	info->fix = atmel_lcdfb_fix;
+	strcpy(info->fix.id, sinfo->pdev->name);
 
 	/* Enable LCDC Clocks */
 	sinfo->bus_clk = clk_get(dev, "hclk");
-- 
1.8.5.2

