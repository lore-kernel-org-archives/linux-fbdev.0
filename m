From: Alex Stewart <alex@foogod.com>
Subject: [PATCH] neofb: blanking patch done
Date: Sat, 24 Apr 2004 00:39:34 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040424073934.GA23738@foogod.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BHHlD-00047U-8U
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 00:39:39 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BHHl9-0004j5-Gd
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 00:39:35 -0700
Received: from firestar.foogod.com (firestar [127.0.0.1])
	by firestar.foogod.com (8.12.8/8.12.5) with ESMTP id i3O7dYlu023791
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 24 Apr 2004 00:39:34 -0700
Received: (from alex@localhost)
	by firestar.foogod.com (8.12.8/8.12.8/Submit) id i3O7dY5b023789
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 24 Apr 2004 00:39:34 -0700
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


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, I sorted out the issues with the blanking patch, fixed it up to use the new
vga core routines, and did a little bit of miscellaneous cleanup.  It works for
me; feedback is welcome.

Patch is attached, and also available at http://www.foogod.com/~alex/neofb

(this patch is against James' latest driver patch)

-alex

--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb-js.6.blanking.patch"

--- ./drivers/video/neofb.c.blanking	2004-04-24 01:04:28.000000000 -0700
+++ ./drivers/video/neofb.c	2004-04-24 01:24:38.739531288 -0700
@@ -1320,27 +1320,34 @@
 /*
  *    (Un)Blank the display.
  */
-static int neofb_blank(int blank, struct fb_info *info)
+static int neofb_blank(int blank_mode, struct fb_info *info)
 {
+	struct neofb_par *par = (struct neofb_par *)info->par;
+	int seqflags, lcdflags, dpmsflags, reg;
+
 	/*
-	 *  Blank the screen if blank_mode != 0, else unblank. If
-	 *  blank == NULL then the caller blanks by setting the CLUT
-	 *  (Color Look Up Table) to all black. Return 0 if blanking
-	 *  succeeded, != 0 if un-/blanking failed due to e.g. a
-	 *  video mode which doesn't support it. Implements VESA
-	 *  suspend and powerdown modes on hardware that supports
-	 *  disabling hsync/vsync:
-	 *    blank_mode == 2: suspend vsync
-	 *    blank_mode == 3: suspend hsync
-	 *    blank_mode == 4: powerdown
+	 *  Blank the screen if blank_mode != 0, else unblank.
+	 *  Return 0 if blanking succeeded, != 0 if un-/blanking failed due to
+	 *  e.g. a video mode which doesn't support it. Implements VESA suspend
+	 *  and powerdown modes for monitors, and backlight control on LCDs.
+	 *    blank_mode == 0: unblanked (backlight on)
+	 *    blank_mode == 1: blank (backlight on)
+	 *    blank_mode == 2: suspend vsync (backlight off)
+	 *    blank_mode == 3: suspend hsync (backlight off)
+	 *    blank_mode == 4: powerdown (backlight off)
 	 *
-	 *  wms...Enable VESA DMPS compatible powerdown mode
+	 *  wms...Enable VESA DPMS compatible powerdown mode
 	 *  run "setterm -powersave powerdown" to take advantage
 	 */
 
-	switch (blank) {
+	switch (blank_mode) {
 	case 4:		/* powerdown - both sync lines down */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = 0;			/* LCD off */
+		dpmsflags = NEO_GR01_SUPPRESS_HSYNC |
+			    NEO_GR01_SUPPRESS_VSYNC;
 #ifdef CONFIG_TOSHIBA
+		/* Do we still need this? */
 		/* attempt to turn off backlight on toshiba; also turns off external */
 		{
 			SMMRegisters regs;
@@ -1353,13 +1360,26 @@
 #endif
 		break;
 	case 3:		/* hsync off */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = 0;			/* LCD off */
+		dpmsflags = NEO_GR01_SUPPRESS_HSYNC;
 		break;
 	case 2:		/* vsync off */
-		break;
-	case 1:		/* just software blanking of screen */
-		break;
-	default:		/* case 0, or anything else: unblank */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = 0;			/* LCD off */
+		dpmsflags = NEO_GR01_SUPPRESS_VSYNC;
+		break;
+	case 1:		/* just blank screen (backlight stays on) */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
+		dpmsflags = 0;			/* no hsync/vsync suppression */
+		break;
+	case 0:		/* unblank */
+		seqflags = 0;			/* Enable sequencer */
+		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
+		dpmsflags = 0x00;	/* no hsync/vsync suppression */
 #ifdef CONFIG_TOSHIBA
+		/* Do we still need this? */
 		/* attempt to re-enable backlight/external on toshiba */
 		{
 			SMMRegisters regs;
@@ -1371,7 +1391,20 @@
 		}
 #endif
 		break;
+	default:	/* Anything else we don't understand; return 1 to tell
+			 * fb_blank we didn't actually do anything */
+		return 1;
 	}
+
+	neoUnlock();
+	reg = (vga_rseq(NULL, 0x01) & ~0x20) | seqflags;
+	vga_wseq(NULL, 0x01, reg);
+	reg = (vga_rgfx(NULL, 0x20) & ~0x02) | lcdflags;
+	vga_wgfx(NULL, 0x20, reg);
+	reg = (vga_rgfx(NULL, 0x01) & ~0xF0) | 0x80 | dpmsflags;
+	vga_wgfx(NULL, 0x01, reg);
+	neoLock(&par->state);
+
 	return 0;
 }
 
--- ./include/video/neomagic.h.blanking	2004-04-24 01:04:28.000000000 -0700
+++ ./include/video/neomagic.h	2004-04-24 01:24:38.773526120 -0700
@@ -69,6 +69,9 @@
 #define NEO_ICON128_ENABLE	0x0000000C
 #define NEO_ICON_BLANK		0x00000010
 
+#define NEO_GR01_SUPPRESS_VSYNC 0x10
+#define NEO_GR01_SUPPRESS_HSYNC 0x20
+
 #ifdef __KERNEL__
 
 #ifdef NEOFB_DEBUG

--ibTvN161/egqYuK8--


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
