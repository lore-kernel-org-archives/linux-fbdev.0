From: David Lechner <david@lechnology.com>
Date: Fri, 28 Jul 2017 20:26:30 +0000
Subject: [PATCH] fbcon: Use background color for margins
Message-Id: <1501273590-3237-1-git-send-email-david@lechnology.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

Screens that don't have a black border around the active area will have
ugly black bars for the margin when the text background color is not black.
This is especially noticeable on an LCD screen (not the backlit kind) when
the terminal colors are inverted.

Fix by using the same color for the margin that is used in the regular
clear function.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/video/console/bitblit.c   | 3 ++-
 drivers/video/console/fbcon_ccw.c | 3 ++-
 drivers/video/console/fbcon_cw.c  | 3 ++-
 drivers/video/console/fbcon_ud.c  | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
index dbfe4ee..61b182b 100644
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -205,6 +205,7 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 			      int bottom_only)
 {
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
 	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
@@ -213,7 +214,7 @@ static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = attr_bgcol_ec(bgshift, vc, info);
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_ccw.c b/drivers/video/console/fbcon_ccw.c
index 5a3cbf6..80527be 100644
--- a/drivers/video/console/fbcon_ccw.c
+++ b/drivers/video/console/fbcon_ccw.c
@@ -191,6 +191,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 			     int bottom_only)
 {
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
 	unsigned int rw = info->var.yres - (vc->vc_cols*cw);
@@ -198,7 +199,7 @@ static void ccw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int bs = vc->vc_rows*ch;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = attr_bgcol_ec(bgshift, vc, info);
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_cw.c b/drivers/video/console/fbcon_cw.c
index e7ee44d..58c16a1 100644
--- a/drivers/video/console/fbcon_cw.c
+++ b/drivers/video/console/fbcon_cw.c
@@ -174,6 +174,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 			     int bottom_only)
 {
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
 	unsigned int rw = info->var.yres - (vc->vc_cols*cw);
@@ -181,7 +182,7 @@ static void cw_clear_margins(struct vc_data *vc, struct fb_info *info,
 	unsigned int rs = info->var.yres - rw;
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = attr_bgcol_ec(bgshift, vc, info);
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
diff --git a/drivers/video/console/fbcon_ud.c b/drivers/video/console/fbcon_ud.c
index 19e3714..eea3028 100644
--- a/drivers/video/console/fbcon_ud.c
+++ b/drivers/video/console/fbcon_ud.c
@@ -222,13 +222,14 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 static void ud_clear_margins(struct vc_data *vc, struct fb_info *info,
 			     int bottom_only)
 {
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
 	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
 	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
 	struct fb_fillrect region;
 
-	region.color = 0;
+	region.color = attr_bgcol_ec(bgshift, vc, info);
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {
-- 
2.7.4

