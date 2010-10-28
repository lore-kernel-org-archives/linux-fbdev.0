From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 28 Oct 2010 12:34:44 +0000
Subject: [PATCH 1/4] video: add fb_edid_add_monspecs for parsing extended
Message-Id: <Pine.LNX.4.64.1010281427240.1257@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Erik Gilling <konkers@android.com>

Modern monitors/tvs have more extended EDID information blocks which can
contain extra detailed modes.  This adds a fb_edid_add_monspecs function
which drivers can use to parse those additions blocks.

Signed-off-by: Erik Gilling <konkers@android.com>
---
 drivers/video/fbmon.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h    |    2 +
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 563a98b..a0b5a93 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -973,6 +973,63 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("====================\n");
 }
 
+void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
+{
+	unsigned char *block;
+	struct fb_videomode *mode, *m;
+	int num = 0, i, first = 1;
+
+	if (edid = NULL)
+		return;
+
+	if (!edid_checksum(edid))
+		return;
+
+	if (edid[0] != 0x2)
+		return;
+
+	mode = kzalloc(50 * sizeof(struct fb_videomode), GFP_KERNEL);
+	if (mode = NULL)
+		return;
+
+	block = edid + edid[0x2];
+
+	DPRINTK("  Extended Detailed Timings\n");
+
+	for (i = 0; i < (128 - edid[0x2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
+	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
+		if (!(block[0] = 0x00 && block[1] = 0x00)) {
+			get_detailed_timing(block, &mode[num]);
+			if (first) {
+			        mode[num].flag |= FB_MODE_IS_FIRST;
+				first = 0;
+			}
+			num++;
+		}
+	}
+
+	/* Yikes, EDID data is totally useless */
+	if (!num) {
+		kfree(mode);
+		return;
+	}
+
+	m = kzalloc((specs->modedb_len + num) *
+		       sizeof(struct fb_videomode), GFP_KERNEL);
+
+	if (!m) {
+		kfree(mode);
+		return;
+	}
+
+	memmove(m, specs->modedb, specs->modedb_len * sizeof(struct fb_videomode));
+	memmove(m + specs->modedb_len, mode, num * sizeof(struct fb_videomode));
+	kfree(mode);
+	kfree(specs->modedb);
+	specs->modedb = m;
+	specs->modedb_len = specs->modedb_len + num;
+}
+
 /*
  * VESA Generalized Timing Formula (GTF)
  */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f0268de..3fc99cb 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1086,6 +1086,8 @@ extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
 extern const unsigned char *fb_firmware_edid(struct device *device);
 extern void fb_edid_to_monspecs(unsigned char *edid,
 				struct fb_monspecs *specs);
+extern void fb_edid_add_monspecs(unsigned char *edid,
+				 struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb);
 extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
-- 
1.7.1

