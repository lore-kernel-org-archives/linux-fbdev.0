From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Mar 2012 17:43:53 +0000
Subject: [RFC/PATCH 5/6] fbdev: sh_mobile_lcdc: Destroy mutex at remove time
Message-Id: <1331833434-11934-6-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add a missing mutex_destroy() call when the driver is unbound from the
device.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 2009432..23d0446 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1725,8 +1725,11 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++) {
-		if (priv->ch[i].bl)
-			sh_mobile_lcdc_bl_remove(priv->ch[i].bl);
+		struct sh_mobile_lcdc_chan *ch = &priv->ch[i];
+
+		if (ch->bl)
+			sh_mobile_lcdc_bl_remove(ch->bl);
+		mutex_destroy(&ch->open_lock);
 	}
 
 	if (priv->dot_clk) {
-- 
1.7.3.4

