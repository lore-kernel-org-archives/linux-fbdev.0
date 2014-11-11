From: David Ung <davidu@nvidia.com>
Date: Tue, 11 Nov 2014 22:54:15 +0000
Subject: [PATCH] video: fbdev: Add CVT timing calculations.
Message-Id: <1415746455-28701-1-git-send-email-davidu@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently fbmon is still relying on the old GTF timings when parsing
the standard timings of the EDID.
This causes problem with some monitor eg DELL U2410 which advertises
high resolutions like 1920x1200@60 and GTF timing gives it 193mhz
clock which is out of spec of the monitor which has dclkmax of 170mhz.
This patch address the above problem by adding support for CVT with
reduced timings.

Signed-off-by: David Ung <davidu@nvidia.com>
---
 drivers/video/fbdev/core/fbmon.c | 92 +++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 5b0e313..8d4ec9f 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -21,6 +21,11 @@
  *      GTF Spreadsheet by Andy Morrish (1/5/97)
  *      available at http://www.vesa.org
  *
+ * Coordinated Video Timing is derived from:
+ *
+ *      CVT Spreadsheet by Graham Loveridge (9/Apr/2003)
+ *      available at http://www.vesa.org
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file COPYING in the main directory of this archive
  * for more details.
@@ -383,17 +388,21 @@ static void get_chroma(unsigned char *block, struct fb_monspecs *specs)
 }
 
 static void calc_mode_timings(int xres, int yres, int refresh,
-			      struct fb_videomode *mode)
+			      struct fb_videomode *mode,
+			      struct fb_monspecs *specs)
 {
 	struct fb_var_screeninfo *var;
+	struct fb_info info;
 
 	var = kzalloc(sizeof(struct fb_var_screeninfo), GFP_KERNEL);
+	if (specs)
+		memcpy(&info.monspecs, specs, sizeof(struct fb_monspecs));
 
 	if (var) {
 		var->xres = xres;
 		var->yres = yres;
-		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON,
-			    refresh, var, NULL);
+		fb_get_mode(FB_VSYNCTIMINGS | FB_IGNOREMON, refresh, var,
+			    specs && !specs->gtf ? &info : NULL);
 		mode->xres = xres;
 		mode->yres = yres;
 		mode->pixclock = var->pixclock;
@@ -417,12 +426,12 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
 
 	c = block[0];
 	if (c&0x80) {
-		calc_mode_timings(720, 400, 70, &mode[num]);
+		calc_mode_timings(720, 400, 70, &mode[num], NULL);
 		mode[num++].flag = FB_MODE_IS_CALCULATED;
 		DPRINTK("      720x400@70Hz\n");
 	}
 	if (c&0x40) {
-		calc_mode_timings(720, 400, 88, &mode[num]);
+		calc_mode_timings(720, 400, 88, &mode[num], NULL);
 		mode[num++].flag = FB_MODE_IS_CALCULATED;
 		DPRINTK("      720x400@88Hz\n");
 	}
@@ -431,7 +440,7 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
 		DPRINTK("      640x480@60Hz\n");
 	}
 	if (c&0x10) {
-		calc_mode_timings(640, 480, 67, &mode[num]);
+		calc_mode_timings(640, 480, 67, &mode[num], NULL);
 		mode[num++].flag = FB_MODE_IS_CALCULATED;
 		DPRINTK("      640x480@67Hz\n");
 	}
@@ -462,7 +471,7 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
 		DPRINTK("      800x600@75Hz\n");
 	}
 	if (c&0x20) {
-		calc_mode_timings(832, 624, 75, &mode[num]);
+		calc_mode_timings(832, 624, 75, &mode[num], NULL);
 		mode[num++].flag = FB_MODE_IS_CALCULATED;
 		DPRINTK("      832x624@75Hz\n");
 	}
@@ -496,7 +505,7 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
 }
 
 static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
-		int ver, int rev)
+			  int ver, int rev, struct fb_monspecs *specs)
 {
 	int xres, yres = 0, refresh, ratio, i;
 
@@ -535,7 +544,7 @@ static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
 			return 1;
 		}
 	}
-	calc_mode_timings(xres, yres, refresh, mode);
+	calc_mode_timings(xres, yres, refresh, mode, specs);
 	return 1;
 }
 
@@ -545,7 +554,7 @@ static int get_dst_timing(unsigned char *block,
 	int j, num = 0;
 
 	for (j = 0; j < 6; j++, block += STD_TIMING_DESCRIPTION_SIZE)
-		num += get_std_timing(block, &mode[num], ver, rev);
+		num += get_std_timing(block, &mode[num], ver, rev, NULL);
 
 	return num;
 }
@@ -601,7 +610,8 @@ static void get_detailed_timing(unsigned char *block,
  * This function builds a mode database using the contents of the EDID
  * data
  */
-static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize,
+					     struct fb_monspecs *specs)
 {
 	struct fb_videomode *mode, *m;
 	unsigned char *block;
@@ -643,7 +653,7 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 	DPRINTK("   Standard Timings\n");
 	block = edid + STD_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE)
-		num += get_std_timing(block, &mode[num], ver, rev);
+		num += get_std_timing(block, &mode[num], ver, rev, specs);
 
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
@@ -707,7 +717,7 @@ static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
 		int num_modes, hz, hscan, pixclock;
 		int vtotal, htotal;
 
-		modes = fb_create_modedb(edid, &num_modes);
+		modes = fb_create_modedb(edid, &num_modes, NULL);
 		if (!modes) {
 			DPRINTK("None Available\n");
 			return 1;
@@ -964,7 +974,7 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("   Display Characteristics:\n");
 	get_monspecs(edid, specs);
 
-	specs->modedb = fb_create_modedb(edid, &specs->modedb_len);
+	specs->modedb = fb_create_modedb(edid, &specs->modedb_len, specs);
 
 	/*
 	 * Workaround for buggy EDIDs that sets that the first
@@ -1255,6 +1265,55 @@ static void fb_timings_dclk(struct __fb_timings *timings)
 }
 
 /*
+ * All calculations are based on the VESA CVT Spreadsheet
+ * available at VESA's public ftp (http://www.vesa.org).
+ *
+ * The names of variables are kept to match as closely to the names
+ * that appears in the spreadsheet.
+ */
+#define RB_MIN_V_BLANK  460
+#define RB_H_BLANK      160
+#define CELL_GRAN       8
+#define CLOCK_STEP      250
+#define RB_V_FPORCH     3
+#define V_SYNC_RND      6
+#define MIN_V_BPORCH    6
+
+static void fb_timings_vfreq_cvt(struct __fb_timings *timings)
+{
+	u32 v_lines_rnd, h_period_est, vbi_line, rb_min_vbi, act_vbi_lines;
+	u32 total_v_lines, h_pixels_rnd, total_active_pixels, total_pixels;
+	u32 act_pixel_freq;
+	u32 v_field_rate_rqd = timings->vfreq;
+	u32 h_pixels = timings->hactive;
+	u32 v_lines = timings->vactive;
+
+	v_lines_rnd = v_lines;
+	h_period_est = 1000000 / v_field_rate_rqd - RB_MIN_V_BLANK;
+	h_period_est = h_period_est / v_lines_rnd;
+	vbi_line = RB_MIN_V_BLANK / h_period_est;
+	rb_min_vbi = RB_V_FPORCH + V_SYNC_RND + MIN_V_BPORCH;
+	if (vbi_line < rb_min_vbi)
+		act_vbi_lines = rb_min_vbi;
+	else
+		act_vbi_lines = vbi_line;
+	total_v_lines = act_vbi_lines + v_lines_rnd;
+	h_pixels_rnd = (h_pixels / CELL_GRAN) * CELL_GRAN;
+	total_active_pixels = h_pixels_rnd;
+	total_pixels = RB_H_BLANK + total_active_pixels;
+	act_pixel_freq = v_field_rate_rqd * total_v_lines * total_pixels;
+	act_pixel_freq /= 1000;
+	act_pixel_freq = act_pixel_freq / CLOCK_STEP * CLOCK_STEP * 1000;
+
+	timings->hfreq = act_pixel_freq / total_pixels;
+	timings->vblank = act_vbi_lines;
+	timings->vtotal = timings->vactive + timings->vblank;
+	timings->hblank = RB_H_BLANK;
+	timings->htotal = timings->hactive + timings->hblank;
+	timings->dclk = timings->htotal * timings->hfreq;
+}
+
+/*
  * fb_get_mode - calculates video mode using VESA GTF
  * @flags: if: 0 - maximize vertical refresh rate
  *             1 - vrefresh-driven calculation;
@@ -1347,7 +1406,10 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 		break;
 	case FB_VSYNCTIMINGS: /* vrefresh driven */
 		timings->vfreq = val;
-		fb_timings_vfreq(timings);
+		if (info && !info->monspecs.gtf)
+			fb_timings_vfreq_cvt(timings);
+		else
+			fb_timings_vfreq(timings);
 		break;
 	case FB_HSYNCTIMINGS: /* hsync driven */
 		timings->hfreq = val;
-- 
1.8.1.5


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
