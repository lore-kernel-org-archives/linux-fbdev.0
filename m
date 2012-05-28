From: Emil Goode <emilgoode@gmail.com>
Date: Mon, 28 May 2012 14:40:19 +0000
Subject: [PATCH] video: bfin_adv7393fb: Fix cleanup code
Message-Id: <1338216019-1288-1-git-send-email-emilgoode@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FlorianSchandinat@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>

This patch fixes the cleanup code of the bfin_adv7393_fb_probe
function by changing the order in which cleanup is performed
and by adding one label.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 drivers/video/bfin_adv7393fb.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/bfin_adv7393fb.c b/drivers/video/bfin_adv7393fb.c
index 1a268a2..ddbd031 100644
--- a/drivers/video/bfin_adv7393fb.c
+++ b/drivers/video/bfin_adv7393fb.c
@@ -414,7 +414,7 @@ static int __devinit bfin_adv7393_fb_probe(struct i2c_client *client,
 		if (ret) {
 			dev_err(&client->dev, "PPI0_FS3 GPIO request failed\n");
 			ret = -EBUSY;
-			goto out_8;
+			goto out_9;
 		}
 	}
 
@@ -528,15 +528,18 @@ static int __devinit bfin_adv7393_fb_probe(struct i2c_client *client,
  out_3:
 	free_dma(CH_PPI);
  out_4:
-	dma_free_coherent(NULL, fbdev->fb_len, fbdev->fb_mem,
-			  fbdev->dma_handle);
- out_5:
 	fb_dealloc_cmap(&fbdev->info.cmap);
- out_6:
+ out_5:
 	kfree(fbdev->info.pseudo_palette);
+ out_6:
+	dma_free_coherent(NULL, fbdev->fb_len, fbdev->fb_mem,
+			  fbdev->dma_handle);
  out_7:
 	peripheral_free_list(ppi_pins);
  out_8:
+	if (ANOMALY_05000400)
+		gpio_free(P_IDENT(P_PPI0_FS3));
+ out_9:
 	kfree(fbdev);
 
 	return ret;
-- 
1.7.10

