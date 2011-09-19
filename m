From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 19 Sep 2011 00:27:45 +0000
Subject: [WIP/RFC 07/31] fbdev: sh_mobile_lcdc: Add sh_mobile_lcdc_entity definition
Message-Id: <1316392089-27598-8-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The sh_mobile_lcdc_entity structure will be used to abstract operations
performed by transceivers (such as MIPI/DSI and HDMI).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.h |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index a58a0f3..f1451c6 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -14,9 +14,23 @@ enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
 
 #define PALETTE_NR 16
 
-struct sh_mobile_lcdc_priv;
-struct fb_info;
 struct backlight_device;
+struct fb_info;
+struct module;
+struct sh_mobile_lcdc_entity;
+struct sh_mobile_lcdc_priv;
+
+struct sh_mobile_lcdc_entity_ops {
+	/* Display */
+	void (*display_on)(struct sh_mobile_lcdc_entity *entity,
+			   struct fb_info *info);
+	void (*display_off)(struct sh_mobile_lcdc_entity *entity);
+};
+
+struct sh_mobile_lcdc_entity {
+	struct module *owner;
+	const struct sh_mobile_lcdc_entity_ops *ops;
+};
 
 /*
  * struct sh_mobile_lcdc_chan - LCDC display channel
-- 
1.7.3.4

