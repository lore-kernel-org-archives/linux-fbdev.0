From: Timur Tabi <timur@freescale.com>
Date: Tue, 16 Oct 2012 22:33:50 +0000
Subject: [PATCH 9/9] drivers/video: fsl-diu-fb: store EDID data in the global object
Message-Id: <1350426830-12140-9-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Although the DIU driver creates five framebuffer devices, only the first
one controls the physical display.  The remaining four are virtual "AOIs".
Therefore, the EDID data should be stored in the global fsl_diu_data
object, instead of the per-framebuffer object.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 0883bc4..d3fc92e 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -342,7 +342,6 @@ struct mfb_info {
 	int x_aoi_d;		/* aoi display x offset to physical screen */
 	int y_aoi_d;		/* aoi display y offset to physical screen */
 	struct fsl_diu_data *parent;
-	u8 *edid_data;
 };
 
 /**
@@ -377,6 +376,8 @@ struct fsl_diu_data {
 	struct diu_ad ad[NUM_AOIS] __aligned(8);
 	u8 gamma[256 * 3] __aligned(32);
 	u8 cursor[MAX_CURS * MAX_CURS * 2] __aligned(32);
+	uint8_t edid_data[EDID_LENGTH];
+	bool has_edid;
 } __aligned(32);
 
 /* Determine the DMA address of a member of the fsl_diu_data structure */
@@ -1310,6 +1311,7 @@ static int __devinit install_fb(struct fb_info *info)
 {
 	int rc;
 	struct mfb_info *mfbi = info->par;
+	struct fsl_diu_data *data = mfbi->parent;
 	const char *aoi_mode, *init_aoi_mode = "320x240";
 	struct fb_videomode *db = fsl_diu_mode_db;
 	unsigned int dbsize = ARRAY_SIZE(fsl_diu_mode_db);
@@ -1326,9 +1328,9 @@ static int __devinit install_fb(struct fb_info *info)
 		return rc;
 
 	if (mfbi->index = PLANE0) {
-		if (mfbi->edid_data) {
+		if (data->has_edid) {
 			/* Now build modedb from EDID */
-			fb_edid_to_monspecs(mfbi->edid_data, &info->monspecs);
+			fb_edid_to_monspecs(data->edid_data, &info->monspecs);
 			fb_videomode_to_modelist(info->monspecs.modedb,
 						 info->monspecs.modedb_len,
 						 &info->modelist);
@@ -1346,7 +1348,7 @@ static int __devinit install_fb(struct fb_info *info)
 		 * For plane 0 we continue and look into
 		 * driver's internal modedb.
 		 */
-		if ((mfbi->index = PLANE0) && mfbi->edid_data)
+		if ((mfbi->index = PLANE0) && data->has_edid)
 			has_default_mode = 0;
 		else
 			return -EINVAL;
@@ -1410,9 +1412,6 @@ static void uninstall_fb(struct fb_info *info)
 	if (!mfbi->registered)
 		return;
 
-	if (mfbi->index = PLANE0)
-		kfree(mfbi->edid_data);
-
 	unregister_framebuffer(info);
 	unmap_video_memory(info);
 	if (&info->cmap)
@@ -1525,6 +1524,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 	struct mfb_info *mfbi;
 	struct fsl_diu_data *data;
 	dma_addr_t dma_addr; /* DMA addr of fsl_diu_data struct */
+	const void *prop;
 	unsigned int i;
 	int ret;
 
@@ -1568,17 +1568,13 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
 		mfbi->parent = data;
 		mfbi->ad = &data->ad[i];
+	}
 
-		if (mfbi->index = PLANE0) {
-			const u8 *prop;
-			int len;
-
-			/* Get EDID */
-			prop = of_get_property(np, "edid", &len);
-			if (prop && len = EDID_LENGTH)
-				mfbi->edid_data = kmemdup(prop, EDID_LENGTH,
-							  GFP_KERNEL);
-		}
+	/* Get the EDID data from the device tree, if present */
+	prop = of_get_property(np, "edid", &ret);
+	if (prop && ret = EDID_LENGTH) {
+		memcpy(data->edid_data, prop, EDID_LENGTH);
+		data->has_edid = true;
 	}
 
 	data->diu_reg = of_iomap(np, 0);
-- 
1.7.3.4


