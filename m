From: Dan Carpenter <error27@gmail.com>
Date: Sat, 19 Mar 2011 04:36:47 +0000
Subject: [patch] fbdev: sh_mobile_lcdc: checking NULL instead of IS_ERR()
Message-Id: <20110319043647.GZ2008@bicker>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

backlight_device_register() returns an ERR_PTR.  It doesn't return NULL.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bf2629f..a53abe1 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1088,7 +1088,7 @@ static struct backlight_device *sh_mobile_lcdc_bl_probe(struct device *parent,
 
 	bl = backlight_device_register(ch->cfg.bl_info.name, parent, ch,
 				       &sh_mobile_lcdc_bl_ops, NULL);
-	if (!bl) {
+	if (IS_ERR(bl)) {
 		dev_err(parent, "unable to register backlight device\n");
 		return NULL;
 	}
