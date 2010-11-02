From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 10:47:40 +0000
Subject: [PATCH 3/4 v2] fbdev: when parsing E-EDID blocks, also use SVD
Message-Id: <Pine.LNX.4.64.1011021143480.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add parsing of E-EDID SVD entries. In this first version only a few
CEA/EIA-861E modes are implemented, more can be added as needed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: no change

 drivers/video/fbmon.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 38b3c30..943bcff 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -973,6 +973,45 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("====================\n");
 }
 
+const struct fb_videomode cea_modes[] = {
+	/* #1: 640x480p@59.94/60Hz */
+	[1] = {
+		NULL, 60, 640, 480, 39722, 48, 16, 33, 10, 96, 2, 0, FB_VMODE_NONINTERLACED, 0,
+	},
+	/* #3: 720x480p@59.94/60Hz */
+	[3] = {
+		NULL, 60, 720, 480, 37037, 60, 16, 30, 9, 62, 6, 0, FB_VMODE_NONINTERLACED, 0,
+	},
+	/* #5: 1920x1080i@59.94/60Hz */
+	[5] = {
+		NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5, 0, FB_VMODE_INTERLACED, 0,
+	},
+	/* #7: 720(1440)x480iH@59.94/60Hz */
+	[7] = {
+		NULL, 60, 1440, 480, 18554/*37108*/, 114, 38, 15, 4, 124, 3, 0, FB_VMODE_INTERLACED, 0,
+	},
+	/* #9: 720(1440)x240pH@59.94/60Hz */
+	[9] = {
+		NULL, 60, 1440, 240, 18554, 114, 38, 16, 4, 124, 3, 0, FB_VMODE_NONINTERLACED, 0,
+	},
+	/* #18: 720x576pH@50Hz */
+	[18] = {
+		NULL, 50, 720, 576, 37037, 68, 12, 39, 5, 64, 5, 0, FB_VMODE_NONINTERLACED, 0,
+	},
+	/* #19: 1280x720p@50Hz */
+	[19] = {
+		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5, 0, FB_VMODE_NONINTERLACED, 0,
+	},
+	/* #20: 1920x1080i@50Hz */
+	[20] = {
+		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5, 0, FB_VMODE_INTERLACED, 0,
+	},
+	/* #35: (2880)x480p4x@59.94/60Hz */
+	[35] = {
+		NULL, 50, 2880, 480, 11100, 240, 64, 30, 9, 248, 6, 0, FB_VMODE_NONINTERLACED, 0,
+	},
+};
+
 /**
  * fb_edid_add_monspecs() - add monitor video modes from E-EDID data
  * @edid:	128 byte array with an E-EDID block
@@ -983,7 +1022,8 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	unsigned char *block;
 	struct fb_videomode *m;
 	int num = 0, i;
-	u8 edt[(128 - 4) / DETAILED_TIMING_DESCRIPTION_SIZE];
+	u8 svd[64], edt[(128 - 4) / DETAILED_TIMING_DESCRIPTION_SIZE];
+	u8 pos = 4, svd_n = 0;
 
 	if (!edid)
 		return;
@@ -995,6 +1035,21 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	    edid[2] < 4 || edid[2] > 128 - DETAILED_TIMING_DESCRIPTION_SIZE)
 		return;
 
+	DPRINTK("  Short Video Descriptors\n");
+
+	while (pos < edid[2]) {
+		u8 len = edid[pos] & 0x1f, type = (edid[pos] >> 5) & 7;
+		pr_debug("Data block %u of %u bytes\n", type, len);
+		if (type = 2)
+			for (i = pos; i < pos + len; i++) {
+				u8 idx = edid[pos + i] & 0x7f;
+				svd[svd_n++] = idx;
+				pr_debug("N%sative mode #%d\n",
+					 edid[pos + i] & 0x80 ? "" : "on-n", idx);
+			}
+		pos += len + 1;
+	}
+
 	block = edid + edid[2];
 
 	DPRINTK("  Extended Detailed Timings\n");
@@ -1005,10 +1060,10 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 			edt[num++] = block - edid;
 
 	/* Yikes, EDID data is totally useless */
-	if (!num)
+	if (!(num + svd_n))
 		return;
 
-	m = kzalloc((specs->modedb_len + num) *
+	m = kzalloc((specs->modedb_len + num + svd_n) *
 		       sizeof(struct fb_videomode), GFP_KERNEL);
 
 	if (!m)
@@ -1023,9 +1078,22 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 		pr_debug("Adding %ux%u@%u\n", m[i].xres, m[i].yres, m[i].refresh);
 	}
 
+	for (i = specs->modedb_len + num; i < specs->modedb_len + num + svd_n; i++) {
+		int idx = svd[i - specs->modedb_len - num];
+		if (!idx || idx > 63) {
+			pr_warning("Reserved SVD code %d\n", idx);
+		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
+			pr_warning("Unimplemented SVD code %d\n", idx);
+		} else {
+			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
+			pr_debug("Adding SVD #%d: %ux%u@%u\n", idx,
+				 m[i].xres, m[i].yres, m[i].refresh);
+		}
+	}
+
 	kfree(specs->modedb);
 	specs->modedb = m;
-	specs->modedb_len = specs->modedb_len + num;
+	specs->modedb_len = specs->modedb_len + num + svd_n;
 }
 
 /*
-- 
1.7.2.3

