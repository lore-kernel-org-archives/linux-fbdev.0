From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 11:59:22 +0000
Subject: [PATCH 1/2] fbdev: shmobile-lcdcfb: Use NULL instead of 0 as NULL pointer
Message-Id: <1390305563-27229-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Setting a pointer to NULL shouldn't use 0.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index ab85ad6..2bcc84a 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1227,7 +1227,7 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 		/* Free the MERAM cache. */
 		if (ch->cache) {
 			sh_mobile_meram_cache_free(priv->meram_dev, ch->cache);
-			ch->cache = 0;
+			ch->cache = NULL;
 		}
 
 	}
-- 
1.8.3.2

