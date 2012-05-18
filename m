From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 18 May 2012 08:58:26 +0000
Subject: [PATCH for v3.4] fbdev: sh_mobile_lcdc: Don't confuse line size with pitch
Message-Id: <1337331506-13156-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

When using the MERAM the LCDC line size needs to be programmed with a
MERAM-specific value different than the real frame buffer pitch. Fix it.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |    5 +++--
 drivers/video/sh_mobile_lcdcfb.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

Hi Linus,

Could you please apply this patch to v3.4-rc ? I apologize for pushing it this
late, but this is a fix for a 3.4 regression that has only been discovered now
and breaks an important use case (fbcon on SH Mobile).

Due to the little time left before v3.4 Florian has asked me to send you the
patch directly instead of pushing it through his tree.

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 7a0b301..e672698 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -758,7 +758,7 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		}
 
 		lcdc_write_chan(ch, LDDFR, tmp);
-		lcdc_write_chan(ch, LDMLSR, ch->pitch);
+		lcdc_write_chan(ch, LDMLSR, ch->line_size);
 		lcdc_write_chan(ch, LDSA1R, ch->base_addr_y);
 		if (ch->format->yuv)
 			lcdc_write_chan(ch, LDSA2R, ch->base_addr_c);
@@ -847,6 +847,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		ch->base_addr_y = ch->dma_handle;
 		ch->base_addr_c = ch->base_addr_y + ch->xres * ch->yres_virtual;
+		ch->line_size = ch->pitch;
 
 		/* Enable MERAM if possible. */
 		if (mdev = NULL || mdev->ops = NULL ||
@@ -882,7 +883,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 		meram = mdev->ops->meram_register(mdev, ch->cfg->meram_cfg,
 					ch->pitch, ch->yres, pixelformat,
-					&ch->pitch);
+					&ch->line_size);
 		if (!IS_ERR(meram)) {
 			mdev->ops->meram_update(mdev, meram,
 					ch->base_addr_y, ch->base_addr_c,
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index da1c26e..5c3bddd 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -84,6 +84,7 @@ struct sh_mobile_lcdc_chan {
 
 	unsigned long base_addr_y;
 	unsigned long base_addr_c;
+	unsigned int line_size;
 
 	int (*notify)(struct sh_mobile_lcdc_chan *ch,
 		      enum sh_mobile_lcdc_entity_event event,
-- 
Regards,

Laurent Pinchart

