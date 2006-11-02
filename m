From: akpm@osdl.org
Subject: [patch 18/25] atyfb: Fix compiler warnings
Date: Wed, 01 Nov 2006 21:50:29 -0800
Message-ID: <200611020550.kA25oTH9002342@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVTH-0007YB-3s for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:35 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVTG-0008RA-PW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:50:35 -0800
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
Cc: akpm@osdl.org, adaplas@pol.net, syrjala@sci.fi

From: Ville Syrjala <syrjala@sci.fi>

Fix some compiler warnings and remove an #ifdef.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/atyfb_base.c |   35 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff -puN drivers/video/aty/atyfb_base.c~atyfb-fix-compiler-warnings drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c~atyfb-fix-compiler-warnings
+++ a/drivers/video/aty/atyfb_base.c
@@ -2350,11 +2350,7 @@ static int __devinit aty_init(struct fb_
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
@@ -2464,18 +2460,21 @@ static int __devinit aty_init(struct fb_
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
@@ -2668,6 +2667,7 @@ static int __devinit aty_init(struct fb_
 				has_var = 1;
 		} else {
 			if (default_vmode == VMODE_CHOOSE) {
+				int sense;
 				if (M64_HAS(G3_PB_1024x768))
 					/* G3 PowerBook with 1024x768 LCD */
 					default_vmode = VMODE_1024_768_60;
@@ -3711,6 +3711,8 @@ static int __devinit atyfb_atari_probe(v
 
 #endif /* CONFIG_ATARI */
 
+#ifdef CONFIG_PCI
+
 static void __devexit atyfb_remove(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -3758,7 +3760,6 @@ static void __devexit atyfb_remove(struc
 	framebuffer_release(info);
 }
 
-#ifdef CONFIG_PCI
 
 static void __devexit atyfb_pci_remove(struct pci_dev *pdev)
 {
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
