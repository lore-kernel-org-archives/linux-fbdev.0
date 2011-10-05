From: Timur Tabi <timur@freescale.com>
Date: Wed, 05 Oct 2011 00:36:49 +0000
Subject: [PATCH 6/9] drivers/video: fsl-diu-fb: remove unused panel operating mode support
Message-Id: <1317775012-9797-6-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The MFB_TYPE_xxx macros indicate different "operating modes" of each AOI,
but this feature is not actually used in the driver.  The mfb_index.type
field is always set to MFB_TYPE_OUTPUT, so just delete it and any code
that references it.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |  117 +++++++++++++++++--------------------------
 1 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index c5f9731..0fd4c784 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -49,12 +49,6 @@
 #define INT_PARERR	0x08	/* Display parameters error interrupt */
 #define INT_LS_BF_VS	0x10	/* Lines before vsync. interrupt */
 
-/* Panels'operation modes */
-#define MFB_TYPE_OUTPUT	0	/* Panel output to display */
-#define MFB_TYPE_OFF	1	/* Panel off */
-#define MFB_TYPE_WB	2	/* Panel written back to memory */
-#define MFB_TYPE_TEST	3	/* Panel generate color bar */
-
 struct diu_hw {
 	struct diu __iomem *diu_reg;
 	spinlock_t reg_lock;
@@ -370,7 +364,6 @@ enum mfb_index {
 
 struct mfb_info {
 	enum mfb_index index;
-	int type;
 	char *id;
 	int registered;
 	unsigned long pseudo_palette[16];
@@ -388,7 +381,6 @@ struct mfb_info {
 static struct mfb_info mfb_template[] = {
 	{
 		.index = PLANE0,
-		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel0",
 		.registered = 0,
 		.count = 0,
@@ -397,7 +389,6 @@ static struct mfb_info mfb_template[] = {
 	},
 	{
 		.index = PLANE1_AOI0,
-		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel1 AOI0",
 		.registered = 0,
 		.g_alpha = 0xff,
@@ -407,7 +398,6 @@ static struct mfb_info mfb_template[] = {
 	},
 	{
 		.index = PLANE1_AOI1,
-		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel1 AOI1",
 		.registered = 0,
 		.g_alpha = 0xff,
@@ -417,7 +407,6 @@ static struct mfb_info mfb_template[] = {
 	},
 	{
 		.index = PLANE2_AOI0,
-		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel2 AOI0",
 		.registered = 0,
 		.g_alpha = 0xff,
@@ -427,7 +416,6 @@ static struct mfb_info mfb_template[] = {
 	},
 	{
 		.index = PLANE2_AOI1,
-		.type = MFB_TYPE_OUTPUT,
 		.id = "Panel2 AOI1",
 		.registered = 0,
 		.g_alpha = 0xff,
@@ -517,62 +505,57 @@ void wr_reg_wa(u32 *reg, u32 val)
 	} while (in_be32(reg) != val);
 }
 
-static int fsl_diu_enable_panel(struct fb_info *info)
+static void fsl_diu_enable_panel(struct fb_info *info)
 {
 	struct mfb_info *pmfbi, *cmfbi, *mfbi = info->par;
 	struct diu *hw = dr.diu_reg;
 	struct diu_ad *ad = mfbi->ad;
 	struct fsl_diu_data *machine_data = mfbi->parent;
-	int res = 0;
 
-	if (mfbi->type != MFB_TYPE_OFF) {
-		switch (mfbi->index) {
-		case PLANE0:
-			if (hw->desc[0] != ad->paddr)
-				wr_reg_wa(&hw->desc[0], ad->paddr);
-			break;
-		case PLANE1_AOI0:
-			cmfbi = machine_data->fsl_diu_info[2]->par;
-			if (hw->desc[1] != ad->paddr) {	/* AOI0 closed */
-				if (cmfbi->count > 0)	/* AOI1 open */
-					ad->next_ad -						cpu_to_le32(cmfbi->ad->paddr);
-				else
-					ad->next_ad = 0;
-				wr_reg_wa(&hw->desc[1], ad->paddr);
-			}
-			break;
-		case PLANE2_AOI0:
-			cmfbi = machine_data->fsl_diu_info[4]->par;
-			if (hw->desc[2] != ad->paddr) {	/* AOI0 closed */
-				if (cmfbi->count > 0)	/* AOI1 open */
-					ad->next_ad -						cpu_to_le32(cmfbi->ad->paddr);
-				else
-					ad->next_ad = 0;
-				wr_reg_wa(&hw->desc[2], ad->paddr);
-			}
-			break;
-		case PLANE1_AOI1:
-			pmfbi = machine_data->fsl_diu_info[1]->par;
-			ad->next_ad = 0;
-			if (hw->desc[1] = machine_data->dummy_ad->paddr)
-				wr_reg_wa(&hw->desc[1], ad->paddr);
-			else					/* AOI0 open */
-				pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
-			break;
-		case PLANE2_AOI1:
-			pmfbi = machine_data->fsl_diu_info[3]->par;
-			ad->next_ad = 0;
-			if (hw->desc[2] = machine_data->dummy_ad->paddr)
-				wr_reg_wa(&hw->desc[2], ad->paddr);
-			else				/* AOI0 was open */
-				pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
-			break;
+	switch (mfbi->index) {
+	case PLANE0:
+		if (hw->desc[0] != ad->paddr)
+			wr_reg_wa(&hw->desc[0], ad->paddr);
+		break;
+	case PLANE1_AOI0:
+		cmfbi = machine_data->fsl_diu_info[2]->par;
+		if (hw->desc[1] != ad->paddr) {	/* AOI0 closed */
+			if (cmfbi->count > 0)	/* AOI1 open */
+				ad->next_ad +					cpu_to_le32(cmfbi->ad->paddr);
+			else
+				ad->next_ad = 0;
+			wr_reg_wa(&hw->desc[1], ad->paddr);
 		}
-	} else
-		res = -EINVAL;
-	return res;
+		break;
+	case PLANE2_AOI0:
+		cmfbi = machine_data->fsl_diu_info[4]->par;
+		if (hw->desc[2] != ad->paddr) {	/* AOI0 closed */
+			if (cmfbi->count > 0)	/* AOI1 open */
+				ad->next_ad +					cpu_to_le32(cmfbi->ad->paddr);
+			else
+				ad->next_ad = 0;
+			wr_reg_wa(&hw->desc[2], ad->paddr);
+		}
+		break;
+	case PLANE1_AOI1:
+		pmfbi = machine_data->fsl_diu_info[1]->par;
+		ad->next_ad = 0;
+		if (hw->desc[1] = machine_data->dummy_ad->paddr)
+			wr_reg_wa(&hw->desc[1], ad->paddr);
+		else					/* AOI0 open */
+			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
+		break;
+	case PLANE2_AOI1:
+		pmfbi = machine_data->fsl_diu_info[3]->par;
+		ad->next_ad = 0;
+		if (hw->desc[2] = machine_data->dummy_ad->paddr)
+			wr_reg_wa(&hw->desc[2], ad->paddr);
+		else				/* AOI0 was open */
+			pmfbi->ad->next_ad = cpu_to_le32(ad->paddr);
+		break;
+	}
 }
 
 static void fsl_diu_disable_panel(struct fb_info *info)
@@ -849,11 +832,6 @@ static void update_lcdc(struct fb_info *info)
 
 	hw = dr.diu_reg;
 
-	if (mfbi->type = MFB_TYPE_OFF) {
-		fsl_diu_disable_panel(info);
-		return;
-	}
-
 	diu_ops.set_monitor_port(machine_data->monitor_port);
 	gamma_table_base = pool.gamma.vaddr;
 	cursor_base = pool.cursor.vaddr;
@@ -1205,11 +1183,8 @@ static int fsl_diu_open(struct fb_info *info, int user)
 		res = fsl_diu_set_par(info);
 		if (res < 0)
 			mfbi->count--;
-		else {
-			res = fsl_diu_enable_panel(info);
-			if (res < 0)
-				mfbi->count--;
-		}
+		else
+			fsl_diu_enable_panel(info);
 	}
 
 	spin_unlock(&diu_lock);
-- 
1.7.4.4


