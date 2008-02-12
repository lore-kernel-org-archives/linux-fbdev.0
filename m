From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH 3/3] radeonfb: Drop redundant RTRACE
	macro
Date: Tue, 12 Feb 2008 10:27:31 +0100
Message-ID: <20080212102731.0dde4457@hyperion.delvare>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOrQM-0001Z7-F6 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 01:27:35 -0800
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JOrQL-0005AL-AT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Feb 2008 01:27:34 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

RTRACE() does exact the same thing as the standard pr_debug() call, so
just use the latter.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
This patch was already sent on:
 * 2007-11-17

 drivers/video/aty/radeon_base.c    |   34 +++++++++++-----------
 drivers/video/aty/radeon_i2c.c     |    8 ++---
 drivers/video/aty/radeon_monitor.c |   54 ++++++++++++++++++------------------
 drivers/video/aty/radeonfb.h       |   10 ------
 4 files changed, 48 insertions(+), 58 deletions(-)

--- linux-2.6.24-rc3.orig/drivers/video/aty/radeon_base.c	2007-11-27 09:54:14.000000000 +0100
+++ linux-2.6.24-rc3/drivers/video/aty/radeon_base.c	2007-11-27 09:54:14.000000000 +0100
@@ -1489,7 +1489,7 @@ static void radeon_calc_pll_regs(struct 
 		freq = rinfo->pll.ppll_max;
 	if (freq*12 < rinfo->pll.ppll_min)
 		freq = rinfo->pll.ppll_min / 12;
-	RTRACE("freq = %lu, PLL min = %u, PLL max = %u\n",
+	pr_debug("freq = %lu, PLL min = %u, PLL max = %u\n",
 	       freq, rinfo->pll.ppll_min, rinfo->pll.ppll_max);
 
 	for (post_div = &post_divs[0]; post_div->divider; ++post_div) {
@@ -1510,7 +1510,7 @@ static void radeon_calc_pll_regs(struct 
 		post_div = &post_divs[post_div->bitvalue];
 		pll_output_freq = post_div->divider * freq;
 	}
-	RTRACE("ref_div = %d, ref_clk = %d, output_freq = %d\n",
+	pr_debug("ref_div = %d, ref_clk = %d, output_freq = %d\n",
 	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
 	       pll_output_freq);
 
@@ -1520,7 +1520,7 @@ static void radeon_calc_pll_regs(struct 
 		post_div = &post_divs[post_div->bitvalue];
 		pll_output_freq = post_div->divider * freq;
 	}
-	RTRACE("ref_div = %d, ref_clk = %d, output_freq = %d\n",
+	pr_debug("ref_div = %d, ref_clk = %d, output_freq = %d\n",
 	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
 	       pll_output_freq);
 
@@ -1529,9 +1529,9 @@ static void radeon_calc_pll_regs(struct 
 	regs->ppll_ref_div = rinfo->pll.ref_div;
 	regs->ppll_div_3 = fb_div | (post_div->bitvalue << 16);
 
-	RTRACE("post div = 0x%x\n", post_div->bitvalue);
-	RTRACE("fb_div = 0x%x\n", fb_div);
-	RTRACE("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
+	pr_debug("post div = 0x%x\n", post_div->bitvalue);
+	pr_debug("fb_div = 0x%x\n", fb_div);
+	pr_debug("ppll_div_3 = 0x%x\n", regs->ppll_div_3);
 }
 
 static int radeonfb_set_par(struct fb_info *info)
@@ -1603,9 +1603,9 @@ static int radeonfb_set_par(struct fb_in
 	dotClock = 1000000000 / pixClock;
 	freq = dotClock / 10; /* x100 */
 
-	RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
+	pr_debug("hStart = %d, hEnd = %d, hTotal = %d\n",
 		hSyncStart, hSyncEnd, hTotal);
-	RTRACE("vStart = %d, vEnd = %d, vTotal = %d\n",
+	pr_debug("vStart = %d, vEnd = %d, vTotal = %d\n",
 		vSyncStart, vSyncEnd, vTotal);
 
 	hsync_wid = (hSyncEnd - hSyncStart) / 8;
@@ -1714,16 +1714,16 @@ static int radeonfb_set_par(struct fb_in
 		newmode->surf_info[i] = 0;
 	}
 
-	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
+	pr_debug("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
 		newmode->crtc_h_total_disp, newmode->crtc_h_sync_strt_wid);
-	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
+	pr_debug("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
 		newmode->crtc_v_total_disp, newmode->crtc_v_sync_strt_wid);
 
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
 
-	RTRACE("pixclock = %lu\n", (unsigned long)pixClock);
-	RTRACE("freq = %lu\n", (unsigned long)freq);
+	pr_debug("pixclock = %lu\n", (unsigned long)pixClock);
+	pr_debug("freq = %lu\n", (unsigned long)freq);
 
 	/* We use PPLL_DIV_3 */
 	newmode->clk_cntl_index = 0x300;
@@ -1987,7 +1987,7 @@ static void fixup_memory_mappings(struct
 	if (rinfo->has_CRTC2)
 		OUTREG(CRTC2_GEN_CNTL, save_crtc2_gen_cntl);	
 
-	RTRACE("aper_base: %08x MC_FB_LOC to: %08x, MC_AGP_LOC to: %08x\n",
+	pr_debug("aper_base: %08x MC_FB_LOC to: %08x, MC_AGP_LOC to: %08x\n",
 		aper_base,
 		((aper_base + aper_size - 1) & 0xffff0000) | (aper_base >> 16),
 		0xffff0000 | (agp_base >> 16));
@@ -2084,7 +2084,7 @@ static void radeon_identify_vram(struct 
 	 * ToDo: identify these cases
 	 */
 
-	RTRACE("radeonfb (%s): Found %ldk of %s %d bits wide videoram\n",
+	pr_debug("radeonfb (%s): Found %ldk of %s %d bits wide videoram\n",
 	       pci_name(rinfo->pdev),
 	       rinfo->video_ram / 1024,
 	       rinfo->vram_ddr ? "DDR" : "SDRAM",
@@ -2160,7 +2160,7 @@ static int __devinit radeonfb_pci_regist
 	struct radeonfb_info *rinfo;
 	int ret;
 
-	RTRACE("radeonfb_pci_register BEGIN\n");
+	pr_debug("radeonfb_pci_register BEGIN\n");
 	
 	/* Enable device in PCI config */
 	ret = pci_enable_device(pdev);
@@ -2279,7 +2279,7 @@ static int __devinit radeonfb_pci_regist
 		goto err_unmap_rom;
 	}
 
-	RTRACE("radeonfb (%s): mapped %ldk videoram\n", pci_name(rinfo->pdev),
+	pr_debug("radeonfb (%s): mapped %ldk videoram\n", pci_name(rinfo->pdev),
 	       rinfo->mapped_vram/1024);
 
 	/*
@@ -2374,7 +2374,7 @@ static int __devinit radeonfb_pci_regist
 
 	if (rinfo->bios_seg)
 		radeon_unmap_ROM(rinfo, pdev);
-	RTRACE("radeonfb_pci_register END\n");
+	pr_debug("radeonfb_pci_register END\n");
 
 	return 0;
 err_unmap_fb:
--- linux-2.6.24-rc3.orig/drivers/video/aty/radeon_i2c.c	2007-11-27 09:54:14.000000000 +0100
+++ linux-2.6.24-rc3/drivers/video/aty/radeon_i2c.c	2007-11-27 09:54:14.000000000 +0100
@@ -149,21 +149,21 @@ int radeon_probe_i2c_connector(struct ra
 	if (out_edid)
 		*out_edid = edid;
 	if (!edid) {
-		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
+		pr_debug("radeonfb: I2C (port %d) ... not found\n", conn);
 		return MT_NONE;
 	}
 	if (edid[0x14] & 0x80) {
 		/* Fix detection using BIOS tables */
 		if (rinfo->is_mobility /*&& conn == ddc_dvi*/ &&
 		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
-			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
+			pr_debug("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
 			return MT_LCD;
 		} else {
-			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
+			pr_debug("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
 			return MT_DFP;
 		}
 	}
-       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
+	pr_debug("radeonfb: I2C (port %d) ... found CRT display\n", conn);
 	return MT_CRT;
 }
 
--- linux-2.6.24-rc3.orig/drivers/video/aty/radeon_monitor.c	2007-11-27 09:54:14.000000000 +0100
+++ linux-2.6.24-rc3/drivers/video/aty/radeon_monitor.c	2007-11-27 09:54:14.000000000 +0100
@@ -69,11 +69,11 @@ static int __devinit radeon_parse_montyp
 	u8 *tmp;
         int i, mt = MT_NONE;  
 	
-	RTRACE("analyzing OF properties...\n");
+	pr_debug("analyzing OF properties...\n");
 	pmt = of_get_property(dp, "display-type", NULL);
 	if (!pmt)
 		return MT_NONE;
-	RTRACE("display-type: %s\n", pmt);
+	pr_debug("display-type: %s\n", pmt);
 	/* OF says "LCD" for DFP as well, we discriminate from the caller of this
 	 * function
 	 */
@@ -117,7 +117,7 @@ static int __devinit radeon_probe_OF_hea
 {
         struct device_node *dp;
 
-	RTRACE("radeon_probe_OF_head\n");
+	pr_debug("radeon_probe_OF_head\n");
 
         dp = rinfo->of_node;
         while (dp == NULL)
@@ -135,7 +135,7 @@ static int __devinit radeon_probe_OF_hea
 			if (!pname)
 				return MT_NONE;
 			len = strlen(pname);
-			RTRACE("head: %s (letter: %c, head_no: %d)\n",
+			pr_debug("head: %s (letter: %c, head_no: %d)\n",
 			       pname, pname[len-1], head_no);
 			if (pname[len-1] == 'A' && head_no == 0) {
 				int mt = radeon_parse_montype_prop(dp, out_EDID, 0);
@@ -185,7 +185,7 @@ static int __devinit radeon_get_panel_in
 		rinfo->panel_info.xres, rinfo->panel_info.yres);
 
 	rinfo->panel_info.pwr_delay = BIOS_IN16(tmp + 44);
-	RTRACE("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_delay);
+	pr_debug("BIOS provided panel power delay: %d\n", rinfo->panel_info.pwr_delay);
 	if (rinfo->panel_info.pwr_delay > 2000 || rinfo->panel_info.pwr_delay <= 0)
 		rinfo->panel_info.pwr_delay = 2000;
 
@@ -199,16 +199,16 @@ static int __devinit radeon_get_panel_in
 	    rinfo->panel_info.fbk_divider > 3) {
 		rinfo->panel_info.use_bios_dividers = 1;
 		printk(KERN_INFO "radeondb: BIOS provided dividers will be used\n");
-		RTRACE("ref_divider = %x\n", rinfo->panel_info.ref_divider);
-		RTRACE("post_divider = %x\n", rinfo->panel_info.post_divider);
-		RTRACE("fbk_divider = %x\n", rinfo->panel_info.fbk_divider);
+		pr_debug("ref_divider = %x\n", rinfo->panel_info.ref_divider);
+		pr_debug("post_divider = %x\n", rinfo->panel_info.post_divider);
+		pr_debug("fbk_divider = %x\n", rinfo->panel_info.fbk_divider);
 	}
-	RTRACE("Scanning BIOS table ...\n");
+	pr_debug("Scanning BIOS table ...\n");
 	for(i=0; i<32; i++) {
 		tmp0 = BIOS_IN16(tmp+64+i*2);
 		if (tmp0 == 0)
 			break;
-		RTRACE(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
+		pr_debug(" %d x %d\n", BIOS_IN16(tmp0), BIOS_IN16(tmp0+2));
 		if ((BIOS_IN16(tmp0) == rinfo->panel_info.xres) &&
 		    (BIOS_IN16(tmp0+2) == rinfo->panel_info.yres)) {
 			rinfo->panel_info.hblank = (BIOS_IN16(tmp0+17) - BIOS_IN16(tmp0+19)) * 8;
@@ -227,19 +227,19 @@ static int __devinit radeon_get_panel_in
 			/* Mark panel infos valid */
 			rinfo->panel_info.valid = 1;
 
-			RTRACE("Found panel in BIOS table:\n");
-			RTRACE("  hblank: %d\n", rinfo->panel_info.hblank);
-			RTRACE("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
-			RTRACE("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
-			RTRACE("  vblank: %d\n", rinfo->panel_info.vblank);
-			RTRACE("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
-			RTRACE("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
-			RTRACE("  clock: %d\n", rinfo->panel_info.clock);
+			pr_debug("Found panel in BIOS table:\n");
+			pr_debug("  hblank: %d\n", rinfo->panel_info.hblank);
+			pr_debug("  hOver_plus: %d\n", rinfo->panel_info.hOver_plus);
+			pr_debug("  hSync_width: %d\n", rinfo->panel_info.hSync_width);
+			pr_debug("  vblank: %d\n", rinfo->panel_info.vblank);
+			pr_debug("  vOver_plus: %d\n", rinfo->panel_info.vOver_plus);
+			pr_debug("  vSync_width: %d\n", rinfo->panel_info.vSync_width);
+			pr_debug("  clock: %d\n", rinfo->panel_info.clock);
 				
 			return 1;
 		}
 	}
-	RTRACE("Didn't find panel in BIOS table !\n");
+	pr_debug("Didn't find panel in BIOS table !\n");
 
 	return 0;
 }
@@ -271,18 +271,18 @@ static void __devinit radeon_parse_conne
 	 * DEBUG is enabled
 	 */
 	chips = BIOS_IN8(offset++) >> 4;
-	RTRACE("%d chips in connector info\n", chips);
+	pr_debug("%d chips in connector info\n", chips);
 	for (i = 0; i < chips; i++) {
 		tmp = BIOS_IN8(offset++);
 		connectors = tmp & 0x0f;
-		RTRACE(" - chip %d has %d connectors\n", tmp >> 4, connectors);
+		pr_debug(" - chip %d has %d connectors\n", tmp >> 4, connectors);
 		for (conn = 0; ; conn++) {
 			tmp = BIOS_IN16(offset);
 			if (tmp == 0)
 				break;
 			offset += 2;
 			type = (tmp >> 12) & 0x0f;
-			RTRACE("  * connector %d of type %d (%s) : %04x\n",
+			pr_debug("  * connector %d of type %d (%s) : %04x\n",
 			       conn, type, __conn_type_table[type], tmp);
 		}
 	}
@@ -449,7 +449,7 @@ void __devinit radeon_probe_screens(stru
 		 * a layout for each card ?
 		 */
 
-		RTRACE("Using specified monitor layout: %s", monitor_layout);
+		pr_debug("Using specified monitor layout: %s", monitor_layout);
 #ifdef CONFIG_FB_RADEON_I2C
 		if (!ignore_edid) {
 			if (rinfo->mon1_type != MT_NONE)
@@ -479,7 +479,7 @@ void __devinit radeon_probe_screens(stru
 		 * Auto-detecting display type (well... trying to ...)
 		 */
 		
-		RTRACE("Starting monitor auto detection...\n");
+		pr_debug("Starting monitor auto detection...\n");
 
 #if defined(DEBUG) && defined(CONFIG_FB_RADEON_I2C)
 		{
@@ -756,7 +756,7 @@ void __devinit radeon_check_modes(struct
 	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type != MT_CRT
 	    && rinfo->mon1_EDID) {
 		struct fb_var_screeninfo var;
-		RTRACE("Parsing EDID data for panel info\n");
+		pr_debug("Parsing EDID data for panel info\n");
 		if (fb_parse_edid(rinfo->mon1_EDID, &var) == 0) {
 			if (var.xres >= rinfo->panel_info.xres &&
 			    var.yres >= rinfo->panel_info.yres)
@@ -776,7 +776,7 @@ void __devinit radeon_check_modes(struct
 	if (rinfo->mon1_type != MT_CRT && rinfo->panel_info.valid) {
 		struct fb_var_screeninfo *var = &info->var;
 
-		RTRACE("Setting up default mode based on panel info\n");
+		pr_debug("Setting up default mode based on panel info\n");
 		var->xres = rinfo->panel_info.xres;
 		var->yres = rinfo->panel_info.yres;
 		var->xres_virtual = rinfo->panel_info.xres;
@@ -824,7 +824,7 @@ void __devinit radeon_check_modes(struct
 		int			dbsize;
 		char			modename[32];
 
-		RTRACE("Guessing panel info...\n");
+		pr_debug("Guessing panel info...\n");
 		if (rinfo->panel_info.xres == 0 || rinfo->panel_info.yres == 0) {
 			u32 tmp = INREG(FP_HORZ_STRETCH) & HORZ_PANEL_SIZE;
 			rinfo->panel_info.xres = ((tmp >> HORZ_PANEL_SHIFT) + 1) * 8;
--- linux-2.6.24-rc3.orig/drivers/video/aty/radeonfb.h	2007-11-27 09:54:14.000000000 +0100
+++ linux-2.6.24-rc3/drivers/video/aty/radeonfb.h	2007-11-27 09:54:14.000000000 +0100
@@ -369,16 +369,6 @@ struct radeonfb_info {
 
 
 /*
- * Debugging stuffs
- */
-#ifdef DEBUG
-#define RTRACE		printk
-#else
-#define RTRACE		if(0) printk
-#endif
-
-
-/*
  * IO macros
  */
 


-- 
Jean Delvare

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
