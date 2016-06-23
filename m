From: wolzstefan@web.de
Date: Thu, 23 Jun 2016 12:00:11 +0000
Subject: [PATCH 2/4] sm750fb/sm750_hw.c: fixed whitespacing
Message-Id: <1466683213-17477-3-git-send-email-wolzstefan@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
In-Reply-To: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de, Stefan Wolz <wolzstefan@web.de>, Christian Halder <christian.halder@fau.de>, Sebastian Handwerker <sebastian.handwerker@posteo.de>

From: Stefan Wolz <wolzstefan@web.de>

Deleted unnecessary newlines and added whitespaces around operators.

Signed-off-by: Stefan Wolz <wolzstefan@web.de>
Signed-off-by: Christian Halder <christian.halder@fau.de>
Signed-off-by: Sebastian Handwerker <sebastian.handwerker@posteo.de>
---
 drivers/staging/sm750fb/sm750_hw.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 72380a8..052f113 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -56,7 +56,6 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 	}
 
-
 	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
 	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
 
@@ -86,8 +85,6 @@ exit:
 	return ret;
 }
 
-
-
 int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 {
 	struct init_status *parm;
@@ -101,7 +98,7 @@ int hw_sm750_inithw(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	if (parm->mem_clk = 0)
 		parm->mem_clk = parm->chip_clk;
 	if (parm->master_clk = 0)
-		parm->master_clk = parm->chip_clk/3;
+		parm->master_clk = parm->chip_clk / 3;
 
 	ddk750_initHw((initchip_param_t *)&sm750_dev->initParm);
 	/* for sm718,open pci burst */
@@ -184,7 +181,6 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 	dispSet = 0;
 	channel = *output->channel;
 
-
 	if (getChipType() != SM750LE) {
 		if (channel = sm750_primary) {
 			pr_info("primary channel\n");
@@ -199,7 +195,6 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 				dispSet |= do_LCD1_SEC;
 			if (output->paths & sm750_crt)
 				dispSet |= do_CRT_SEC;
-
 		}
 		ddk750_setLogicalDispOut(dispSet);
 	} else {
@@ -234,13 +229,11 @@ int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc, struct fb_var_screeninfo *
 		break;
 	default:
 		return -EINVAL;
-
 	}
 
 	return 0;
 }
 
-
 /*
 	set the controller's mode for @crtc charged with @var and @fix parameters
 */
@@ -255,7 +248,6 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
 
-
 	ret = 0;
 	par = container_of(crtc, struct lynxfb_par, crtc);
 	sm750_dev = par->dev;
@@ -279,9 +271,12 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 
 	/* set timing */
 	modparm.pixel_clock = ps_to_hz(var->pixclock);
-	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT) ? POS:NEG;
-	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT) ? POS:NEG;
-	modparm.clock_phase_polarity = (var->sync & FB_SYNC_COMP_HIGH_ACT) ? POS:NEG;
+	modparm.vertical_sync_polarity = (var->sync & FB_SYNC_HOR_HIGH_ACT)
+					 ? POS : NEG;
+	modparm.horizontal_sync_polarity = (var->sync & FB_SYNC_VERT_HIGH_ACT)
+					   ? POS : NEG;
+	modparm.clock_phase_polarity = (var->sync & FB_SYNC_COMP_HIGH_ACT)
+				       ? POS : NEG;
 	modparm.horizontal_display_end = var->xres;
 	modparm.horizontal_sync_width = var->hsync_len;
 	modparm.horizontal_sync_start = var->xres + var->right_margin;
@@ -353,10 +348,8 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		reg |= ((var->bits_per_pixel >> 4) &
 			CRT_DISPLAY_CTRL_FORMAT_MASK);
 		POKE32(CRT_DISPLAY_CTRL, reg);
-
 	}
 
-
 exit:
 	return ret;
 }
@@ -366,7 +359,8 @@ int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
 {
 	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
 
-	POKE32(add[crtc->channel] + index*4, (red<<16)|(green<<8)|blue);
+	POKE32(add[crtc->channel] + index * 4,
+	       (red << 16) | (green << 8) | blue);
 	return 0;
 }
 
@@ -462,7 +456,6 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 	return 0;
 }
 
-
 void hw_sm750_initAccel(struct sm750_dev *sm750_dev)
 {
 	u32 reg;
@@ -510,7 +503,6 @@ int hw_sm750le_deWait(void)
 	return -1;
 }
 
-
 int hw_sm750_deWait(void)
 {
 	int i = 0x10000000;
-- 
1.9.1

