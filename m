From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:27 +0000
Subject: [PATCH 32/57] fbdev: sh_mobile_lcdc: Reorganize the sh_mobile_lcdc_chan structure
Message-Id: <1323784972-24205-33-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Group fields by purpose, and make the separation between core fields and
FB-related fields clear.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.h |   39 ++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index c175387..8e0d009 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -53,30 +53,22 @@ struct sh_mobile_lcdc_entity {
 struct sh_mobile_lcdc_chan {
 	struct sh_mobile_lcdc_priv *lcdc;
 	struct sh_mobile_lcdc_entity *tx_dev;
+	struct sh_mobile_lcdc_chan_cfg cfg;
 
 	unsigned long *reg_offs;
 	unsigned long ldmt1r_value;
 	unsigned long enabled; /* ME and SE in LDCNT2R */
-	struct sh_mobile_lcdc_chan_cfg cfg;
-	u32 pseudo_palette[PALETTE_NR];
-	struct fb_info *info;
-	struct backlight_device *bl;
+	int meram_enabled;
+
+	struct mutex open_lock;		/* protects the use counter */
+	int use_count;
+
 	dma_addr_t dma_handle;
-	struct fb_deferred_io defio;
-	struct scatterlist *sglist;
-	unsigned long frame_end;
 	unsigned long pan_offset;
+
+	unsigned long frame_end;
 	wait_queue_head_t frame_end_wait;
 	struct completion vsync_completion;
-	struct {
-		unsigned int width;
-		unsigned int height;
-		struct fb_videomode mode;
-	} display;
-	int use_count;
-	int blank_status;
-	struct mutex open_lock;		/* protects the use counter */
-	int meram_enabled;
 
 	unsigned long base_addr_y;
 	unsigned long base_addr_c;
@@ -86,6 +78,21 @@ struct sh_mobile_lcdc_chan {
 		      enum sh_mobile_lcdc_entity_event event,
 		      const struct fb_videomode *mode,
 		      const struct fb_monspecs *monspec);
+
+	/* Backlight */
+	struct backlight_device *bl;
+
+	/* FB */
+	struct fb_info *info;
+	u32 pseudo_palette[PALETTE_NR];
+	struct {
+		unsigned int width;
+		unsigned int height;
+		struct fb_videomode mode;
+	} display;
+	struct fb_deferred_io defio;
+	struct scatterlist *sglist;
+	int blank_status;
 };
 
 #endif
-- 
1.7.3.4

