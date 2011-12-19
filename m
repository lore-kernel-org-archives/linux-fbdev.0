From: Timur Tabi <timur@freescale.com>
Date: Mon, 19 Dec 2011 22:26:16 +0000
Subject: [PATCH 3/5] drivers/video: fsl-diu-fb: remove broken reference count enabling the display
Message-Id: <1324333578-23992-3-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The functions enable_lcdc() and disable_lcdc() used the variable fb_enable
to keep a reference count of when the display is enabled, but the code is
broken.  The display is always disabled when disable_lcdc(), and it is
always enabled when enable_lcdc() is called, regardless of the value of
fb_enable.  Obviously, we don't need to keep a reference count, so just
remove the variable.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 231752e..d8d461d 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -352,7 +352,6 @@ struct mfb_info {
  * @fsl_diu_info: fb_info objects, one per AOI
  * @dev_attr: sysfs structure
  * @irq: IRQ
- * @fb_enabled: TRUE if the DIU is enabled, FALSE if not
  * @monitor_port: the monitor port this DIU is connected to
  * @diu_reg: pointer to the DIU hardware registers
  * @reg_lock: spinlock for register access
@@ -371,7 +370,6 @@ struct fsl_diu_data {
 	struct mfb_info mfb[NUM_AOIS];
 	struct device_attribute dev_attr;
 	unsigned int irq;
-	int fb_enabled;
 	enum fsl_diu_monitor_port monitor_port;
 	struct diu __iomem *diu_reg;
 	spinlock_t reg_lock;
@@ -619,10 +617,7 @@ static void enable_lcdc(struct fb_info *info)
 	struct fsl_diu_data *data = mfbi->parent;
 	struct diu __iomem *hw = data->diu_reg;
 
-	if (!data->fb_enabled) {
-		out_be32(&hw->diu_mode, MFB_MODE1);
-		data->fb_enabled++;
-	}
+	out_be32(&hw->diu_mode, MFB_MODE1);
 }
 
 static void disable_lcdc(struct fb_info *info)
@@ -631,10 +626,7 @@ static void disable_lcdc(struct fb_info *info)
 	struct fsl_diu_data *data = mfbi->parent;
 	struct diu __iomem *hw = data->diu_reg;
 
-	if (data->fb_enabled) {
-		out_be32(&hw->diu_mode, 0);
-		data->fb_enabled = 0;
-	}
+	out_be32(&hw->diu_mode, 0);
 }
 
 static void adjust_aoi_size_position(struct fb_var_screeninfo *var,
-- 
1.7.3.4


