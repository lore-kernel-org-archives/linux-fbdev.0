From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH 6/7]
Date: Sun, 21 Mar 2004 21:47:00 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403212147.00908.alex.kern@gmx.de>
References: <200403212033.39808.alex.kern@gmx.de> <200403212039.22396.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E9fXAepXolsd/jj"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B59qr-0000xK-Ts
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 12:47:21 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B59ql-0004Mc-TW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Mar 2004 12:47:16 -0800
In-Reply-To: <200403212039.22396.alex.kern@gmx.de>
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


--Boundary-00=_E9fXAepXolsd/jj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag, 21. M=E4rz 2004 20:39 schrieb Alexander Kern:
Uups, something goes wrong
 here another version...


--Boundary-00=_E9fXAepXolsd/jj
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="06_mach64-laterinit2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="06_mach64-laterinit2.diff"

diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/atyfb_base.c linux-2.6.alex/drivers/video/aty/atyfb_base.c
--- linux-2.6.4/drivers/video/aty/atyfb_base.c	2004-03-21 21:30:07.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/atyfb_base.c	2004-03-20 21:33:24.000000000 +0100
@@ -366,24 +366,29 @@ static struct {
 };
 
 /* can not fail */
-static void __devinit correct_chipset(int i, struct atyfb_par *par)
+static void __devinit correct_chipset(struct atyfb_par *par)
 {
 	u8 rev;
 	u16 type;
 	u32 chip_id;
 	const char *name;
+	int i;
+
+	for (i = sizeof(aty_chips) / sizeof(*aty_chips) - 1; i >= 0; i--)
+		if (par->pci_id == aty_chips[i].pci_id)
+			break;
 
 	name = aty_chips[i].name;
 	par->pll_limits.pll_max = aty_chips[i].pll;
 	par->pll_limits.mclk = aty_chips[i].mclk;
 	par->pll_limits.xclk = aty_chips[i].xclk;
 	par->features = aty_chips[i].features;
-	par->pci_id = aty_chips[i].pci_id;
 	
 	chip_id = aty_ld_le32(CONFIG_CHIP_ID, par);
 	type = chip_id & CFG_CHIP_TYPE;
 	rev = (chip_id & CFG_CHIP_REV) >> 24;
-	switch(aty_chips[i].pci_id) {
+
+	switch(par->pci_id) {
 #ifdef CONFIG_FB_ATY_GX
 	case PCI_CHIP_MACH64GX:
 		assert(type == 0x00d7);
@@ -432,7 +437,7 @@ static void __devinit correct_chipset(in
 #endif
 	}
 
-	printk("atyfb: %s [0x%04x rev 0x%02x] ", name, type, rev);
+	printk("atyfb: %s [0x%04x rev 0x%02x]\n", name, type, rev);
 }
 
 static char ram_dram[] __initdata = "DRAM";
@@ -2648,6 +2653,8 @@ static int __devinit atyfb_setup_sparc(s
 		par->mmap_map[j].prot_flag = _PAGE_E;
 		j++;
 	}
+	
+	correct_chipset(par);
 
 	if (IS_XL(pdev->device)) {
 		/*
@@ -3094,6 +3101,7 @@ static int __devinit atyfb_setup_generic
 	}
 
 	/* always succeeded ? */
+	correct_chipset(par);
 	init_from_bios(par);
 
 	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
@@ -3120,6 +3128,7 @@ static int __devinit atyfb_pci_probe(str
 	for (i = sizeof(aty_chips) / sizeof(*aty_chips) - 1; i >= 0; i--)
 		if (pdev->device == aty_chips[i].pci_id)
 			break;
+
 	if (i < 0)
 		return -ENODEV;
 
@@ -3145,6 +3154,7 @@ static int __devinit atyfb_pci_probe(str
 	}
 	par = info->par;
 	info->fix = atyfb_fix;
+	par->pci_id = aty_chips[i].pci_id;
 
 	/* Reserve space */
 	par->res_start = rp->start;
@@ -3154,9 +3164,6 @@ static int __devinit atyfb_pci_probe(str
 		goto err_free;
 	}
 
-	/* set default Values aus pci_table */
-	correct_chipset(i, par);
-
 	/* Setup "info" structure */
 #ifdef __sparc__
 	rc = atyfb_setup_sparc(pdev, info, addr);
diff -U 3 -H -d -I '*.o' -p -r -- linux-2.6.4/drivers/video/aty/mach64_ct.c linux-2.6.alex/drivers/video/aty/mach64_ct.c
--- linux-2.6.4/drivers/video/aty/mach64_ct.c	2004-03-21 21:28:27.000000000 +0100
+++ linux-2.6.alex/drivers/video/aty/mach64_ct.c	2004-03-20 20:10:00.000000000 +0100
@@ -273,12 +273,11 @@ void aty_set_pll_ct(const struct fb_info
 		__FUNCTION__,
 		pll->ct.pll_ext_cntl, pll->ct.pll_gen_cntl, pll->ct.pll_vclk_cntl);
 
-#endif
 	printk("atyfb(%s): setting clock %lu for FeedBackDivider %i, ReferenceDivider %i, PostDivider %i(%i)\n",
 		__FUNCTION__,
 		par->clk_wr_offset, pll->ct.vclk_fb_div,
 		pll->ct.pll_ref_div, pll->ct.vclk_post_div, pll->ct.vclk_post_div_real);
-
+#endif
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table != 0) {
 		/* turn off LCD */

--Boundary-00=_E9fXAepXolsd/jj--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
