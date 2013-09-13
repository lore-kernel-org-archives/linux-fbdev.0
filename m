From: Zhou Zhu <zzhu3@marvell.com>
Date: Fri, 13 Sep 2013 06:59:45 +0000
Subject: [PATCH V5 1/5] video: mmp: rb swap setting update for mmp display
Message-Id: <1379055589-26132-2-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Guoqing Li <ligq@marvell.com>

We could set rb swap in two modules: DMA controler input part and
dsi interface output part.
DMA input part is based on pix_fmt to set rbswap, dsi output interface
part will set rbswap based on platform dsi_rbswap configuration.

This patch include below change and enhancement:

1) The input format which support rbswap is based on RGB format,
eg. RGB565 indicates the source data in memory is that Red is [15~11],
Green is [10~5], Blue is [4:0], Red is MSB, Blue is LSB, but for the
display dma input default setting(rbswap = 0), it only support Blue
is [15~11], Green is [10~5], Red is [4:0], Red is LSB, Blue is MSB,
so for this format(RGB565), display controller need to set rbswap
 = 1 and it can support the MSB/LSB correctly.
BGR/YUV format will not set it in mmp display driver.

2) The dsi output part of rbswap is depend on dsi_rbswap which is
defined in specific platfrom. For output dsi interface, it has this
feature to do rbswap again if it needs specifc byte sequence of RGB
byte for DSI panel.
eg. If display content is set RGB565 in memory and DMA input part set
rbswap in driver to support Red as MSB , Blue LSB, but dsi panel only
support Red as LSB, Blue as MSB, then it can use this feature.
If there is no this requirement of panel, this dsi output part is not
needed.

Signed-off-by: Guoqing Li <ligq@marvell.com>
Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
Reviewed-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/mmp/hw/mmp_ctrl.c |   19 +++++++++++--------
 drivers/video/mmp/hw/mmp_ctrl.h |    5 +++++
 include/video/mmp_disp.h        |    1 +
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
index 75dca19..a40d95a 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -60,8 +60,7 @@ static irqreturn_t ctrl_handle_irq(int irq, void *dev_id)
 
 static u32 fmt_to_reg(struct mmp_overlay *overlay, int pix_fmt)
 {
-	u32 link_config = path_to_path_plat(overlay->path)->link_config;
-	u32 rbswap, uvswap = 0, yuvswap = 0,
+	u32 rbswap = 0, uvswap = 0, yuvswap = 0,
 		csc_en = 0, val = 0,
 		vid = overlay_is_vid(overlay);
 
@@ -71,27 +70,23 @@ static u32 fmt_to_reg(struct mmp_overlay *overlay, int pix_fmt)
 	case PIXFMT_RGB888PACK:
 	case PIXFMT_RGB888UNPACK:
 	case PIXFMT_RGBA888:
-		rbswap = !(link_config & 0x1);
+		rbswap = 1;
 		break;
 	case PIXFMT_VYUY:
 	case PIXFMT_YVU422P:
 	case PIXFMT_YVU420P:
-		rbswap = link_config & 0x1;
 		uvswap = 1;
 		break;
 	case PIXFMT_YUYV:
-		rbswap = link_config & 0x1;
 		yuvswap = 1;
 		break;
 	default:
-		rbswap = link_config & 0x1;
 		break;
 	}
 
 	switch (pix_fmt) {
 	case PIXFMT_RGB565:
 	case PIXFMT_BGR565:
-		val = 0;
 		break;
 	case PIXFMT_RGB1555:
 	case PIXFMT_BGR1555:
@@ -248,7 +243,8 @@ static void path_set_mode(struct mmp_path *path, struct mmp_mode *mode)
 {
 	struct lcd_regs *regs = path_regs(path);
 	u32 total_x, total_y, vsync_ctrl, tmp, sclk_src, sclk_div,
-		link_config = path_to_path_plat(path)->link_config;
+		link_config = path_to_path_plat(path)->link_config,
+		dsi_rbswap = path_to_path_plat(path)->link_config;
 
 	/* FIXME: assert videomode supported */
 	memcpy(&path->mode, mode, sizeof(struct mmp_mode));
@@ -263,6 +259,12 @@ static void path_set_mode(struct mmp_path *path, struct mmp_mode *mode)
 	tmp |= CFG_DUMB_ENA(1);
 	writel_relaxed(tmp, ctrl_regs(path) + intf_ctrl(path->id));
 
+	/* interface rb_swap setting */
+	tmp = readl_relaxed(ctrl_regs(path) + intf_rbswap_ctrl(path->id)) &
+		(~(CFG_INTFRBSWAP_MASK));
+	tmp |= dsi_rbswap & CFG_INTFRBSWAP_MASK;
+	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
+
 	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
 	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
 		&regs->screen_h_porch);
@@ -419,6 +421,7 @@ static int path_init(struct mmphw_path_plat *path_plat,
 	path_plat->path = path;
 	path_plat->path_config = config->path_config;
 	path_plat->link_config = config->link_config;
+	path_plat->dsi_rbswap = config->dsi_rbswap;
 	path_set_default(path);
 
 	kfree(path_info);
diff --git a/drivers/video/mmp/hw/mmp_ctrl.h b/drivers/video/mmp/hw/mmp_ctrl.h
index edd2002..53301cf 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.h
+++ b/drivers/video/mmp/hw/mmp_ctrl.h
@@ -163,6 +163,8 @@ struct lcd_regs {
 
 #define LCD_SCLK(path) ((PATH_PN = path->id) ? LCD_CFG_SCLK_DIV :\
 	((PATH_TV = path->id) ? LCD_TCLK_DIV : LCD_PN2_SCLK_DIV))
+#define intf_rbswap_ctrl(id)	((id) ? (((id) & 1) ? LCD_TVIF_CTRL : \
+				PN2_IOPAD_CONTROL) : LCD_TOP_CTRL)
 
 /* dither configure */
 #ifdef CONFIG_CPU_PXA988
@@ -615,6 +617,8 @@ struct lcd_regs {
 #define LCD_SPU_DUMB_CTRL			0x01B8
 #define	 CFG_DUMBMODE(mode)			((mode)<<28)
 #define	 CFG_DUMBMODE_MASK			0xF0000000
+#define	 CFG_INTFRBSWAP(mode)			((mode)<<24)
+#define	 CFG_INTFRBSWAP_MASK			0x0F000000
 #define	 CFG_LCDGPIO_O(data)			((data)<<20)
 #define	 CFG_LCDGPIO_O_MASK			0x0FF00000
 #define	 CFG_LCDGPIO_ENA(gpio)			((gpio)<<12)
@@ -1427,6 +1431,7 @@ struct mmphw_path_plat {
 	struct mmp_path *path;
 	u32 path_config;
 	u32 link_config;
+	u32 dsi_rbswap;
 };
 
 /* mmp ctrl describes mmp controller related info */
diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index b9dd1fb..32094c0 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -334,6 +334,7 @@ struct mmp_mach_path_config {
 	int output_type;
 	u32 path_config;
 	u32 link_config;
+	u32 dsi_rbswap;
 };
 
 struct mmp_mach_plat_info {
-- 
1.7.9.5

