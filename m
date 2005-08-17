From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Atari aty patch
Date: Wed, 17 Aug 2005 20:22:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508172019150.16408@anakin>
References: <Pine.LNX.4.56.0508151749500.7300@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5q9d-000755-QC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Aug 2005 12:34:21 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E5q3E-0002Gv-6F
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 18 Aug 2005 12:27:44 -0700
Received: from amsfep16-int.chello.nl ([213.46.243.25])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1E5SwN-0005uD-AD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 11:47:08 -0700
In-Reply-To: <Pine.LNX.4.56.0508151749500.7300@pentafluge.infradead.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-m68k@vger.kernel.org

On Mon, 15 Aug 2005, James Simmons wrote:
> Could someone try this patch to make sure it works.

After adding these:
  - Kill warning about unused local variable pll_ref_div
  - Add missing return in atyfb_atari_probe()

we still need a call somewhere to correct_chipset(), and it gives the
compile errors listed below.

--- linux/drivers/video/aty/atyfb_base.c.james	2005-08-17 20:14:12.000000000 +0200
+++ linux/drivers/video/aty/atyfb_base.c	2005-08-17 20:11:06.000000000 +0200
@@ -2171,7 +2171,6 @@ static int __init aty_init(struct fb_inf
 	const char *ramname = NULL, *xtal;
 	int gtb_memsize;
 	struct fb_var_screeninfo var;
-	u8 pll_ref_div;
 	u32 i;
 #if defined(CONFIG_PPC)
 	int sense;
@@ -2284,18 +2283,20 @@ static int __init aty_init(struct fb_inf
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
@@ -3576,13 +3577,16 @@ static int __devinit atyfb_atari_probe(s
 			par->clk_wr_offset = 0; /* Panther 1 ISA Adapter (Gerald) */
 			break;
 		}
-	}
+
+// FIXME
+//rc = correct_chipset(par);
 
 	if (aty_init(info, "ISA bus")) {
 		framebuffer_release(info);
 		/* This is insufficient! kernel_map has added two large chunks!! */
 		return -ENXIO;
 	}
+	return 0;
 }
 
 static void __devexit atyfb_atari_remove(struct device *dev)


drivers/video/aty/atyfb_base.c: In function `store_video_par':
drivers/video/aty/atyfb_base.c:3521: warning: passing arg 3 of `platform_device_register_simple' from incompatible pointer type
drivers/video/aty/atyfb_base.c: In function `atyfb_atari_probe':
drivers/video/aty/atyfb_base.c:3549: dereferencing pointer to incomplete type
drivers/video/aty/atyfb_base.c:3561: dereferencing pointer to incomplete type
drivers/video/aty/atyfb_base.c:3563: warning: passing arg 3 of `aty_st_le32' from incompatible pointer type
drivers/video/aty/atyfb_base.c:3564: warning: passing arg 2 of `aty_ld_le32' from incompatible pointer type
drivers/video/aty/atyfb_base.c:3568: dereferencing pointer to incomplete type
drivers/video/aty/atyfb_base.c:3571: dereferencing pointer to incomplete type
drivers/video/aty/atyfb_base.c:3574: dereferencing pointer to incomplete type
drivers/video/aty/atyfb_base.c:3577: dereferencing pointer to incomplete type
drivers/video/aty/atyfb_base.c: At top level:
drivers/video/aty/atyfb_base.c:3602: warning: initialization from incompatible pointer type
drivers/video/aty/atyfb_base.c: In function `atyfb_init':
drivers/video/aty/atyfb_base.c:3703: warning: passing arg 1 of `platform_device_unregister' from incompatible pointer type
drivers/video/aty/atyfb_base.c: In function `atyfb_exit':
drivers/video/aty/atyfb_base.c:3719: warning: passing arg 1 of `platform_device_unregister' from incompatible pointer type
drivers/video/aty/atyfb_base.c: At top level:
drivers/video/aty/atyfb_base.c:415: warning: `correct_chipset' defined but not used

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
