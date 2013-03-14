From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:30 +0000
Subject: [PATCH 6/6] video: mxsfb: remove mxsfb_platform_data
Message-Id: <1363240410-16865-7-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

None of mxsfb users uses mxsfb_platform_data now.  Let's remove it
from mxsfb driver.

As the result, include/linux/mxsfb.h gets deleted with a few macros
moved into mxsfb.c.  Along with the change, the typo "FAILING" in macro
name is fixed to be "FALLING".

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/video/mxsfb.c |   39 +++++++++++++++++----------------------
 include/linux/mxsfb.h |   39 ---------------------------------------
 2 files changed, 17 insertions(+), 61 deletions(-)
 delete mode 100644 include/linux/mxsfb.h

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index cf968c6..b528f56 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -49,7 +49,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/mxsfb.h>
+#include <linux/fb.h>
 #include <video/videomode.h>
 
 #define REG_SET	4
@@ -109,7 +109,7 @@
 #define VDCTRL0_ENABLE_PRESENT		(1 << 28)
 #define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
 #define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
-#define VDCTRL0_DOTCLK_ACT_FAILING	(1 << 25)
+#define VDCTRL0_DOTCLK_ACT_FALLING	(1 << 25)
 #define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
 #define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
 #define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
@@ -144,6 +144,14 @@
 #define BLUE 2
 #define TRANSP 3
 
+#define STMLCDIF_8BIT  1 /** pixel data bus to the display is of 8 bit width */
+#define STMLCDIF_16BIT 0 /** pixel data bus to the display is of 16 bit width */
+#define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit width */
+#define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
+
+#define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
+#define FB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negtive edge sampling */
+
 enum mxsfb_devtype {
 	MXSFB_V3,
 	MXSFB_V4,
@@ -459,8 +467,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 		vdctrl0 |= VDCTRL0_VSYNC_ACT_HIGH;
 	if (fb_info->var.sync & FB_SYNC_DATA_ENABLE_HIGH_ACT)
 		vdctrl0 |= VDCTRL0_ENABLE_ACT_HIGH;
-	if (fb_info->var.sync & FB_SYNC_DOTCLK_FAILING_ACT)
-		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FAILING;
+	if (fb_info->var.sync & FB_SYNC_DOTCLK_FALLING_ACT)
+		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FALLING;
 
 	writel(vdctrl0, host->base + LCDC_VDCTRL0);
 
@@ -759,7 +767,7 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host)
 		if (vm.data_flags & DISPLAY_FLAGS_DE_HIGH)
 			fb_vm.sync |= FB_SYNC_DATA_ENABLE_HIGH_ACT;
 		if (vm.data_flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
-			fb_vm.sync |= FB_SYNC_DOTCLK_FAILING_ACT;
+			fb_vm.sync |= FB_SYNC_DOTCLK_FALLING_ACT;
 		fb_add_videomode(&fb_vm, &fb_info->modelist);
 	}
 
@@ -774,7 +782,6 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
 	struct fb_var_screeninfo *var = &fb_info->var;
-	struct mxsfb_platform_data *pdata = host->pdev->dev.platform_data;
 	dma_addr_t fb_phys;
 	void *fb_virt;
 	unsigned fb_size;
@@ -788,15 +795,9 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	fb_info->fix.visual = FB_VISUAL_TRUECOLOR,
 	fb_info->fix.accel = FB_ACCEL_NONE;
 
-	if (pdata) {
-		host->ld_intf_width = pdata->ld_intf_width;
-		var->bits_per_pixel -			pdata->default_bpp ? pdata->default_bpp : 16;
-	} else {
-		ret = mxsfb_init_fbinfo_dt(host);
-		if (ret)
-			return ret;
-	}
+	ret = mxsfb_init_fbinfo_dt(host);
+	if (ret)
+		return ret;
 
 	var->nonstd = 0;
 	var->activate = FB_ACTIVATE_NOW;
@@ -852,7 +853,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id  			of_match_device(mxsfb_dt_ids, &pdev->dev);
-	struct mxsfb_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
 	struct mxsfb_info *host;
 	struct fb_info *fb_info;
@@ -860,7 +860,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 	struct pinctrl *pinctrl;
 	int panel_enable;
 	enum of_gpio_flags flags;
-	int i, ret;
+	int ret;
 
 	if (of_id)
 		pdev->id_entry = of_id->data;
@@ -932,11 +932,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto fb_release;
 
-	if (pdata)
-		for (i = 0; i < pdata->mode_count; i++)
-			fb_add_videomode(&pdata->mode_list[i],
-					 &fb_info->modelist);
-
 	modelist = list_first_entry(&fb_info->modelist,
 			struct fb_modelist, list);
 	fb_videomode_to_var(&fb_info->var, &modelist->mode);
diff --git a/include/linux/mxsfb.h b/include/linux/mxsfb.h
deleted file mode 100644
index 6d64e2e..0000000
--- a/include/linux/mxsfb.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA 02110-1301, USA.
- */
-
-#ifndef __LINUX_MXSFB_H
-#define __LINUX_MXSFB_H
-
-#include <linux/fb.h>
-
-#define STMLCDIF_8BIT 1	/** pixel data bus to the display is of 8 bit width */
-#define STMLCDIF_16BIT 0 /** pixel data bus to the display is of 16 bit width */
-#define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit width */
-#define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
-
-#define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
-
-struct mxsfb_platform_data {
-	struct fb_videomode *mode_list;
-	unsigned mode_count;
-
-	unsigned default_bpp;
-
-	unsigned ld_intf_width;	/* refer STMLCDIF_* macros */
-};
-
-#endif /* __LINUX_MXSFB_H */
-- 
1.7.9.5


