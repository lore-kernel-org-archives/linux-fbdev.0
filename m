From: Raphael Assenat <raph@8d.com>
Subject: [PATCH 4/5] mbxfb: Add YUV video overlay support
Date: Tue, 05 Sep 2006 11:00:47 -0400
Message-ID: <44FD911F.3020000@8d.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040001090207080309050903"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GKcP3-0005PV-1y for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 07:59:53 -0700
Received: from roc.holo.8d.com ([64.254.227.115])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GKcP6-0001lT-Ox
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Sep 2006 07:59:57 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, Mike Rapoport <mike@compulab.co.il>

This is a multi-part message in MIME format.
--------------040001090207080309050903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a way to create and use the video plane (YUV overlay) and
scaling video scaling features of the chip.

The overlay is configured, resized and modified using a device specific
ioctl.

Also included in this patch:
  - If no platform data was passed, print an error and exit instead of crashing.
  - Added a write_reg(_dly) macro. This improves readability when
    manipulating chip registers. (no more udelay() after each write).
  - Comments about some issues.

Signed-off-by: Raphael Assenat <raph@8d.com>

--------------040001090207080309050903
Content-Type: text/plain;
 name="mbxfb-yuv-overlay.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mbxfb-yuv-overlay.diff"

This patch adds a way to create and use the video plane (YUV overlay) and
scaling video scaling features of the chip.

The overlay is configured, resized and modified using a device specific
ioctl.

Also included in this patch:
 - If no platform data was passed, print an error and exit instead of crashing.
 - Added a write_reg(_dly) macro. This improves readability when
   manipulating chip registers. (no more udelay() after each write).
 - Comments about some issues.

Signed-off-by: Raphael Assenat <raph@8d.com>

--- linux-2.6.18-rc2-mbx/drivers/video/mbx/mbxfb.c	2006-09-05 10:47:49.000000000 -0400
+++ linux-2.6.18-rc2-8d2/drivers/video/mbx/mbxfb.c	2006-09-05 10:35:13.000000000 -0400
@@ -1,9 +1,15 @@
 /*
  *  linux/drivers/video/mbx/mbxfb.c
  *
+ *  Copyright (C) 2006 8D Technologies inc
+ *  Raphael Assenat <raph@8d.com>
+ *  	- Added video overlay support
+ *  	- Various improvements
+ *  
  *  Copyright (C) 2006 Compulab, Ltd.
  *  Mike Rapoport <mike@compulab.co.il>
- *
+ *  	- Creation of driver
+ * 
  *   Based on pxafb.c
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -19,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/uaccess.h>
 
 #include <asm/io.h>
 
@@ -29,6 +36,14 @@
 
 static unsigned long virt_base_2700;
 
+#define write_reg(val, reg) do { writel((val), (reg)); } while(0)
+
+/* Without this delay, the graphics appears somehow scaled and 
+ * there is a lot of jitter in scanlines. This delay is probably 
+ * needed only after setting some specific register(s) somewhere, 
+ * not all over the place... */
+#define write_reg_dly(val, reg) do { writel((val), reg); udelay(1000); } while(0)
+
 #define MIN_XRES	16
 #define MIN_YRES	16
 #define MAX_XRES	2048
@@ -257,19 +272,17 @@
 	gsctrl &= ~(FMsk(GSCTRL_GSWIDTH) | FMsk(GSCTRL_GSHEIGHT));
 	gsctrl |= Gsctrl_Width(info->var.xres) |
 		Gsctrl_Height(info->var.yres);
-	writel(gsctrl, GSCTRL);
-	udelay(1000);
+	write_reg_dly(gsctrl, GSCTRL);
 
 	gsadr &= ~(FMsk(GSADR_SRCSTRIDE));
 	gsadr |= Gsadr_Srcstride(info->var.xres * info->var.bits_per_pixel /
 				 (8 * 16) - 1);
-	writel(gsadr, GSADR);
-	udelay(1000);
+	write_reg_dly(gsadr, GSADR);
 
 	/* setup timings */
 	var->pixclock = mbxfb_get_pixclock(info->var.pixclock, &div);
 
-	writel((Disp_Pll_M(div.m) | Disp_Pll_N(div.n) |
+	write_reg_dly((Disp_Pll_M(div.m) | Disp_Pll_N(div.n) |
 		Disp_Pll_P(div.p) | DISP_PLL_EN), DISPPLL);
 
 	hbps = var->hsync_len;
@@ -282,18 +295,20 @@
 	vfps = vas + var->yres;
 	vt = vfps + var->lower_margin;
 
-	writel((Dht01_Hbps(hbps) | Dht01_Ht(ht)), DHT01);
-	writel((Dht02_Hlbs(has) | Dht02_Has(has)), DHT02);
-	writel((Dht03_Hfps(hfps) | Dht03_Hrbs(hfps)), DHT03);
-	writel((Dhdet_Hdes(has) | Dhdet_Hdef(hfps)), DHDET);
-
-	writel((Dvt01_Vbps(vbps) | Dvt01_Vt(vt)), DVT01);
-	writel((Dvt02_Vtbs(vas) | Dvt02_Vas(vas)), DVT02);
-	writel((Dvt03_Vfps(vfps) | Dvt03_Vbbs(vfps)), DVT03);
-	writel((Dvdet_Vdes(vas) | Dvdet_Vdef(vfps)), DVDET);
-	writel((Dvectrl_Vevent(vfps) | Dvectrl_Vfetch(vbps)), DVECTRL);
+	write_reg_dly((Dht01_Hbps(hbps) | Dht01_Ht(ht)), DHT01);
+	write_reg_dly((Dht02_Hlbs(has) | Dht02_Has(has)), DHT02);
+	write_reg_dly((Dht03_Hfps(hfps) | Dht03_Hrbs(hfps)), DHT03);
+	write_reg_dly((Dhdet_Hdes(has) | Dhdet_Hdef(hfps)), DHDET);
+
+	write_reg_dly((Dvt01_Vbps(vbps) | Dvt01_Vt(vt)), DVT01);
+	write_reg_dly((Dvt02_Vtbs(vas) | Dvt02_Vas(vas)), DVT02);
+	write_reg_dly((Dvt03_Vfps(vfps) | Dvt03_Vbbs(vfps)), DVT03);
+	write_reg_dly((Dvdet_Vdes(vas) | Dvdet_Vdef(vfps)), DVDET);
+	write_reg_dly((Dvectrl_Vevent(vfps) | Dvectrl_Vfetch(vbps)), DVECTRL);
+
+	write_reg_dly((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
 
-	writel((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
+	write_reg_dly(DINTRE_VEVENT0_EN, DINTRE);
 
 	return 0;
 }
@@ -305,23 +320,203 @@
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_NORMAL:
-		writel((readl(DSCTRL) & ~DSCTRL_SYNCGEN_EN), DSCTRL);
-		udelay(1000);
-		writel((readl(PIXCLK) & ~PIXCLK_EN), PIXCLK);
-		udelay(1000);
-		writel((readl(VOVRCLK) & ~VOVRCLK_EN), VOVRCLK);
-		udelay(1000);
+		write_reg_dly((readl(DSCTRL) & ~DSCTRL_SYNCGEN_EN), DSCTRL);
+		write_reg_dly((readl(PIXCLK) & ~PIXCLK_EN), PIXCLK);
+		write_reg_dly((readl(VOVRCLK) & ~VOVRCLK_EN), VOVRCLK);
 		break;
 	case FB_BLANK_UNBLANK:
-		writel((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
-		udelay(1000);
-		writel((readl(PIXCLK) | PIXCLK_EN), PIXCLK);
-		udelay(1000);
+		write_reg_dly((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
+		write_reg_dly((readl(PIXCLK) | PIXCLK_EN), PIXCLK);
 		break;
 	}
 	return 0;
 }
 
+static int mbxfb_setupOverlay(struct mbxfb_overlaySetup *set)
+{
+	u32 vsctrl, vbbase, vscadr, vsadr; 
+	u32 sssize, spoctrl, svctrl, shctrl;
+	u32 vubase, vvbase;
+	u32 vovrclk;
+	
+	if (set->scaled_width==0 || set->scaled_height==0)
+		return -EINVAL;
+
+	/* read registers which have reserved bits
+	 * so we can write them back as-is. */
+	vovrclk = readl(VOVRCLK);
+	vsctrl = readl(VSCTRL);
+	vscadr = readl(VSCADR);
+	vubase = readl(VUBASE);
+	vvbase = readl(VVBASE);
+	
+	spoctrl = readl(SPOCTRL);
+	sssize = readl(SSSIZE);
+
+	
+	vbbase = Vbbase_Glalpha(set->alpha);
+
+	vsctrl &= ~(	FMsk(VSCTRL_VSWIDTH) | 
+					FMsk(VSCTRL_VSHEIGHT) |
+					FMsk(VSCTRL_VPIXFMT) |
+					VSCTRL_GAMMA_EN | VSCTRL_CSC_EN |
+					VSCTRL_COSITED );
+	vsctrl |= Vsctrl_Width(set->width) | Vsctrl_Height(set->height) |
+				VSCTRL_CSC_EN;
+	
+	vscadr &= ~(VSCADR_STR_EN | VSCADR_COLKEY_EN | VSCADR_COLKEYSRC |
+				FMsk(VSCADR_BLEND_M) | FMsk(VSCADR_BLEND_POS) |
+				FMsk(VSCADR_VBASE_ADR) );
+	vubase &= ~(VUBASE_UVHALFSTR | FMsk(VUBASE_UBASE_ADR));
+	vvbase &= ~(FMsk(VVBASE_VBASE_ADR));
+	
+	switch (set->fmt)
+	{
+		case MBXFB_FMT_YUV12:
+			vsctrl |= VSCTRL_VPIXFMT_YUV12;
+
+			set->Y_stride = ((set->width) + 0xf ) & ~0xf;
+			
+			break;
+		case MBXFB_FMT_UY0VY1:
+			vsctrl |= VSCTRL_VPIXFMT_UY0VY1;
+			set->Y_stride = (set->width*2 + 0xf ) & ~0xf;
+			break;
+		case MBXFB_FMT_VY0UY1:
+			vsctrl |= VSCTRL_VPIXFMT_VY0UY1;
+			set->Y_stride = (set->width*2 + 0xf ) & ~0xf;
+			break;
+		case MBXFB_FMT_Y0UY1V:
+			vsctrl |= VSCTRL_VPIXFMT_Y0UY1V;
+			set->Y_stride = (set->width*2 + 0xf ) & ~0xf;
+			break;
+		case MBXFB_FMT_Y0VY1U:
+			vsctrl |= VSCTRL_VPIXFMT_Y0VY1U;
+			set->Y_stride = (set->width*2 + 0xf ) & ~0xf;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	/* VSCTRL has the bits which sets the Video Pixel Format. 
+	 * When passing from a packed to planar format, 
+	 * if we write VSCTRL first, VVBASE and VUBASE would
+	 * be zero if we would not set them here. (And then,
+	 * the chips hangs and only a reset seems to fix it).
+	 * 
+	 * If course, the values calculated here have no meaning 
+	 * for packed formats.
+	 */
+	set->UV_stride = ((set->width/2) + 0x7 ) & ~0x7;
+		set->U_offset = set->height * set->Y_stride;
+		set->V_offset = set->U_offset + 
+						set->height * set->UV_stride;
+	vubase |= Vubase_Ubase_Adr(
+			(0x60000 + set->mem_offset + set->U_offset)>>3);
+	vvbase |= Vvbase_Vbase_Adr(
+			(0x60000 + set->mem_offset + set->V_offset)>>3);
+
+	
+	vscadr |= VSCADR_BLEND_VID | VSCADR_BLEND_GLOB |
+		Vscadr_Vbase_Adr((0x60000 + set->mem_offset)>>4);
+	
+	if (set->enable)
+		vscadr |= VSCADR_STR_EN;
+
+	
+	vsadr = Vsadr_Srcstride((set->Y_stride)/16-1) |
+		Vsadr_Xstart(set->x) | Vsadr_Ystart(set->y);
+
+	sssize &= ~(FMsk(SSSIZE_SC_WIDTH) | FMsk(SSSIZE_SC_HEIGHT));
+	sssize = Sssize_Sc_Width(set->scaled_width-1) | 
+			Sssize_Sc_Height(set->scaled_height-1);	
+
+	spoctrl &= ~(SPOCTRL_H_SC_BP | SPOCTRL_V_SC_BP | 
+			SPOCTRL_HV_SC_OR | SPOCTRL_VS_UR_C | 
+			FMsk(SPOCTRL_VORDER) | FMsk(SPOCTRL_VPITCH));
+	spoctrl = Spoctrl_Vpitch((set->height<<11)/set->scaled_height) 
+							| SPOCTRL_VORDER_2TAP;
+
+	/* Bypass horiz/vert scaler when same size */
+	if (set->scaled_width == set->width)
+		spoctrl |= SPOCTRL_H_SC_BP;
+	if (set->scaled_height == set->height)
+		spoctrl |= SPOCTRL_V_SC_BP;
+
+	svctrl = Svctrl_Initial1(1<<10) | Svctrl_Initial2(1<<10);
+
+	shctrl = Shctrl_Hinitial(4<<11) 
+			| Shctrl_Hpitch((set->width<<11)/set->scaled_width);
+	
+	/* Video plane registers */	
+	write_reg(vsctrl, VSCTRL);
+	write_reg(vbbase, VBBASE);
+	write_reg(vscadr, VSCADR);
+	write_reg(vubase, VUBASE);
+	write_reg(vvbase, VVBASE);
+	write_reg(vsadr, VSADR);
+	
+	/* Video scaler registers */
+	write_reg(sssize, SSSIZE);
+	write_reg(spoctrl, SPOCTRL);
+	write_reg(svctrl, SVCTRL);
+	write_reg(shctrl, SHCTRL);
+
+	/* RAPH: Using those coefficients, the scaled
+	 * image is quite blurry. I dont know how
+	 * to improve them ; The chip documentation
+	 * was not helpful.. */
+	write_reg(0x21212121, VSCOEFF0);
+	write_reg(0x21212121, VSCOEFF1);
+	write_reg(0x21212121, VSCOEFF2);
+	write_reg(0x21212121, VSCOEFF3);
+	write_reg(0x21212121, VSCOEFF4);
+	write_reg(0x00000000, HSCOEFF0);
+	write_reg(0x00000000, HSCOEFF1);
+	write_reg(0x00000000, HSCOEFF2);
+	write_reg(0x03020201, HSCOEFF3);
+	write_reg(0x09070604, HSCOEFF4);
+	write_reg(0x0f0e0c0a, HSCOEFF5);
+	write_reg(0x15141211, HSCOEFF6);
+	write_reg(0x19181716, HSCOEFF7);
+	write_reg(0x00000019, HSCOEFF8);
+
+	/* Clock */
+	if (set->enable) 
+		vovrclk |= 1;
+	else
+		vovrclk &= ~1;
+
+	write_reg(vovrclk, VOVRCLK);
+
+	return 0;
+}
+
+static int mbxfb_ioctl(struct fb_info *info, unsigned int cmd,
+				unsigned long arg)
+{
+	struct mbxfb_overlaySetup setup;
+	int res;
+
+	if (cmd == MBXFB_IOCX_OVERLAY)
+	{
+		if (copy_from_user(&setup, (void __user*)arg,
+					sizeof(struct mbxfb_overlaySetup)))
+			return -EFAULT;
+
+		res = mbxfb_setupOverlay(&setup);	
+		if (res)
+			return res;
+
+		if (copy_to_user((void __user*)arg, &setup,
+					sizeof(struct mbxfb_overlaySetup)))
+			return -EFAULT;
+		
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static struct fb_ops mbxfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var = mbxfb_check_var,
@@ -331,6 +526,7 @@
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
 	.fb_blank = mbxfb_blank,
+	.fb_ioctl = mbxfb_ioctl,
 };
 
 /*
@@ -339,36 +535,29 @@
 */
 static void __devinit setup_memc(struct fb_info *fbi)
 {
-	struct mbxfb_info *mfbi = fbi->par;
 	unsigned long tmp;
 	int i;
 
 	/* FIXME: use platfrom specific parameters */
 	/* setup SDRAM controller */
-	writel((LMCFG_LMC_DS | LMCFG_LMC_TS | LMCFG_LMD_TS |
+	write_reg_dly((LMCFG_LMC_DS | LMCFG_LMC_TS | LMCFG_LMD_TS |
 		LMCFG_LMA_TS),
 	       LMCFG);
-	udelay(1000);
 
-	writel(LMPWR_MC_PWR_ACT, LMPWR);
-	udelay(1000);
+	write_reg_dly(LMPWR_MC_PWR_ACT, LMPWR);
 
 	/* setup SDRAM timings */
-	writel((Lmtim_Tras(7) | Lmtim_Trp(3) | Lmtim_Trcd(3) |
+	write_reg_dly((Lmtim_Tras(7) | Lmtim_Trp(3) | Lmtim_Trcd(3) |
 		Lmtim_Trc(9) | Lmtim_Tdpl(2)),
 	       LMTIM);
-	udelay(1000);
 	/* setup SDRAM refresh rate */
-	writel(0xc2b, LMREFRESH);
-	udelay(1000);
+	write_reg_dly(0xc2b, LMREFRESH);
 	/* setup SDRAM type parameters */
-	writel((LMTYPE_CASLAT_3 | LMTYPE_BKSZ_2 | LMTYPE_ROWSZ_11 |
+	write_reg_dly((LMTYPE_CASLAT_3 | LMTYPE_BKSZ_2 | LMTYPE_ROWSZ_11 |
 		LMTYPE_COLSZ_8),
 	       LMTYPE);
-	udelay(1000);
 	/* enable memory controller */
-	writel(LMPWR_MC_PWR_ACT, LMPWR);
-	udelay(1000);
+	write_reg_dly(LMPWR_MC_PWR_ACT, LMPWR);
 
 	/* perform dummy reads */
 	for ( i = 0; i < 16; i++ ) {
@@ -379,34 +568,30 @@
 static void enable_clocks(struct fb_info *fbi)
 {
 	/* enable clocks */
-	writel(SYSCLKSRC_PLL_2, SYSCLKSRC);
-	udelay(1000);
-	writel(PIXCLKSRC_PLL_1, PIXCLKSRC);
-	udelay(1000);
-	writel(0x00000000, CLKSLEEP);
-	udelay(1000);
-	writel((Core_Pll_M(0x17) | Core_Pll_N(0x3) | Core_Pll_P(0x0) |
+	write_reg_dly(SYSCLKSRC_PLL_2, SYSCLKSRC);
+	write_reg_dly(PIXCLKSRC_PLL_1, PIXCLKSRC);
+	write_reg_dly(0x00000000, CLKSLEEP);
+	
+	/* PLL output = (Frefclk * M) / (N * 2^P ) 
+	 *
+	 * M: 0x17, N: 0x3, P: 0x0 == 100 Mhz!
+	 * M: 0xb, N: 0x1, P: 0x1 == 71 Mhz
+	 * */
+	write_reg_dly((Core_Pll_M(0xb) | Core_Pll_N(0x1) | Core_Pll_P(0x1) |
 		CORE_PLL_EN),
 	       COREPLL);
-	udelay(1000);
-	writel((Disp_Pll_M(0x1b) | Disp_Pll_N(0x7) | Disp_Pll_P(0x1) |
+	
+	write_reg_dly((Disp_Pll_M(0x1b) | Disp_Pll_N(0x7) | Disp_Pll_P(0x1) |
 		DISP_PLL_EN),
 	       DISPPLL);
 
-	writel(0x00000000, VOVRCLK);
-	udelay(1000);
-	writel(PIXCLK_EN, PIXCLK);
-	udelay(1000);
-	writel(MEMCLK_EN, MEMCLK);
-	udelay(1000);
-	writel(0x00000006, M24CLK);
-	udelay(1000);
-	writel(0x00000006, MBXCLK);
-	udelay(1000);
-	writel(SDCLK_EN, SDCLK);
-	udelay(1000);
-	writel(0x00000001, PIXCLKDIV);
-	udelay(1000);
+	write_reg_dly(0x00000000, VOVRCLK);
+	write_reg_dly(PIXCLK_EN, PIXCLK);
+	write_reg_dly(MEMCLK_EN, MEMCLK);
+	write_reg_dly(0x00000006, M24CLK);
+	write_reg_dly(0x00000006, MBXCLK);
+	write_reg_dly(SDCLK_EN, SDCLK);
+	write_reg_dly(0x00000001, PIXCLKDIV);
 }
 
 static void __devinit setup_graphics(struct fb_info *fbi)
@@ -430,16 +615,11 @@
 		break;
 	}
 
-	writel(gsctrl, GSCTRL);
-	udelay(1000);
-	writel(0x00000000, GBBASE);
-	udelay(1000);
-	writel(0x00ffffff, GDRCTRL);
-	udelay(1000);
-	writel((GSCADR_STR_EN | Gscadr_Gbase_Adr(0x6000)), GSCADR);
-	udelay(1000);
-	writel(0x00000000, GPLUT);
-	udelay(1000);
+	write_reg_dly(gsctrl, GSCTRL);
+	write_reg_dly(0x00000000, GBBASE);
+	write_reg_dly(0x00ffffff, GDRCTRL);
+	write_reg_dly((GSCADR_STR_EN | Gscadr_Gbase_Adr(0x6000)), GSCADR);
+	write_reg_dly(0x00000000, GPLUT);
 }
 
 static void __devinit setup_display(struct fb_info *fbi)
@@ -451,17 +631,14 @@
 		dsctrl |= DSCTRL_HS_POL;
 	if (fbi->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		dsctrl |= DSCTRL_VS_POL;
-	writel(dsctrl, DSCTRL);
-	udelay(1000);
-	writel(0xd0303010, DMCTRL);
-	udelay(1000);
-	writel((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
+	write_reg_dly(dsctrl, DSCTRL);
+	write_reg_dly(0xd0303010, DMCTRL);
+	write_reg_dly((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
 }
 
 static void __devinit enable_controller(struct fb_info *fbi)
 {
-	writel(SYSRST_RST, SYSRST);
-	udelay(1000);
+	write_reg_dly(SYSRST_RST, SYSRST);
 
 
 	enable_clocks(fbi);
@@ -478,12 +655,12 @@
 static int mbxfb_suspend(struct platform_device *dev, pm_message_t state)
 {
 	/* make frame buffer memory enter self-refresh mode */
-	writel(LMPWR_MC_PWR_SRM, LMPWR);
+	write_reg_dly(LMPWR_MC_PWR_SRM, LMPWR);
 	while (LMPWRSTAT != LMPWRSTAT_MC_PWR_SRM)
 		; /* empty statement */
 
 	/* reset the device, since it's initial state is 'mostly sleeping' */
-	writel(SYSRST_RST, SYSRST);
+	write_reg_dly(SYSRST_RST, SYSRST);
 	return 0;
 }
 
@@ -495,7 +672,7 @@
 /* 	setup_graphics(fbi); */
 /* 	setup_display(fbi); */
 
-	writel((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
+	write_reg_dly((readl(DSCTRL) | DSCTRL_SYNCGEN_EN), DSCTRL);
 	return 0;
 }
 #else
@@ -520,6 +697,12 @@
 
 	dev_dbg(dev, "mbxfb_probe\n");
 
+	pdata = dev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&dev->dev, "platform data is required\n");
+		return -EINVAL;
+	}
+	
 	fbi = framebuffer_alloc(sizeof(struct mbxfb_info), &dev->dev);
 	if (fbi == NULL) {
 		dev_err(&dev->dev, "framebuffer_alloc failed\n");
@@ -528,7 +711,8 @@
 
 	mfbi = fbi->par;
 	fbi->pseudo_palette = mfbi->pseudo_palette;
-	pdata = dev->dev.platform_data;
+
+
 	if (pdata->probe)
 		mfbi->platform_probe = pdata->probe;
 	if (pdata->remove)
@@ -569,7 +753,7 @@
 		goto err3;
 	}
 	virt_base_2700 = (unsigned long)mfbi->reg_virt_addr;
-
+	
 	mfbi->fb_virt_addr = ioremap_nocache(mfbi->fb_phys_addr,
 					     res_size(mfbi->fb_req));
 	if (!mfbi->reg_virt_addr) {
@@ -578,16 +762,16 @@
 		goto err4;
 	}
 
-	/* FIXME: get from platform */
 	fbi->screen_base = (char __iomem *)(mfbi->fb_virt_addr + 0x60000);
-	fbi->screen_size = 8 * 1024 * 1024;	/* 8 Megs */
+	fbi->screen_size = pdata->memsize;
 	fbi->fbops = &mbxfb_ops;
 
 	fbi->var = mbxfb_default;
 	fbi->fix = mbxfb_fix;
 	fbi->fix.smem_start = mfbi->fb_phys_addr + 0x60000;
-	fbi->fix.smem_len = 8 * 1024 * 1024;
-	fbi->fix.line_length = 640 * 2;
+	fbi->fix.smem_len = pdata->memsize;
+	fbi->fix.line_length = mbxfb_default.xres_virtual * 
+					mbxfb_default.bits_per_pixel / 8;
 
 	ret = fb_alloc_cmap(&fbi->cmap, 256, 0);
 	if (ret < 0) {
@@ -636,8 +820,7 @@
 {
 	struct fb_info *fbi = platform_get_drvdata(dev);
 
-	writel(SYSRST_RST, SYSRST);
-	udelay(1000);
+	write_reg_dly(SYSRST_RST, SYSRST);
 
 	mbxfb_debugfs_remove(fbi);
 
--- linux-2.6.18-rc2-mbx/include/video/mbxfb.h	2006-09-01 16:11:25.000000000 -0400
+++ linux-2.6.18-rc2-8d2/include/video/mbxfb.h	2006-09-05 10:26:31.000000000 -0400
@@ -1,6 +1,9 @@
 #ifndef __MBX_FB_H
 #define __MBX_FB_H
 
+#include <asm/ioctl.h>
+#include <asm/types.h>
+
 struct mbxfb_val {
 	unsigned int	defval;
 	unsigned int	min;
@@ -25,4 +28,32 @@
 		int (*remove)(struct fb_info *fb);
 };
 
+/* planar */
+#define MBXFB_FMT_YUV12		0 
+
+/* packed */
+#define MBXFB_FMT_UY0VY1	1
+#define MBXFB_FMT_VY0UY1	2
+#define MBXFB_FMT_Y0UY1V	3
+#define MBXFB_FMT_Y0VY1U	4
+struct mbxfb_overlaySetup {
+	__u32 enable;
+	__u32 x, y;
+	__u32 width, height;
+	__u32 alpha;
+	__u32 fmt;
+	__u32 mem_offset;
+	__u32 scaled_width;
+	__u32 scaled_height;
+	
+	/* Filled by the driver */
+	__u32 U_offset;
+	__u32 V_offset;
+
+	__u16 Y_stride;
+	__u16 UV_stride;
+};
+
+#define MBXFB_IOCX_OVERLAY	_IOWR(0xF4, 0x00,struct mbxfb_overlaySetup)
+
 #endif /* __MBX_FB_H */

--------------040001090207080309050903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------040001090207080309050903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------040001090207080309050903--
