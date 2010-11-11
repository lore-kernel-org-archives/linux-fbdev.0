From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Nov 2010 14:44:52 +0000
Subject: [PATCH 2/4 v3] fbdev: export fb_edid_add_monspecs() for modules,
Message-Id: <Pine.LNX.4.64.1011111524170.15747@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

fb_edid_add_monspecs() should also be exported for use in modules, and it
requires a dummy version for the case, when CONFIG_FB_MODE_HELPERS is not
selected. This patch also improves the algorithm by removing a redundant
memory allocation, adds function documentation, adds data verification and
replaces memmove() with memcpy().

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: use the PIXEL_CLOCK macro instead of open-coding

v2: added changes, suggested by Andrew:

1. replace memmove() with memcpy()
2. add documentation
3. sanity check edid[2]

 drivers/video/fbmon.c |   58 +++++++++++++++++++++++++-----------------------
 1 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index a0b5a93..b25399a 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -973,58 +973,56 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("====================\n");
 }
 
+/**
+ * fb_edid_add_monspecs() - add monitor video modes from E-EDID data
+ * @edid:	128 byte array with an E-EDID block
+ * @spacs:	monitor specs to be extended
+ */
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
 		return;
 
-	if (edid[0] != 0x2)
+	if (edid[0] != 0x2 ||
+	    edid[2] < 4 || edid[2] > 128 - DETAILED_TIMING_DESCRIPTION_SIZE)
 		return;
 
-	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
-	if (mode = NULL)
-		return;
-
-	block = edid + edid[0x2];
+	block = edid + edid[2];
 
 	DPRINTK("  Extended Detailed Timings\n");
 
-	for (i = 0; i < (128 - edid[0x2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
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
+	for (i = 0; i < (128 - edid[2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
+	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE)
+		if (PIXEL_CLOCK)
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
+
+	memcpy(m, specs->modedb, specs->modedb_len * sizeof(struct fb_videomode));
+
+	for (i = specs->modedb_len; i < specs->modedb_len + num; i++) {
+		get_detailed_timing(edid + edt[i - specs->modedb_len], &m[i]);
+		if (i = specs->modedb_len)
+			m[i].flag |= FB_MODE_IS_FIRST;
+		pr_debug("Adding %ux%u@%u\n", m[i].xres, m[i].yres, m[i].refresh);
 	}
 
-	memmove(m, specs->modedb, specs->modedb_len * sizeof(struct fb_videomode));
-	memmove(m + specs->modedb_len, mode, num * sizeof(struct fb_videomode));
-	kfree(mode);
 	kfree(specs->modedb);
 	specs->modedb = m;
 	specs->modedb_len = specs->modedb_len + num;
@@ -1346,6 +1344,9 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 	specs = NULL;
 }
+void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
+{
+}
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
@@ -1453,6 +1454,7 @@ EXPORT_SYMBOL(fb_firmware_edid);
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
+EXPORT_SYMBOL(fb_edid_add_monspecs);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
 EXPORT_SYMBOL(fb_destroy_modedb);
-- 
1.7.2.3

