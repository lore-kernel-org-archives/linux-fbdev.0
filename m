From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Add missing parts of reversal of Mobility changes.
Date: Thu, 27 Mar 2003 14:36:32 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303271435200.26358-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yXZZ-0001vr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 05:37:38 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi James,

This patch makes atyfb compile again.

Add missing parts of reversal of Mobility changes.

--- linux-m68k-2.5.66/drivers/video/aty/mach64_gx.c	Tue Mar 25 10:06:59 2003
+++ testing/linux-m68k-2.5.66/drivers/video/aty/mach64_gx.c	Wed Mar 26 11:18:58 2003
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



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
