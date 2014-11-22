From: David Ung <davidu@nvidia.com>
Date: Sat, 22 Nov 2014 03:21:52 +0000
Subject: [PATCH] video: fbmon: Check Standard Timing against DMT and maxclk
Message-Id: <1416626512-12919-1-git-send-email-davidu@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fbmon may generate mode timings that are out of spec of the monitor.
eg DELL U2410 has a max clock 170mhz but advertises a resolutions of
1920x1200@60 in its Standard Timings, fbmon creates a mode using the
GTF timing calculation which gave it a 193mhz clock.
This patch add the VESA Display Monitor Timing (DMT) table.
During parsing of Standard Timings, it compare the 2 byte STD code
with DMT to see what the VESA mode should be.  If there is no entry
in the vesa_modes table or no match found, it fallsback to the GTF
timings.  A final check to see if the mode can be supported by the
monitor by comparing against monspecs.dclkmax.

Signed-off-by: David Ung <davidu@nvidia.com>
---
 drivers/video/fbdev/core/fbmon.c  |  47 ++++++++++------
 drivers/video/fbdev/core/modedb.c | 111 ++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h                |  12 ++++-
 3 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 5b0e313..cc3ea6c8 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -496,7 +496,7 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
 }
 
 static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
-		int ver, int rev)
+			  int ver, int rev, struct fb_monspecs *specs)
 {
 	int xres, yres = 0, refresh, ratio, i;
 
@@ -526,26 +526,39 @@ static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
 	refresh = (block[1] & 0x3f) + 60;
 
 	DPRINTK("      %dx%d@%dHz\n", xres, yres, refresh);
-	for (i = 0; i < VESA_MODEDB_SIZE; i++) {
-		if (vesa_modes[i].xres = xres &&
-		    vesa_modes[i].yres = yres &&
-		    vesa_modes[i].refresh = refresh) {
-			*mode = vesa_modes[i];
+	for (i = 0; i < DMT_SIZE; i++) {
+		u32 std_2byte_code = block[0] << 8 | block[1];
+
+		if (std_2byte_code = dmt_modes[i].std_2byte_code) {
+			if (!dmt_modes[i].mode)
+				break;
+			*mode = *dmt_modes[i].mode;
 			mode->flag |= FB_MODE_IS_STANDARD;
-			return 1;
+			DPRINTK("        DMT id=%d\n", dmt_modes[i].dmt_id);
+			break;
 		}
 	}
-	calc_mode_timings(xres, yres, refresh, mode);
+
+	if (i = DMT_SIZE || !dmt_modes[i].mode)
+		calc_mode_timings(xres, yres, refresh, mode);
+
+	/* Check the mode we got is within valid spec of the monitor */
+	if (specs && specs->dclkmax
+	    && PICOS2KHZ(mode->pixclock) * 1000 > specs->dclkmax) {
+		DPRINTK("        mode exceed max DCLK\n");
+		return 0;
+	}
+
 	return 1;
 }
 
-static int get_dst_timing(unsigned char *block,
-			  struct fb_videomode *mode, int ver, int rev)
+static int get_dst_timing(unsigned char *block, struct fb_videomode *mode,
+			  int ver, int rev, struct fb_monspecs *specs)
 {
 	int j, num = 0;
 
 	for (j = 0; j < 6; j++, block += STD_TIMING_DESCRIPTION_SIZE)
-		num += get_std_timing(block, &mode[num], ver, rev);
+		num += get_std_timing(block, &mode[num], ver, rev, specs);
 
 	return num;
 }
@@ -601,7 +614,8 @@ static void get_detailed_timing(unsigned char *block,
  * This function builds a mode database using the contents of the EDID
  * data
  */
-static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize,
+					     struct fb_monspecs *specs)
 {
 	struct fb_videomode *mode, *m;
 	unsigned char *block;
@@ -643,12 +657,13 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
 	DPRINTK("   Standard Timings\n");
 	block = edid + STD_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < STD_TIMING; i++, block += STD_TIMING_DESCRIPTION_SIZE)
-		num += get_std_timing(block, &mode[num], ver, rev);
+		num += get_std_timing(block, &mode[num], ver, rev, specs);
 
 	block = edid + DETAILED_TIMING_DESCRIPTIONS_START;
 	for (i = 0; i < 4; i++, block+= DETAILED_TIMING_DESCRIPTION_SIZE) {
 		if (block[0] = 0x00 && block[1] = 0x00 && block[3] = 0xfa)
-			num += get_dst_timing(block + 5, &mode[num], ver, rev);
+			num += get_dst_timing(block + 5, &mode[num],
+					      ver, rev, specs);
 	}
 
 	/* Yikes, EDID data is totally useless */
@@ -707,7 +722,7 @@ static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
 		int num_modes, hz, hscan, pixclock;
 		int vtotal, htotal;
 
-		modes = fb_create_modedb(edid, &num_modes);
+		modes = fb_create_modedb(edid, &num_modes, specs);
 		if (!modes) {
 			DPRINTK("None Available\n");
 			return 1;
@@ -964,7 +979,7 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("   Display Characteristics:\n");
 	get_monspecs(edid, specs);
 
-	specs->modedb = fb_create_modedb(edid, &specs->modedb_len);
+	specs->modedb = fb_create_modedb(edid, &specs->modedb_len, specs);
 
 	/*
 	 * Workaround for buggy EDIDs that sets that the first
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 388f797..858a97e 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -468,8 +468,119 @@ const struct fb_videomode vesa_modes[] = {
 	/* 33 1920x1440-75 VESA */
 	{ NULL, 75, 1920, 1440, 3367, 352, 144, 56, 1, 224, 3,
 	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 34 1920x1200-60 RB VESA */
+	{ NULL, 60, 1920, 1200, 6493, 80, 48, 26, 3, 32, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 35 1920x1200-60 VESA */
+	{ NULL, 60, 1920, 1200, 5174, 336, 136, 36, 3, 200, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 36 1920x1200-75 VESA */
+	{ NULL, 75, 1920, 1200, 4077, 344, 136, 46, 3, 208, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 37 1920x1200-85 VESA */
+	{ NULL, 85, 1920, 1200, 3555, 352, 144, 53, 3, 208, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 38 2560x1600-60 RB VESA */
+	{ NULL, 60, 2560, 1600, 3724, 80, 48, 37, 3, 32, 6,
+	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 39 2560x1600-60 VESA */
+	{ NULL, 60, 2560, 1600, 2869, 472, 192, 49, 3, 280, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 40 2560x1600-75 VESA */
+	{ NULL, 75, 2560, 1600, 2256, 488, 208, 63, 3, 280, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 41 2560x1600-85 VESA */
+	{ NULL, 85, 2560, 1600, 1979, 488, 208, 73, 3, 280, 6,
+	  FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
+	/* 42 2560x1600-120 RB VESA */
+	{ NULL, 120, 2560, 1600, 1809, 80, 48, 85, 3, 32, 6,
+	  FB_SYNC_HOR_HIGH_ACT, FB_VMODE_NONINTERLACED, FB_MODE_IS_VESA },
 };
 EXPORT_SYMBOL(vesa_modes);
+
+const struct dmt_videomode dmt_modes[DMT_SIZE] = {
+	{ 0x01, 0x0000, 0x000000, &vesa_modes[0] },
+	{ 0x02, 0x3119, 0x000000, &vesa_modes[1] },
+	{ 0x03, 0x0000, 0x000000, &vesa_modes[2] },
+	{ 0x04, 0x3140, 0x000000, &vesa_modes[3] },
+	{ 0x05, 0x314c, 0x000000, &vesa_modes[4] },
+	{ 0x06, 0x314f, 0x000000, &vesa_modes[5] },
+	{ 0x07, 0x3159, 0x000000, &vesa_modes[6] },
+	{ 0x08, 0x0000, 0x000000, &vesa_modes[7] },
+	{ 0x09, 0x4540, 0x000000, &vesa_modes[8] },
+	{ 0x0a, 0x454c, 0x000000, &vesa_modes[9] },
+	{ 0x0b, 0x454f, 0x000000, &vesa_modes[10] },
+	{ 0x0c, 0x4559, 0x000000, &vesa_modes[11] },
+	{ 0x0d, 0x0000, 0x000000, 0 },
+	{ 0x0e, 0x0000, 0x000000, 0 },
+	{ 0x0f, 0x0000, 0x000000, &vesa_modes[12] },
+	{ 0x10, 0x6140, 0x000000, &vesa_modes[13] },
+	{ 0x11, 0x614a, 0x000000, &vesa_modes[14] },
+	{ 0x12, 0x614f, 0x000000, &vesa_modes[15] },
+	{ 0x13, 0x6159, 0x000000, &vesa_modes[16] },
+	{ 0x14, 0x0000, 0x000000, 0 },
+	{ 0x15, 0x714f, 0x000000, &vesa_modes[17] },
+	{ 0x16, 0x0000, 0x7f1c21, 0 },
+	{ 0x17, 0x0000, 0x7f1c28, 0 },
+	{ 0x18, 0x0000, 0x7f1c44, 0 },
+	{ 0x19, 0x0000, 0x7f1c62, 0 },
+	{ 0x1a, 0x0000, 0x000000, 0 },
+	{ 0x1b, 0x0000, 0x8f1821, 0 },
+	{ 0x1c, 0x8100, 0x8f1828, 0 },
+	{ 0x1d, 0x810f, 0x8f1844, 0 },
+	{ 0x1e, 0x8119, 0x8f1862, 0 },
+	{ 0x1f, 0x0000, 0x000000, 0 },
+	{ 0x20, 0x8140, 0x000000, &vesa_modes[18] },
+	{ 0x21, 0x8159, 0x000000, &vesa_modes[19] },
+	{ 0x22, 0x0000, 0x000000, 0 },
+	{ 0x23, 0x8180, 0x000000, &vesa_modes[20] },
+	{ 0x24, 0x818f, 0x000000, &vesa_modes[21] },
+	{ 0x25, 0x8199, 0x000000, &vesa_modes[22] },
+	{ 0x26, 0x0000, 0x000000, 0 },
+	{ 0x27, 0x0000, 0x000000, 0 },
+	{ 0x28, 0x0000, 0x000000, 0 },
+	{ 0x29, 0x0000, 0x0c2021, 0 },
+	{ 0x2a, 0x9040, 0x0c2028, 0 },
+	{ 0x2b, 0x904f, 0x0c2044, 0 },
+	{ 0x2c, 0x9059, 0x0c2062, 0 },
+	{ 0x2d, 0x0000, 0x000000, 0 },
+	{ 0x2e, 0x9500, 0xc11821, 0 },
+	{ 0x2f, 0x9500, 0xc11828, 0 },
+	{ 0x30, 0x950f, 0xc11844, 0 },
+	{ 0x31, 0x9519, 0xc11868, 0 },
+	{ 0x32, 0x0000, 0x000000, 0 },
+	{ 0x33, 0xa940, 0x000000, &vesa_modes[23] },
+	{ 0x34, 0xa945, 0x000000, &vesa_modes[24] },
+	{ 0x35, 0xa94a, 0x000000, &vesa_modes[25] },
+	{ 0x36, 0xa94f, 0x000000, &vesa_modes[26] },
+	{ 0x37, 0xa959, 0x000000, &vesa_modes[27] },
+	{ 0x38, 0x0000, 0x000000, 0 },
+	{ 0x39, 0x0000, 0x0c2821, 0 },
+	{ 0x3a, 0xb300, 0x0c2828, 0 },
+	{ 0x3b, 0xb30f, 0x0c2844, 0 },
+	{ 0x3c, 0xb319, 0x0c2868, 0 },
+	{ 0x3d, 0x0000, 0x000000, 0 },
+	{ 0x3e, 0xc140, 0x000000, &vesa_modes[28] },
+	{ 0x3f, 0xc14f, 0x000000, &vesa_modes[29] },
+	{ 0x40, 0x0000, 0x000000, 0 },
+	{ 0x41, 0xc940, 0x000000, &vesa_modes[30] },
+	{ 0x42, 0xc94f, 0x000000, &vesa_modes[31] },
+	{ 0x43, 0x0000, 0x000000, 0 },
+	{ 0x44, 0x0000, 0x572821, &vesa_modes[34] },
+	{ 0x45, 0xd100, 0x572828, &vesa_modes[35] },
+	{ 0x46, 0xd10f, 0x572844, &vesa_modes[36] },
+	{ 0x47, 0xd119, 0x572862, &vesa_modes[37] },
+	{ 0x48, 0x0000, 0x000000, 0 },
+	{ 0x49, 0xd140, 0x000000, &vesa_modes[32] },
+	{ 0x4a, 0xd14f, 0x000000, &vesa_modes[33] },
+	{ 0x4b, 0x0000, 0x000000, 0 },
+	{ 0x4c, 0x0000, 0x1f3821, &vesa_modes[38] },
+	{ 0x4d, 0x0000, 0x1f3828, &vesa_modes[39] },
+	{ 0x4e, 0x0000, 0x1f3844, &vesa_modes[40] },
+	{ 0x4f, 0x0000, 0x1f3862, &vesa_modes[41] },
+	{ 0x50, 0x0000, 0x000000, &vesa_modes[42] },
+};
+EXPORT_SYMBOL(dmt_modes);
 #endif /* CONFIG_FB_MODE_HELPERS */
 
 /**
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 09bb7a1..043f328 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -726,7 +726,9 @@ extern int fb_videomode_from_videomode(const struct videomode *vm,
 				       struct fb_videomode *fbmode);
 
 /* drivers/video/modedb.c */
-#define VESA_MODEDB_SIZE 34
+#define VESA_MODEDB_SIZE 43
+#define DMT_SIZE 0x50
+
 extern void fb_var_to_videomode(struct fb_videomode *mode,
 				const struct fb_var_screeninfo *var);
 extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
@@ -777,9 +779,17 @@ struct fb_videomode {
 	u32 flag;
 };
 
+struct dmt_videomode {
+	u32 dmt_id;
+	u32 std_2byte_code;
+	u32 cvt_3byte_code;
+	const struct fb_videomode *mode;
+};
+
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
 extern const struct fb_videomode cea_modes[64];
+extern const struct dmt_videomode dmt_modes[];
 
 struct fb_modelist {
 	struct list_head list;
-- 
1.8.1.5

