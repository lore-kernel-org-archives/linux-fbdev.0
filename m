From: Fredrik Noring <noring@nocrew.org>
Date: Fri, 22 Jun 2018 18:37:54 +0000
Subject: [PATCH] fbdev: Distinguish between interlaced and progressive modes
Message-Id: <20180622183754.GB17701@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

With this change fb_find_mode can match interlaced and progressive
modes equally well, and distinguish between for example 1920x1080i
and 1920x1080p.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/video/fbdev/core/modedb.c | 41 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 2510fa728d77..de119f11b78f 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -644,7 +644,7 @@ static int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
  *
  *     Valid mode specifiers for @mode_option:
  *
- *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
+ *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][p][m] or
  *     <name>[-<bpp>][@<refresh>]
  *
  *     with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
@@ -653,10 +653,10 @@ static int fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
  *      If 'M' is present after yres (and before refresh/bpp if present),
  *      the function will compute the timings using VESA(tm) Coordinated
  *      Video Timings (CVT).  If 'R' is present after 'M', will compute with
- *      reduced blanking (for flatpanels).  If 'i' is present, compute
- *      interlaced mode.  If 'm' is present, add margins equal to 1.8%
- *      of xres rounded down to 8 pixels, and 1.8% of yres. The char
- *      'i' and 'm' must be after 'M' and 'R'. Example:
+ *      reduced blanking (for flatpanels).  If 'i' or 'p' are present, compute
+ *      interlaced or progressive mode.  If 'm' is present, add margins equal
+ *      to 1.8% of xres rounded down to 8 pixels, and 1.8% of yres. The chars
+ *      'i', 'p' and 'm' must be after 'M' and 'R'. Example:
  *
  *      1024x768MR-8@60m - Reduced blank with margins at 60Hz.
  *
@@ -697,7 +697,8 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 		unsigned int namelen = strlen(name);
 		int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
 		unsigned int xres = 0, yres = 0, bpp = default_bpp, refresh = 0;
-		int yres_specified = 0, cvt = 0, rb = 0, interlace = 0;
+		int yres_specified = 0, cvt = 0, rb = 0;
+		int interlace_specified = 0, interlace = 0;
 		int margins = 0;
 		u32 best, diff, tdiff;
 
@@ -748,9 +749,17 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				if (!cvt)
 					margins = 1;
 				break;
+			case 'p':
+				if (!cvt) {
+					interlace = 0;
+					interlace_specified = 1;
+				}
+				break;
 			case 'i':
-				if (!cvt)
+				if (!cvt) {
 					interlace = 1;
+					interlace_specified = 1;
+				}
 				break;
 			default:
 				goto done;
@@ -819,11 +828,21 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			if ((name_matches(db[i], name, namelen) ||
 			     (res_specified && res_matches(db[i], xres, yres))) &&
 			    !fb_try_mode(var, info, &db[i], bpp)) {
-				if (refresh_specified && db[i].refresh = refresh)
-					return 1;
+				const int db_interlace = (db[i].vmode &
+					FB_VMODE_INTERLACED ? 1 : 0);
+				int score = abs(db[i].refresh - refresh);
+
+				if (interlace_specified)
+					score += abs(db_interlace - interlace);
+
+				if (!interlace_specified ||
+				    db_interlace = interlace)
+					if (refresh_specified &&
+					    db[i].refresh = refresh)
+						return 1;
 
-				if (abs(db[i].refresh - refresh) < diff) {
-					diff = abs(db[i].refresh - refresh);
+				if (score < diff) {
+					diff = score;
 					best = i;
 				}
 			}
