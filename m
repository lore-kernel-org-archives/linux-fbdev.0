From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: acceleration bug fixes
Date: Fri, 16 May 2008 07:20:09 +0200
Message-ID: <20080516072009.ebdee232.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwsLj-0000Id-VK for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 May 2008 22:19:24 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwsLi-0004q4-7z
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 May 2008 22:19:23 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes two problems when acceleration is
enabled:

 - bit for bitblt direction is corrected
   so scrolling down works as expected on 3DImage chips

 - initialization of acceleration is done later
   this helps with initial console malfuntion (on Blade3D
   chips) well documented here:
   http://marc.info/?l=linux-fbdev-users&m=111386953124478&w=2

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This is tridentfb patch number 21. The list of previous patches in -mm tree:

01 tridentfb-replace-macros-with-functions.patch
02 tridentfb-convert-fb_info-into-allocated-one.patch
03 tridentfb-move-global-pseudo-palette-into-structure.patch
04 tridentfb-move-global-chip_id-into-structure.patch
05 tridentfb-move-global-flat-panel-variable-into-structure.patch
06 tridentfb-convert-is_blade-and-is_xp-macros-into-functions.patch
07 tridentfb-move-global-acceleration-hooks-into-structure.patch
08 tridentfb-make-use-of-functions-and-constants-from-the-vgah.patch
09 tridentfb-fix-timing-calculations.patch
10 tridentfb-use-mmio-access-for-clock-setting.patch
11 tridentfb-fix-clock-settings-for-older-trident-96xx-chips.patch
12 tridentfb-improve-probe-function.patch
13 tridentfb-improved-register-values-on-tgui-9680.patch
14 tridentfb-add-tgui-9440-support.patch
15 tridentfb-fix-unitialized-pseudo_palette.patch
16 tridentfb-improve-check_var-function.patch
17 tridentfb-preserve-memory-type-settings.patch
18 tridentfb-fix-hi-color-modes-for-tgui-9440.patch
19 tridentfb-add-acceleration-for-tgui-families.patch
20-tridentfb-acceleration-code-improvements.patch

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-14 21:47:41.948105140 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-15 20:09:42.903823950 +0200
@@ -395,7 +395,7 @@ static void image_fill_rect(struct tride
 static void image_copy_rect(struct tridentfb_par *par,
 			    u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
 {
-	int direction = 2;
+	int direction = 0x4;
 	u32 s1 = point(x1, y1);
 	u32 s2 = point(x1 + w - 1, y1 + h - 1);
 	u32 d1 = point(x2, y2);
@@ -1075,10 +1075,6 @@ static int tridentfb_set_par(struct fb_i
 	/* enable GE for text acceleration */
 	write3X4(par, GraphEngReg, 0x80);
 
-#ifdef CONFIG_FB_TRIDENT_ACCEL
-	par->init_accel(par, info->var.xres_virtual, bpp);
-#endif
-
 	switch (bpp) {
 	case 8:
 		tmp = 0x00;
@@ -1173,6 +1169,10 @@ static int tridentfb_set_par(struct fb_i
 		set_number_of_lines(par, info->var.yres);
 	info->fix.line_length = info->var.xres_virtual * bpp / 8;
 	set_lwidth(par, info->fix.line_length / 8);
+#ifdef CONFIG_FB_TRIDENT_ACCEL
+	par->init_accel(par, info->var.xres_virtual, bpp);
+#endif
+
 	info->fix.visual = (bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 	info->cmap.len = (bpp == 8) ? 256 : 16;
 	debug("exit\n");

----------------------------------------------------------------------
Wypozycz auto. Tylko 70 PLN za dobe! 
Bez dziennego limitu kilometrow, z pelnym ubezpieczeniem. 
Sprawdz! >> www.express.interia.pl 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
