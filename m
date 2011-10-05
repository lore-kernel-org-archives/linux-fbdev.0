From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:48 +0000
Subject: [PATCH 5/9] drivers/video: fsl-diu-fb: use an enum for the AOI index
Message-Id: <1317775012-9797-5-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Each of the five AOIs created by the DIU driver has a special purpose, and
they're not treated equally.  It makes sense to identify them with an enum
instead of a hard-coded number.

Since the 'index' is now an enum, it can only contain allowed values, so
there's no need to check for an invalid value.  This simplifies some other
code, such as fsl_diu_disable_panel(), which no longer needs to return an
error code.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   94 +++++++++++++++++++++----------------------
 1 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 29652ab..c5f9731 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -360,8 +360,16 @@ struct fsl_diu_data {
 	enum fsl_diu_monitor_port monitor_port;
 };
 
+enum mfb_index {
+	PLANE0 = 0,	/* Plane 0, only one AOI that fills the screen */
+	PLANE1_AOI0,	/* Plane 1, first AOI */
+	PLANE1_AOI1,	/* Plane 1, second AOI */
+	PLANE2_AOI0,	/* Plane 2, first AOI */
+	PLANE2_AOI1,	/* Plane 2, second AOI */
+};
+
 struct mfb_info {
-	int index;
+	enum mfb_index index;
 	int type;
 	char *id;
 	int registered;
@@ -378,8 +386,8 @@ struct mfb_info {
 
 
 static struct mfb_info mfb_template[] = {
-	{		/* AOI 0 for plane 0 */
-		.index = 0,
+	{
+		.index = PLANE0,
 		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel0",
 		.registered = 0,
@@ -387,8 +395,8 @@ static struct mfb_info mfb_template[] = {
 		.x_aoi_d = 0,
 		.y_aoi_d = 0,
 	},
-	{		/* AOI 0 for plane 1 */
-		.index = 1,
+	{
+		.index = PLANE1_AOI0,
 		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel1 AOI0",
 		.registered = 0,
@@ -397,8 +405,8 @@ static struct mfb_info mfb_template[] = {
 		.x_aoi_d = 0,
 		.y_aoi_d = 0,
 	},
-	{		/* AOI 1 for plane 1 */
-		.index = 2,
+	{
+		.index = PLANE1_AOI1,
 		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel1 AOI1",
 		.registered = 0,
@@ -407,8 +415,8 @@ static struct mfb_info mfb_template[] = {
 		.x_aoi_d = 0,
 		.y_aoi_d = 480,
 	},
-	{		/* AOI 0 for plane 2 */
-		.index = 3,
+	{
+		.index = PLANE2_AOI0,
 		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel2 AOI0",
 		.registered = 0,
@@ -417,8 +425,8 @@ static struct mfb_info mfb_template[] = {
 		.x_aoi_d = 640,
 		.y_aoi_d = 0,
 	},
-	{		/* AOI 1 for plane 2 */
-		.index = 4,
+	{
+		.index = PLANE2_AOI1,
 		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel2 AOI1",
 		.registered = 0,
@@ -519,11 +527,11 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 
 	if (mfbi->type != MFB_TYPE_OFF) {
 		switch (mfbi->index) {
-		case 0:				/* plane 0 */
+		case PLANE0:
 			if (hw->desc[0] != ad->paddr)
 				wr_reg_wa(&hw->desc[0], ad->paddr);
 			break;
-		case 1:				/* plane 1 AOI 0 */
+		case PLANE1_AOI0:
 			cmfbi = machine_data->fsl_diu_info[2]->par;
 			if (hw->desc[1] != ad->paddr) {	/* AOI0 closed */
 				if (cmfbi->count > 0)	/* AOI1 open */
@@ -534,7 +542,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 				wr_reg_wa(&hw->desc[1], ad->paddr);
 			}
 			break;
-		case 3:				/* plane 2 AOI 0 */
+		case PLANE2_AOI0:
 			cmfbi = machine_data->fsl_diu_info[4]->par;
 			if (hw->desc[2] != ad->paddr) {	/* AOI0 closed */
 				if (cmfbi->count > 0)	/* AOI1 open */
@@ -545,7 +553,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 				wr_reg_wa(&hw->desc[2], ad->paddr);
 			}
 			break;
-		case 2:				/* plane 1 AOI 1 */
+		case PLANE1_AOI1:
 			pmfbi = machine_data->fsl_diu_info[1]->par;
 			ad->next_ad = 0;
 			if (hw->desc[1] = machine_data->dummy_ad->paddr)
@@ -553,7 +561,7 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 			else					/* AOI0 open */
 				pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
 			break;
-		case 4:				/* plane 2 AOI 1 */
+		case PLANE2_AOI1:
 			pmfbi = machine_data->fsl_diu_info[3]->par;
 			ad->next_ad = 0;
 			if (hw->desc[2] = machine_data->dummy_ad->paddr)
@@ -561,29 +569,25 @@ static int fsl_diu_enable_panel(struct fb_info *info)
 			else				/* AOI0 was open */
 				pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
 			break;
-		default:
-			res = -EINVAL;
-			break;
 		}
 	} else
 		res = -EINVAL;
 	return res;
 }
 
-static int fsl_diu_disable_panel(struct fb_info *info)
+static void fsl_diu_disable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
 	struct diu *hw = dr.diu_reg;
 	struct diu_ad *ad = mfbi->ad;
 	struct fsl_diu_data *machine_data = mfbi->parent;
-	int res = 0;
 
 	switch (mfbi->index) {
-	case 0:					/* plane 0 */
+	case PLANE0:
 		if (hw->desc[0] != machine_data->dummy_ad->paddr)
 			wr_reg_wa(&hw->desc[0], machine_data->dummy_ad->paddr);
 		break;
-	case 1:					/* plane 1 AOI 0 */
+	case PLANE1_AOI0:
 		cmfbi = machine_data->fsl_diu_info[2]->par;
 		if (cmfbi->count > 0)	/* AOI1 is open */
 			wr_reg_wa(&hw->desc[1], cmfbi->ad->paddr);
@@ -592,7 +596,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
 					/* close AOI 0 */
 		break;
-	case 3:					/* plane 2 AOI 0 */
+	case PLANE2_AOI0:
 		cmfbi = machine_data->fsl_diu_info[4]->par;
 		if (cmfbi->count > 0)	/* AOI1 is open */
 			wr_reg_wa(&hw->desc[2], cmfbi->ad->paddr);
@@ -601,7 +605,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
 					/* close AOI 0 */
 		break;
-	case 2:					/* plane 1 AOI 1 */
+	case PLANE1_AOI1:
 		pmfbi = machine_data->fsl_diu_info[1]->par;
 		if (hw->desc[1] != ad->paddr) {
 				/* AOI1 is not the first in the chain */
@@ -612,7 +616,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 			wr_reg_wa(&hw->desc[1], machine_data->dummy_ad->paddr);
 					/* close AOI 1 */
 		break;
-	case 4:					/* plane 2 AOI 1 */
+	case PLANE2_AOI1:
 		pmfbi = machine_data->fsl_diu_info[3]->par;
 		if (hw->desc[2] != ad->paddr) {
 				/* AOI1 is not the first in the chain */
@@ -623,12 +627,7 @@ static int fsl_diu_disable_panel(struct fb_info *info)
 			wr_reg_wa(&hw->desc[2], machine_data->dummy_ad->paddr);
 				/* close AOI 1 */
 		break;
-	default:
-		res = -EINVAL;
-		break;
 	}
-
-	return res;
 }
 
 static void enable_lcdc(struct fb_info *info)
@@ -660,7 +659,8 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 {
 	struct mfb_info *lower_aoi_mfbi, *upper_aoi_mfbi, *mfbi = info->par;
 	struct fsl_diu_data *machine_data = mfbi->parent;
-	int available_height, upper_aoi_bottom, index = mfbi->index;
+	int available_height, upper_aoi_bottom;
+	enum mfb_index index = mfbi->index;
 	int lower_aoi_is_open, upper_aoi_is_open;
 	__u32 base_plane_width, base_plane_height, upper_aoi_height;
 
@@ -672,14 +672,14 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 	if (mfbi->y_aoi_d < 0)
 		mfbi->y_aoi_d = 0;
 	switch (index) {
-	case 0:
+	case PLANE0:
 		if (mfbi->x_aoi_d != 0)
 			mfbi->x_aoi_d = 0;
 		if (mfbi->y_aoi_d != 0)
 			mfbi->y_aoi_d = 0;
 		break;
-	case 1:			/* AOI 0 */
-	case 3:
+	case PLANE1_AOI0:
+	case PLANE2_AOI0:
 		lower_aoi_mfbi = machine_data->fsl_diu_info[index+1]->par;
 		lower_aoi_is_open = lower_aoi_mfbi->count > 0 ? 1 : 0;
 		if (var->xres > base_plane_width)
@@ -696,8 +696,8 @@ static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
 		if ((mfbi->y_aoi_d + var->yres) > available_height)
 			mfbi->y_aoi_d = available_height - var->yres;
 		break;
-	case 2:			/* AOI 1 */
-	case 4:
+	case PLANE1_AOI1:
+	case PLANE2_AOI1:
 		upper_aoi_mfbi = machine_data->fsl_diu_info[index-1]->par;
 		upper_aoi_height  				machine_data->fsl_diu_info[index-1]->var.yres;
@@ -1002,7 +1002,7 @@ static int fsl_diu_set_par(struct fb_info *info)
 	ad->ckmin_g = 255;
 	ad->ckmin_b = 255;
 
-	if (mfbi->index = 0)
+	if (mfbi->index = PLANE0)
 		update_lcdc(info);
 	return 0;
 }
@@ -1195,7 +1195,7 @@ static int fsl_diu_open(struct fb_info *info, int user)
 	int res = 0;
 
 	/* free boot splash memory on first /dev/fb0 open */
-	if (!mfbi->index && diu_ops.release_bootmem)
+	if ((mfbi->index = PLANE0) && diu_ops.release_bootmem)
 		diu_ops.release_bootmem();
 
 	spin_lock(&diu_lock);
@@ -1225,11 +1225,9 @@ static int fsl_diu_release(struct fb_info *info, int user)
 
 	spin_lock(&diu_lock);
 	mfbi->count--;
-	if (mfbi->count = 0) {
-		res = fsl_diu_disable_panel(info);
-		if (res < 0)
-			mfbi->count++;
-	}
+	if (mfbi->count = 0)
+		fsl_diu_disable_panel(info);
+
 	spin_unlock(&diu_lock);
 	return res;
 }
@@ -1275,7 +1273,7 @@ static int __devinit install_fb(struct fb_info *info)
 	if (init_fbinfo(info))
 		return -EINVAL;
 
-	if (mfbi->index = 0) {	/* plane 0 */
+	if (mfbi->index = PLANE0) {
 		if (mfbi->edid_data) {
 			/* Now build modedb from EDID */
 			fb_edid_to_monspecs(mfbi->edid_data, &info->monspecs);
@@ -1296,7 +1294,7 @@ static int __devinit install_fb(struct fb_info *info)
 		 * For plane 0 we continue and look into
 		 * driver's internal modedb.
 		 */
-		if (mfbi->index = 0 && mfbi->edid_data)
+		if ((mfbi->index = PLANE0) && mfbi->edid_data)
 			has_default_mode = 0;
 		else
 			return -EINVAL;
@@ -1360,7 +1358,7 @@ static void uninstall_fb(struct fb_info *info)
 	if (!mfbi->registered)
 		return;
 
-	if (mfbi->index = 0)
+	if (mfbi->index = PLANE0)
 		kfree(mfbi->edid_data);
 
 	unregister_framebuffer(info);
@@ -1565,7 +1563,7 @@ static int __devinit fsl_diu_probe(struct platform_device *pdev)
 		memcpy(mfbi, &mfb_template[i], sizeof(struct mfb_info));
 		mfbi->parent = machine_data;
 
-		if (mfbi->index = 0) {
+		if (mfbi->index = PLANE0) {
 			const u8 *prop;
 			int len;
 
-- 
1.7.4.4


