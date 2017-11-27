From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 09:38:18 +0000
Subject: [PATCH] video: adv7393fb: Delete two error messages for a failed memory allocation in bfin_adv7393_f
Message-Id: <21f1ee42-17f3-5012-0810-2d0a2890dcc1@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 10:33:19 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/bfin_adv7393fb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev/bfin_adv7393fb.c
index 542ffaddc6ab..aed6b934f009 100644
--- a/drivers/video/fbdev/bfin_adv7393fb.c
+++ b/drivers/video/fbdev/bfin_adv7393fb.c
@@ -389,10 +389,8 @@ static int bfin_adv7393_fb_probe(struct i2c_client *client,
 	}
 
 	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
-	if (!fbdev) {
-		dev_err(&client->dev, "failed to allocate device private record");
+	if (!fbdev)
 		return -ENOMEM;
-	}
 
 	i2c_set_clientdata(client, fbdev);
 
@@ -461,7 +459,6 @@ static int bfin_adv7393_fb_probe(struct i2c_client *client,
 
 	fbdev->info.pseudo_palette = kzalloc(sizeof(u32) * 16, GFP_KERNEL);
 	if (!fbdev->info.pseudo_palette) {
-		dev_err(&client->dev, "failed to allocate pseudo_palette\n");
 		ret = -ENOMEM;
 		goto free_fb_mem;
 	}
-- 
2.15.0

