From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [FBDEV BK] Updates and fixes.
Date: Wed, 16 Apr 2003 08:20:38 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0304160818590.8914-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0304152004350.8236-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304152004350.8236-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 15 Apr 2003, James Simmons wrote:
> > drivers/video/aty/mach64_gx.c:194: warning: initialization from incompatible pointer type
> 
> Haven't applied a few driver patches yet because I have been working on 
> the upper layer stuff.

Try this one. I thought I had sent it to Linus with my latest batch...

To: linus
Subject: [PATCH] ATI Mach64 GX compile fix

Atyfb: Add missing parts of reversal of Mobility changes, allowing ATI Mach64
GX support to compile again.

--- linux-2.5.x/drivers/video/aty/mach64_gx.c	Tue Mar 25 10:06:59 2003
+++ linux-m68k-2.5.x/drivers/video/aty/mach64_gx.c	Wed Mar 26 11:18:58 2003
@@ -119,7 +119,7 @@
 }
 
 static int aty_var_to_pll_514(const struct fb_info *info, u32 vclk_per,
-			      u32 bpp, u32 width, union aty_pll *pll)
+			      u8 bpp, union aty_pll *pll)
 {
 	/*
 	 *  FIXME: use real calculations instead of using fixed values from the old
@@ -338,7 +338,7 @@
      */
 
 static int aty_var_to_pll_18818(const struct fb_info *info, u32 vclk_per,
-				u32 bpp, u32 width, union aty_pll *pll)
+				u8 bpp, union aty_pll *pll)
 {
 	u32 MHz100;		/* in 0.01 MHz */
 	u32 program_bits;
@@ -494,7 +494,7 @@
      */
 
 static int aty_var_to_pll_1703(const struct fb_info *info, u32 vclk_per,
-			       u32 bpp, u32 width, union aty_pll *pll)
+			       u32 vclk_per, u8 bpp, union aty_pll *pll)
 {
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
@@ -610,7 +610,7 @@
      */
 
 static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
-			       u32 bpp, u32 width, union aty_pll *pll)
+			       u32 vclk_per, u8 bpp, union aty_pll *pll)
 {
 	u32 tempA, tempB, fOut, longMHz100, diff, preDiff;
 
@@ -734,7 +734,7 @@
      */
 
 static int aty_var_to_pll_408(const struct fb_info *info, u32 vclk_per,
-			      u32 bpp, u32 width, union aty_pll *pll)
+			      u8 bpp, union aty_pll *pll)
 {
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
