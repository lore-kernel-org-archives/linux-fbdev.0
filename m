From: Alexander Kern <alex.kern@gmx.de>
Subject: [PATCH 4/7]
Date: Sun, 21 Mar 2004 20:38:36 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212038.36230.alex.kern@gmx.de>
References: <200403212033.39808.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_88eXAMVuD0K+aqy"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B58mX-0001oR-24
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:38:49 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1B58mU-0002lI-Rh
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 11:38:47 -0800
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


--Boundary-00=_88eXAMVuD0K+aqy
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_88eXAMVuD0K+aqy
Content-Type: text/x-diff;
  charset="utf-8";
  name="04_mach64-bios.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="04_mach64-bios.diff"

diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-18 20:02:44.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-18 20:12:51.000000000 +0100
@@ -2766,124 +2766,33 @@ static int __devinit atyfb_setup_sparc(s
 
 #else /* __sparc__ */
 
-static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info, unsigned long addr)
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
 {
-	struct atyfb_par *par = info->par;
-	u16 tmp;
-	unsigned long raddr;
-	struct resource *rrp;
-#if defined(CONFIG_FB_ATY_GENERIC_LCD)
-	u32 driv_inf_tab, sig, rom_addr;
+	u32 driv_inf_tab, sig;
 	u16 lcd_ofs;
-#endif
-
-	raddr = addr + 0x7ff000UL;
-	rrp = &pdev->resource[2];
-	if ((rrp->flags & IORESOURCE_MEM) && request_mem_region(rrp->start, rrp->end - rrp->start + 1, "atyfb")) {
-		par->aux_app = 1;
-		raddr = rrp->start;
-		printk(KERN_INFO "atyfb: using auxiliary register aperture\n");
-	}
-
-	info->fix.mmio_start = raddr;
-	par->ati_regbase = (unsigned long)ioremap(info->fix.mmio_start, 0x1000);
-	if (par->ati_regbase == 0)
-		return -ENOMEM;
-
-	info->fix.mmio_start += par->aux_app ? 0x400 : 0xc00;
-	par->ati_regbase += par->aux_app ? 0x400 : 0xc00;
-
-	/*
-	 * Enable memory-space accesses using config-space
-	 * command register.
-	 */
-	pci_read_config_word(pdev, PCI_COMMAND, &tmp);
-	if (!(tmp & PCI_COMMAND_MEMORY)) {
-		tmp |= PCI_COMMAND_MEMORY;
-		pci_write_config_word(pdev, PCI_COMMAND, tmp);
-	}
-#ifdef __BIG_ENDIAN
-	/* Use the big-endian aperture */
-	addr += 0x800000;
-#endif
-
-	/* Map in frame buffer */
-	info->fix.smem_start = addr;
-	info->screen_base = (char *)ioremap(addr, 0x800000);
-	if (info->screen_base == NULL) {
-		iounmap((void *)par->ati_regbase);
-		par->ati_regbase = 0;
-		return -ENOMEM;
-	}
-
-#ifdef CONFIG_FB_ATY_GENERIC_LCD
+	
 	/* To support an LCD panel, we should know it's dimensions and
-	 * it's desired pixel clock.
+	 *  it's desired pixel clock.
 	 * There are two ways to do it:
-	 * - Check the startup video mode and calculate the panel
-	 *   size from it. This is unreliable.
-	 * - Read it from the driver information table in the video BIOS, that
-	 *   works only on x86
-	 *
-	 * So, we try to find a BIOS and get access to it.
-	 */
-	rom_addr = 0xc0000 + ((aty_ld_le32(SCRATCH_REG1, par) & 0x7f) << 11);
-	par->bios_base_phys = rom_addr;
-	par->bios_base = (unsigned long)ioremap(rom_addr, 0x10000);
-
-	/* The BIOS starts with 0xaa55. */
-	if (*((u16 *)par->bios_base) == 0xaa55) {
-		printk(KERN_INFO "atyfb: Mach64 BIOS is located at %x, mapped at %x.\n",
-		       (u32)par->bios_base_phys, (u32)par->bios_base);
-
-		/* check for frequncy table */
-		if (1) {
-			u8 *bios_ptr;
-			u16 rom_table_offset, freq_table_offset, XCLK_pwd, XCLK_dram, XCLK_vram, ref_freq, ref_divider, sclk;
-			u32 min_freq, max_freq;
-
-			bios_ptr = (u8*)par->bios_base;
-			rom_table_offset = (u16)(bios_ptr[0x48] | (bios_ptr[0x49] << 8));
-			printk(KERN_INFO "atyfb: rom table offset is %d\n", rom_table_offset);
-
-			freq_table_offset = bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_table_offset + 17] << 8);
-			printk(KERN_INFO "atyfb: frequency table offset is %d\n", freq_table_offset);
-
-			min_freq = bios_ptr[freq_table_offset + 2] | (bios_ptr[freq_table_offset + 3] << 8);
-			max_freq = bios_ptr[freq_table_offset + 4] | (bios_ptr[freq_table_offset + 5] << 8);
-			ref_freq = bios_ptr[freq_table_offset + 8] | (bios_ptr[freq_table_offset + 9] << 8);
-			ref_divider = bios_ptr[freq_table_offset + 10] | (bios_ptr[freq_table_offset + 11] << 8);
-
-			XCLK_pwd = bios_ptr[freq_table_offset + 14] | (bios_ptr[freq_table_offset + 15] << 8);
-			XCLK_dram = bios_ptr[freq_table_offset + 16] | (bios_ptr[freq_table_offset + 17] << 8);
-			XCLK_vram = bios_ptr[freq_table_offset + 18] | (bios_ptr[freq_table_offset + 19] << 8);
-			sclk = bios_ptr[freq_table_offset + 20] | (bios_ptr[freq_table_offset + 21] << 8);
-
-			printk(KERN_INFO "atyfb: BIOS frequency table:\n");
-			printk(KERN_INFO "       XCLK_pwd %d, XCLK_dram %d, XCLK_vram %d\n", XCLK_pwd, XCLK_dram, XCLK_vram);
-			printk(KERN_INFO "       ref_clk %d, ref_divider %d\n", ref_freq, ref_divider);
-			printk(KERN_INFO "       vpll_min %d, vpll_max %d\n", min_freq, max_freq);
-			printk(KERN_INFO "       sclk %d\n", sclk);
-
-			par->ref_clk_per = 100000000UL / ref_freq;
-			par->xclk_per  = 100000000UL / XCLK_vram;
-			par->pll_per = 100000000UL / max_freq;
-		}
-
-		/* Address of driver information table is at offset 0x78. */
-		driv_inf_tab = par->bios_base + *((u16 *)(par->bios_base+0x78));
-
-		/* Check for the driver information table signature. */
-		sig = (*(u32 *)driv_inf_tab);
-		if ((sig == 0x54504c24) || /* Rage LT pro */
-		    (sig == 0x544d5224) || /* Rage mobility */
-		    (sig == 0x54435824) || /* Rage XC */
-		    (sig == 0x544c5824)) { /* Rage XL */
-			printk(KERN_INFO "atyfb: BIOS contains driver information table.\n");
-			lcd_ofs = (*(u16 *)(driv_inf_tab + 10));
-			par->lcd_table = 0;
-			if (lcd_ofs != 0)
-				par->lcd_table = par->bios_base + lcd_ofs;
+	 *  - Check the startup video mode and calculate the panel
+	 *    size from it. This is unreliable.
+	 *  - Read it from the driver information table in the video BIOS.
+	*/
+	/* Address of driver information table is at offset 0x78. */
+	driv_inf_tab = bios_base + *((u16 *)(bios_base+0x78));
+	
+	/* Check for the driver information table signature. */
+	sig = (*(u32 *)driv_inf_tab);
+	if ((sig == 0x54504c24) || /* Rage LT pro */
+		(sig == 0x544d5224) || /* Rage mobility */
+		(sig == 0x54435824) || /* Rage XC */
+		(sig == 0x544c5824)) { /* Rage XL */
+		printk(KERN_INFO "atyfb: BIOS contains driver information table.\n");
+		lcd_ofs = (*(u16 *)(driv_inf_tab + 10));
+		par->lcd_table = 0;
+		if (lcd_ofs != 0) {
+			par->lcd_table = bios_base + lcd_ofs;
 		}
 	}
 
@@ -2900,7 +2809,6 @@ static int __devinit atyfb_setup_generic
 		u16 *lcdmodeptr;
 		u32 format;
 		u8 lcd_refresh_rates[16] = {50,56,60,67,70,72,75,76,85,90,100,120,140,150,160,200};
-
 		/* The most important information is the panel size at
 		 * offset 25 and 27, but there's some other nice information
 		 * which we print to the screen.
@@ -2908,7 +2816,7 @@ static int __devinit atyfb_setup_generic
 		id = *(u8 *)par->lcd_table;
 		strncpy(model,(char *)par->lcd_table+1,24);
 		model[23]=0;
-
+	
 		width = par->lcd_width = *(u16 *)(par->lcd_table+25);
 		height = par->lcd_height = *(u16 *)(par->lcd_table+27);
 		panel_type = *(u16 *)(par->lcd_table+29);
@@ -2980,7 +2888,7 @@ static int __devinit atyfb_setup_generic
 			}
 		}
 		printk(KERN_INFO "atyfb: %s%s %s monitor detected: %s\n        id=%d, %dx%d pixels, %s\n",
-		       txtdual ,txtcolour, txtmonitor, model, id, width, height, txtformat);
+			txtdual ,txtcolour, txtmonitor, model, id, width, height, txtformat);
 		refresh_rates_buf[0] = 0;
 		refresh_rates = *(u16 *)(par->lcd_table+62);
 		m = 1;
@@ -2999,14 +2907,13 @@ static int __devinit atyfb_setup_generic
 		}
 		default_refresh_rate = (*(u8 *)(par->lcd_table+61) & 0xf0) >> 4;
 		printk(KERN_INFO "        supports refresh rates [%s], default %d Hz\n",
-		       refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
+			refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
 		par->lcd_refreshrate = lcd_refresh_rates[default_refresh_rate];
-
 		/* We now need to determine the crtc parameters for the
 		 * lcd monitor. This is tricky, because they are not stored
 		 * individually in the BIOS. Instead, the BIOS contains a
 		 * table of display modes that work for this monitor.
-		 *  
+		 *
 		 * The idea is that we search for a mode of the same dimensions
 		 * as the dimensions of the lcd monitor. Say our lcd monitor
 		 * is 800x600 pixels, we search for a 800x600 monitor.
@@ -3017,11 +2924,11 @@ static int __devinit atyfb_setup_generic
 		while (*lcdmodeptr != 0) {
 			u32 modeptr;
 			u16 mwidth, mheight, lcd_hsync_start, lcd_vsync_start;
-			modeptr = par->bios_base + *lcdmodeptr;
-
+			modeptr = bios_base + *lcdmodeptr;
+	
 			mwidth = *((u16 *)(modeptr+0));
 			mheight = *((u16 *)(modeptr+2));
-
+	
 			if (mwidth == width && mheight == height) {
 				par->lcd_pixclock = 100000000 / *((u16 *)(modeptr+9));
 				par->lcd_htotal = *((u16 *)(modeptr+17)) & 511;
@@ -3029,26 +2936,28 @@ static int __devinit atyfb_setup_generic
 				lcd_hsync_start = *((u16 *)(modeptr+21)) & 511;
 				par->lcd_hsync_dly = (*((u16 *)(modeptr+21)) >> 9) & 7;
 				par->lcd_hsync_len = *((u8 *)(modeptr+23)) & 63;
+	
 				par->lcd_vtotal = *((u16 *)(modeptr+24)) & 2047;
 				par->lcd_vdisp = *((u16 *)(modeptr+26)) & 2047;
 				lcd_vsync_start = *((u16 *)(modeptr+28)) & 2047;
 				par->lcd_vsync_len = (*((u16 *)(modeptr+28)) >> 11) & 31;
+	
 				par->lcd_htotal = (par->lcd_htotal + 1) * 8;
 				par->lcd_hdisp = (par->lcd_hdisp + 1) * 8;
 				lcd_hsync_start = (lcd_hsync_start + 1) * 8;
 				par->lcd_hsync_len = par->lcd_hsync_len * 8;
-
+	
 				par->lcd_vtotal++;
 				par->lcd_vdisp++;
 				lcd_vsync_start++;
-				
+	
 				par->lcd_right_margin = lcd_hsync_start - par->lcd_hdisp;
 				par->lcd_lower_margin = lcd_vsync_start - par->lcd_vdisp;
 				par->lcd_hblank_len = par->lcd_htotal - par->lcd_hdisp;
 				par->lcd_vblank_len = par->lcd_vtotal - par->lcd_vdisp;
 				break;
 			}
-
+	
 			lcdmodeptr++;
 		}
 		if (*lcdmodeptr == 0) {
@@ -3056,29 +2965,133 @@ static int __devinit atyfb_setup_generic
 			/* To do: Switch to CRT if possible. */
 		} else {
 			printk(KERN_INFO "        LCD CRTC parameters: %d.%d  %d %d %d %d  %d %d %d %d\n",
-			       1000000 / par->lcd_pixclock, 1000000 % par->lcd_pixclock,
-			       par->lcd_hdisp,
-			       par->lcd_hdisp + par->lcd_right_margin,
-			       par->lcd_hdisp + par->lcd_right_margin + par->lcd_hsync_dly + par->lcd_hsync_len,
-			       par->lcd_htotal,
-			       par->lcd_vdisp,
-			       par->lcd_vdisp + par->lcd_lower_margin,
-			       par->lcd_vdisp + par->lcd_lower_margin + par->lcd_vsync_len,
-			       par->lcd_vtotal);
+				1000000 / par->lcd_pixclock, 1000000 % par->lcd_pixclock,
+				par->lcd_hdisp,
+				par->lcd_hdisp + par->lcd_right_margin,
+				par->lcd_hdisp + par->lcd_right_margin
+					+ par->lcd_hsync_dly + par->lcd_hsync_len,
+				par->lcd_htotal,
+				par->lcd_vdisp,
+				par->lcd_vdisp + par->lcd_lower_margin,
+				par->lcd_vdisp + par->lcd_lower_margin + par->lcd_vsync_len,
+				par->lcd_vtotal);
 			printk(KERN_INFO "                           : %d %d %d %d %d %d %d %d %d\n",
-			       par->lcd_pixclock,
-			       par->lcd_hblank_len - (par->lcd_right_margin + par->lcd_hsync_dly + par->lcd_hsync_len),
-			       par->lcd_hdisp,
-			       par->lcd_right_margin,
-			       par->lcd_hsync_len,
-			       par->lcd_vblank_len - (par->lcd_lower_margin + par->lcd_vsync_len),
-			       par->lcd_vdisp,
-			       par->lcd_lower_margin,
-			       par->lcd_vsync_len);
+				par->lcd_pixclock,
+				par->lcd_hblank_len - (par->lcd_right_margin +
+					par->lcd_hsync_dly + par->lcd_hsync_len),
+				par->lcd_hdisp,
+				par->lcd_right_margin,
+				par->lcd_hsync_len,
+				par->lcd_vblank_len - (par->lcd_lower_margin + par->lcd_vsync_len),
+				par->lcd_vdisp,
+				par->lcd_lower_margin,
+				par->lcd_vsync_len);
 		}
 	}
+}
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
 
+static int __devinit init_from_bios(struct atyfb_par *par)
+{
+	u32 bios_base, rom_addr;
+	int ret;
+
+	rom_addr = 0xc0000 + ((aty_ld_le32(SCRATCH_REG1, par) & 0x7f) << 11);
+	bios_base = (unsigned long)ioremap(rom_addr, 0x10000);
+
+	/* The BIOS starts with 0xaa55. */
+	if (*((u16 *)bios_base) == 0xaa55) {
+
+		u8 *bios_ptr;
+		u16 rom_table_offset, freq_table_offset;
+		PLL_BLOCK_MACH64 pll_block;
+		
+		printk(KERN_INFO "atyfb: Mach64 BIOS is located at %x, mapped at %x.\n", rom_addr, bios_base);
+
+		/* check for frequncy table */
+		bios_ptr = (u8*)bios_base;
+		rom_table_offset = (u16)(bios_ptr[0x48] | (bios_ptr[0x49] << 8));
+		freq_table_offset = bios_ptr[rom_table_offset + 16] | (bios_ptr[rom_table_offset + 17] << 8);
+		memcpy(&pll_block, bios_ptr + freq_table_offset, sizeof(PLL_BLOCK_MACH64));
+
+		printk(KERN_INFO "atyfb: BIOS frequency table:\n");
+		printk(KERN_INFO " PCLK_min_freq %d, PCLK_max_freq %d, ref_freq %d, ref_divider %d\n",
+			pll_block.PCLK_min_freq, pll_block.PCLK_max_freq,
+			pll_block.ref_freq, pll_block.ref_divider);
+		printk(KERN_INFO " MCLK_pwd %d, MCLK_max_freq %d, XCLK_max_freq %d, SCLK_freq %d\n",
+			pll_block.MCLK_pwd, pll_block.MCLK_max_freq,
+			pll_block.XCLK_max_freq, pll_block.SCLK_freq);
+
+		par->pll_limits.pll_min = pll_block.PCLK_min_freq/100;
+		par->pll_limits.pll_max = pll_block.PCLK_max_freq/100;
+		par->pll_limits.ref_clk = pll_block.ref_freq/100;
+		par->pll_limits.ref_div = pll_block.ref_divider;
+		par->pll_limits.sclk = pll_block.SCLK_freq/100;
+		par->pll_limits.mclk = pll_block.MCLK_max_freq/100;
+		par->pll_limits.mclk_pm = pll_block.MCLK_pwd/100;
+		par->pll_limits.xclk = pll_block.XCLK_max_freq/100;
+#ifdef CONFIG_FB_ATY_GENERIC_LCD
+		aty_init_lcd(par, bios_base);
+#endif
+		ret = 0;
+	} else {
+		printk(KERN_CRIT "atyfb: no BIOS frequency table found, use parameters\n");
+		ret = -ENXIO;
+	}
+	iounmap((void*)bios_base);
+
+	return ret;
+}
+
+static int __devinit atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info, unsigned long addr)
+{
+	struct atyfb_par *par = info->par;
+	u16 tmp;
+	unsigned long raddr;
+	struct resource *rrp;
+
+	raddr = addr + 0x7ff000UL;
+	rrp = &pdev->resource[2];
+	if ((rrp->flags & IORESOURCE_MEM) && request_mem_region(rrp->start, rrp->end - rrp->start + 1, "atyfb")) {
+		par->aux_app = 1;
+		raddr = rrp->start;
+		printk(KERN_INFO "atyfb: using auxiliary register aperture\n");
+	}
+
+	info->fix.mmio_start = raddr;
+	par->ati_regbase = (unsigned long)ioremap(info->fix.mmio_start, 0x1000);
+	if (par->ati_regbase == 0)
+		return -ENOMEM;
+
+	info->fix.mmio_start += par->aux_app ? 0x400 : 0xc00;
+	par->ati_regbase += par->aux_app ? 0x400 : 0xc00;
+
+	/*
+	 * Enable memory-space accesses using config-space
+	 * command register.
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &tmp);
+	if (!(tmp & PCI_COMMAND_MEMORY)) {
+		tmp |= PCI_COMMAND_MEMORY;
+		pci_write_config_word(pdev, PCI_COMMAND, tmp);
+	}
+#ifdef __BIG_ENDIAN
+	/* Use the big-endian aperture */
+	addr += 0x800000;
+#endif
+
+	/* Map in frame buffer */
+	info->fix.smem_start = addr;
+	info->screen_base = (char *)ioremap(addr, 0x800000);
+	if (info->screen_base == NULL) {
+		iounmap((void *)par->ati_regbase);
+		par->ati_regbase = 0;
+		return -ENOMEM;
+	}
+
+	/* always succeeded ? */
+	init_from_bios(par);
+
 	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
 		par->clk_wr_offset = (inb(R_GENMO) & 0x0CU) >> 2;
 	else

--Boundary-00=_88eXAMVuD0K+aqy--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
