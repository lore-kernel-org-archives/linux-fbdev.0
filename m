From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 26 May 2011 06:53:10 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: Reduce scope and rename result variable
Message-Id: <1306392790-17462-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 69843ba7f24950f8ef5dadacfbfbd08f53e3455b
reduces the scope of the variable that was used to get the
return value of ops->meram_register() in sh_mobile_lcdc_start.

In order to avoid conflicts with that patch, the variable has been renamed
and scoped within the local if-clause.
---
 drivers/video/sh_mobile_lcdcfb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 404c03b..596b662 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -617,6 +617,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			unsigned long icb_addr_y, icb_addr_c;
 			int icb_pitch;
 			int pf;
+			int retval;
 
 			cfg = ch->cfg.meram_cfg;
 			mdev = priv->meram_dev;
@@ -637,7 +638,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 				pf = SH_MOBILE_MERAM_PF_RGB;
 			}
 
-			ret = mdev->ops->meram_register(mdev, cfg, pitch,
+			retval = mdev->ops->meram_register(mdev, cfg, pitch,
 						ch->info->var.yres,
 						pf,
 						base_addr_y,
@@ -645,7 +646,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 						&icb_addr_y,
 						&icb_addr_c,
 						&icb_pitch);
-			if (!ret)  {
+			if (!retval)  {
 				/* set LDSA1R value */
 				base_addr_y = icb_addr_y;
 				pitch = icb_pitch;
-- 
1.7.1

