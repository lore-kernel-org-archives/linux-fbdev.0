From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 08 Nov 2015 21:34:53 +0000
Subject: [PATCH] video: constify geode ops structures
Message-Id: <1447018493-20631-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: kernel-janitors@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

These geode ops structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/geode/display_gx1.c  |    2 +-
 drivers/video/fbdev/geode/display_gx1.h  |    2 +-
 drivers/video/fbdev/geode/geodefb.h      |    4 ++--
 drivers/video/fbdev/geode/video_cs5530.c |    2 +-
 drivers/video/fbdev/geode/video_cs5530.h |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/geode/display_gx1.c b/drivers/video/fbdev/geode/display_gx1.c
index 926d53e..b383eb9 100644
--- a/drivers/video/fbdev/geode/display_gx1.c
+++ b/drivers/video/fbdev/geode/display_gx1.c
@@ -208,7 +208,7 @@ static void gx1_set_hw_palette_reg(struct fb_info *info, unsigned regno,
 	writel(val, par->dc_regs + DC_PAL_DATA);
 }
 
-struct geode_dc_ops gx1_dc_ops = {
+const struct geode_dc_ops gx1_dc_ops = {
 	.set_mode	 = gx1_set_mode,
 	.set_palette_reg = gx1_set_hw_palette_reg,
 };
diff --git a/drivers/video/fbdev/geode/display_gx1.h b/drivers/video/fbdev/geode/display_gx1.h
index 671c055..e1cc41b 100644
--- a/drivers/video/fbdev/geode/display_gx1.h
+++ b/drivers/video/fbdev/geode/display_gx1.h
@@ -18,7 +18,7 @@
 unsigned gx1_gx_base(void);
 int gx1_frame_buffer_size(void);
 
-extern struct geode_dc_ops gx1_dc_ops;
+extern const struct geode_dc_ops gx1_dc_ops;
 
 /* GX1 configuration I/O registers */
 
diff --git a/drivers/video/fbdev/geode/geodefb.h b/drivers/video/fbdev/geode/geodefb.h
index ae04820..e2e0793 100644
--- a/drivers/video/fbdev/geode/geodefb.h
+++ b/drivers/video/fbdev/geode/geodefb.h
@@ -31,8 +31,8 @@ struct geodefb_par {
 	int panel_y;
 	void __iomem *dc_regs;
 	void __iomem *vid_regs;
-	struct geode_dc_ops  *dc_ops;
-	struct geode_vid_ops *vid_ops;
+	const struct geode_dc_ops  *dc_ops;
+	const struct geode_vid_ops *vid_ops;
 };
 
 #endif /* !__GEODEFB_H__ */
diff --git a/drivers/video/fbdev/geode/video_cs5530.c b/drivers/video/fbdev/geode/video_cs5530.c
index 649c394..8806132 100644
--- a/drivers/video/fbdev/geode/video_cs5530.c
+++ b/drivers/video/fbdev/geode/video_cs5530.c
@@ -186,7 +186,7 @@ static int cs5530_blank_display(struct fb_info *info, int blank_mode)
 	return 0;
 }
 
-struct geode_vid_ops cs5530_vid_ops = {
+const struct geode_vid_ops cs5530_vid_ops = {
 	.set_dclk          = cs5530_set_dclk_frequency,
 	.configure_display = cs5530_configure_display,
 	.blank_display     = cs5530_blank_display,
diff --git a/drivers/video/fbdev/geode/video_cs5530.h b/drivers/video/fbdev/geode/video_cs5530.h
index 56cecca..c843348 100644
--- a/drivers/video/fbdev/geode/video_cs5530.h
+++ b/drivers/video/fbdev/geode/video_cs5530.h
@@ -15,7 +15,7 @@
 #ifndef __VIDEO_CS5530_H__
 #define __VIDEO_CS5530_H__
 
-extern struct geode_vid_ops cs5530_vid_ops;
+extern const struct geode_vid_ops cs5530_vid_ops;
 
 /* CS5530 Video device registers */
 

