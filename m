From: domen@coderock.org
Subject: [patch 9/9] drivers/video/: Clean up printk()'s
Date: Sun, 06 Mar 2005 11:36:37 +0100
Message-ID: <20050306103638.293BC1F240@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7t9U-0001kK-6x
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:38:24 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7t9P-0003hv-6s
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:38:24 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org, james4765@cwazy.co.uk, james4765@gmail.com


This patch adds KERN_ constants to all of the printk()'s that need them in
drivers/video/

[Merged multiple patches, I can send split ones if desired -domen]

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/atafb.c                |    6 -
 kj-domen/drivers/video/aty/mach64_ct.c        |   22 +--
 kj-domen/drivers/video/aty/radeon_monitor.c   |    6 -
 kj-domen/drivers/video/aty/radeon_pm.c        |    6 -
 kj-domen/drivers/video/bw2.c                  |    2=20
 kj-domen/drivers/video/cg3.c                  |    2=20
 kj-domen/drivers/video/cg6.c                  |    2=20
 kj-domen/drivers/video/cirrusfb.c             |   21 ++-
 kj-domen/drivers/video/clps711xfb.c           |    2=20
 kj-domen/drivers/video/console/fbcon.c        |    2=20
 kj-domen/drivers/video/console/mdacon.c       |    4=20
 kj-domen/drivers/video/console/newport_con.c  |    4=20
 kj-domen/drivers/video/cyber2000fb.c          |    2=20
 kj-domen/drivers/video/dnfb.c                 |    2=20
 kj-domen/drivers/video/fbmem.c                |    2=20
 kj-domen/drivers/video/fbmon.c                |   10 -
 kj-domen/drivers/video/ffb.c                  |    6 -
 kj-domen/drivers/video/fm2fb.c                |    2=20
 kj-domen/drivers/video/igafb.c                |   12 +-
 kj-domen/drivers/video/imsttfb.c              |    5=20
 kj-domen/drivers/video/intelfb/intelfbhw.c    |  152 +++++++++++++--------=
-----
 kj-domen/drivers/video/kyro/fbdev.c           |    2=20
 kj-domen/drivers/video/leo.c                  |    2=20
 kj-domen/drivers/video/macfb.c                |   14 +-
 kj-domen/drivers/video/matrox/matroxfb_base.c |    2=20
 kj-domen/drivers/video/modedb.c               |    2=20
 kj-domen/drivers/video/neofb.c                |   10 -
 kj-domen/drivers/video/p9100.c                |    2=20
 kj-domen/drivers/video/platinumfb.c           |    6 -
 kj-domen/drivers/video/pm3fb.c                |    2=20
 kj-domen/drivers/video/pmag-ba-fb.c           |    2=20
 kj-domen/drivers/video/pmagb-b-fb.c           |    2=20
 kj-domen/drivers/video/pvr2fb.c               |    4=20
 kj-domen/drivers/video/radeonfb.c             |   63 ++++------
 kj-domen/drivers/video/retz3fb.c              |   84 +++++++-------
 kj-domen/drivers/video/riva/fbdev.c           |   13 +-
 kj-domen/drivers/video/savage/savagefb.c      |   35 +++--
 kj-domen/drivers/video/sstfb.c                |    2=20
 kj-domen/drivers/video/sun3fb.c               |    6 -
 kj-domen/drivers/video/tcx.c                  |    2=20
 kj-domen/drivers/video/tdfxfb.c               |   12 +-
 kj-domen/drivers/video/virgefb.c              |   46 +++----
 kj-domen/drivers/video/w100fb.c               |    8 -
 43 files changed, 297 insertions(+), 296 deletions(-)

diff -puN drivers/video/atafb.c~printk-drivers_video drivers/video/atafb.c
--- kj/drivers/video/atafb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/atafb.c	2005-03-05 16:13:24.000000000 +0100
@@ -2732,7 +2732,7 @@ int __init atafb_init(void)
 		}
 		fbhw =3D &st_switch;
 		atafb_ops.fb_setcolreg =3D &stste_setcolreg;
-		printk("Cannot determine video hardware; defaulting to ST(e)\n");
+		pr_info("Cannot determine video hardware; defaulting to ST(e)\n");
 #else /* ATAFB_STE */
 		/* no default driver included */
 		/* Nobody will ever see this message :-) */
@@ -2809,13 +2809,13 @@ int __init atafb_init(void)
 	if (register_framebuffer(&fb_info) < 0)
 		return -EINVAL;
=20
-	printk("Determined %dx%d, depth %d\n",
+	pr_info("Determined %dx%d, depth %d\n",
 	       disp.var.xres, disp.var.yres, disp.var.bits_per_pixel);
 	if ((disp.var.xres !=3D disp.var.xres_virtual) ||
 	    (disp.var.yres !=3D disp.var.yres_virtual))
 	   printk("   virtual %dx%d\n",
 			  disp.var.xres_virtual, disp.var.yres_virtual);
-	printk("fb%d: %s frame buffer device, using %dK of video memory\n",
+	pr_info("fb%d: %s frame buffer device, using %dK of video memory\n",
 	       fb_info.node, fb_info.modename, screen_len>>10);
=20
 	/* TODO: This driver cannot be unloaded yet */
diff -puN drivers/video/aty/mach64_ct.c~printk-drivers_video drivers/video/=
aty/mach64_ct.c
--- kj/drivers/video/aty/mach64_ct.c~printk-drivers_video	2005-03-05 16:13:=
24.000000000 +0100
+++ kj-domen/drivers/video/aty/mach64_ct.c	2005-03-05 16:13:24.000000000 +0=
100
@@ -196,7 +196,7 @@ static int aty_dsp_gt(const struct fb_in
 	pll->dsp_on_off =3D (dsp_on << 16) + dsp_off;
 	pll->dsp_config =3D (dsp_precision << 20) | (pll->dsp_loop_latency << 16)=
 | dsp_xclks;
 #ifdef DEBUG
-	printk("atyfb(%s): dsp_config 0x%08x, dsp_on_off 0x%08x\n",
+	pr_debug("atyfb(%s): dsp_config 0x%08x, dsp_on_off 0x%08x\n",
 		__FUNCTION__, pll->dsp_config, pll->dsp_on_off);
 #endif
 	return 0;
@@ -226,7 +226,7 @@ static int aty_valid_pll_ct(const struct
 #ifdef DEBUG
 	pllvclk =3D (1000000 * 2 * pll->vclk_fb_div) /
 		(par->ref_clk_per * pll->pll_ref_div);
-	printk("atyfb(%s): pllvclk=3D%d MHz, vclk=3D%d MHz\n",
+	pr_debug("atyfb(%s): pllvclk=3D%d MHz, vclk=3D%d MHz\n",
 		__FUNCTION__, pllvclk, pllvclk / pll->vclk_post_div_real);
 #endif
 	pll->pll_vclk_cntl =3D 0x03; /* VCLK =3D PLL_VCLK/VCLKx_POST */
@@ -257,9 +257,7 @@ static u32 aty_pll_to_var_ct(const struc
 		ret /=3D pll->ct.xres;
 	}
 #endif
-#ifdef DEBUG
-	printk("atyfb(%s): calculated 0x%08X(%i)\n", __FUNCTION__, ret, ret);
-#endif
+	pr_debug("atyfb(%s): calculated 0x%08X(%i)\n", __FUNCTION__, ret, ret);
 	return ret;
 }
=20
@@ -270,17 +268,15 @@ void aty_set_pll_ct(const struct fb_info
 	u8 tmp, tmp2;
=20
 	lcd_gen_cntrl =3D 0;
-#ifdef DEBUG
-	printk("atyfb(%s): about to program:\n"
+	pr_debug("atyfb(%s): about to program:\n"
 		"pll_ext_cntl=3D0x%02x pll_gen_cntl=3D0x%02x pll_vclk_cntl=3D0x%02x\n",
 		__FUNCTION__,
 		pll->ct.pll_ext_cntl, pll->ct.pll_gen_cntl, pll->ct.pll_vclk_cntl);
=20
-	printk("atyfb(%s): setting clock %lu for FeedBackDivider %i, ReferenceDiv=
ider %i, PostDivider %i(%i)\n",
+	pr_debug("atyfb(%s): setting clock %lu for FeedBackDivider %i, ReferenceD=
ivider %i, PostDivider %i(%i)\n",
 		__FUNCTION__,
 		par->clk_wr_offset, pll->ct.vclk_fb_div,
 		pll->ct.pll_ref_div, pll->ct.vclk_post_div, pll->ct.vclk_post_div_real);
-#endif
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table !=3D 0) {
 		/* turn off LCD */
@@ -412,10 +408,8 @@ int __init aty_init_pll_ct(const struct=20
 		pll->ct.xclk_post_div -=3D 1;
 	}
=20
-#ifdef DEBUG
-	printk("atyfb(%s): mclk_fb_mult=3D%d, xclk_post_div=3D%d\n",
+	pr_debug("atyfb(%s): mclk_fb_mult=3D%d, xclk_post_div=3D%d\n",
 		__FUNCTION__, pll->ct.mclk_fb_mult, pll->ct.xclk_post_div);
-#endif
=20
 	memcntl =3D aty_ld_le32(MEM_CNTL, par);
 	trp =3D (memcntl & 0x300) >> 8;
@@ -525,7 +519,7 @@ int __init aty_init_pll_ct(const struct=20
 #ifdef DEBUG
 	pllmclk =3D (1000000 * pll->ct.mclk_fb_mult * pll->ct.mclk_fb_div) /
 			(par->ref_clk_per * pll->ct.pll_ref_div);
-	printk("atyfb(%s): pllmclk=3D%d MHz, xclk=3D%d MHz\n",
+	pr_debug("atyfb(%s): pllmclk=3D%d MHz, xclk=3D%d MHz\n",
 		__FUNCTION__, pllmclk, pllmclk / pll->ct.xclk_post_div_real);
 #endif
=20
@@ -566,7 +560,7 @@ int __init aty_init_pll_ct(const struct=20
 #ifdef DEBUG
 		pllsclk =3D (1000000 * 2 * sclk_fb_div) /
 			(par->ref_clk_per * pll->ct.pll_ref_div);
-		printk("atyfb(%s): use sclk, pllsclk=3D%d MHz, sclk=3Dmclk=3D%d MHz\n",
+		pr_debug("atyfb(%s): use sclk, pllsclk=3D%d MHz, sclk=3Dmclk=3D%d MHz\n",
 			__FUNCTION__, pllsclk, pllsclk / sclk_post_div_real);
 #endif
 		/*
diff -puN drivers/video/aty/radeon_monitor.c~printk-drivers_video drivers/v=
ideo/aty/radeon_monitor.c
--- kj/drivers/video/aty/radeon_monitor.c~printk-drivers_video	2005-03-05 1=
6:13:24.000000000 +0100
+++ kj-domen/drivers/video/aty/radeon_monitor.c	2005-03-05 16:13:24.0000000=
00 +0100
@@ -178,10 +178,10 @@ static int __devinit radeon_get_panel_in
 	for(i=3D0; i<24; i++)
 		stmp[i] =3D BIOS_IN8(tmp+i+1);
 	stmp[24] =3D 0;
-	printk("radeonfb: panel ID string: %s\n", stmp);
+	pr_info("radeonfb: panel ID string: %s\n", stmp);
 	rinfo->panel_info.xres =3D BIOS_IN16(tmp + 25);
 	rinfo->panel_info.yres =3D BIOS_IN16(tmp + 27);
-	printk("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
+	pr_info("radeonfb: detected LVDS panel size from BIOS: %dx%d\n",
 		rinfo->panel_info.xres, rinfo->panel_info.yres);
=20
 	rinfo->panel_info.pwr_delay =3D BIOS_IN16(tmp + 44);
@@ -561,7 +561,7 @@ void __devinit radeon_probe_screens(stru
 		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4))
 		     || (INREG(LVDS_GEN_CNTL) & LVDS_ON))) {
 			rinfo->mon1_type =3D MT_LCD;
-			printk("Non-DDC laptop panel detected\n");
+			pr_info("Non-DDC laptop panel detected\n");
 		}
 		if (rinfo->mon1_type =3D=3D MT_NONE)
 			rinfo->mon1_type =3D radeon_crt_is_connected(rinfo, rinfo->reversed_DAC=
);
diff -puN drivers/video/aty/radeon_pm.c~printk-drivers_video drivers/video/=
aty/radeon_pm.c
--- kj/drivers/video/aty/radeon_pm.c~printk-drivers_video	2005-03-05 16:13:=
24.000000000 +0100
+++ kj-domen/drivers/video/aty/radeon_pm.c	2005-03-05 16:13:24.000000000 +0=
100
@@ -2523,7 +2523,7 @@ int radeonfb_pci_suspend(struct pci_dev=20
 	if (state !=3D PM_SUSPEND_MEM)
 		goto done;
 	if (susdisking) {
-		printk("suspending to disk but state =3D %d\n", state);
+		printk(KERN_NOTICE "suspending to disk but state =3D %d\n", state);
 		goto done;
 	}
=20
@@ -2693,10 +2693,10 @@ void radeonfb_pm_init(struct radeonfb_in
 	rinfo->dynclk =3D dynclk;
 	if (dynclk =3D=3D 1) {
 		radeon_pm_enable_dynamic_mode(rinfo);
-		printk("radeonfb: Dynamic Clock Power Management enabled\n");
+		pr_info("radeonfb: Dynamic Clock Power Management enabled\n");
 	} else if (dynclk =3D=3D 0) {
 		radeon_pm_disable_dynamic_mode(rinfo);
-		printk("radeonfb: Dynamic Clock Power Management disabled\n");
+		pr_info("radeonfb: Dynamic Clock Power Management disabled\n");
 	}
=20
 	/* Check if we can power manage on suspend/resume. We can do
diff -puN drivers/video/bw2.c~printk-drivers_video drivers/video/bw2.c
--- kj/drivers/video/bw2.c~printk-drivers_video	2005-03-05 16:13:24.0000000=
00 +0100
+++ kj-domen/drivers/video/bw2.c	2005-03-05 16:13:24.000000000 +0100
@@ -374,7 +374,7 @@ static void bw2_init_one(struct sbus_dev
=20
 	list_add(&all->list, &bw2_list);
=20
-	printk("bw2: bwtwo at %lx:%lx\n",
+	pr_info("bw2: bwtwo at %lx:%lx\n",
 	       (long) (sdev ? sdev->reg_addrs[0].which_io : 0),
 	       (long) all->par.physbase);
 }
diff -puN drivers/video/cg3.c~printk-drivers_video drivers/video/cg3.c
--- kj/drivers/video/cg3.c~printk-drivers_video	2005-03-05 16:13:24.0000000=
00 +0100
+++ kj-domen/drivers/video/cg3.c	2005-03-05 16:13:24.000000000 +0100
@@ -435,7 +435,7 @@ static void cg3_init_one(struct sbus_dev
=20
 	list_add(&all->list, &cg3_list);
=20
-	printk("cg3: %s at %lx:%lx\n",
+	pr_info("cg3: %s at %lx:%lx\n",
 	       sdev->prom_name,
 	       (long) sdev->reg_addrs[0].which_io,
 	       (long) sdev->reg_addrs[0].phys_addr);
diff -puN drivers/video/cg6.c~printk-drivers_video drivers/video/cg6.c
--- kj/drivers/video/cg6.c~printk-drivers_video	2005-03-05 16:13:24.0000000=
00 +0100
+++ kj-domen/drivers/video/cg6.c	2005-03-05 16:13:24.000000000 +0100
@@ -747,7 +747,7 @@ static void cg6_init_one(struct sbus_dev
=20
 	list_add(&all->list, &cg6_list);
=20
-	printk("cg6: CGsix [%s] at %lx:%lx\n",
+	pr_info("cg6: CGsix [%s] at %lx:%lx\n",
 	       all->info.fix.id,
 	       (long) sdev->reg_addrs[0].which_io,
 	       (long) sdev->reg_addrs[0].phys_addr);
diff -puN drivers/video/cirrusfb.c~printk-drivers_video drivers/video/cirru=
sfb.c
--- kj/drivers/video/cirrusfb.c~printk-drivers_video	2005-03-05 16:13:24.00=
0000000 +0100
+++ kj-domen/drivers/video/cirrusfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -93,7 +93,7 @@
 #ifndef CIRRUSFB_NDEBUG
 #define assert(expr) \
         if(!(expr)) { \
-        printk( "Assertion failed! %s,%s,%s,line=3D%d\n",\
+        printk(KERN_DEBUG "Assertion failed! %s,%s,%s,line=3D%d\n",\
         #expr,__FILE__,__FUNCTION__,__LINE__); \
         }
 #else
@@ -701,14 +701,14 @@ int cirrusfb_check_var(struct fb_var_scr
 		den =3D 1;
 		break;		/* 4 bytes per pixel */
 	default:
-		printk ("cirrusfb: mode %dx%dx%d rejected...color depth not supported.\n=
",
+		printk (KERN_WARNING "cirrusfb: mode %dx%dx%d rejected...color depth not=
 supported.\n",
 			var->xres, var->yres, var->bits_per_pixel);
 		DPRINTK ("EXIT - EINVAL error\n");
 		return -EINVAL;
 	}
=20
 	if (var->xres * nom / den * var->yres > cinfo->size) {
-		printk ("cirrusfb: mode %dx%dx%d rejected...resolution too high to fit i=
nto video memory!\n",
+		printk (KERN_WARNING "cirrusfb: mode %dx%dx%d rejected...resolution too =
high to fit into video memory!\n",
 			var->xres, var->yres, var->bits_per_pixel);
 		DPRINTK ("EXIT - EINVAL error\n");
 		return -EINVAL;
@@ -717,20 +717,20 @@ int cirrusfb_check_var(struct fb_var_scr
 	/* use highest possible virtual resolution */
 	if (var->xres_virtual =3D=3D -1 &&
 	    var->yres_virtual =3D=3D -1) {
-		printk ("cirrusfb: using maximum available virtual resolution\n");
+		pr_info ("cirrusfb: using maximum available virtual resolution\n");
 		for (i =3D 0; modes[i].xres !=3D -1; i++) {
 			if (modes[i].xres * nom / den * modes[i].yres < cinfo->size / 2)
 				break;
 		}
 		if (modes[i].xres =3D=3D -1) {
-			printk ("cirrusfb: could not find a virtual resolution that fits into v=
ideo memory!!\n");
+			printk (KERN_WARNING "cirrusfb: could not find a virtual resolution tha=
t fits into video memory!!\n");
 			DPRINTK ("EXIT - EINVAL error\n");
 			return -EINVAL;
 		}
 		var->xres_virtual =3D modes[i].xres;
 		var->yres_virtual =3D modes[i].yres;
=20
-		printk ("cirrusfb: virtual resolution set to maximum of %dx%d\n",
+		pr_info ("cirrusfb: virtual resolution set to maximum of %dx%d\n",
 			var->xres_virtual, var->yres_virtual);
 	}
=20
@@ -2167,7 +2167,7 @@ static unsigned int cirrusfb_get_memsize
 		/* 64-bit DRAM data bus width; assume 2MB. Also indicates 2MB memory
 		   * on the 5430. */
 	    case 0x18: mem =3D 2048 * 1024; break;
-	    default: printk ("CLgenfb: Unknown memory size!\n");
+	    default: printk (KERN_WARNING "CLgenfb: Unknown memory size!\n");
 		mem =3D 1024 * 1024;
 	}
 	if (SRF & 0x80) {
@@ -2352,7 +2352,7 @@ static void __devexit cirrusfb_cleanup (
=20
 	unregister_framebuffer (info);
 	fb_dealloc_cmap (&info->cmap);
-	printk ("Framebuffer unregistered\n");
+	pr_info ("Framebuffer unregistered\n");
 	cinfo->unmap(cinfo);
=20
 	DPRINTK ("EXIT\n");
@@ -2437,6 +2437,9 @@ static int cirrusfb_pci_register (struct
 	cinfo->size =3D board_size;
 	cinfo->unmap =3D cirrusfb_pci_unmap;
=20
+	printk(KERN_INFO "cirrusfb: %s board detected; ",
+	       cirrusfb_board_info[btype].name);
+
 	printk (" RAM (%lu kB) at 0xx%lx, ", cinfo->size / KB_, board_addr);
 	printk ("Cirrus Logic chipset on PCI bus\n");
 	pci_set_drvdata(pdev, info);
@@ -2529,7 +2532,7 @@ static int cirrusfb_zorro_register(struc
 		goto err_release_fb;
 	}
=20
-	printk (" RAM (%lu MB) at $%lx, ", board_size / MB_, board_addr);
+	pr_info (" RAM (%lu MB) at $%lx, ", board_size / MB_, board_addr);
=20
 	ret =3D -EIO;
=20
diff -puN drivers/video/clps711xfb.c~printk-drivers_video drivers/video/clp=
s711xfb.c
--- kj/drivers/video/clps711xfb.c~printk-drivers_video	2005-03-05 16:13:24.=
000000000 +0100
+++ kj-domen/drivers/video/clps711xfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -385,7 +385,7 @@ int __init clps711xfb_init(void)
 	clps7111fb_backlight_proc_entry =3D create_proc_entry("backlight", 0444,
 		&proc_root);
 	if (clps7111fb_backlight_proc_entry =3D=3D NULL) {
-		printk("Couldn't create the /proc entry for the backlight.\n");
+		printk(KERN_ERR "Couldn't create the /proc entry for the backlight.\n");
 		return -EINVAL;
 	}
=20
diff -puN drivers/video/console/fbcon.c~printk-drivers_video drivers/video/=
console/fbcon.c
--- kj/drivers/video/console/fbcon.c~printk-drivers_video	2005-03-05 16:13:=
24.000000000 +0100
+++ kj-domen/drivers/video/console/fbcon.c	2005-03-05 16:13:24.000000000 +0=
100
@@ -842,7 +842,7 @@ static const char *fbcon_startup(void)
 			udelay(20);
=20
 		if (ct =3D=3D 1000)
-			printk
+			pr_info
 			    ("fbcon_startup: No VBL detected, using timer based cursor.\n");
=20
 		free_irq(IRQ_MAC_VBL, fb_vbl_detect);
diff -puN drivers/video/console/mdacon.c~printk-drivers_video drivers/video=
/console/mdacon.c
--- kj/drivers/video/console/mdacon.c~printk-drivers_video	2005-03-05 16:13=
:24.000000000 +0100
+++ kj-domen/drivers/video/console/mdacon.c	2005-03-05 16:13:24.000000000 +=
0100
@@ -326,7 +326,7 @@ static const char __init *mdacon_startup
 	mda_type_name =3D "MDA";
=20
 	if (! mda_detect()) {
-		printk("mdacon: MDA card not detected.\n");
+		pr_info("mdacon: MDA card not detected.\n");
 		return NULL;
 	}
=20
@@ -337,7 +337,7 @@ static const char __init *mdacon_startup
 	/* cursor looks ugly during boot-up, so turn it off */
 	mda_set_cursor(mda_vram_len - 1);
=20
-	printk("mdacon: %s with %ldK of memory detected.\n",
+	pr_info("mdacon: %s with %ldK of memory detected.\n",
 		mda_type_name, mda_vram_len/1024);
=20
 	return "MDA-2";
diff -puN drivers/video/console/newport_con.c~printk-drivers_video drivers/=
video/console/newport_con.c
--- kj/drivers/video/console/newport_con.c~printk-drivers_video	2005-03-05 =
16:13:24.000000000 +0100
+++ kj-domen/drivers/video/console/newport_con.c	2005-03-05 16:13:24.000000=
000 +0100
@@ -231,7 +231,7 @@ void newport_get_screensize(void)
 			newport_ysize +=3D linetable[i + 1];
 		}
 	}
-	printk("NG1: Screensize %dx%d\n", newport_xsize, newport_ysize);
+	pr_info("NG1: Screensize %dx%d\n", newport_xsize, newport_ysize);
 }
=20
 static void newport_get_revisions(void)
@@ -274,7 +274,7 @@ static void newport_get_revisions(void)
 	bt445_rev =3D (npregs->set.dcbdata0.bybytes.b3 >> 4) - 0x0a;
=20
 #define L(a)     (char)('A'+(a))
-	printk
+	pr_info
 	    ("NG1: Revision %d, %d bitplanes, REX3 revision %c, VC2 revision %c, =
xmap9 revision %c, cmap revision %c, bt445 revision %c\n",
 	     board_rev, bitplanes, L(rex3_rev), L(vc2_rev), L(xmap9_rev),
 	     L(cmap_rev ? (cmap_rev + 1) : 0), L(bt445_rev));
diff -puN drivers/video/cyber2000fb.c~printk-drivers_video drivers/video/cy=
ber2000fb.c
--- kj/drivers/video/cyber2000fb.c~printk-drivers_video	2005-03-05 16:13:24=
.000000000 +0100
+++ kj-domen/drivers/video/cyber2000fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -1370,7 +1370,7 @@ static int __devinit cyberpro_common_pro
 	err =3D -EINVAL;
 	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
 	    		  &cyber2000fb_default_mode, 8)) {
-		printk("%s: no valid mode found\n", cfb->fb.fix.id);
+		printk(KERN_ERR "%s: no valid mode found\n", cfb->fb.fix.id);
 		goto failed;
 	}
=20
diff -puN drivers/video/dnfb.c~printk-drivers_video drivers/video/dnfb.c
--- kj/drivers/video/dnfb.c~printk-drivers_video	2005-03-05 16:13:24.000000=
000 +0100
+++ kj-domen/drivers/video/dnfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -266,7 +266,7 @@ static int __devinit dnfb_probe(struct d
 	out_8(AP_CONTROL_2, S_DATA_PLN);
 	out_be16(AP_ROP_1, SWAP(0x3));
=20
-	printk("apollo frame buffer alive and kicking !\n");
+	pr_info("apollo frame buffer initialized\n");
 	return err;
 }
=20
diff -puN drivers/video/fbmem.c~printk-drivers_video drivers/video/fbmem.c
--- kj/drivers/video/fbmem.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/fbmem.c	2005-03-05 16:13:24.000000000 +0100
@@ -1195,7 +1195,7 @@ fbmem_init(void)
=20
 	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
-		printk("unable to get major %d for fb devs\n", FB_MAJOR);
+		printk(KERN_WARNING "unable to get major %d for fb devs\n", FB_MAJOR);
=20
 	fb_class =3D class_simple_create(THIS_MODULE, "graphics");
 	if (IS_ERR(fb_class)) {
diff -puN drivers/video/fbmon.c~printk-drivers_video drivers/video/fbmon.c
--- kj/drivers/video/fbmon.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/fbmon.c	2005-03-05 16:13:24.000000000 +0100
@@ -44,7 +44,7 @@
 #undef DEBUG  /* define this for verbose EDID parsing output */
=20
 #ifdef DEBUG
-#define DPRINTK(fmt, args...) printk(fmt,## args)
+#define DPRINTK(fmt, args...) pr_debug("%s(): ", fmt, __FUNCTION__, ## arg=
s)
 #else
 #define DPRINTK(fmt, args...)
 #endif
@@ -106,7 +106,7 @@ static int check_edid(unsigned char *edi
 	for (i =3D 0; i < ARRAY_SIZE(brokendb); i++) {
 		if (!strncmp(manufacturer, brokendb[i].manufacturer, 4) &&
 			brokendb[i].model =3D=3D model) {
-			printk("fbmon: The EDID Block of "
+			pr_info("fbmon: The EDID Block of "
 			       "Manufacturer: %s Model: 0x%x is known to "
 			       "be broken,\n",  manufacturer, model);
  			fix =3D brokendb[i].fix;
@@ -139,11 +139,11 @@ static void fix_edid(unsigned char *edid
=20
 	switch (fix) {
 	case FBMON_FIX_HEADER:
-		printk("fbmon: trying a header reconstruct\n");
+		pr_info("fbmon: trying a header reconstruct\n");
 		memcpy(edid, edid_v1_header, 8);
 		break;
 	case FBMON_FIX_INPUT:
-		printk("fbmon: trying to fix input type\n");
+		pr_info("fbmon: trying to fix input type\n");
 		b =3D edid + EDID_STRUCT_DISPLAY;
 		b[0] &=3D ~0x80;
 		edid[127] +=3D 0x80;
@@ -767,7 +767,7 @@ static void get_monspecs(unsigned char *
 		specs->misc |=3D FB_MISC_1ST_DETAIL;
 	}
 	if (c & 0x01) {
-		printk("      Display is GTF capable\n");
+		DPRINTK("      Display is GTF capable\n");
 		specs->gtf =3D 1;
 	}
 }
diff -puN drivers/video/ffb.c~printk-drivers_video drivers/video/ffb.c
--- kj/drivers/video/ffb.c~printk-drivers_video	2005-03-05 16:13:24.0000000=
00 +0100
+++ kj-domen/drivers/video/ffb.c	2005-03-05 16:13:24.000000000 +0100
@@ -934,12 +934,12 @@ static void ffb_init_one(int node, int p
 	struct all_info *all;
=20
 	if (prom_getproperty(node, "reg", (void *) regs, sizeof(regs)) <=3D 0) {
-		printk("ffb: Cannot get reg device node property.\n");
+		printk(KERN_ERR "ffb: Cannot get reg device node property.\n");
 		return;
 	}
=20
 	if (ffb_apply_upa_parent_ranges(parent, &regs[0])) {
-		printk("ffb: Cannot apply parent ranges to regs.\n");
+		printk(KERN_ERR "ffb: Cannot apply parent ranges to regs.\n");
 		return;
 	}
=20
@@ -1026,7 +1026,7 @@ static void ffb_init_one(int node, int p
=20
 	list_add(&all->list, &ffb_list);
=20
-	printk("ffb: %s at %016lx type %d DAC %d\n",
+	pr_info("ffb: %s at %016lx type %d DAC %d\n",
 	       ((all->par.flags & FFB_FLAG_AFB) ? "AFB" : "FFB"),
 	       regs[0].phys_addr, all->par.board_type, all->par.dac_rev);
 }
diff -puN drivers/video/fm2fb.c~printk-drivers_video drivers/video/fm2fb.c
--- kj/drivers/video/fm2fb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/fm2fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -288,7 +288,7 @@ static int __devinit fm2fb_probe(struct=20
 		zorro_release_device(z);
 		return -EINVAL;
 	}
-	printk("fb%d: %s frame buffer device\n", info->node, fb_fix.id);
+	pr_info("fb%d: %s frame buffer device\n", info->node, fb_fix.id);
 	return 0;
 }
=20
diff -puN drivers/video/igafb.c~printk-drivers_video drivers/video/igafb.c
--- kj/drivers/video/igafb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/igafb.c	2005-03-05 16:13:24.000000000 +0100
@@ -364,7 +364,7 @@ static int __init iga_init(struct fb_inf
 	if (register_framebuffer(info) < 0)
 		return 0;
=20
-	printk("fb%d: %s frame buffer device at 0x%08lx [%dMB VRAM]\n",
+	pr_info("fb%d: %s frame buffer device at 0x%08lx [%dMB VRAM]\n",
 	       info->node, info->fix.id,=20
 	       par->frame_buffer_phys, info->fix.smem_len >> 20);
=20
@@ -406,7 +406,7 @@ int __init igafb_init(void)
=20
         info =3D kmalloc(size, GFP_ATOMIC);
         if (!info) {
-                printk("igafb_init: can't alloc fb_info\n");
+                printk(KERN_ERR "igafb_init: can't alloc fb_info\n");
                 return -ENOMEM;
         }
         memset(info, 0, size);
@@ -415,13 +415,13 @@ int __init igafb_init(void)
 =09
=20
 	if ((addr =3D pdev->resource[0].start) =3D=3D 0) {
-                printk("igafb_init: no memory start\n");
+                printk(KERN_ERR "igafb_init: no memory start\n");
 		kfree(info);
 		return -ENXIO;
 	}
=20
 	if ((info->screen_base =3D ioremap(addr, 1024*1024*2)) =3D=3D 0) {
-                printk("igafb_init: can't remap %lx[2M]\n", addr);
+                printk(KERN_ERR "igafb_init: can't remap %lx[2M]\n", addr);
 		kfree(info);
 		return -ENXIO;
 	}
@@ -454,7 +454,7 @@ int __init igafb_init(void)
 		igafb_fix.mmio_start =3D 0x30000000;	/* XXX */
 	}
 	if ((par->io_base =3D (int) ioremap(igafb_fix.mmio_start, igafb_fix.smem_=
len)) =3D=3D 0) {
-                printk("igafb_init: can't remap %lx[4K]\n", igafb_fix.mmio=
_start);
+                printk(KERN_ERR "igafb_init: can't remap %lx[4K]\n", igafb=
_fix.mmio_start);
 		iounmap((void *)info->screen_base);
 		kfree(info);
 		return -ENXIO;
@@ -470,7 +470,7 @@ int __init igafb_init(void)
=20
 	par->mmap_map =3D kmalloc(4 * sizeof(*par->mmap_map), GFP_ATOMIC);
 	if (!par->mmap_map) {
-		printk("igafb_init: can't alloc mmap_map\n");
+		printk(KERN_ERR "igafb_init: can't alloc mmap_map\n");
 		iounmap((void *)par->io_base);
 		iounmap(info->screen_base);
 		kfree(info);
diff -puN drivers/video/imsttfb.c~printk-drivers_video drivers/video/imsttf=
b.c
--- kj/drivers/video/imsttfb.c~printk-drivers_video	2005-03-05 16:13:24.000=
000000 +0100
+++ kj-domen/drivers/video/imsttfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -1413,7 +1413,8 @@ init_imstt(struct fb_info *info)
=20
 	if ((info->var.xres * info->var.yres) * (info->var.bits_per_pixel >> 3) >=
 info->fix.smem_len
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
-		printk("imsttfb: %ux%ux%u not supported\n", info->var.xres, info->var.yr=
es, info->var.bits_per_pixel);
+		printk(KERN_ERR "imsttfb: %ux%ux%u not supported\n",
+			info->var.xres, info->var.yres, info->var.bits_per_pixel);
 		kfree(info);
 		return;
 	}
@@ -1455,7 +1456,7 @@ init_imstt(struct fb_info *info)
 	}
=20
 	tmp =3D (read_reg_le32(par->dc_regs, SSTATUS) & 0x0f00) >> 8;
-	printk("fb%u: %s frame buffer; %uMB vram; chip version %u\n",
+	pr_info("fb%u: %s frame buffer; %uMB vram; chip version %u\n",
 		info->node, info->fix.id, info->fix.smem_len >> 20, tmp);
 }
=20
diff -puN drivers/video/intelfb/intelfbhw.c~printk-drivers_video drivers/vi=
deo/intelfb/intelfbhw.c
--- kj/drivers/video/intelfb/intelfbhw.c~printk-drivers_video	2005-03-05 16=
:13:24.000000000 +0100
+++ kj-domen/drivers/video/intelfb/intelfbhw.c	2005-03-05 16:13:24.00000000=
0 +0100
@@ -529,10 +529,10 @@ intelfbhw_print_hw_state(struct intelfb_
 	if (!hw || !dinfo)
 		return;
 	/* Read in as much of the HW state as possible. */
-	printk("hw state dump start\n");
-	printk("	VGA0_DIVISOR:		0x%08x\n", hw->vga0_divisor);
-	printk("	VGA1_DIVISOR:		0x%08x\n", hw->vga1_divisor);
-	printk("	VGAPD: 			0x%08x\n", hw->vga_pd);
+	pr_info("hw state dump start\n");
+	pr_info("	VGA0_DIVISOR:		0x%08x\n", hw->vga0_divisor);
+	pr_info("	VGA1_DIVISOR:		0x%08x\n", hw->vga1_divisor);
+	pr_info("	VGAPD: 			0x%08x\n", hw->vga_pd);
 	n =3D (hw->vga0_divisor >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 	m1 =3D (hw->vga0_divisor >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 	m2 =3D (hw->vga0_divisor >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -541,9 +541,9 @@ intelfbhw_print_hw_state(struct intelfb_
 	else
 		p1 =3D (hw->vga_pd >> VGAPD_0_P1_SHIFT) & DPLL_P1_MASK;
 	p2 =3D (hw->vga_pd >> VGAPD_0_P2_SHIFT) & DPLL_P2_MASK;
-	printk("	VGA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+	pr_info("	VGA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
 		m1, m2, n, p1, p2);
-	printk("	VGA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+	pr_info("	VGA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
=20
 	n =3D (hw->vga1_divisor >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 	m1 =3D (hw->vga1_divisor >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -553,16 +553,16 @@ intelfbhw_print_hw_state(struct intelfb_
 	else
 		p1 =3D (hw->vga_pd >> VGAPD_1_P1_SHIFT) & DPLL_P1_MASK;
 	p2 =3D (hw->vga_pd >> VGAPD_1_P2_SHIFT) & DPLL_P2_MASK;
-	printk("	VGA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+	pr_info("	VGA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
 		m1, m2, n, p1, p2);
-	printk("	VGA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+	pr_info("	VGA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
=20
-	printk("	DPLL_A:			0x%08x\n", hw->dpll_a);
-	printk("	DPLL_B:			0x%08x\n", hw->dpll_b);
-	printk("	FPA0:			0x%08x\n", hw->fpa0);
-	printk("	FPA1:			0x%08x\n", hw->fpa1);
-	printk("	FPB0:			0x%08x\n", hw->fpb0);
-	printk("	FPB1:			0x%08x\n", hw->fpb1);
+	pr_info("	DPLL_A:			0x%08x\n", hw->dpll_a);
+	pr_info("	DPLL_B:			0x%08x\n", hw->dpll_b);
+	pr_info("	FPA0:			0x%08x\n", hw->fpa0);
+	pr_info("	FPA1:			0x%08x\n", hw->fpa1);
+	pr_info("	FPB0:			0x%08x\n", hw->fpb0);
+	pr_info("	FPB1:			0x%08x\n", hw->fpb1);
=20
 	n =3D (hw->fpa0 >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 	m1 =3D (hw->fpa0 >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -572,9 +572,9 @@ intelfbhw_print_hw_state(struct intelfb_
 	else
 		p1 =3D (hw->dpll_a >> DPLL_P1_SHIFT) & DPLL_P1_MASK;
 	p2 =3D (hw->dpll_a >> DPLL_P2_SHIFT) & DPLL_P2_MASK;
-	printk("	PLLA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+	pr_info("	PLLA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
 		m1, m2, n, p1, p2);
-	printk("	PLLA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+	pr_info("	PLLA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
=20
 	n =3D (hw->fpa1 >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 	m1 =3D (hw->fpa1 >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -584,62 +584,62 @@ intelfbhw_print_hw_state(struct intelfb_
 	else
 		p1 =3D (hw->dpll_a >> DPLL_P1_SHIFT) & DPLL_P1_MASK;
 	p2 =3D (hw->dpll_a >> DPLL_P2_SHIFT) & DPLL_P2_MASK;
-	printk("	PLLA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
+	pr_info("	PLLA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
 		m1, m2, n, p1, p2);
-	printk("	PLLA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
+	pr_info("	PLLA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
=20
 #if 0
-	printk("	PALETTE_A:\n");
+	pr_info("	PALETTE_A:\n");
 	for (i =3D 0; i < PALETTE_8_ENTRIES)
-		printk("	%3d:	0x%08x\n", i, hw->palette_a[i];
-	printk("	PALETTE_B:\n");
+		pr_info("	%3d:	0x%08x\n", i, hw->palette_a[i];
+	pr_info("	PALETTE_B:\n");
 	for (i =3D 0; i < PALETTE_8_ENTRIES)
-		printk("	%3d:	0x%08x\n", i, hw->palette_b[i];
+		pr_info("	%3d:	0x%08x\n", i, hw->palette_b[i];
 #endif
=20
-	printk("	HTOTAL_A:		0x%08x\n", hw->htotal_a);
-	printk("	HBLANK_A:		0x%08x\n", hw->hblank_a);
-	printk("	HSYNC_A:		0x%08x\n", hw->hsync_a);
-	printk("	VTOTAL_A:		0x%08x\n", hw->vtotal_a);
-	printk("	VBLANK_A:		0x%08x\n", hw->vblank_a);
-	printk("	VSYNC_A:		0x%08x\n", hw->vsync_a);
-	printk("	SRC_SIZE_A:		0x%08x\n", hw->src_size_a);
-	printk("	BCLRPAT_A:		0x%08x\n", hw->bclrpat_a);
-	printk("	HTOTAL_B:		0x%08x\n", hw->htotal_b);
-	printk("	HBLANK_B:		0x%08x\n", hw->hblank_b);
-	printk("	HSYNC_B:		0x%08x\n", hw->hsync_b);
-	printk("	VTOTAL_B:		0x%08x\n", hw->vtotal_b);
-	printk("	VBLANK_B:		0x%08x\n", hw->vblank_b);
-	printk("	VSYNC_B:		0x%08x\n", hw->vsync_b);
-	printk("	SRC_SIZE_B:		0x%08x\n", hw->src_size_b);
-	printk("	BCLRPAT_B:		0x%08x\n", hw->bclrpat_b);
-
-	printk("	ADPA:			0x%08x\n", hw->adpa);
-	printk("	DVOA:			0x%08x\n", hw->dvoa);
-	printk("	DVOB:			0x%08x\n", hw->dvob);
-	printk("	DVOC:			0x%08x\n", hw->dvoc);
-	printk("	DVOA_SRCDIM:		0x%08x\n", hw->dvoa_srcdim);
-	printk("	DVOB_SRCDIM:		0x%08x\n", hw->dvob_srcdim);
-	printk("	DVOC_SRCDIM:		0x%08x\n", hw->dvoc_srcdim);
-	printk("	LVDS:			0x%08x\n", hw->lvds);
-
-	printk("	PIPEACONF:		0x%08x\n", hw->pipe_a_conf);
-	printk("	PIPEBCONF:		0x%08x\n", hw->pipe_b_conf);
-	printk("	DISPARB:		0x%08x\n", hw->disp_arb);
-
-	printk("	CURSOR_A_CONTROL:	0x%08x\n", hw->cursor_a_control);
-	printk("	CURSOR_B_CONTROL:	0x%08x\n", hw->cursor_b_control);
-	printk("	CURSOR_A_BASEADDR:	0x%08x\n", hw->cursor_a_base);
-	printk("	CURSOR_B_BASEADDR:	0x%08x\n", hw->cursor_b_base);
+	pr_info("	HTOTAL_A:		0x%08x\n", hw->htotal_a);
+	pr_info("	HBLANK_A:		0x%08x\n", hw->hblank_a);
+	pr_info("	HSYNC_A:		0x%08x\n", hw->hsync_a);
+	pr_info("	VTOTAL_A:		0x%08x\n", hw->vtotal_a);
+	pr_info("	VBLANK_A:		0x%08x\n", hw->vblank_a);
+	pr_info("	VSYNC_A:		0x%08x\n", hw->vsync_a);
+	pr_info("	SRC_SIZE_A:		0x%08x\n", hw->src_size_a);
+	pr_info("	BCLRPAT_A:		0x%08x\n", hw->bclrpat_a);
+	pr_info("	HTOTAL_B:		0x%08x\n", hw->htotal_b);
+	pr_info("	HBLANK_B:		0x%08x\n", hw->hblank_b);
+	pr_info("	HSYNC_B:		0x%08x\n", hw->hsync_b);
+	pr_info("	VTOTAL_B:		0x%08x\n", hw->vtotal_b);
+	pr_info("	VBLANK_B:		0x%08x\n", hw->vblank_b);
+	pr_info("	VSYNC_B:		0x%08x\n", hw->vsync_b);
+	pr_info("	SRC_SIZE_B:		0x%08x\n", hw->src_size_b);
+	pr_info("	BCLRPAT_B:		0x%08x\n", hw->bclrpat_b);
+
+	pr_info("	ADPA:			0x%08x\n", hw->adpa);
+	pr_info("	DVOA:			0x%08x\n", hw->dvoa);
+	pr_info("	DVOB:			0x%08x\n", hw->dvob);
+	pr_info("	DVOC:			0x%08x\n", hw->dvoc);
+	pr_info("	DVOA_SRCDIM:		0x%08x\n", hw->dvoa_srcdim);
+	pr_info("	DVOB_SRCDIM:		0x%08x\n", hw->dvob_srcdim);
+	pr_info("	DVOC_SRCDIM:		0x%08x\n", hw->dvoc_srcdim);
+	pr_info("	LVDS:			0x%08x\n", hw->lvds);
+
+	pr_info("	PIPEACONF:		0x%08x\n", hw->pipe_a_conf);
+	pr_info("	PIPEBCONF:		0x%08x\n", hw->pipe_b_conf);
+	pr_info("	DISPARB:		0x%08x\n", hw->disp_arb);
+
+	pr_info("	CURSOR_A_CONTROL:	0x%08x\n", hw->cursor_a_control);
+	pr_info("	CURSOR_B_CONTROL:	0x%08x\n", hw->cursor_b_control);
+	pr_info("	CURSOR_A_BASEADDR:	0x%08x\n", hw->cursor_a_base);
+	pr_info("	CURSOR_B_BASEADDR:	0x%08x\n", hw->cursor_b_base);
=20
-	printk("	CURSOR_A_PALETTE:	");
+	pr_info("	CURSOR_A_PALETTE:	");
 	for (i =3D 0; i < 4; i++) {
 		printk("0x%08x", hw->cursor_a_palette[i]);
 		if (i < 3)
 			printk(", ");
 	}
 	printk("\n");
-	printk("	CURSOR_B_PALETTE:	");
+	pr_info("	CURSOR_B_PALETTE:	");
 	for (i =3D 0; i < 4; i++) {
 		printk("0x%08x", hw->cursor_b_palette[i]);
 		if (i < 3)
@@ -647,40 +647,40 @@ intelfbhw_print_hw_state(struct intelfb_
 	}
 	printk("\n");
=20
-	printk("	CURSOR_SIZE:		0x%08x\n", hw->cursor_size);
+	pr_info("	CURSOR_SIZE:		0x%08x\n", hw->cursor_size);
=20
-	printk("	DSPACNTR:		0x%08x\n", hw->disp_a_ctrl);
-	printk("	DSPBCNTR:		0x%08x\n", hw->disp_b_ctrl);
-	printk("	DSPABASE:		0x%08x\n", hw->disp_a_base);
-	printk("	DSPBBASE:		0x%08x\n", hw->disp_b_base);
-	printk("	DSPASTRIDE:		0x%08x\n", hw->disp_a_stride);
-	printk("	DSPBSTRIDE:		0x%08x\n", hw->disp_b_stride);
+	pr_info("	DSPACNTR:		0x%08x\n", hw->disp_a_ctrl);
+	pr_info("	DSPBCNTR:		0x%08x\n", hw->disp_b_ctrl);
+	pr_info("	DSPABASE:		0x%08x\n", hw->disp_a_base);
+	pr_info("	DSPBBASE:		0x%08x\n", hw->disp_b_base);
+	pr_info("	DSPASTRIDE:		0x%08x\n", hw->disp_a_stride);
+	pr_info("	DSPBSTRIDE:		0x%08x\n", hw->disp_b_stride);
=20
-	printk("	VGACNTRL:		0x%08x\n", hw->vgacntrl);
-	printk("	ADD_ID:			0x%08x\n", hw->add_id);
+	pr_info("	VGACNTRL:		0x%08x\n", hw->vgacntrl);
+	pr_info("	ADD_ID:			0x%08x\n", hw->add_id);
=20
 	for (i =3D 0; i < 7; i++) {
-		printk("	SWF0%d			0x%08x\n", i,
+		pr_info("	SWF0%d			0x%08x\n", i,
 			hw->swf0x[i]);
 	}
 	for (i =3D 0; i < 7; i++) {
-		printk("	SWF1%d			0x%08x\n", i,
+		pr_info("	SWF1%d			0x%08x\n", i,
 			hw->swf1x[i]);
 	}
 	for (i =3D 0; i < 3; i++) {
-		printk("	SWF3%d			0x%08x\n", i,
+		pr_info("	SWF3%d			0x%08x\n", i,
 			hw->swf3x[i]);
 	}
 	for (i =3D 0; i < 8; i++)
-		printk("	FENCE%d			0x%08x\n", i,
+		pr_info("	FENCE%d			0x%08x\n", i,
 			hw->fence[i]);
=20
-	printk("	INSTPM			0x%08x\n", hw->instpm);
-	printk("	MEM_MODE		0x%08x\n", hw->mem_mode);
-	printk("	FW_BLC_0		0x%08x\n", hw->fw_blc_0);
-	printk("	FW_BLC_1		0x%08x\n", hw->fw_blc_1);
+	pr_info("	INSTPM			0x%08x\n", hw->instpm);
+	pr_info("	MEM_MODE		0x%08x\n", hw->mem_mode);
+	pr_info("	FW_BLC_0		0x%08x\n", hw->fw_blc_0);
+	pr_info("	FW_BLC_1		0x%08x\n", hw->fw_blc_1);
=20
-	printk("hw state dump end\n");
+	pr_info("hw state dump end\n");
 #endif
 }
=20
diff -puN drivers/video/kyro/fbdev.c~printk-drivers_video drivers/video/kyr=
o/fbdev.c
--- kj/drivers/video/kyro/fbdev.c~printk-drivers_video	2005-03-05 16:13:24.=
000000000 +0100
+++ kj-domen/drivers/video/kyro/fbdev.c	2005-03-05 16:13:24.000000000 +0100
@@ -739,7 +739,7 @@ static int __devinit kyrofb_probe(struct
 	if (register_framebuffer(info) < 0)
 		goto out_unmap;
=20
-	printk("fb%d: %s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRAM=
\n",
+	pr_info("fb%d: %s frame buffer device, at %dx%d@%d using %ldk/%ldk of VRA=
M\n",
 	       info->node, info->fix.id, info->var.xres,
 	       info->var.yres, info->var.bits_per_pixel, size >> 10,
 	       (unsigned long)info->fix.smem_len >> 10);
diff -puN drivers/video/leo.c~printk-drivers_video drivers/video/leo.c
--- kj/drivers/video/leo.c~printk-drivers_video	2005-03-05 16:13:24.0000000=
00 +0100
+++ kj-domen/drivers/video/leo.c	2005-03-05 16:13:24.000000000 +0100
@@ -614,7 +614,7 @@ static void leo_init_one(struct sbus_dev
=20
 	list_add(&all->list, &leo_list);
=20
-	printk("leo: %s at %lx:%lx\n",
+	pr_info("leo: %s at %lx:%lx\n",
 	       sdev->prom_name,
 	       (long) sdev->reg_addrs[0].which_io,
 	       (long) sdev->reg_addrs[0].phys_addr);
diff -puN drivers/video/macfb.c~printk-drivers_video drivers/video/macfb.c
--- kj/drivers/video/macfb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/macfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -639,9 +639,9 @@ void __init macfb_init(void)
 	   Mac */
 	fb_info.screen_base =3D ioremap(mac_bi_data.videoaddr, macfb_fix.smem_len=
);
 =09
-	printk("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
+	pr_info("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
 	       macfb_fix.smem_start, fb_info.screen_base, macfb_fix.smem_len/1024=
);
-	printk("macfb: mode is %dx%dx%d, linelength=3D%d\n",
+	pr_info("macfb: mode is %dx%dx%d, linelength=3D%d\n",
 	       macfb_defined.xres, macfb_defined.yres, macfb_defined.bits_per_pix=
el, macfb_fix.line_length);
 =09
 	/*
@@ -653,7 +653,7 @@ void __init macfb_init(void)
 	macfb_defined.height =3D PIXEL_TO_MM(macfb_defined.yres);
 	macfb_defined.width  =3D PIXEL_TO_MM(macfb_defined.xres);	=20
=20
-	printk("macfb: scrolling: redraw\n");
+	pr_info("macfb: scrolling: redraw\n");
 	macfb_defined.yres_virtual =3D macfb_defined.yres;
=20
 	/* some dummy values for timing to make fbset happy */
@@ -689,7 +689,7 @@ void __init macfb_init(void)
 		macfb_defined.green.length =3D 5;
 		macfb_defined.blue.offset =3D 0;
 		macfb_defined.blue.length =3D 5;
-		printk("macfb: directcolor: "
+		pr_info("macfb: directcolor: "
 		       "size=3D1:5:5:5, shift=3D15:10:5:0\n");
 		video_cmap_len =3D 16;
 		/* Should actually be FB_VISUAL_DIRECTCOLOR, but this
@@ -706,14 +706,14 @@ void __init macfb_init(void)
 		macfb_defined.green.length =3D 8;
 		macfb_defined.blue.offset =3D 0;
 		macfb_defined.blue.length =3D 8;
-		printk("macfb: truecolor: "
+		pr_info("macfb: truecolor: "
 		       "size=3D0:8:8:8, shift=3D0:16:8:0\n");
 		video_cmap_len =3D 16;
 		macfb_fix.visual =3D FB_VISUAL_TRUECOLOR;
 	default:
 		video_cmap_len =3D 0;
 		macfb_fix.visual =3D FB_VISUAL_MONO01;
-		printk("macfb: unknown or unsupported bit depth: %d\n", macfb_defined.bi=
ts_per_pixel);
+		printk(KERN_WARNING "macfb: unknown or unsupported bit depth: %d\n", mac=
fb_defined.bits_per_pixel);
 		break;
 	}
 =09
@@ -962,7 +962,7 @@ void __init macfb_init(void)
 	if (register_framebuffer(&fb_info) < 0)
 		return;
=20
-	printk("fb%d: %s frame buffer device\n",
+	pr_info("fb%d: %s frame buffer device\n",
 	       fb_info.node, fb_info.fix.id);
 }
=20
diff -puN drivers/video/matrox/matroxfb_base.c~printk-drivers_video drivers=
/video/matrox/matroxfb_base.c
--- kj/drivers/video/matrox/matroxfb_base.c~printk-drivers_video	2005-03-05=
 16:13:24.000000000 +0100
+++ kj-domen/drivers/video/matrox/matroxfb_base.c	2005-03-05 16:13:24.00000=
0000 +0100
@@ -1880,7 +1880,7 @@ static int initMatrox2(WPMINFO struct bo
 	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
 		goto failVideoIO;
 	}
-	printk("fb%d: %s frame buffer device\n",
+	pr_info("fb%d: %s frame buffer device\n",
 	       ACCESS_FBINFO(fbcon.node), ACCESS_FBINFO(fbcon.fix.id));
=20
 	/* there is no console on this fb... but we have to initialize hardware
diff -puN drivers/video/modedb.c~printk-drivers_video drivers/video/modedb.c
--- kj/drivers/video/modedb.c~printk-drivers_video	2005-03-05 16:13:24.0000=
00000 +0100
+++ kj-domen/drivers/video/modedb.c	2005-03-05 16:13:24.000000000 +0100
@@ -24,7 +24,7 @@
     ((v).xres =3D=3D (x) && (v).yres =3D=3D (y))
=20
 #ifdef DEBUG
-#define DPRINTK(fmt, args...)	printk("modedb %s: " fmt, __FUNCTION__ , ## =
args)
+#define DPRINTK(fmt, args...)	pr_debug("modedb %s: " fmt, __FUNCTION__ , #=
# args)
 #else
 #define DPRINTK(fmt, args...)
 #endif
diff -puN drivers/video/neofb.c~printk-drivers_video drivers/video/neofb.c
--- kj/drivers/video/neofb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/neofb.c	2005-03-05 16:13:24.000000000 +0100
@@ -252,7 +252,7 @@ static void neoCalcVCLK(const struct fb_
 	par->VCLK3Denominator =3D d_best;
=20
 #ifdef NEOFB_DEBUG
-	printk("neoVCLK: f:%d NumLow=3D%d NumHi=3D%d Den=3D%d Df=3D%d\n",
+	printk(KERN_DEBUG "neoVCLK: f:%d NumLow=3D%d NumHi=3D%d Den=3D%d Df=3D%d\=
n",
 	       f_target >> 12,
 	       par->VCLK3NumeratorLow,
 	       par->VCLK3NumeratorHigh,
@@ -1696,13 +1696,13 @@ static int __devinit neo_map_mmio(struct
=20
 	if (!request_mem_region
 	    (info->fix.mmio_start, MMIO_SIZE, "memory mapped I/O")) {
-		printk("neofb: memory mapped IO in use\n");
+		printk(KERN_ERR "neofb: memory mapped IO in use\n");
 		return -EBUSY;
 	}
=20
 	par->mmio_vbase =3D ioremap(info->fix.mmio_start, MMIO_SIZE);
 	if (!par->mmio_vbase) {
-		printk("neofb: unable to map memory mapped IO\n");
+		printk(KERN_ERR "neofb: unable to map memory mapped IO\n");
 		release_mem_region(info->fix.mmio_start,
 				   info->fix.mmio_len);
 		return -ENOMEM;
@@ -1737,14 +1737,14 @@ static int __devinit neo_map_video(struc
=20
 	if (!request_mem_region(info->fix.smem_start, info->fix.smem_len,
 				"frame buffer")) {
-		printk("neofb: frame buffer in use\n");
+		printk(KERN_WARNING "neofb: frame buffer in use\n");
 		return -EBUSY;
 	}
=20
 	info->screen_base =3D
 	    ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (!info->screen_base) {
-		printk("neofb: unable to map screen memory\n");
+		printk(KERN_ERR "neofb: unable to map screen memory\n");
 		release_mem_region(info->fix.smem_start,
 				   info->fix.smem_len);
 		return -ENOMEM;
diff -puN drivers/video/p9100.c~printk-drivers_video drivers/video/p9100.c
--- kj/drivers/video/p9100.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/p9100.c	2005-03-05 16:13:24.000000000 +0100
@@ -326,7 +326,7 @@ static void p9100_init_one(struct sbus_d
=20
 	list_add(&all->list, &p9100_list);
=20
-	printk("p9100: %s at %lx:%lx\n",
+	pr_info("p9100: %s at %lx:%lx\n",
 	       sdev->prom_name,
 	       (long) sdev->reg_addrs[0].which_io,
 	       (long) sdev->reg_addrs[0].phys_addr);
diff -puN drivers/video/platinumfb.c~printk-drivers_video drivers/video/pla=
tinumfb.c
--- kj/drivers/video/platinumfb.c~printk-drivers_video	2005-03-05 16:13:24.=
000000000 +0100
+++ kj-domen/drivers/video/platinumfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -146,7 +146,7 @@ static int platinumfb_set_par (struct fb
 	info->fix.visual =3D (pinfo->cmode =3D=3D CMODE_8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 	info->fix.line_length =3D vmode_attrs[pinfo->vmode-1].hres * (1<<pinfo->c=
mode) + offset;
-	printk("line_length: %x\n", info->fix.line_length);
+	printk(KERN_DEBUG "line_length: %x\n", info->fix.line_length);
 	return 0;
 }
=20
@@ -362,12 +362,12 @@ static int __devinit platinum_init_fb(st
 	      platinum_vram_reqd(default_vmode, default_cmode) > pinfo->total_vra=
m)
 		default_cmode--;
=20
-	printk("platinumfb:  Using video mode %d and color mode %d.\n", default_v=
mode, default_cmode);
+	pr_info("platinumfb:  Using video mode %d and color mode %d.\n", default_=
vmode, default_cmode);
=20
 	/* Setup default var */
 	if (mac_vmode_to_var(default_vmode, default_cmode, &var) < 0) {
 		/* This shouldn't happen! */
-		printk("mac_vmode_to_var(%d, %d,) failed\n", default_vmode, default_cmod=
e);
+		printk(KERN_ERR "mac_vmode_to_var(%d, %d,) failed\n", default_vmode, def=
ault_cmode);
 try_again:
 		default_vmode =3D VMODE_640_480_60;
 		default_cmode =3D CMODE_8;
diff -puN drivers/video/pm3fb.c~printk-drivers_video drivers/video/pm3fb.c
--- kj/drivers/video/pm3fb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/pm3fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -1643,7 +1643,7 @@ static void pm3fb_common_init(struct pm3
 =09
 	pm3fb_write_mode(l_fb_info);
 =09
-	printk("fb%d: %s, using %uK of video memory (%s)\n",
+	pr_info("fb%d: %s, using %uK of video memory (%s)\n",
 	       l_fb_info->gen.info.node,
 	       permedia3_name, (u32) (l_fb_info->fb_size >> 10),
 	       cardbase[l_fb_info->board_type].cardname);
diff -puN drivers/video/pmag-ba-fb.c~printk-drivers_video drivers/video/pma=
g-ba-fb.c
--- kj/drivers/video/pmag-ba-fb.c~printk-drivers_video	2005-03-05 16:13:24.=
000000000 +0100
+++ kj-domen/drivers/video/pmag-ba-fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -126,7 +126,7 @@ int __init pmagbafb_init_one(int slot)
 	struct fb_info *info =3D &pmagba_fb_info[slot];=20
 	struct display *disp =3D &pmagba_disp[slot];
=20
-	printk("PMAG-BA framebuffer in slot %d\n", slot);
+	pr_info("PMAG-BA framebuffer in slot %d\n", slot);
 	/*
 	 * Framebuffer display memory base address and friends
 	 */
diff -puN drivers/video/pmagb-b-fb.c~printk-drivers_video drivers/video/pma=
gb-b-fb.c
--- kj/drivers/video/pmagb-b-fb.c~printk-drivers_video	2005-03-05 16:13:24.=
000000000 +0100
+++ kj-domen/drivers/video/pmagb-b-fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -126,7 +126,7 @@ int __init pmagbbfb_init_one(int slot)
 	unsigned long base_addr =3D get_tc_base_addr(slot);
 	struct fb_info *info =3D &pmagbb_fb_info[slot];
=20
-	printk("PMAGB-BA framebuffer in slot %d\n", slot);
+	pr_info("PMAGB-BA framebuffer in slot %d\n", slot);
 	/*
 	 * Framebuffer display memory base address and friends
 	 */
diff -puN drivers/video/pvr2fb.c~printk-drivers_video drivers/video/pvr2fb.c
--- kj/drivers/video/pvr2fb.c~printk-drivers_video	2005-03-05 16:13:24.0000=
00000 +0100
+++ kj-domen/drivers/video/pvr2fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -818,10 +818,10 @@ static int __init pvr2fb_common_init(voi
=20
 	rev =3D fb_readl(par->mmio_base + 0x04);
=20
-	printk("fb%d: %s (rev %ld.%ld) frame buffer device, using %ldk/%ldk of vi=
deo memory\n",
+	pr_info("fb%d: %s (rev %ld.%ld) frame buffer device, using %ldk/%ldk of v=
ideo memory\n",
 	       fb_info->node, fb_info->fix.id, (rev >> 4) & 0x0f, rev & 0x0f,
 	       modememused >> 10, (unsigned long)(fb_info->fix.smem_len >> 10));
-	printk("fb%d: Mode %dx%d-%d pitch =3D %ld cable: %s video output: %s\n", =

+	pr_info("fb%d: Mode %dx%d-%d pitch =3D %ld cable: %s video output: %s\n",
 	       fb_info->node, fb_info->var.xres, fb_info->var.yres,
 	       fb_info->var.bits_per_pixel,=20
 	       get_line_length(fb_info->var.xres, fb_info->var.bits_per_pixel),
diff -puN drivers/video/radeonfb.c~printk-drivers_video drivers/video/radeo=
nfb.c
--- kj/drivers/video/radeonfb.c~printk-drivers_video	2005-03-05 16:13:24.00=
0000000 +0100
+++ kj-domen/drivers/video/radeonfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -28,6 +28,7 @@
  *
  */
=20
+#define DEBUG
=20
 #define RADEON_VERSION	"0.1.6"
=20
@@ -80,13 +81,7 @@
 #include <video/radeon.h>
 #include <linux/radeonfb.h>
=20
-#define DEBUG	1
-
-#if DEBUG
-#define RTRACE		printk
-#else
-#define RTRACE		if(0) printk
-#endif
+#define RTRACE		pr_debug
=20
 // XXX
 #undef CONFIG_PMAC_PBOOK
@@ -807,7 +802,7 @@ static void radeon_get_pllinfo(struct ra
         	rinfo->pll.ppll_min =3D pll.PCLK_min_freq;
         	rinfo->pll.ppll_max =3D pll.PCLK_max_freq;
=20
-		printk("radeonfb: ref_clk=3D%d, ref_div=3D%d, xclk=3D%d from BIOS\n",
+		pr_info("radeonfb: ref_clk=3D%d, ref_div=3D%d, xclk=3D%d from BIOS\n",
 			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 	} else {
 #ifdef CONFIG_PPC_OF
@@ -827,7 +822,7 @@ static void radeon_get_pllinfo(struct ra
 			rinfo->pll.ppll_min =3D 12000;
 			rinfo->pll.ppll_max =3D 35000;
=20
-			printk("radeonfb: ref_clk=3D%d, ref_div=3D%d, xclk=3D%d from OF\n",
+			pr_info("radeonfb: ref_clk=3D%d, ref_div=3D%d, xclk=3D%d from OF\n",
 				rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
=20
 			return;
@@ -887,7 +882,7 @@ static void radeon_get_pllinfo(struct ra
 				break;
 		}
=20
-		printk("radeonfb: ref_clk=3D%d, ref_div=3D%d, xclk=3D%d defaults\n",
+		pr_info("radeonfb: ref_clk=3D%d, ref_div=3D%d, xclk=3D%d defaults\n",
 			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 	}
 }
@@ -1009,7 +1004,7 @@ static int radeon_dfp_parse_EDID(struct=20
 			rinfo->vAct_high =3D 1;
 	}
=20
-	printk("radeonfb: detected DFP panel size from EDID: %dx%d\n",
+	pr_info("radeonfb: detected DFP panel size from EDID: %dx%d\n",
 		rinfo->panel_xres, rinfo->panel_yres);
=20
 	rinfo->got_dfpinfo =3D 1;
@@ -1061,22 +1056,22 @@ static int radeon_get_dfpinfo_BIOS(struc
 		return 0;
=20
 	if (!(fpbiosstart =3D rinfo->bios_seg + readw(rinfo->bios_seg + 0x48))) {
-		printk("radeonfb: Failed to detect DFP panel info using BIOS\n");
+		printk(KERN_NOTICE "radeonfb: Failed to detect DFP panel info using BIOS=
\n");
 		return 0;
 	}
=20
 	if (!(tmp =3D rinfo->bios_seg + readw(fpbiosstart + 0x40))) {
-		printk("radeonfb: Failed to detect DFP panel info using BIOS\n");
+		printk(KERN_NOTICE "radeonfb: Failed to detect DFP panel info using BIOS=
\n");
 		return 0;
 	}
=20
 	for(i=3D0; i<24; i++)
 		stmp[i] =3D readb(tmp+i+1);
 	stmp[24] =3D 0;
-	printk("radeonfb: panel ID string: %s\n", stmp);
+	pr_info("radeonfb: panel ID string: %s\n", stmp);
 	rinfo->panel_xres =3D readw(tmp + 25);
 	rinfo->panel_yres =3D readw(tmp + 27);
-	printk("radeonfb: detected DFP panel size from BIOS: %dx%d\n",
+	pr_info("radeonfb: detected DFP panel size from BIOS: %dx%d\n",
 		rinfo->panel_xres, rinfo->panel_yres);
=20
 	for(i=3D0; i<32; i++) {
@@ -1152,11 +1147,11 @@ static int radeon_get_dfpinfo (struct ra
 				rinfo->panel_xres =3D 1600;
 				break;
 			default:
-				printk("radeonfb: Failed to detect DFP panel size\n");
+				printk(KERN_NOTICE "radeonfb: Failed to detect DFP panel size\n");
 				return 0;
 		}
=20
-		printk("radeonfb: detected DFP panel size from registers: %dx%d\n",
+		pr_info("radeonfb: detected DFP panel size from registers: %dx%d\n",
 			rinfo->panel_xres, rinfo->panel_yres);
=20
 		tmp =3D INREG(FP_CRTC_H_TOTAL_DISP);
@@ -1326,20 +1321,20 @@ static int radeon_do_maximize(struct rad
  =20
         /* use highest possible virtual resolution */
         if (v->xres_virtual =3D=3D -1 && v->yres_virtual =3D=3D -1) {
-                printk("radeonfb: using max available virtual resolution\n=
");
+                pr_info("radeonfb: using max available virtual resolution\=
n");
                 for (i=3D0; modes[i].xres !=3D -1; i++) {
                         if (modes[i].xres * nom / den * modes[i].yres <
                             rinfo->video_ram / 2)
                                 break;
                 }
                 if (modes[i].xres =3D=3D -1) {
-                        printk("radeonfb: could not find virtual resolutio=
n that fits into video memory!\n");
+                        printk(KERN_NOTICE "radeonfb: could not find virtu=
al resolution that fits into video memory!\n");
                         return -EINVAL;
                 }
                 v->xres_virtual =3D modes[i].xres; =20
                 v->yres_virtual =3D modes[i].yres;
                =20
-                printk("radeonfb: virtual resolution set to max of %dx%d\n=
",
+                pr_info("radeonfb: virtual resolution set to max of %dx%d\=
n",
                         v->xres_virtual, v->yres_virtual);
         } else if (v->xres_virtual =3D=3D -1) {
                 v->xres_virtual =3D (rinfo->video_ram * den /  =20
@@ -1444,7 +1439,7 @@ static int radeonfb_check_var (struct fb
                         v.transp.length =3D 8;
                         break;
                 default:
-                        printk ("radeonfb: mode %dx%dx%d rejected, color d=
epth invalid\n",
+                        printk (KERN_ERR "radeonfb: mode %dx%dx%d rejected=
, color depth invalid\n",
                                 var->xres, var->yres, var->bits_per_pixel);
                         return -EINVAL;
         }
@@ -1977,7 +1972,7 @@ static int radeonfb_set_par (struct fb_i
 	RTRACE("vclk_freq =3D %d, per =3D %d\n", vclk_freq, xclk_per_trans_precis=
e);
=20
 	if ((ron + rinfo->ram.rloop) >=3D roff) {
-		printk("radeonfb: error ron out of range\n");
+		printk(KERN_ERR "radeonfb: error ron out of range\n");
 		return -EINVAL;
 	}
=20
@@ -2769,7 +2764,7 @@ int radeon_sleep_notify(struct pmu_sleep
=20
 				radeonfb_blank(0, (struct fb_info *)rinfo);
 				release_console_sem();
-				printk("CLK_PIN_CNTL on wakeup was: %08x\n", dbg_clk);
+				printk(KERN_DEBUG "CLK_PIN_CNTL on wakeup was: %08x\n", dbg_clk);
 				break;
 		}
 	}
@@ -2796,7 +2791,7 @@ static int radeonfb_pci_register (struct
=20
 	rinfo =3D kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);
 	if (!rinfo) {
-		printk ("radeonfb: could not allocate memory\n");
+		printk (KERN_ERR "radeonfb: could not allocate memory\n");
 		return -ENODEV;
 	}
=20
@@ -2813,14 +2808,14 @@ static int radeonfb_pci_register (struct
 	/* request the mem regions */
 	if (!request_mem_region (rinfo->fb_base_phys,
 				 pci_resource_len(pdev, 0), "radeonfb")) {
-		printk ("radeonfb: cannot reserve FB region\n");
+		printk (KERN_ERR "radeonfb: cannot reserve FB region\n");
 		kfree (rinfo);
 		return -ENODEV;
 	}
=20
 	if (!request_mem_region (rinfo->mmio_base_phys,
 				 pci_resource_len(pdev, 2), "radeonfb")) {
-		printk ("radeonfb: cannot reserve MMIO region\n");
+		printk (KERN_ERR "radeonfb: cannot reserve MMIO region\n");
 		release_mem_region (rinfo->fb_base_phys,
 				    pci_resource_len(pdev, 0));
 		kfree (rinfo);
@@ -2830,7 +2825,7 @@ static int radeonfb_pci_register (struct
 	/* map the regions */
 	rinfo->mmio_base =3D ioremap (rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
-		printk ("radeonfb: cannot map MMIO\n");
+		printk (KERN_ERR "radeonfb: cannot map MMIO\n");
 		release_mem_region (rinfo->mmio_base_phys,
 				    pci_resource_len(pdev, 2));
 		release_mem_region (rinfo->fb_base_phys,
@@ -2859,7 +2854,7 @@ static int radeonfb_pci_register (struct
 	}
 #endif
 	if (mirror)
-		printk("radeonfb: mirroring display to CRT\n");
+		pr_info("radeonfb: mirroring display to CRT\n");
=20
 	/* framebuffer size */
 	tmp =3D INREG(CONFIG_MEMSIZE);
@@ -2967,7 +2962,7 @@ static int radeonfb_pci_register (struct
=20
 	rinfo->fb_base =3D ioremap (rinfo->fb_base_phys, rinfo->video_ram);
 	if (!rinfo->fb_base) {
-		printk ("radeonfb: cannot map FB\n");
+		printk (KERN_ERR "radeonfb: cannot map FB\n");
 		iounmap(rinfo->mmio_base);
 		release_mem_region (rinfo->mmio_base_phys,
 				    pci_resource_len(pdev, 2));
@@ -3019,7 +3014,7 @@ static int radeonfb_pci_register (struct
 	board_list =3D rinfo;
 	((struct fb_info *) rinfo)->device =3D &pdev->dev;
 	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
-		printk ("radeonfb: could not register framebuffer\n");
+		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
 		iounmap(rinfo->fb_base);
 		iounmap(rinfo->mmio_base);
 		release_mem_region (rinfo->mmio_base_phys,
@@ -3049,16 +3044,16 @@ static int radeonfb_pci_register (struct
 	}
 #endif
=20
-	printk ("radeonfb: ATI Radeon %s %s %d MB\n", rinfo->name, rinfo->ram_typ=
e,
+	pr_info ("radeonfb: ATI Radeon %s %s %d MB\n", rinfo->name, rinfo->ram_ty=
pe,
 		(rinfo->video_ram/(1024*1024)));
=20
 	if (rinfo->hasCRTC2) {
-		printk("radeonfb: DVI port %s monitor connected\n",
+		pr_info("radeonfb: DVI port %s monitor connected\n",
 			GET_MON_NAME(rinfo->dviDisp_type));
-		printk("radeonfb: CRT port %s monitor connected\n",
+		pr_info("radeonfb: CRT port %s monitor connected\n",
 			GET_MON_NAME(rinfo->crtDisp_type));
 	} else {
-		printk("radeonfb: CRT port %s monitor connected\n",
+		pr_info("radeonfb: CRT port %s monitor connected\n",
 			GET_MON_NAME(rinfo->crtDisp_type));
 	}
=20
diff -puN drivers/video/retz3fb.c~printk-drivers_video drivers/video/retz3f=
b.c
--- kj/drivers/video/retz3fb.c~printk-drivers_video	2005-03-05 16:13:24.000=
000000 +0100
+++ kj-domen/drivers/video/retz3fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -20,6 +20,8 @@
  * for more details.
  */
=20
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -44,9 +46,6 @@
=20
 #include "retz3fb.h"
=20
-/* #define DEBUG if(1) */
-#define DEBUG if(0)
-
 /*
  * Reserve space for one pattern line.
  *
@@ -125,6 +124,7 @@ static char fontname[40] __initdata =3D {=20
=20
 static char retz3fb_name[16] =3D "RetinaZ3";
=20
+#define DBG(fmt, args...) pr_debug("%s %s: " fmt, retz3fb_name, __FUNCTION=
__ , ## args)
=20
 /*
  * A small info on how to convert XFree86 timing values into fb
@@ -455,25 +455,25 @@ static int retz3_set_video(struct fb_inf
=20
 #if 0 /* testing */
=20
-	printk("HBS: %i\n", data.h_bstart);
-	printk("HSS: %i\n", data.h_sstart);
-	printk("HSE: %i\n", data.h_sstop);
-	printk("HBE: %i\n", data.h_bstop);
-	printk("HT: %i\n", data.h_total);
-
-	printk("hsync: %i\n", hsync);
-	printk("hfront: %i\n", hfront);
-	printk("hback: %i\n", hback);
-
-	printk("VBS: %i\n", data.v_bstart);
-	printk("VSS: %i\n", data.v_sstart);
-	printk("VSE: %i\n", data.v_sstop);
-	printk("VBE: %i\n", data.v_bstop);
-	printk("VT: %i\n", data.v_total);
-
-	printk("vsync: %i\n", vsync);
-	printk("vfront: %i\n", vfront);
-	printk("vback: %i\n", vback);
+	DBG("HBS: %i\n", data.h_bstart);
+	DBG("HSS: %i\n", data.h_sstart);
+	DBG("HSE: %i\n", data.h_sstop);
+	DBG("HBE: %i\n", data.h_bstop);
+	DBG("HT: %i\n", data.h_total);
+
+	DBG("hsync: %i\n", hsync);
+	DBG("hfront: %i\n", hfront);
+	DBG("hback: %i\n", hback);
+
+	DBG("VBS: %i\n", data.v_bstart);
+	DBG("VSS: %i\n", data.v_sstart);
+	DBG("VSE: %i\n", data.v_sstop);
+	DBG("VBE: %i\n", data.v_bstop);
+	DBG("VT: %i\n", data.v_total);
+
+	DBG("vsync: %i\n", vsync);
+	DBG("vfront: %i\n", vfront);
+	DBG("vback: %i\n", vback);
 #endif
=20
 	if (data.v_total >=3D 1024)
@@ -548,28 +548,28 @@ static int retz3_set_video(struct fb_inf
 	crt_w(regs, CRT_END_VER_RETR, (data.v_sstop & 0x0f) | 0x20);
=20
 	/* Zuerst zu schreibende Werte nur per printk ausgeben */
-	DEBUG printk("CRT_HOR_TOTAL: %ld\n", data.h_total);
+	DBG("CRT_HOR_TOTAL: %ld\n", data.h_total);
 	crt_w(regs, CRT_HOR_TOTAL, data.h_total & 0xff);
=20
-	DEBUG printk("CRT_HOR_DISP_ENA_END: %ld\n", data.h_dispend);
+	DBG("CRT_HOR_DISP_ENA_END: %ld\n", data.h_dispend);
 	crt_w(regs, CRT_HOR_DISP_ENA_END, (data.h_dispend) & 0xff);
=20
-	DEBUG printk("CRT_START_HOR_BLANK: %ld\n", data.h_bstart);
+	DBG("CRT_START_HOR_BLANK: %ld\n", data.h_bstart);
 	crt_w(regs, CRT_START_HOR_BLANK, data.h_bstart & 0xff);
=20
-	DEBUG printk("CRT_END_HOR_BLANK: 128+%ld\n", data.h_bstop % 32);
+	DBG("CRT_END_HOR_BLANK: 128+%ld\n", data.h_bstop % 32);
 	crt_w(regs, CRT_END_HOR_BLANK,  0x80 | (data.h_bstop & 0x1f));
=20
-	DEBUG printk("CRT_START_HOR_RETR: %ld\n", data.h_sstart);
+	DBG("CRT_START_HOR_RETR: %ld\n", data.h_sstart);
 	crt_w(regs, CRT_START_HOR_RETR, data.h_sstart & 0xff);
=20
 	tmp =3D (data.h_sstop & 0x1f);
 	if (data.h_bstop & 0x20)
 		tmp |=3D 0x80;
-	DEBUG printk("CRT_END_HOR_RETR: %d\n", tmp);
+	DBG("CRT_END_HOR_RETR: %d\n", tmp);
 	crt_w(regs, CRT_END_HOR_RETR, tmp);
=20
-	DEBUG printk("CRT_VER_TOTAL: %ld\n", data.v_total & 0xff);
+	DBG("CRT_VER_TOTAL: %ld\n", data.v_total & 0xff);
 	crt_w(regs, CRT_VER_TOTAL, (data.v_total & 0xff));
=20
 	tmp =3D 0x10;  /* LineCompare bit #9 */
@@ -587,7 +587,7 @@ static int retz3_set_video(struct fb_inf
 		tmp |=3D 0x40;
 	if (data.v_sstart & 512)
 		tmp |=3D 0x80;
-	DEBUG printk("CRT_OVERFLOW: %d\n", tmp);
+	DBG("CRT_OVERFLOW: %d\n", tmp);
 	crt_w(regs, CRT_OVERFLOW, tmp);
=20
 	crt_w(regs, CRT_PRESET_ROW_SCAN, 0x00); /* not CL !!! */
@@ -597,7 +597,7 @@ static int retz3_set_video(struct fb_inf
 		tmp |=3D 0x20;
 	if (var->vmode & FB_VMODE_DOUBLE)
 		tmp |=3D 0x80;
- 	DEBUG printk("CRT_MAX_SCAN_LINE: %d\n", tmp);
+ 	DBG("CRT_MAX_SCAN_LINE: %d\n", tmp);
 	crt_w(regs, CRT_MAX_SCAN_LINE, tmp);
=20
 	crt_w(regs, CRT_CURSOR_START, 0x00);
@@ -609,30 +609,30 @@ static int retz3_set_video(struct fb_inf
 	crt_w(regs, CRT_CURSOR_LOC_HIGH, 0x00);
 	crt_w(regs, CRT_CURSOR_LOC_LOW, 0x00);
=20
- 	DEBUG printk("CRT_START_VER_RETR: %ld\n", data.v_sstart & 0xff);
+ 	DBG("CRT_START_VER_RETR: %ld\n", data.v_sstart & 0xff);
 	crt_w(regs, CRT_START_VER_RETR, (data.v_sstart & 0xff));
=20
 #if 1
 	/* 5 refresh cycles per scanline */
-	DEBUG printk("CRT_END_VER_RETR: 64+32+%ld\n", data.v_sstop % 16);
+	DBG("CRT_END_VER_RETR: 64+32+%ld\n", data.v_sstop % 16);
 	crt_w(regs, CRT_END_VER_RETR, ((data.v_sstop & 0x0f) | 0x40 | 0x20));
 #else
-	DEBUG printk("CRT_END_VER_RETR: 128+32+%ld\n", data.v_sstop % 16);
+	DBG("CRT_END_VER_RETR: 128+32+%ld\n", data.v_sstop % 16);
 	crt_w(regs, CRT_END_VER_RETR, ((data.v_sstop & 0x0f) | 128 | 32));
 #endif
-	DEBUG printk("CRT_VER_DISP_ENA_END: %ld\n", data.v_dispend & 0xff);
+	DBG("CRT_VER_DISP_ENA_END: %ld\n", data.v_dispend & 0xff);
 	crt_w(regs, CRT_VER_DISP_ENA_END, (data.v_dispend & 0xff));
=20
-	DEBUG printk("CRT_START_VER_BLANK: %ld\n", data.v_bstart & 0xff);
+	DBG("CRT_START_VER_BLANK: %ld\n", data.v_bstart & 0xff);
 	crt_w(regs, CRT_START_VER_BLANK, (data.v_bstart & 0xff));
=20
-	DEBUG printk("CRT_END_VER_BLANK: %ld\n", data.v_bstop & 0xff);
+	DBG("CRT_END_VER_BLANK: %ld\n", data.v_bstop & 0xff);
 	crt_w(regs, CRT_END_VER_BLANK, (data.v_bstop & 0xff));
=20
-	DEBUG printk("CRT_MODE_CONTROL: 0xe3\n");
+	DBG("CRT_MODE_CONTROL: 0xe3\n");
 	crt_w(regs, CRT_MODE_CONTROL, 0xe3);
=20
-	DEBUG printk("CRT_LINE_COMPARE: 0xff\n");
+	DBG("CRT_LINE_COMPARE: 0xff\n");
 	crt_w(regs, CRT_LINE_COMPARE, 0xff);
=20
 	tmp =3D (var->xres_virtual / 8) * (bpp / 8);
@@ -651,7 +651,7 @@ static int retz3_set_video(struct fb_inf
 		tmp |=3D 0x08;
 	if (var->vmode & FB_VMODE_INTERLACED)
 		tmp |=3D 0x10;
- 	DEBUG printk("CRT_EXT_HOR_TIMING1: %d\n", tmp);
+ 	DBG("CRT_EXT_HOR_TIMING1: %d\n", tmp);
 	crt_w(regs, CRT_EXT_HOR_TIMING1, tmp);
=20
 	tmp =3D 0x00;
@@ -671,7 +671,7 @@ static int retz3_set_video(struct fb_inf
 	tmp |=3D ((data.h_bstop & 0xc0) >> 2);
 	tmp |=3D ((data.h_sstop & 0x60) << 1);
 	crt_w(regs, CRT_EXT_HOR_TIMING2, tmp);
- 	DEBUG printk("CRT_EXT_HOR_TIMING2: %d\n", tmp);
+ 	DBG("CRT_EXT_HOR_TIMING2: %d\n", tmp);
=20
 	tmp =3D 0x10;			/* Line compare bit 10 */
 	if (data.v_total & 0x400)
@@ -686,7 +686,7 @@ static int retz3_set_video(struct fb_inf
 	if (data.v_sstop & 0x10)
 		tmp |=3D 0x80;
 	crt_w(regs, CRT_EXT_VER_TIMING, tmp);
- 	DEBUG printk("CRT_EXT_VER_TIMING: %d\n", tmp);
+ 	DBG("CRT_EXT_VER_TIMING: %d\n", tmp);
=20
 	crt_w(regs, CRT_MONITOR_POWER, 0x00);
=20
diff -puN drivers/video/riva/fbdev.c~printk-drivers_video drivers/video/riv=
a/fbdev.c
--- kj/drivers/video/riva/fbdev.c~printk-drivers_video	2005-03-05 16:13:24.=
000000000 +0100
+++ kj-domen/drivers/video/riva/fbdev.c	2005-03-05 16:13:24.000000000 +0100
@@ -68,9 +68,10 @@
  *
  * -----------------------------------------------------------------------=
-- */
 #ifdef CONFIG_FB_RIVA_DEBUG
-#define NVTRACE          printk
+#define DEBUG
+#define NVTRACE          pr_debug
 #else
-#define NVTRACE          if(0) printk
+#define NVTRACE          if(0) pr_debug
 #endif
=20
 #define NVTRACE_ENTER(...)  NVTRACE("%s START\n", __FUNCTION__)
@@ -79,7 +80,7 @@
 #ifdef CONFIG_FB_RIVA_DEBUG
 #define assert(expr) \
 	if(!(expr)) { \
-	printk( "Assertion failed! %s,%s,%s,line=3D%d\n",\
+	pr_debug( "Assertion failed! %s,%s,%s,line=3D%d\n",\
 	#expr,__FILE__,__FUNCTION__,__LINE__); \
 	BUG(); \
 	}
@@ -1780,7 +1781,7 @@ static int __devinit riva_get_EDID_i2c(s
 	for (i =3D 0; i < par->bus; i++) {
 		riva_probe_i2c_connector(par, i+1, &par->EDID);
 		if (par->EDID && !fb_parse_edid(par->EDID, &var)) {
-			printk(PFX "Found EDID Block from BUS %i\n", i);
+			pr_info(PFX "Found EDID Block from BUS %i\n", i);
 			break;
 		}
 	}
@@ -1829,10 +1830,10 @@ static void __devinit riva_get_EDID(stru
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
 	if (!riva_get_EDID_OF(info, pdev))
-		printk(PFX "could not retrieve EDID from OF\n");
+		pr_info(PFX "could not retrieve EDID from OF\n");
 #elif CONFIG_FB_RIVA_I2C
 	if (!riva_get_EDID_i2c(info))
-		printk(PFX "could not retrieve EDID from DDC/I2C\n");
+		pr_info(PFX "could not retrieve EDID from DDC/I2C\n");
 #endif
 	NVTRACE_LEAVE();
 }
diff -puN drivers/video/savage/savagefb.c~printk-drivers_video drivers/vide=
o/savage/savagefb.c
--- kj/drivers/video/savage/savagefb.c~printk-drivers_video	2005-03-05 16:1=
3:24.000000000 +0100
+++ kj-domen/drivers/video/savage/savagefb.c	2005-03-05 16:13:24.000000000 =
+0100
@@ -41,6 +41,8 @@
  *
  */
=20
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -474,7 +476,7 @@ static int common_calc_clock(long freq,=20
 	return 0;
 }
=20
-#ifdef SAVAGEFB_DEBUG
+#ifdef DEBUG
 /* This function is used to debug, it prints out the contents of s3 regs */
=20
 static void SavagePrintRegs(void)
@@ -483,27 +485,32 @@ static void SavagePrintRegs(void)
 	int vgaCRIndex =3D 0x3d4;
 	int vgaCRReg =3D 0x3d5;
=20
-	printk(KERN_DEBUG "SR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE "
-	       "xF" );
+	pr_debug("SR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF" );
=20
 	for( i =3D 0; i < 0x70; i++ ) {
-		if( !(i % 16) )
-			printk(KERN_DEBUG "\nSR%xx ", i >> 4 );
+		if( !(i % 16) ) {
+			printk("\n");
+			pr_debug("SR%xx ", i >> 4 );
+		}
 		vga_out8( 0x3c4, i );
-		printk(KERN_DEBUG " %02x", vga_in8(0x3c5) );
+		printk(" %02x", vga_in8(0x3c5) );
 	}
+	printk("\n");
=20
-	printk(KERN_DEBUG "\n\nCR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC "
-	       "xD xE xF" );
+	pr_debug("---BREAK---\n");
+	pr_debug("CR    x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF" );
=20
 	for( i =3D 0; i < 0xB7; i++ ) {
-		if( !(i % 16) )
-			printk(KERN_DEBUG "\nCR%xx ", i >> 4 );
+		if( !(i % 16) ) {
+			printk("\n");
+			pr_debug("CR%xx ", i >> 4 );
+		}
 		vga_out8( vgaCRIndex, i );
-		printk(KERN_DEBUG " %02x", vga_in8(vgaCRReg) );
+		pr_debug(" %02x", vga_in8(vgaCRReg) );
 	}
+	printk("\n");
=20
-	printk(KERN_DEBUG "\n\n");
+	pr_debug("---END---\n");
 }
 #endif
=20
@@ -1489,7 +1496,7 @@ static int __devinit savage_map_mmio (st
=20
 	par->mmio.vbase =3D ioremap (par->mmio.pbase, par->mmio.len);
 	if (!par->mmio.vbase) {
-		printk ("savagefb: unable to map memory mapped IO\n");
+		printk (KERN_ERR "savagefb: unable to map memory mapped IO\n");
 		return -ENOMEM;
 	} else
 		printk (KERN_INFO "savagefb: mapped io at %p\n",
@@ -1537,7 +1544,7 @@ static int __devinit savage_map_video (s
 	par->video.vbase =3D ioremap (par->video.pbase, par->video.len);
=20
 	if (!par->video.vbase) {
-		printk ("savagefb: unable to map screen memory\n");
+		printk (KERN_ERR "savagefb: unable to map screen memory\n");
 		return -ENOMEM;
 	} else
 		printk (KERN_INFO "savagefb: mapped framebuffer at %p, "
diff -puN drivers/video/sstfb.c~printk-drivers_video drivers/video/sstfb.c
--- kj/drivers/video/sstfb.c~printk-drivers_video	2005-03-05 16:13:24.00000=
0000 +0100
+++ kj-domen/drivers/video/sstfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -790,7 +790,7 @@ static int sstfb_ioctl(struct inode *ino
 			return -EFAULT;
 		if (val > info->fix.smem_len)
 			val =3D info->fix.smem_len;
-		printk("filling %#x \n", val);
+		printk(KERN_DEBUG "filling %#x \n", val);
 		for (p=3D0 ; p<val; p+=3D2)
 			writew(p >> 6, info->screen_base + p);
 		return 0;
diff -puN drivers/video/sun3fb.c~printk-drivers_video drivers/video/sun3fb.c
--- kj/drivers/video/sun3fb.c~printk-drivers_video	2005-03-05 16:13:24.0000=
00000 +0100
+++ kj-domen/drivers/video/sun3fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -645,7 +645,7 @@ sizechange:
 		kfree(fb);
 		return -EINVAL;
 	}
-	printk("fb%d: %s\n", fb->info.node, p);
+	pr_info("fb%d: %s\n", fb->info.node, p);
=20
 	return 0;
 }
@@ -667,14 +667,14 @@ int __init sun3fb_init(void)
 	case FBTYPE_SUN3COLOR:
 	case FBTYPE_SUN4COLOR:
 		if(idprom->id_machtype !=3D (SM_SUN3|SM_3_60)) {
-			printk("sun3fb: cgthree/four only supported on 3/60\n");
+			printk(KERN_ERR "sun3fb: cgthree/four only supported on 3/60\n");
 			return -ENODEV;
 		}
 	=09
 		addr =3D CGFOUR_OBMEM_ADDR;
 		return sun3fb_init_fb(*(romvec->pv_fbtype), addr);
 	default:
-		printk("sun3fb: unsupported framebuffer\n");
+		printk(KERN_ERR "sun3fb: unsupported framebuffer\n");
 		return -ENODEV;
 	}
 #else
diff -puN drivers/video/tcx.c~printk-drivers_video drivers/video/tcx.c
--- kj/drivers/video/tcx.c~printk-drivers_video	2005-03-05 16:13:24.0000000=
00 +0100
+++ kj-domen/drivers/video/tcx.c	2005-03-05 16:13:24.000000000 +0100
@@ -450,7 +450,7 @@ static void tcx_init_one(struct sbus_dev
=20
 	list_add(&all->list, &tcx_list);
=20
-	printk("tcx: %s at %lx:%lx, %s\n",
+	pr_info("tcx: %s at %lx:%lx, %s\n",
 	       sdev->prom_name,
 	       (long) sdev->reg_addrs[0].which_io,
 	       (long) sdev->reg_addrs[0].phys_addr,
diff -puN drivers/video/tdfxfb.c~printk-drivers_video drivers/video/tdfxfb.c
--- kj/drivers/video/tdfxfb.c~printk-drivers_video	2005-03-05 16:13:24.0000=
00000 +0100
+++ kj-domen/drivers/video/tdfxfb.c	2005-03-05 16:13:24.000000000 +0100
@@ -4,7 +4,7 @@
  *
  * Author: Hannu Mallat <hmallat@cc.hut.fi>
  *
- * Copyright =A9 1999 Hannu Mallat
+ * Copyright  1999 Hannu Mallat
  * All rights reserved
  *
  * Created      : Thu Sep 23 18:17:43 1999, hmallat
@@ -1178,7 +1178,7 @@ static int __devinit tdfxfb_probe(struct
 	tdfx_fix.mmio_len =3D pci_resource_len(pdev, 0);
 	default_par->regbase_virt =3D ioremap_nocache(tdfx_fix.mmio_start, tdfx_f=
ix.mmio_len);
 	if (!default_par->regbase_virt) {
-		printk("fb: Can't remap %s register area.\n", tdfx_fix.id);
+		printk(KERN_WARNING "fb: Can't remap %s register area.\n", tdfx_fix.id);
 		goto out_err;
 	}
    =20
@@ -1190,7 +1190,7 @@ static int __devinit tdfxfb_probe(struct
=20
 	tdfx_fix.smem_start =3D pci_resource_start(pdev, 1);
 	if (!(tdfx_fix.smem_len =3D do_lfb_size(default_par, pdev->device))) {
-		printk("fb: Can't count %s memory.\n", tdfx_fix.id);
+		printk(KERN_WARNING "fb: Can't count %s memory.\n", tdfx_fix.id);
 		release_mem_region(pci_resource_start(pdev, 0),
 				   pci_resource_len(pdev, 0));
 		goto out_err;=09
@@ -1207,7 +1207,7 @@ static int __devinit tdfxfb_probe(struct
 	info->screen_base =3D ioremap_nocache(tdfx_fix.smem_start,=20
 					    tdfx_fix.smem_len);
 	if (!info->screen_base) {
-		printk("fb: Can't remap %s framebuffer.\n", tdfx_fix.id);
+		printk(KERN_WARNING "fb: Can't remap %s framebuffer.\n", tdfx_fix.id);
 		release_mem_region(pci_resource_start(pdev, 1),
 				   pci_resource_len(pdev, 1));
 		release_mem_region(pci_resource_start(pdev, 0),
@@ -1227,7 +1227,7 @@ static int __devinit tdfxfb_probe(struct
 		goto out_err;
 	}
=20
-	printk("fb: %s memory =3D %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
+	pr_info("fb: %s memory =3D %dK\n", tdfx_fix.id, tdfx_fix.smem_len >> 10);
=20
 	tdfx_fix.ypanstep	=3D nopan ? 0 : 1;
 	tdfx_fix.ywrapstep	=3D nowrap ? 0 : 1;
@@ -1270,7 +1270,7 @@ static int __devinit tdfxfb_probe(struct
 	}
=20
 	if (register_framebuffer(info) < 0) {
-		printk("tdfxfb: can't register framebuffer\n");
+		printk(KERN_WARNING "tdfxfb: can't register framebuffer\n");
 		fb_dealloc_cmap(&info->cmap);
 		goto out_err;
 	}
diff -puN drivers/video/virgefb.c~printk-drivers_video drivers/video/virgef=
b.c
--- kj/drivers/video/virgefb.c~printk-drivers_video	2005-03-05 16:13:24.000=
000000 +0100
+++ kj-domen/drivers/video/virgefb.c	2005-03-05 16:13:24.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/video/virgefb.c -- CyberVision64/3D frame buffer device
  *
- *    Copyright (C) 1997 Andr=E9 Heynatz
+ *    Copyright (C) 1997 Andr=EF=BF=BDHeynatz
  *
  *
  * This file is based on the CyberVision frame buffer device (cyberfb.c):
@@ -2157,7 +2157,7 @@ static unsigned short virgefb_compute_cl
 		}
 	}
 	if (save =3D=3D ~0UL)
-		printk("Can't compute clock PLL values for %ld Hz clock\n", freq);
+		printk(KERN_NOTICE "Can't compute clock PLL values for %ld Hz clock\n", =
freq);
 	DPRINTK("EXIT\n");
 	return(mnr);
 }
@@ -2435,20 +2435,20 @@ static void cv64_dump(void)
 	printk("\n");
 	for (i =3D 0; i <=3D 0x6f; i++) {
 		wb_mmio(CRT_ADDRESS, i);
-		printk("crt idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(CRT_ADDRESS_R));
+		pr_info("crt idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(CRT_ADDRESS_R));
 	}
 	for (i =3D 0; i <=3D 0x1c; i++) {
 		wb_mmio(SEQ_ADDRESS, i);
-		printk("seq idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(SEQ_ADDRESS_R));
+		pr_info("seq idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(SEQ_ADDRESS_R));
 	}
 	for (i =3D 0; i <=3D 8; i++) {
 		wb_mmio(GCT_ADDRESS, i);
-		printk("gfx idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(GCT_ADDRESS_R));
+		pr_info("gfx idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(GCT_ADDRESS_R));
 	}
 	for (i =3D 0; i <=3D 0x14; i++) {
 		c =3D rb_mmio(ACT_ADDRESS_RESET);
 		wb_mmio(ACT_ADDRESS_W, i);
-		printk("atr idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(ACT_ADDRESS_R));
+		pr_info("atr idx : 0x%2.2x : 0x%2.2x\n", i, rb_mmio(ACT_ADDRESS_R));
 	}
=20
 	/* re-enable video access to palette */
@@ -2461,23 +2461,23 @@ static void cv64_dump(void)
=20
 	/* general regs */
=20
-	printk("0x3cc(w 0x3c2) : 0x%2.2x\n", rb_mmio(0x3cc));	/* GREG_MISC_OUTPUT=
 READ */
-	printk("0x3c2(-------) : 0x%2.2x\n", rb_mmio(0x3c2));	/* GREG_INPUT_STATU=
S 0 READ */
-	printk("0x3c3(w 0x3c3) : 0x%2.2x\n", rb_vgaio(0x3c3));	/* GREG_VIDEO_SUBS=
_ENABLE */
-	printk("0x3ca(w 0x3da) : 0x%2.2x\n", rb_vgaio(0x3ca));	/* GREG_FEATURE_CO=
NTROL read */
-	printk("0x3da(-------) : 0x%2.2x\n", rb_mmio(0x3da));	/* GREG_INPUT_STATU=
S 1 READ */
+	pr_info("0x3cc(w 0x3c2) : 0x%2.2x\n", rb_mmio(0x3cc));	/* GREG_MISC_OUTPU=
T READ */
+	pr_info("0x3c2(-------) : 0x%2.2x\n", rb_mmio(0x3c2));	/* GREG_INPUT_STAT=
US 0 READ */
+	pr_info("0x3c3(w 0x3c3) : 0x%2.2x\n", rb_vgaio(0x3c3));	/* GREG_VIDEO_SUB=
S_ENABLE */
+	pr_info("0x3ca(w 0x3da) : 0x%2.2x\n", rb_vgaio(0x3ca));	/* GREG_FEATURE_C=
ONTROL read */
+	pr_info("0x3da(-------) : 0x%2.2x\n", rb_mmio(0x3da));	/* GREG_INPUT_STAT=
US 1 READ */
=20
 	/* engine regs */
=20
 	for (i =3D 0x8180; i <=3D 0x8200; i =3D i + 4)
-		printk("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
+		pr_info("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
=20
 	i =3D 0x8504;
-	printk("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
+	pr_info("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
 	i =3D 0x850c;
-	printk("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
+	pr_info("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
 	for (i =3D 0xa4d4; i <=3D 0xa50c; i =3D i + 4)
-		printk("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
+		pr_info("0x%8.8x : 0x%8.8x\n", i, rl_mmio(i));
=20
 	/* PCI regs */
=20
@@ -2485,29 +2485,29 @@ static void cv64_dump(void)
=20
 	for (c =3D 0; c < 0x08; c =3D c + 2) {
 		w =3D (*((u16 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)) ^ =
2)));
-		printk("pci 0x%2.2x : 0x%4.4x\n", c, w);
+		pr_info("pci 0x%2.2x : 0x%4.4x\n", c, w);
 	}
 	c =3D 8;
 	l =3D (*((u32 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)))));
-	printk("pci 0x%2.2x : 0x%8.8x\n", c, l);
+	pr_info("pci 0x%2.2x : 0x%8.8x\n", c, l);
 	c =3D 0x0d;
 	b =3D (*((u8 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)) ^ 3)=
));
-	printk("pci 0x%2.2x : 0x%2.2x\n", c, b);
+	pr_info("pci 0x%2.2x : 0x%2.2x\n", c, b);
 	c =3D 0x10;
 	l =3D (*((u32 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)))));
-	printk("pci 0x%2.2x : 0x%8.8x\n", c, l);
+	pr_info("pci 0x%2.2x : 0x%8.8x\n", c, l);
 	c =3D 0x30;
 	l =3D (*((u32 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)))));
-	printk("pci 0x%2.2x : 0x%8.8x\n", c, l);
+	pr_info("pci 0x%2.2x : 0x%8.8x\n", c, l);
 	c =3D 0x3c;
 	b =3D (*((u8 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)) ^ 3)=
));
-	printk("pci 0x%2.2x : 0x%2.2x\n", c, b);
+	pr_info("pci 0x%2.2x : 0x%2.2x\n", c, b);
 	c =3D 0x3d;
 	b =3D (*((u8 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)) ^ 3)=
));
-	printk("pci 0x%2.2x : 0x%2.2x\n", c, b);
+	pr_info("pci 0x%2.2x : 0x%2.2x\n", c, b);
 	c =3D 0x3e;
 	w =3D (*((u16 *)((u32)(vgaio_regs + c + (on_zorro2 ? 0 : 0x000e0000)) ^ 2=
)));
-	printk("pci 0x%2.2x : 0x%4.4x\n", c, w);
+	pr_info("pci 0x%2.2x : 0x%4.4x\n", c, w);
 	SelectMMIO;
 }
 #endif
diff -puN drivers/video/w100fb.c~printk-drivers_video drivers/video/w100fb.c
--- kj/drivers/video/w100fb.c~printk-drivers_video	2005-03-05 16:13:24.0000=
00000 +0100
+++ kj-domen/drivers/video/w100fb.c	2005-03-05 16:13:24.000000000 +0100
@@ -143,7 +143,7 @@ static ssize_t w100fb_reg_read(struct de
 	unsigned long regs;
 	regs =3D simple_strtoul(buf, NULL, 16);
 	param =3D readl(remapped_regs + regs);
-	printk("Read Register 0x%08lX: 0x%08lX\n", regs, param);
+	printk(KERN_DEBUG "Read Register 0x%08lX: 0x%08lX\n", regs, param);
 	return count;
 }
=20
@@ -156,7 +156,7 @@ static ssize_t w100fb_reg_write(struct d
 	sscanf(buf, "%lx %lx", &regs, &param);
=20
 	if (regs <=3D 0x2000) {
-		printk("Write Register 0x%08lX: 0x%08lX\n", regs, param);
+		printk(KERN_DEBUG "Write Register 0x%08lX: 0x%08lX\n", regs, param);
 		writel(param, remapped_regs + regs);
 	}
=20
@@ -183,11 +183,11 @@ static ssize_t fastsysclk_store(struct d
 	param =3D simple_strtoul(buf, NULL, 10);
=20
 	if (param =3D=3D 75) {
-		printk("Set fastsysclk %d\n", param);
+		printk(KERN_DEBUG "Set fastsysclk %d\n", param);
 		par->fastsysclk_mode =3D param;
 		w100_set_fastsysclk(par->fastsysclk_mode);
 	} else if (param =3D=3D 100) {
-		printk("Set fastsysclk %d\n", param);
+		printk(KERN_DEBUG "Set fastsysclk %d\n", param);
 		par->fastsysclk_mode =3D param;
 		w100_set_fastsysclk(par->fastsysclk_mode);
 	}
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
