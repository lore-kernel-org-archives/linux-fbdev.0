From: Claudio Ciccani <klan@users.sf.net>
Subject: radeonfb and newer radeons (Patch)
Date: Sat, 22 Jul 2006 17:04:51 +0200
Message-ID: <44C23E93.2000805@users.sf.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020400030202040500040605"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G4J2Q-0006Pw-Hg for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 08:05:06 -0700
Received: from smtp.cheapnet.it ([62.94.8.244])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G4J2N-0005hR-Cj
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Jul 2006 08:05:06 -0700
Received: from unknown (HELO [62.94.131.171]) ([62.94.131.171])
	(envelope-sender <klan@users.sf.net>)
	by smtp.cheapnet.it (qmail-ldap-1.03) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	22 Jul 2006 17:04:53 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020400030202040500040605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
the attached patch fixes some issues with R300 based chipsets and
adds support for a number of new devices (mostly X800/X850).
It also enlarges the mmio size to 0x8000 because many 3d registers
of the R300 are located after offset 0x4000 and we need them for
DirectFB (DRI needs too).
The patch applies to linux-2.6.18-rc2, hope there have not been changes
in the meanwhile.

-- 
Regards,
     Claudio Ciccani

klan@users.sf.net
http://directfb.org
http://sf.net/projects/php-directfb


--------------020400030202040500040605
Content-Type: text/x-patch;
 name="radeonfb-r300fix-2.6.18-rc2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb-r300fix-2.6.18-rc2.patch"

--- linux-2.6.18-rc2/drivers/video/aty/radeon_accel.c	2006-01-03 04:21:10.000000000 +0100
+++ /usr/src/linux-2.6.18-rc2/drivers/video/aty/radeon_accel.c	2006-07-22 12:49:43.000000000 +0200
@@ -203,9 +203,7 @@
 	host_path_cntl = INREG(HOST_PATH_CNTL);
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo)) {
 		u32 tmp;
 
 		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
@@ -241,9 +239,7 @@
 	INREG(HOST_PATH_CNTL);
 	OUTREG(HOST_PATH_CNTL, host_path_cntl);
 
-	if (rinfo->family != CHIP_FAMILY_R300 ||
-	    rinfo->family != CHIP_FAMILY_R350 ||
-	    rinfo->family != CHIP_FAMILY_RV350)
+	if (IS_R300_VARIANT(rinfo))
 		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
 
 	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
@@ -254,16 +250,14 @@
 {
 	unsigned long temp;
 
-	/* disable 3D engine */
-	OUTREG(RB3D_CNTL, 0);
-
 	radeonfb_engine_reset(rinfo);
 
 	radeon_fifo_wait (1);
-	if ((rinfo->family != CHIP_FAMILY_R300) &&
-	    (rinfo->family != CHIP_FAMILY_R350) &&
-	    (rinfo->family != CHIP_FAMILY_RV350))
+	if (IS_R300_VARIANT(rinfo)) {
+		//OUTREG(RB2D_DSTCACHE_MODE, 1<<17);
+	} else {
 		OUTREG(RB2D_DSTCACHE_MODE, 0);
+	}
 
 	radeon_fifo_wait (3);
 	/* We re-read MC_FB_LOCATION from card as it can have been
--- linux-2.6.18-rc2/drivers/video/aty/radeon_base.c	2006-07-22 12:41:58.000000000 +0200
+++ /usr/src/linux-2.6.18-rc2/drivers/video/aty/radeon_base.c	2006-07-22 14:24:30.000000000 +0200
@@ -91,7 +91,10 @@
 
 #include "../edid.h" // MOVE THAT TO include/video
 #include "ati_ids.h"
-#include "radeonfb.h"		    
+#include "radeonfb.h"
+
+/* Sorry, we have to limit video ram to 128M */
+#define MAX_VRAM		(128*1024*1024)
 
 #define MAX_MAPPED_VRAM	(2048*2048*4)
 #define MIN_MAPPED_VRAM	(1024*768*1)
@@ -177,6 +180,7 @@
 	/* 9600/FireGL T2 */
 	CHIP_DEF(PCI_CHIP_RV350_AP,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AQ,	RV350,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV350_AU, 	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV360_AR,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AS,	RV350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV350_AT,	RV350,	CHIP_HAS_CRTC2),
@@ -190,7 +194,7 @@
 	CHIP_DEF(PCI_CHIP_R350_NI,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R360_NJ,	R350,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R350_NK,	R350,	CHIP_HAS_CRTC2),
-	/* Newer stuff */
+	/* X300/X600 */
 	CHIP_DEF(PCI_CHIP_RV380_3E50,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV380_3E54,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV380_3150,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
@@ -201,6 +205,19 @@
 	CHIP_DEF(PCI_CHIP_RV370_5B65,	RV380,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV370_5460,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_RV370_5464,	RV380,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	/* X700 */
+	CHIP_DEF(PCI_CHIP_RV410_VJ, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VK, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VO, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VR, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_VS, 	RV410,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RV410_5E48,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4A,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4B,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4C,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4D,	RV410,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RV410_5E4F,	RV410,	CHIP_HAS_CRTC2),
+	/* X800/X850 */
 	CHIP_DEF(PCI_CHIP_R420_JH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JI,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JJ,	R420,	CHIP_HAS_CRTC2),
@@ -209,6 +226,8 @@
 	CHIP_DEF(PCI_CHIP_R420_JM,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R420_JN,	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	CHIP_DEF(PCI_CHIP_R420_JP,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JO, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R420_JT, 	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UH,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UI,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UJ,	R420,	CHIP_HAS_CRTC2),
@@ -217,6 +236,24 @@
 	CHIP_DEF(PCI_CHIP_R423_UR,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_UT,	R420,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_R423_5D57,	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UP, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_5D49, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_5D4A, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_5D48, 	R420,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_R423_UO, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UM, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UN, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R423_UL, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4C, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D50, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4E, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4F, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D52, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_5D4D, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KJ, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KK,    R420,     CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KI, 	R420,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_R480_KL, 	R420,	CHIP_HAS_CRTC2),
 	/* Original Radeon/7200 */
 	CHIP_DEF(PCI_CHIP_RADEON_QD,	RADEON,	0),
 	CHIP_DEF(PCI_CHIP_RADEON_QE,	RADEON,	0),
@@ -442,7 +479,7 @@
 {
 	unsigned char ppll_div_sel;
 	unsigned Ns, Nm, M;
-	unsigned sclk, mclk, tmp, ref_div;
+	unsigned sclk, mclk, tmp;
 	int hTotal, vTotal, num, denom, m, n;
 	unsigned long long hz, vclk;
 	long xtal;
@@ -514,7 +551,7 @@
 	radeon_pll_errata_after_index(rinfo);
 
 	n = (INPLL(PPLL_DIV_0 + ppll_div_sel) & 0x7ff);
-	m = (INPLL(PPLL_REF_DIV) & 0x3ff);
+	m = rinfo->pll.ref_div;
 
 	num *= n;
 	denom *= m;
@@ -556,8 +593,6 @@
 	}
 
 	tmp = INPLL(M_SPLL_REF_FB_DIV);
-	ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
-
 	Ns = (tmp & 0xff0000) >> 16;
 	Nm = (tmp & 0xff00) >> 8;
 	M = (tmp & 0xff);
@@ -566,7 +601,6 @@
 
 	/* we're done, hopefully these are sane values */
 	rinfo->pll.ref_clk = xtal;
-	rinfo->pll.ref_div = ref_div;
 	rinfo->pll.sclk = sclk;
 	rinfo->pll.mclk = mclk;
 
@@ -578,6 +612,8 @@
  */
 static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
+	__u32 tmp;
+	
 	/*
 	 * In the case nothing works, these are defaults; they are mostly
 	 * incomplete, however.  It does provide ppll_max and _min values
@@ -635,8 +671,16 @@
 		rinfo->pll.ref_clk = 2700;
 		break;
 	}
-	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK;
-
+	tmp = INPLL(PPLL_REF_DIV);
+	if (IS_R300_VARIANT(rinfo) || rinfo->family == CHIP_FAMILY_RS300)
+		rinfo->pll.ref_div = (tmp & R300_PPLL_REF_DIV_ACC_MASK) >> R300_PPLL_REF_DIV_ACC_SHIFT;
+	else
+		rinfo->pll.ref_div = (tmp & PPLL_REF_DIV_MASK);
+	
+	printk(KERN_INFO "radeonfb: PLL RefDiv=%d (from regs)\n", rinfo->pll.ref_div);
+	
+	if (rinfo->pll.ref_div == 0)
+		rinfo->pll.ref_div = 12;
 
 #ifdef CONFIG_PPC_OF
 	/*
@@ -652,15 +696,39 @@
 	 * Check out if we have an X86 which gave us some PLL informations
 	 * and if yes, retrieve them
 	 */
-	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
-
-		rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
+	if (!force_measure_pll && rinfo->bios_seg && rinfo->fp_bios_start) {
+		u16 pll_info_block;
+		
+		if ((BIOS_IN8(rinfo->fp_bios_start+4) == 'A' &&
+			 BIOS_IN8(rinfo->fp_bios_start+5) == 'T' &&
+			 BIOS_IN8(rinfo->fp_bios_start+6) == 'O' &&
+			 BIOS_IN8(rinfo->fp_bios_start+7) == 'M') ||
+			(BIOS_IN8(rinfo->fp_bios_start+4) == 'M' &&
+			 BIOS_IN8(rinfo->fp_bios_start+5) == 'O' &&
+			 BIOS_IN8(rinfo->fp_bios_start+6) == 'T' &&
+			 BIOS_IN8(rinfo->fp_bios_start+7) == 'A'))
+		{
+			printk(KERN_INFO "radeonfb: Detected ATOM BIOS\n");
+
+			pll_info_block = BIOS_IN16(BIOS_IN16(rinfo->fp_bios_start+32) + 12);
+
+			rinfo->pll.sclk	= BIOS_IN32(pll_info_block + 0x08);
+			rinfo->pll.mclk	= BIOS_IN32(pll_info_block + 0x0c);
+			rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x52);
+			/* no PLL ref div */
+			rinfo->pll.ppll_min	= BIOS_IN16(pll_info_block + 0x4e);
+			rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x20);	
+		}
+		else {
+			pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
+			
+			rinfo->pll.sclk	= BIOS_IN16(pll_info_block + 0x08);
+			rinfo->pll.mclk	= BIOS_IN16(pll_info_block + 0x0a);
+			rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
+			rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
+			rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
+			rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
+		}
 
 		printk(KERN_INFO "radeonfb: Retrieved PLL infos from BIOS\n");
 		goto found;
@@ -837,7 +905,7 @@
         if (rinfo->asleep)
         	return 0;
 
-	radeon_fifo_wait(2);
+	radeon_engine_idle();
         OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xoffset)
 			     * var->bits_per_pixel / 8) & ~7);
         return 0;
@@ -1272,10 +1340,7 @@
 	radeon_pll_errata_after_data(rinfo);
 
 	/* Set PPLL ref. div */
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_RS300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (IS_R300_VARIANT(rinfo) || rinfo->family == CHIP_FAMILY_RS300) {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
 			/* When restoring console mode, use saved PPLL_REF_DIV
 			 * setting.
@@ -1372,6 +1437,7 @@
 	OUTREG(CRTC_OFFSET_CNTL, 0);
 	OUTREG(CRTC_PITCH, mode->crtc_pitch);
 	OUTREG(SURFACE_CNTL, mode->surface_cntl);
+	OUTREG(DISP_MERGE_CNTL, 0xffff0000);
 
 	radeon_write_pll_regs(rinfo, mode);
 
@@ -1986,9 +2052,7 @@
 	u32 tmp;
 
 	/* framebuffer size */
-        if ((rinfo->family == CHIP_FAMILY_RS100) ||
-            (rinfo->family == CHIP_FAMILY_RS200) ||
-            (rinfo->family == CHIP_FAMILY_RS300)) {
+        if (rinfo->is_IGP) {
           u32 tom = INREG(NB_TOM);
           tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
 
@@ -2013,8 +2077,9 @@
           tmp = INREG(CONFIG_MEMSIZE);
         }
 
-	/* mem size is bits [28:0], mask off the rest */
-	rinfo->video_ram = tmp & CONFIG_MEMSIZE_MASK;
+	rinfo->video_ram = tmp;
+	if (rinfo->video_ram > MAX_VRAM)
+		rinfo->video_ram = MAX_VRAM;
 
 	/*
 	 * Hack to get around some busted production M6's
@@ -2273,25 +2338,26 @@
 	 * archs who would store that elsewhere and/or could initialize
 	 * more than one adapter during boot).
 	 */
-	if (!rinfo->is_mobility)
+	if (!rinfo->is_mobility) {
 		radeon_map_ROM(rinfo, pdev);
-
-	/*
-	 * On x86, the primary display on laptop may have it's BIOS
-	 * ROM elsewhere, try to locate it at the legacy memory hole.
-	 * We probably need to make sure this is the primary display,
-	 * but that is difficult without some arch support.
-	 */
+	}
+	else {
+		/*
+	 	 * On x86, the primary display on laptop may have it's BIOS
+	 	 * ROM elsewhere, try to locate it at the legacy memory hole.
+	 	 * We probably need to make sure this is the primary display,
+	 	 * but that is difficult without some arch support.
+	 	*/
 #ifdef CONFIG_X86
-	if (rinfo->bios_seg == NULL)
 		radeon_find_mem_vbios(rinfo);
 #endif
 
-	/* If both above failed, try the BIOS ROM again for mobility
-	 * chips
-	 */
-	if (rinfo->bios_seg == NULL && rinfo->is_mobility)
-		radeon_map_ROM(rinfo, pdev);
+		/* If both above failed, try the BIOS ROM again for mobility
+	 	 * chips
+		 */
+		if (rinfo->bios_seg == NULL)
+			radeon_map_ROM(rinfo, pdev);
+	}
 
 	/* Get informations about the board's PLL */
 	radeon_get_pllinfo(rinfo);
@@ -2461,6 +2527,8 @@
 
 		if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
+		} else if (!strncmp( this_opt, "default_dynclk:", 15)) {
+			default_dynclk = simple_strtoul((this_opt+15), NULL, 10);
 		} else if (!strncmp(this_opt, "mirror", 6)) {
 			mirror = 1;
 		} else if (!strncmp(this_opt, "force_dfp", 9)) {
--- linux-2.6.18-rc2/drivers/video/aty/ati_ids.h	2006-01-03 04:21:10.000000000 +0100
+++ /usr/src/linux-2.6.18-rc2/drivers/video/aty/ati_ids.h	2006-07-22 12:49:43.000000000 +0200
@@ -31,6 +31,7 @@
 #define PCI_CHIP_RV360_AR               0x4152
 #define PCI_CHIP_RV350_AS               0x4153
 #define PCI_CHIP_RV350_AT               0x4154
+#define PCI_CHIP_RV350_AU 			0x4155
 #define PCI_CHIP_RV350_AV               0x4156
 #define PCI_CHIP_MACH32			0x4158
 #define PCI_CHIP_RS250_4237		0x4237
@@ -64,14 +65,20 @@
 #define PCI_CHIP_RV250_Ie		0x4965
 #define PCI_CHIP_RV250_If		0x4966
 #define PCI_CHIP_RV250_Ig		0x4967
-#define PCI_CHIP_R420_JH                0x4A48
-#define PCI_CHIP_R420_JI                0x4A49
-#define PCI_CHIP_R420_JJ                0x4A4A
-#define PCI_CHIP_R420_JK                0x4A4B
-#define PCI_CHIP_R420_JL                0x4A4C
-#define PCI_CHIP_R420_JM                0x4A4D
-#define PCI_CHIP_R420_JN                0x4A4E
-#define PCI_CHIP_R420_JP                0x4A50
+#define PCI_CHIP_R420_JH           0x4A48
+#define PCI_CHIP_R420_JI           0x4A49
+#define PCI_CHIP_R420_JJ           0x4A4A
+#define PCI_CHIP_R420_JK           0x4A4B
+#define PCI_CHIP_R420_JL           0x4A4C
+#define PCI_CHIP_R420_JM           0x4A4D
+#define PCI_CHIP_R420_JN           0x4A4E
+#define PCI_CHIP_R420_JO 		0x4A4F
+#define PCI_CHIP_R420_JP           0x4A50
+#define PCI_CHIP_R420_JT 		0x4A54
+#define PCI_CHIP_R480_KI 		0x4B49
+#define PCI_CHIP_R480_KJ 		0x4B4A
+#define PCI_CHIP_R480_KK           0x4B4B
+#define PCI_CHIP_R480_KL 		0x4B4C
 #define PCI_CHIP_MACH64LB		0x4C42
 #define PCI_CHIP_MACH64LD		0x4C44
 #define PCI_CHIP_RAGE128LE		0x4C45
@@ -178,20 +185,30 @@
 #define PCI_CHIP_RV370_5465             0x5465
 #define PCI_CHIP_RV370_5466             0x5466
 #define PCI_CHIP_RV370_5467             0x5467
+#define PCI_CHIP_R423_UP 			0x5550
 #define PCI_CHIP_R423_UH                0x5548
 #define PCI_CHIP_R423_UI                0x5549
 #define PCI_CHIP_R423_UJ                0x554A
 #define PCI_CHIP_R423_UK                0x554B
+#define PCI_CHIP_R423_UL 			0x554C
+#define PCI_CHIP_R423_UM 			0x554D
+#define PCI_CHIP_R423_UN 			0x554E
+#define PCI_CHIP_R423_UO 			0x554F
 #define PCI_CHIP_R423_UQ                0x5551
 #define PCI_CHIP_R423_UR                0x5552
 #define PCI_CHIP_R423_UT                0x5554
-#define PCI_CHIP_MACH64VT		0x5654
-#define PCI_CHIP_MACH64VU		0x5655
-#define PCI_CHIP_MACH64VV		0x5656
-#define PCI_CHIP_RS300_5834		0x5834
-#define PCI_CHIP_RS300_5835		0x5835
-#define PCI_CHIP_RS300_5836		0x5836
-#define PCI_CHIP_RS300_5837		0x5837
+#define PCI_CHIP_RV410_VJ 			0x564A
+#define PCI_CHIP_RV410_VK 			0x564B
+#define PCI_CHIP_RV410_VO 			0x564F
+#define PCI_CHIP_RV410_VR 			0x5652
+#define PCI_CHIP_RV410_VS 			0x5653
+#define PCI_CHIP_MACH64VT			0x5654
+#define PCI_CHIP_MACH64VU			0x5655
+#define PCI_CHIP_MACH64VV			0x5656
+#define PCI_CHIP_RS300_5834			0x5834
+#define PCI_CHIP_RS300_5835			0x5835
+#define PCI_CHIP_RS300_5836			0x5836
+#define PCI_CHIP_RS300_5837			0x5837
 #define PCI_CHIP_RV370_5B60             0x5B60
 #define PCI_CHIP_RV370_5B61             0x5B61
 #define PCI_CHIP_RV370_5B62             0x5B62
@@ -200,13 +217,28 @@
 #define PCI_CHIP_RV370_5B65             0x5B65
 #define PCI_CHIP_RV370_5B66             0x5B66
 #define PCI_CHIP_RV370_5B67             0x5B67
-#define PCI_CHIP_RV280_5960		0x5960
-#define PCI_CHIP_RV280_5961		0x5961
-#define PCI_CHIP_RV280_5962		0x5962
-#define PCI_CHIP_RV280_5964		0x5964
-#define PCI_CHIP_RV280_5C61		0x5C61
-#define PCI_CHIP_RV280_5C63		0x5C63
+#define PCI_CHIP_RV280_5960			0x5960
+#define PCI_CHIP_RV280_5961			0x5961
+#define PCI_CHIP_RV280_5962			0x5962
+#define PCI_CHIP_RV280_5964			0x5964
+#define PCI_CHIP_RV280_5C61			0x5C61
+#define PCI_CHIP_RV280_5C63			0x5C63
+#define PCI_CHIP_R423_5D48 			0x5D48
+#define PCI_CHIP_R423_5D49 			0x5D49
+#define PCI_CHIP_R423_5D4A 			0x5D4A
+#define PCI_CHIP_R480_5D4C 			0x5D4C
+#define PCI_CHIP_R480_5D4D 			0x5D4D
+#define PCI_CHIP_R480_5D4E 			0x5D4E
+#define PCI_CHIP_R480_5D4F 			0x5D4F
+#define PCI_CHIP_R480_5D50 			0x5D50
+#define PCI_CHIP_R480_5D52 			0x5D52
 #define PCI_CHIP_R423_5D57              0x5D57
+#define PCI_CHIP_RV410_5E48 			0x5E48
+#define PCI_CHIP_RV410_5E4A 			0x5E4A
+#define PCI_CHIP_RV410_5E4B 			0x5E4B
+#define PCI_CHIP_RV410_5E4C 			0x5E4C
+#define PCI_CHIP_RV410_5E4D 			0x5E4D
+#define PCI_CHIP_RV410_5E4F 			0x5E4F
 #define PCI_CHIP_RS350_7834             0x7834
 #define PCI_CHIP_RS350_7835             0x7835
 
--- linux-2.6.18-rc2/drivers/video/aty/radeonfb.h	2006-07-22 12:41:58.000000000 +0200
+++ /usr/src/linux-2.6.18-rc2/drivers/video/aty/radeonfb.h	2006-07-22 12:53:24.000000000 +0200
@@ -47,7 +47,8 @@
 	CHIP_FAMILY_R350,
 	CHIP_FAMILY_RV350,
 	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
-	CHIP_FAMILY_R420,     /* R420/R423/M18 */
+	CHIP_FAMILY_RV410,
+	CHIP_FAMILY_R420,     /* R420/R423/R480/M18 */
 	CHIP_FAMILY_LAST,
 };
 
@@ -64,6 +65,7 @@
 				((rinfo)->family == CHIP_FAMILY_RV350) || \
 				((rinfo)->family == CHIP_FAMILY_R350)  || \
 				((rinfo)->family == CHIP_FAMILY_RV380) || \
+				((rinfo)->family == CHIP_FAMILY_RV410) || \
 				((rinfo)->family == CHIP_FAMILY_R420))
 
 /*
--- linux-2.6.18-rc2/include/video/radeon.h	2006-01-03 04:21:10.000000000 +0100
+++ /usr/src/linux-2.6.18-rc2/include/video/radeon.h	2006-07-22 12:49:43.000000000 +0200
@@ -2,7 +2,7 @@
 #define _RADEON_H
 
 
-#define RADEON_REGSIZE			0x4000
+#define RADEON_REGSIZE			0x8000
 
 
 #define MM_INDEX                               0x0000  


--------------020400030202040500040605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020400030202040500040605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------020400030202040500040605--
