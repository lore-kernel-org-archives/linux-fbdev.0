From: David Lechner <david@lechnology.com>
Date: Tue, 01 Aug 2017 16:35:57 +0000
Subject: [PATCH v3] fbcon: add fbcon=margin:<color> command line option
Message-Id: <1501605357-30815-1-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

This adds a new command line option to select the fbcon margin color.

The motivation for this is screens where black does not blend into the
physical surroundings of the screen. For example, using an LCD (not the
backlit kind), white text on a black background is hard to read, so
inverting the colors is preferred. However, when you do this, most of the
screen is filled with white but the margins are still filled with black.
This makes a big, black, backwards 'L' on the screen. By setting
fbcon=margin:7, the margins will be filled with white and the LCD looks as
expected.

Signed-off-by: David Lechner <david@lechnology.com>
---

This is a replacement for my previous patches that attempted to invert the
the fbcon margins when the VT was inverted[1].

This time, I am taking the approach suggested by Alan Cox and just making
the margin color configurable.

[1]: https://lkml.org/lkml/2017/7/31/696

 Documentation/fb/fbcon.txt        |  7 +++++++
 drivers/video/console/bitblit.c   |  4 ++--
 drivers/video/console/fbcon.c     | 12 +++++++++++-
 drivers/video/console/fbcon.h     |  2 +-
 drivers/video/console/fbcon_ccw.c |  4 ++--
 drivers/video/console/fbcon_cw.c  |  4 ++--
 drivers/video/console/fbcon_ud.c  |  4 ++--
 drivers/video/console/tileblit.c  |  2 +-
 8 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index 4a9739a..1822b19 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -148,6 +148,13 @@ C. Boot options
 	Actually, the underlying fb driver is totally ignorant of console
 	rotation.
 
+5. fbcon=margin:<color>
+
+	This option specifies the color of the margins. The margins are the
+	leftover area at the right and the bottom of the screen that are not
+	used by text. By default, this area will be black. The 'color' value
+	is 0 to 7 where 0 is black and 7 is white.
+
 C. Attaching, Detaching and Unloading
 
 Before going on how to attach, detach and unload the framebuffer console, an
diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index dbfe4ee..c8adc24 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -203,7 +203,7 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 }
 
 static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
-			      int bottom_only)
+			      int color, int bottom_only)
 {
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
@@ -213,7 +213,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = color;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 12ded23..b59cdf7 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -137,6 +137,7 @@ static int info_idx = -1;
 /* console rotation */
 static int initial_rotation;
 static int fbcon_has_sysfs;
+static int margin_color;
 
 static const struct consw fb_con;
 
@@ -491,6 +492,15 @@ static int __init fb_console_setup(char *this_opt)
 				initial_rotation = 0;
 			continue;
 		}
+
+		if (!strncmp(options, "margin:", 7)) {
+			options += 7;
+			if (*options)
+				margin_color = simple_strtoul(options, &options, 0);
+			if (margin_color > 7)
+				margin_color = 0;
+			continue;
+		}
 	}
 	return 1;
 }
@@ -1299,7 +1309,7 @@ static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	if (!fbcon_is_inactive(vc, info))
-		ops->clear_margins(vc, info, bottom_only);
+		ops->clear_margins(vc, info, margin_color, bottom_only);
 }
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
index 7aaa4ea..ef797bf 100644
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -60,7 +60,7 @@ struct fbcon_ops {
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg);
 	void (*clear_margins)(struct vc_data *vc, struct fb_info *info,
-			      int bottom_only);
+			      int color, int bottom_only);
 	void (*cursor)(struct vc_data *vc, struct fb_info *info, int mode,
 		       int softback_lines, int fg, int bg);
 	int  (*update_start)(struct fb_info *info);
diff --git a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
index 5a3cbf6..e19d675 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -189,7 +189,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 }
 
 static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
-			     int bottom_only)
+			      int color, int bottom_only)
 {
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
@@ -198,7 +198,7 @@ static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bs = vc->vc_rows*ch;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = color;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index e7ee44d..54dd4aa 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -172,7 +172,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 }
 
 static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
-			     int bottom_only)
+			     int color, int bottom_only)
 {
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
@@ -181,7 +181,7 @@ static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int rs = info->var.yres - rw;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = color;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index 19e3714..0c34b92 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -220,7 +220,7 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 }
 
 static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
-			     int bottom_only)
+			     int color, int bottom_only)
 {
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
@@ -228,7 +228,7 @@ static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = color;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/tileblit.c b/drivers/video/console/tileblit.c
index 15e8e1a..ec7265b 100644
--- a/drivers/video/console/tileblit.c
+++ b/drivers/video/console/tileblit.c
@@ -74,7 +74,7 @@ static void tile_putcs(struct vc_data *vc, struct fb_info *info,
 }
 
 static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,
-			       int bottom_only)
+			       int color, int bottom_only)
 {
 	return;
 }
-- 
2.7.4

