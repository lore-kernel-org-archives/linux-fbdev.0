From: Dan Carpenter <error27@gmail.com>
Date: Mon, 21 Mar 2011 15:03:13 +0000
Subject: [patch v2] fbdev: sh_mobile_lcdc: checking NULL instead of IS_ERR()
Message-Id: <20110321150313.GQ2008@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

backlight_device_register() returns an ERR_PTR.  It doesn't return NULL.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
V2:  print the error code as well.
This patch is againts linux-next, in case you missed that earlier.

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bf2629f..757665b 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1088,8 +1088,9 @@ static struct backlight_device *sh_mobile_lcdc_bl_probe(struct device *parent,
 
 	bl = backlight_device_register(ch->cfg.bl_info.name, parent, ch,
 				       &sh_mobile_lcdc_bl_ops, NULL);
-	if (!bl) {
-		dev_err(parent, "unable to register backlight device\n");
+	if (IS_ERR(bl)) {
+		dev_err(parent, "unable to register backlight device: %ld\n",
+			PTR_ERR(bl));
 		return NULL;
 	}
 
