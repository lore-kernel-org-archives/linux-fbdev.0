From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH 2/7]
Date: Sun, 21 Mar 2004 20:37:38 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212037.38126.alex.kern@gmx.de>
References: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_C8eXADf4lcxjIeD"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58lf-0001aU-HN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:37:55 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B58lc-00028d-84
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:37:52 -0800
In-Reply-To: <200403212033.39808.alex.kern@gmx.de>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>


--Boundary-00=_C8eXADf4lcxjIeD
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_C8eXADf4lcxjIeD
Content-Type: text/x-diff;
  charset="utf-8";
  name="02_mach64-aux.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="02_mach64-aux.diff"

diff -U 3 -H -d -p -r -- linux-2.6.4/drivers/video/aty/atyfb.h linux-2.6.alex/drivers/video/aty/atyfb.h
--- linux-2.6.4/drivers/video/aty/atyfb.h	2004-03-13 21:13:43.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb.h	2004-03-13 22:31:04.000000000 +0100
@@ -33,6 +33,28 @@ struct crtc {
 #endif
 };
 
+struct pll_info {
+	int pll_max;
+	int pll_min;
+	int sclk, mclk, mclk_pm, xclk;
+	int ref_div;
+	int ref_clk;
+};
+
+typedef struct {
+	u16 unknown1;
+	u16 PCLK_min_freq;
+	u16 PCLK_max_freq;
+	u16 unknown2;
+	u16 ref_freq;
+	u16 ref_divider;
+	u16 unknown3;
+	u16 MCLK_pwd;
+	u16 MCLK_max_freq;
+	u16 XCLK_max_freq;
+	u16 SCLK_freq;
+} __attribute__ ((packed)) PLL_BLOCK_MACH64;
+
 struct pll_514 {
 	u8 m;
 	u8 n;
@@ -139,8 +161,9 @@ struct atyfb_par {
 	u16 lcd_hblank_len;
 	u16 lcd_vblank_len;
 #endif
+	int aux_app; /* auxiliary aperture */
 };
-    
+
     /*
      *  ATI Mach64 features
      */
diff -U 3 -H -d -p -r -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-13 21:13:43.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-13 22:58:18.000000000 +0100
@@ -1208,11 +1208,11 @@ static int atyfb_set_par(struct fb_info 
 			aty_st_le32(BUS_CNTL, 0x680000f9, par);
 		} else if (M64_HAS(MOBIL_BUS)) {
 			aty_st_le32(DAC_CNTL, 0x80010102, par);
-			aty_st_le32(BUS_CNTL, 0x7b33a040, par);
+			aty_st_le32(BUS_CNTL, 0x7b33a040 | (par->aux_app ? BUS_APER_REG_DIS : 0), par);
 		} else {
 			/* GT */
 			aty_st_le32(DAC_CNTL, 0x86010102, par);
-			aty_st_le32(BUS_CNTL, 0x7b23a040, par);
+			aty_st_le32(BUS_CNTL, 0x7b23a040 | (par->aux_app ? BUS_APER_REG_DIS : 0), par);
 			aty_st_le32(EXT_MEM_CNTL, aty_ld_le32(EXT_MEM_CNTL, par) | 0x5000001, par);
 		}
 		aty_st_le32(MEM_CNTL, tmp, par);
@@ -1965,8 +1965,7 @@ static int __init aty_init(struct fb_inf
 	rev = (chip_id & CFG_CHIP_REV) >> 24;
 	for (j = 0; j < (sizeof(aty_chips) / sizeof(*aty_chips)); j++)
 		if (type == aty_chips[j].chip_type &&
-		    (rev & aty_chips[j].rev_mask) ==
-		    aty_chips[j].rev_val) {
+		    (rev & aty_chips[j].rev_mask) == aty_chips[j].rev_val) {
 			chipname = aty_chips[j].name;
 			pll = aty_chips[j].pll;
 			mclk = aty_chips[j].mclk;
@@ -2211,10 +2210,18 @@ static int __init aty_init(struct fb_inf
 	 *  the full 8 MB of video RAM on 8 MB boards
 	 */
 
-	if (info->fix.smem_len == 0x800000 ||
-	    (par->bus_type == ISA && info->fix.smem_len == 0x400000))
+	if (!par->aux_app &&
+		(info->fix.smem_len == 0x800000 || (par->bus_type == ISA && info->fix.smem_len == 0x400000)))
 		info->fix.smem_len -= GUI_RESERVE;
 
+	/*
+	 *  Disable register access through the linear aperture
+	 *  if the auxiliary aperture is used so we can access
+	 *  the full 8 MB of video RAM on 8 MB boards.
+	 */
+	if (par->aux_app)
+		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
+
 	/* Clear the video memory */
 	fb_memset((void *) info->screen_base, 0, info->fix.smem_len);
 
@@ -2225,8 +2232,7 @@ static int __init aty_init(struct fb_inf
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (M64_HAS(G3_PB_1_1) && machine_is_compatible("PowerBook1,1")) {
 		/* these bits let the 101 powerbook wake up from sleep -- paulus */
-		aty_st_lcd(POWER_MANAGEMENT,
-			   aty_ld_lcd(POWER_MANAGEMENT, par)
+		aty_st_lcd(POWER_MANAGEMENT, aty_ld_lcd(POWER_MANAGEMENT, par)
 			   | (USE_F32KHZ | TRISTATE_MEM_EN), par);
 	} else if (M64_HAS(MOBIL_BUS))
 		register_backlight_controller(&aty_backlight_controller, info, "ati");
@@ -2732,18 +2738,28 @@ static int __devinit atyfb_setup_generic
 {
 	struct atyfb_par *par = info->par;
 	u16 tmp;
+	unsigned long raddr;
+	struct resource *rrp;
 #if defined(CONFIG_FB_ATY_GENERIC_LCD)
 	u32 driv_inf_tab, sig, rom_addr;
 	u16 lcd_ofs;
 #endif
 
-	info->fix.mmio_start = 0x7ff000 + addr;
+	raddr = addr + 0x7ff000UL;
+	rrp = &pdev->resource[2];
+	if ((rrp->flags & IORESOURCE_MEM) && request_mem_region(rrp->start, rrp->end - rrp->start + 1, "atyfb")) {
+		par->aux_app = 1;
+		raddr = rrp->start;
+		printk(KERN_INFO "atyfb: using auxiliary register aperture\n");
+	}
+
+	info->fix.mmio_start = raddr;
 	par->ati_regbase = (unsigned long)ioremap(info->fix.mmio_start, 0x1000);
 	if (par->ati_regbase == 0)
 		return -ENOMEM;
 
-	info->fix.mmio_start += 0xc00;
-	par->ati_regbase += 0xc00;
+	info->fix.mmio_start += par->aux_app ? 0x400 : 0xc00;
+	par->ati_regbase += par->aux_app ? 0x400 : 0xc00;
 
 	/*
 	 * Enable memory-space accesses using config-space

--Boundary-00=_C8eXADf4lcxjIeD--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
