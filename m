From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 11:59:23 +0000
Subject: [PATCH 2/2] fbdev: shmobile-lcdcfb: Fix sparse address space cast warning
Message-Id: <1390305563-27229-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The fbdev screen_base field stores the frame buffer base address.
Depending on the drivers this is either an I/O memory pointer or a
kernel virtual pointer.

The field is marked with the __iomem address space type, cast the kernel
pointer to __iomem to make sparse happy.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 2bcc84a..5805044 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1710,7 +1710,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &sh_mobile_lcdc_overlay_ops;
 	info->device = priv->dev;
-	info->screen_base = ovl->fb_mem;
+	info->screen_base = (char __force __iomem *)ovl->fb_mem;
 	info->par = ovl;
 
 	/* Initialize fixed screen information. Restrict pan to 2 lines steps
@@ -2212,7 +2212,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->fbops = &sh_mobile_lcdc_ops;
 	info->device = priv->dev;
-	info->screen_base = ch->fb_mem;
+	info->screen_base = (char __force __iomem *)ch->fb_mem;
 	info->pseudo_palette = &ch->pseudo_palette;
 	info->par = ch;
 
-- 
1.8.3.2

