From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: MTRR support
Date: Wed, 25 Aug 2004 02:46:30 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040824234630.GA20966@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bzkzp-0007FE-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Aug 2004 16:46:33 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bzkzp-0006iv-4s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Aug 2004 16:46:33 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 024561913B
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 25 Aug 2004 02:46:31 +0300 (EEST)
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


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The attached patch adds MTRR support to atyfb.

Write-combining is enabled for the whole PCI resource and an uncachable=20
hole is made for MMIO registers if necessary.

I also changed aty_init() to return 0 on success like the other functions=
.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-mtrr.patch"

diff -NaurbB linux-irq2/drivers/video/aty/atyfb.h linux-mtrr/drivers/video/aty/atyfb.h
--- linux-irq2/drivers/video/aty/atyfb.h	2004-07-22 21:08:19.000000000 +0300
+++ linux-mtrr/drivers/video/aty/atyfb.h	2004-08-16 10:13:14.000000000 +0300
@@ -178,6 +178,10 @@
 	unsigned long irq_flags;
 	unsigned int irq;
 	spinlock_t int_lock;
+#ifdef CONFIG_MTRR
+	int mtrr_aper;
+	int mtrr_reg;
+#endif
 };
 
     /*
diff -NaurbB linux-irq2/drivers/video/aty/atyfb_base.c linux-mtrr/drivers/video/aty/atyfb_base.c
--- linux-irq2/drivers/video/aty/atyfb_base.c	2004-08-25 01:52:01.631006776 +0300
+++ linux-mtrr/drivers/video/aty/atyfb_base.c	2004-08-25 01:51:41.023139648 +0300
@@ -92,6 +92,9 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
+#ifdef CONFIG_MTRR
+#include <asm/mtrr.h>
+#endif
 
 
 /*
@@ -286,6 +289,7 @@
 };
 
 static char noaccel __initdata = 0;
+static char nomtrr __initdata = 0;
 static u32 default_vram __initdata = 0;
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
@@ -2388,6 +2392,26 @@
 	if (par->aux_start)
 		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
 
+#ifdef CONFIG_MTRR
+	par->mtrr_aper = -1;
+	par->mtrr_reg = -1;
+	if (!nomtrr) {
+		/* Cover the whole resource. */
+		par->mtrr_aper = mtrr_add(par->res_start,
+					  par->res_size, MTRR_TYPE_WRCOMB, 1);
+		if (par->mtrr_aper >= 0 && !par->aux_start) {
+			/* Make a hole for mmio. */
+			par->mtrr_reg = mtrr_add(par->res_start + 0x800000 -
+						 GUI_RESERVE, GUI_RESERVE,
+						 MTRR_TYPE_UNCACHABLE, 1);
+			if (par->mtrr_reg < 0) {
+				mtrr_del(par->mtrr_aper, 0, 0);
+				par->mtrr_aper = -1;
+			}
+		}
+	}
+#endif
+
 	/* Clear the video memory */
 	fb_memset((void *) info->screen_base, 0, info->fix.smem_len);
 
@@ -2457,7 +2481,7 @@
 
 	if (atyfb_check_var(&var, info)) {
 		printk(KERN_CRIT "atyfb: can't set default video mode\n");
-		return 0;
+		goto err_del_mtrr;
 	}
 
 #ifdef __sparc__
@@ -2473,13 +2497,22 @@
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	if (register_framebuffer(info) < 0)
-		return 0;
+		goto err_del_mtrr;
 
 	fb_list = info;
 
 	printk("fb%d: %s frame buffer device on %s\n",
 	       info->node, info->fix.id, name);
-	return 1;
+	return 0;
+
+ err_del_mtrr:
+#ifdef CONFIG_MTRR
+	if (par->mtrr_reg >= 0)
+		mtrr_del(par->mtrr_reg, 0, 0);
+	if (par->mtrr_aper >= 0)
+		mtrr_del(par->mtrr_aper, 0, 0);
+#endif
+	return -1;
 }
 
 #ifndef MODULE
@@ -2493,6 +2526,8 @@
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "noaccel", 7))
 			noaccel = 1;
+		else if (!strncmp(this_opt, "nomtrr", 6))
+			nomtrr = 1;
 		else if (!strncmp(this_opt, "vram:", 5))
 			default_vram =
 			    simple_strtoul(this_opt + 5, NULL, 0);
@@ -3364,7 +3399,7 @@
 	pci_set_drvdata(pdev, info);
 
 	/* Init chip & register framebuffer */
-	if (!aty_init(info, "PCI"))
+	if (aty_init(info, "PCI"))
 		goto err_release_io;
 
 #ifdef __sparc__
@@ -3466,7 +3501,7 @@
 			break;
 		}
 
-		if (!aty_init(info, "ISA bus")) {
+		if (aty_init(info, "ISA bus")) {
 			framebuffer_release(info);
 			/* This is insufficient! kernel_map has added two large chunks!! */
 			return -ENXIO;
@@ -3482,6 +3517,12 @@
 
 	unregister_framebuffer(info);
 
+#ifdef CONFIG_MTRR
+	if (par->mtrr_reg >= 0)
+		mtrr_del(par->mtrr_reg, 0, 0);
+	if (par->mtrr_aper >= 0)
+		mtrr_del(par->mtrr_aper, 0, 0);
+#endif
 #ifndef __sparc__
 	if (par->ati_regbase)
 		iounmap((void *) par->ati_regbase);

--tKW2IUtsqtDRztdT--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
