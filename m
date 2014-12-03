From: David Ung <davidu@nvidia.com>
Date: Wed, 03 Dec 2014 21:49:29 +0000
Subject: [PATCH 3/3] video: fbdev: Validate mode timing against monspec
Message-Id: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fbmon may generate mode timings that are out of spec of the monitor.
eg DELL U2410 has a max clock 170mhz but advertises a resolutions of
1920x1200@60 in its Standard Timings, fbmon creates a mode using the
GTF timing calculation which gave it a 193mhz clock.
This patch checks to see if the mode can be supported by the monitor
by comparing against monspecs.dclkmax.

Signed-off-by: David Ung <davidu@nvidia.com>
---
 drivers/video/fbdev/core/fbmon.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index aa1110a..cc3ea6c8 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -496,7 +496,7 @@ static int get_est_timing(unsigned char *block, struct fb_videomode *mode)
 }
 
 static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
-		int ver, int rev)
+			  int ver, int rev, struct fb_monspecs *specs)
 {
 	int xres, yres = 0, refresh, ratio, i;
 
@@ -542,16 +542,23 @@ static int get_std_timing(unsigned char *block, struct fb_videomode *mode,
 	if (i = DMT_SIZE || !dmt_modes[i].mode)
 		calc_mode_timings(xres, yres, refresh, mode);
 
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
@@ -607,7 +614,8 @@ static void get_detailed_timing(unsigned char *block,
  * This function builds a mode database using the contents of the EDID
  * data
  */
-static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
+static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize,
+					     struct fb_monspecs *specs)
 {
 	struct fb_videomode *mode, *m;
 	unsigned char *block;
@@ -649,12 +657,13 @@ static struct fb_videomode *fb_create_modedb(unsigned char *edid, int *dbsize)
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
@@ -713,7 +722,7 @@ static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
 		int num_modes, hz, hscan, pixclock;
 		int vtotal, htotal;
 
-		modes = fb_create_modedb(edid, &num_modes);
+		modes = fb_create_modedb(edid, &num_modes, specs);
 		if (!modes) {
 			DPRINTK("None Available\n");
 			return 1;
@@ -970,7 +979,7 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("   Display Characteristics:\n");
 	get_monspecs(edid, specs);
 
-	specs->modedb = fb_create_modedb(edid, &specs->modedb_len);
+	specs->modedb = fb_create_modedb(edid, &specs->modedb_len, specs);
 
 	/*
 	 * Workaround for buggy EDIDs that sets that the first
-- 
1.8.1.5


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
