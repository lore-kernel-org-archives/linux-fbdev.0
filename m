From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] neofb: drop the xtimings structure
Date: Sat, 5 Jul 2008 18:52:20 +0200
Message-ID: <20080705185220.6615eef8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KFAvs-0008BZ-OK for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 Jul 2008 09:48:20 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KFAvq-0004Ac-R4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 Jul 2008 09:48:20 -0700
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

Remove the xtimings structure which only stored some
values to be used later (mostly once). Calculate and use
these values in places they are needed.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

--- linux-old/drivers/video/neofb.c	2008-07-05 17:40:23.157418130 +0200
+++ linux-new/drivers/video/neofb.c	2008-07-05 18:36:33.409409663 +0200
@@ -259,15 +259,20 @@ static void neoCalcVCLK(const struct fb_
  */
 
 static int vgaHWInit(const struct fb_var_screeninfo *var,
-		     const struct fb_info *info,
-		     struct neofb_par *par, struct xtimings *timings)
+		     struct neofb_par *par)
 {
+	int hsync_end = var->xres + var->right_margin + var->hsync_len;
+	int htotal = (hsync_end + var->left_margin) >> 3;
+	int vsync_start = var->yres + var->lower_margin;
+	int vsync_end = vsync_start + var->vsync_len;
+	int vtotal = vsync_end + var->upper_margin;
+
 	par->MiscOutReg = 0x23;
 
-	if (!(timings->sync & FB_SYNC_HOR_HIGH_ACT))
+	if (!(var->sync & FB_SYNC_HOR_HIGH_ACT))
 		par->MiscOutReg |= 0x40;
 
-	if (!(timings->sync & FB_SYNC_VERT_HIGH_ACT))
+	if (!(var->sync & FB_SYNC_VERT_HIGH_ACT))
 		par->MiscOutReg |= 0x80;
 
 	/*
@@ -282,25 +287,25 @@ static int vgaHWInit(const struct fb_var
 	/*
 	 * CRTC Controller
 	 */
-	par->CRTC[0] = (timings->HTotal >> 3) - 5;
-	par->CRTC[1] = (timings->HDisplay >> 3) - 1;
-	par->CRTC[2] = (timings->HDisplay >> 3) - 1;
-	par->CRTC[3] = (((timings->HTotal >> 3) - 1) & 0x1F) | 0x80;
-	par->CRTC[4] = (timings->HSyncStart >> 3);
-	par->CRTC[5] = ((((timings->HTotal >> 3) - 1) & 0x20) << 2)
-	    | (((timings->HSyncEnd >> 3)) & 0x1F);
-	par->CRTC[6] = (timings->VTotal - 2) & 0xFF;
-	par->CRTC[7] = (((timings->VTotal - 2) & 0x100) >> 8)
-	    | (((timings->VDisplay - 1) & 0x100) >> 7)
-	    | ((timings->VSyncStart & 0x100) >> 6)
-	    | (((timings->VDisplay - 1) & 0x100) >> 5)
-	    | 0x10 | (((timings->VTotal - 2) & 0x200) >> 4)
-	    | (((timings->VDisplay - 1) & 0x200) >> 3)
-	    | ((timings->VSyncStart & 0x200) >> 2);
+	par->CRTC[0] = htotal - 5;
+	par->CRTC[1] = (var->xres >> 3) - 1;
+	par->CRTC[2] = (var->xres >> 3) - 1;
+	par->CRTC[3] = ((htotal - 1) & 0x1F) | 0x80;
+	par->CRTC[4] = ((var->xres + var->right_margin) >> 3);
+	par->CRTC[5] = (((htotal - 1) & 0x20) << 2)
+	    | (((hsync_end >> 3)) & 0x1F);
+	par->CRTC[6] = (vtotal - 2) & 0xFF;
+	par->CRTC[7] = (((vtotal - 2) & 0x100) >> 8)
+	    | (((var->yres - 1) & 0x100) >> 7)
+	    | ((vsync_start & 0x100) >> 6)
+	    | (((var->yres - 1) & 0x100) >> 5)
+	    | 0x10 | (((vtotal - 2) & 0x200) >> 4)
+	    | (((var->yres - 1) & 0x200) >> 3)
+	    | ((vsync_start & 0x200) >> 2);
 	par->CRTC[8] = 0x00;
-	par->CRTC[9] = (((timings->VDisplay - 1) & 0x200) >> 4) | 0x40;
+	par->CRTC[9] = (((var->yres - 1) & 0x200) >> 4) | 0x40;
 
-	if (timings->dblscan)
+	if (var->vmode & FB_VMODE_DOUBLE)
 		par->CRTC[9] |= 0x80;
 
 	par->CRTC[10] = 0x00;
@@ -309,13 +314,13 @@ static int vgaHWInit(const struct fb_var
 	par->CRTC[13] = 0x00;
 	par->CRTC[14] = 0x00;
 	par->CRTC[15] = 0x00;
-	par->CRTC[16] = timings->VSyncStart & 0xFF;
-	par->CRTC[17] = (timings->VSyncEnd & 0x0F) | 0x20;
-	par->CRTC[18] = (timings->VDisplay - 1) & 0xFF;
+	par->CRTC[16] = vsync_start & 0xFF;
+	par->CRTC[17] = (vsync_end & 0x0F) | 0x20;
+	par->CRTC[18] = (var->yres - 1) & 0xFF;
 	par->CRTC[19] = var->xres_virtual >> 4;
 	par->CRTC[20] = 0x00;
-	par->CRTC[21] = (timings->VDisplay - 1) & 0xFF;
-	par->CRTC[22] = (timings->VTotal - 1) & 0xFF;
+	par->CRTC[21] = (var->yres - 1) & 0xFF;
+	par->CRTC[22] = (vtotal - 1) & 0xFF;
 	par->CRTC[23] = 0xC3;
 	par->CRTC[24] = 0xFF;
 
@@ -736,11 +741,11 @@ neofb_check_var(struct fb_var_screeninfo
 static int neofb_set_par(struct fb_info *info)
 {
 	struct neofb_par *par = info->par;
-	struct xtimings timings;
 	unsigned char temp;
 	int i, clock_hi = 0;
 	int lcd_stretch;
 	int hoffset, voffset;
+	int vsync_start, vtotal;
 
 	DBG("neofb_set_par");
 
@@ -748,28 +753,15 @@ static int neofb_set_par(struct fb_info 
 
 	vgaHWProtect(1);	/* Blank the screen */
 
-	timings.dblscan = info->var.vmode & FB_VMODE_DOUBLE;
-	timings.interlaced = info->var.vmode & FB_VMODE_INTERLACED;
-	timings.HDisplay = info->var.xres;
-	timings.HSyncStart = timings.HDisplay + info->var.right_margin;
-	timings.HSyncEnd = timings.HSyncStart + info->var.hsync_len;
-	timings.HTotal = timings.HSyncEnd + info->var.left_margin;
-	timings.VDisplay = info->var.yres;
-	timings.VSyncStart = timings.VDisplay + info->var.lower_margin;
-	timings.VSyncEnd = timings.VSyncStart + info->var.vsync_len;
-	timings.VTotal = timings.VSyncEnd + info->var.upper_margin;
-	timings.sync = info->var.sync;
-	timings.pixclock = PICOS2KHZ(info->var.pixclock);
-
-	if (timings.pixclock < 1)
-		timings.pixclock = 1;
+	vsync_start = info->var.yres + info->var.lower_margin;
+	vtotal = vsync_start + info->var.vsync_len + info->var.upper_margin;
 
 	/*
 	 * This will allocate the datastructure and initialize all of the
 	 * generic VGA registers.
 	 */
 
-	if (vgaHWInit(&info->var, info, par, &timings))
+	if (vgaHWInit(&info->var, par))
 		return -EINVAL;
 
 	/*
@@ -808,10 +800,10 @@ static int neofb_set_par(struct fb_info 
 	par->ExtCRTDispAddr = 0x10;
 
 	/* Vertical Extension */
-	par->VerticalExt = (((timings.VTotal - 2) & 0x400) >> 10)
-	    | (((timings.VDisplay - 1) & 0x400) >> 9)
-	    | (((timings.VSyncStart) & 0x400) >> 8)
-	    | (((timings.VSyncStart) & 0x400) >> 7);
+	par->VerticalExt = (((vtotal - 2) & 0x400) >> 10)
+	    | (((info->var.yres - 1) & 0x400) >> 9)
+	    | (((vsync_start) & 0x400) >> 8)
+	    | (((vsync_start) & 0x400) >> 7);
 
 	/* Fast write bursts on unless disabled. */
 	if (par->pci_burst)
@@ -972,7 +964,7 @@ static int neofb_set_par(struct fb_info 
 	 * Calculate the VCLK that most closely matches the requested dot
 	 * clock.
 	 */
-	neoCalcVCLK(info, par, timings.pixclock);
+	neoCalcVCLK(info, par, PICOS2KHZ(info->var.pixclock));
 
 	/* Since we program the clocks ourselves, always use VCLK3. */
 	par->MiscOutReg |= 0x0C;
--- linux-old/include/video/neomagic.h	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/include/video/neomagic.h	2008-07-05 18:35:37.017409826 +0200
@@ -90,23 +90,6 @@
 #define PCI_CHIP_NM2360 0x0006
 #define PCI_CHIP_NM2380 0x0016
 
-
-struct xtimings {
-	unsigned int pixclock;
-	unsigned int HDisplay;
-	unsigned int HSyncStart;
-	unsigned int HSyncEnd;
-	unsigned int HTotal;
-	unsigned int VDisplay;
-	unsigned int VSyncStart;
-	unsigned int VSyncEnd;
-	unsigned int VTotal;
-	unsigned int sync;
-	int dblscan;
-	int interlaced;
-};
-
-
 /* --------------------------------------------------------------------- */
 
 typedef volatile struct {

----------------------------------------------------------------------
Wyjezdzasz? Sprawdz, co mozesz ciekawego obejrzec!
Przewodniki >>> http://link.interia.pl/f1e5f


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
