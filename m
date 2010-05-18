From: Ben Dooks <ben-linux@fluff.org>
Date: Tue, 18 May 2010 10:54:05 +0000
Subject: [PATCH 5/5] s3c-fb: Integrate palette setup code into main driver
Message-Id: <1274180045-14645-6-git-send-email-ben-linux@fluff.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
In-Reply-To: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove the palette setup code from the header files and
put it into the main driver.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/include/plat/regs-fb-v4.h |   34 -----------------------
 drivers/video/s3c-fb.c                          |   33 +++++++++++++++++++++-
 2 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
index 8352f5d..4c3647f 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
@@ -137,40 +137,6 @@
 #define WPALCON_W2PAL_16BPP_A555		(1 << 6)
 
 
-/* system specific implementation code for palette sizes, and other
- * information that changes depending on which architecture is being
- * compiled.
-*/
-
-struct s3c_fb_palette {
-	struct fb_bitfield	r;
-	struct fb_bitfield	g;
-	struct fb_bitfield	b;
-	struct fb_bitfield	a;
-};
-
-static inline void s3c_fb_init_palette(unsigned int window,
-				       struct s3c_fb_palette *palette)
-{
-	if (window < 2) {
-		/* Windows 0/1 are 8/8/8 or A/8/8/8 */
-		palette->r.offset = 16;
-		palette->r.length = 8;
-		palette->g.offset = 8;
-		palette->g.length = 8;
-		palette->b.offset = 0;
-		palette->b.length = 8;
-	} else {
-		/* currently we assume RGB 5/6/5 */
-		palette->r.offset = 11;
-		palette->r.length = 5;
-		palette->g.offset = 5;
-		palette->g.length = 6;
-		palette->b.offset = 0;
-		palette->b.length = 5;
-	}
-}
-
 /* Notes on per-window bpp settings
  *
  * Value	Win0	 Win1	  Win2	   Win3	    Win 4
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 8b49ea7..b9907b9 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -116,6 +116,20 @@ struct s3c_fb_driverdata {
 };
 
 /**
+ * struct s3c_fb_palette - palette information
+ * @r: Red bitfield.
+ * @g: Green bitfield.
+ * @b: Blue bitfield.
+ * @a: Alpha bitfield.
+ */
+struct s3c_fb_palette {
+	struct fb_bitfield	r;
+	struct fb_bitfield	g;
+	struct fb_bitfield	b;
+	struct fb_bitfield	a;
+};
+
+/**
  * struct s3c_fb_win - per window private data for each framebuffer.
  * @windata: The platform data supplied for the window configuration.
  * @parent: The hardware that this window is part of.
@@ -865,7 +879,24 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	}
 
 	/* setup the r/b/g positions for the window's palette */
-	s3c_fb_init_palette(win_no, &win->palette);
+	if (win->variant.palette_16bpp) {
+		/* Set RGB 5:6:5 as default */
+		win->palette.r.offset = 11;
+		win->palette.r.length = 5;
+		win->palette.g.offset = 5;
+		win->palette.g.length = 6;
+		win->palette.b.offset = 0;
+		win->palette.b.length = 5;
+
+	} else {
+		/* Set 8bpp or 8bpp and 1bit alpha */
+		win->palette.r.offset = 16;
+		win->palette.r.length = 8;
+		win->palette.g.offset = 8;
+		win->palette.g.length = 8;
+		win->palette.b.offset = 0;
+		win->palette.b.length = 8;
+	}
 
 	/* setup the initial video mode from the window */
 	fb_videomode_to_var(&fbinfo->var, initmode);
-- 
1.6.3.3

