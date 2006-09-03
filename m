From: syrjala@sci.fi
Subject: [patch 2/9] atyfb: Fix compiler warnings
Date: Mon, 04 Sep 2006 01:06:49 +0300
Message-ID: <20060903220659.843881353@proteus.korsu.shacknet.nu>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0160811461=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RD-A8 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp3.pp.htv.fi ([213.243.153.36])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00u-0004pq-40
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
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
Cc: alex.kern@gmx.de, Ville Syrjala <syrjala@sci.fi>

--===============0160811461==
Content-Disposition: inline; filename=atyfb_fix_compiler_warnings.patch

Fix some compiler warnings and remove an #ifdef.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb_base.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -2349,11 +2349,7 @@ static int __devinit aty_init(struct fb_
 	const char *ramname = NULL, *xtal;
 	int gtb_memsize, has_var = 0;
 	struct fb_var_screeninfo var;
-	u8 pll_ref_div;
 	u32 i;
-#if defined(CONFIG_PPC)
-	int sense;
-#endif
 
 	init_waitqueue_head(&par->vblank.wait);
 	spin_lock_init(&par->int_lock);
@@ -2463,18 +2459,21 @@ static int __devinit aty_init(struct fb_
 			par->pll_limits.mclk = 63;
 	}
 
-	if (M64_HAS(GTB_DSP)
-	    && (pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par))) {
-		int diff1, diff2;
-		diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
-		diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
-		if (diff1 < 0)
-			diff1 = -diff1;
-		if (diff2 < 0)
-			diff2 = -diff2;
-		if (diff2 < diff1) {
-			par->ref_clk_per = 1000000000000ULL / 29498928;
-			xtal = "29.498928";
+	if (M64_HAS(GTB_DSP)) {
+		u8 pll_ref_div = aty_ld_pll_ct(PLL_REF_DIV, par);
+
+		if (pll_ref_div) {
+			int diff1, diff2;
+			diff1 = 510 * 14 / pll_ref_div - par->pll_limits.pll_max;
+			diff2 = 510 * 29 / pll_ref_div - par->pll_limits.pll_max;
+			if (diff1 < 0)
+				diff1 = -diff1;
+			if (diff2 < 0)
+				diff2 = -diff2;
+			if (diff2 < diff1) {
+				par->ref_clk_per = 1000000000000ULL / 29498928;
+				xtal = "29.498928";
+			}
 		}
 	}
 #endif /* CONFIG_FB_ATY_CT */
@@ -2667,6 +2666,7 @@ static int __devinit aty_init(struct fb_
 				has_var = 1;
 		} else {
 			if (default_vmode == VMODE_CHOOSE) {
+				int sense;
 				if (M64_HAS(G3_PB_1024x768))
 					/* G3 PowerBook with 1024x768 LCD */
 					default_vmode = VMODE_1024_768_60;
@@ -3702,6 +3702,8 @@ static int __devinit atyfb_atari_probe(v
 
 #endif /* CONFIG_ATARI */
 
+#ifdef CONFIG_PCI
+
 static void __devexit atyfb_remove(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -3749,7 +3751,6 @@ static void __devexit atyfb_remove(struc
 	framebuffer_release(info);
 }
 
-#ifdef CONFIG_PCI
 
 static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
 {

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============0160811461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0160811461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0160811461==--
