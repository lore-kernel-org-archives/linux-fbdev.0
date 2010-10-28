From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Oct 2010 12:34:48 +0000
Subject: [PATCH 2/4] fbdev: export fb_edid_add_monspecs() for modules, improve
Message-Id: <Pine.LNX.4.64.1010281431560.1257@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fb_edid_add_monspecs() should also be exported for use in modules, and it
requires a dummy version for the case, when CONFIG_FB_MODE_HELPERS is not
selected. This patch also improves the algorithm by removing a redundant
memory allocation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/fbmon.c |   46 +++++++++++++++++++++-------------------------
 1 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 7a77170..d9ba6c1 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -976,10 +976,11 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 	unsigned char *block;
-	struct fb_videomode *mode, *m;
-	int num = 0, i, first = 1;
+	struct fb_videomode *m;
+	int num = 0, i;
+	u8 edt[(128 - 4) / DETAILED_TIMING_DESCRIPTION_SIZE];
 
-	if (edid = NULL)
+	if (!edid)
 		return;
 
 	if (!edid_checksum(edid))
@@ -988,43 +989,34 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	if (edid[0] != 0x2)
 		return;
 
-	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
-	if (mode = NULL)
-		return;
-
 	block = edid + edid[0x2];
 
 	DPRINTK("  Extended Detailed Timings\n");
 
 	for (i = 0; i < (128 - edid[0x2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
-	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
-		if (!(block[0] = 0x00 && block[1] = 0x00)) {
-			get_detailed_timing(block, &mode[num]);
-			if (first) {
-			        mode[num].flag |= FB_MODE_IS_FIRST;
-				first = 0;
-			}
-			num++;
-		}
-	}
+	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE)
+		if (!(block[0] = 0x00 && block[1] = 0x00))
+			edt[num++] = block - edid;
 
 	/* Yikes, EDID data is totally useless */
-	if (!num) {
-		kfree(mode);
+	if (!num)
 		return;
-	}
 
 	m = kzalloc((specs->modedb_len + num) *
 		       sizeof(struct fb_videomode), GFP_KERNEL);
 
-	if (!m) {
-		kfree(mode);
+	if (!m)
 		return;
-	}
 
 	memmove(m, specs->modedb, specs->modedb_len * sizeof(struct fb_videomode));
-	memmove(m + specs->modedb_len, mode, num * sizeof(struct fb_videomode));
-	kfree(mode);
+
+	for (i = specs->modedb_len; i < specs->modedb_len + num; i++) {
+		get_detailed_timing(edid + edt[i - specs->modedb_len], &m[i]);
+		if (i = specs->modedb_len)
+			m[i].flag |= FB_MODE_IS_FIRST;
+		pr_debug("Adding %ux%u@%u\n", m[i].xres, m[i].yres, m[i].refresh);
+	}
+
 	kfree(specs->modedb);
 	specs->modedb = m;
 	specs->modedb_len = specs->modedb_len + num;
@@ -1345,6 +1337,9 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 }
+void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
+{
+}
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
@@ -1452,6 +1447,7 @@ EXPORT_SYMBOL(fb_firmware_edid);
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
+EXPORT_SYMBOL(fb_edid_add_monspecs);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
 EXPORT_SYMBOL(fb_destroy_modedb);
-- 
1.7.1

