From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/3] cirrusfb: eliminate CRT registers
	from global structure
Date: Wed, 3 Sep 2008 21:22:34 +0200
Message-ID: <20080903212234.7d7299a9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaxpS-0006fA-FJ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:15:46 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaxpR-0000w1-Dv
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:15:46 -0700
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

Move calculations of CRT register values into
the cirrusfb_set_par_foo() where the values
are used.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |  192 ++++++++++++++++++++--------------------------
 1 files changed, 83 insertions(+), 109 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 4e34a68..20be2db 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -334,22 +334,6 @@ struct cirrusfb_regs {
 	long multiplexing;
 	long mclk;
 	long divMCLK;
-
-	long HorizRes;		/* The x resolution in pixel */
-	long HorizTotal;
-	long HorizDispEnd;
-	long HorizBlankStart;
-	long HorizBlankEnd;
-	long HorizSyncStart;
-	long HorizSyncEnd;
-
-	long VertRes;		/* the physical y resolution in scanlines */
-	long VertTotal;
-	long VertDispEnd;
-	long VertSyncStart;
-	long VertSyncEnd;
-	long VertBlankStart;
-	long VertBlankEnd;
 };
 
 #ifdef CIRRUSFB_DEBUG
@@ -664,8 +648,6 @@ static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 	long maxclock;
 	int maxclockidx = var->bits_per_pixel >> 3;
 	struct cirrusfb_info *cinfo = info->par;
-	int xres, hfront, hsync, hback;
-	int yres, vfront, vsync, vback;
 
 	switch (var->bits_per_pixel) {
 	case 1:
@@ -723,7 +705,7 @@ static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 	switch (var->bits_per_pixel) {
 	case 16:
 	case 32:
-		if (regs->HorizRes <= 800)
+		if (var->xres <= 800)
 			/* Xbh has this type of clock for 32-bit */
 			freq /= 2;
 		break;
@@ -735,57 +717,6 @@ static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 	regs->mclk = cirrusfb_get_mclk(freq, var->bits_per_pixel,
 					&regs->divMCLK);
 
-	xres = var->xres;
-	hfront = var->right_margin;
-	hsync = var->hsync_len;
-	hback = var->left_margin;
-
-	yres = var->yres;
-	vfront = var->lower_margin;
-	vsync = var->vsync_len;
-	vback = var->upper_margin;
-
-	if (var->vmode & FB_VMODE_DOUBLE) {
-		yres *= 2;
-		vfront *= 2;
-		vsync *= 2;
-		vback *= 2;
-	} else if (var->vmode & FB_VMODE_INTERLACED) {
-		yres = (yres + 1) / 2;
-		vfront = (vfront + 1) / 2;
-		vsync = (vsync + 1) / 2;
-		vback = (vback + 1) / 2;
-	}
-	regs->HorizRes = xres;
-	regs->HorizTotal = (xres + hfront + hsync + hback) / 8 - 5;
-	regs->HorizDispEnd = xres / 8 - 1;
-	regs->HorizBlankStart = xres / 8;
-	/* does not count with "-5" */
-	regs->HorizBlankEnd = regs->HorizTotal + 5;
-	regs->HorizSyncStart = (xres + hfront) / 8 + 1;
-	regs->HorizSyncEnd = (xres + hfront + hsync) / 8 + 1;
-
-	regs->VertRes = yres;
-	regs->VertTotal = yres + vfront + vsync + vback - 2;
-	regs->VertDispEnd = yres - 1;
-	regs->VertBlankStart = yres;
-	regs->VertBlankEnd = regs->VertTotal;
-	regs->VertSyncStart = yres + vfront - 1;
-	regs->VertSyncEnd = yres + vfront + vsync - 1;
-
-	if (regs->VertRes >= 1024) {
-		regs->VertTotal /= 2;
-		regs->VertSyncStart /= 2;
-		regs->VertSyncEnd /= 2;
-		regs->VertDispEnd /= 2;
-	}
-	if (regs->multiplexing) {
-		regs->HorizTotal /= 2;
-		regs->HorizSyncStart /= 2;
-		regs->HorizSyncEnd /= 2;
-		regs->HorizDispEnd /= 2;
-	}
-
 	return 0;
 }
 
@@ -823,6 +754,8 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	unsigned char tmp;
 	int offset = 0, err;
 	const struct cirrusfb_board_info_rec *bi;
+	int hdispend, hsyncstart, hsyncend, htotal;
+	int yres, vdispend, vsyncstart, vsyncend, vtotal;
 
 	DPRINTK("ENTER\n");
 	DPRINTK("Requested mode: %dx%dx%d\n",
@@ -840,76 +773,117 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 
 	bi = &cirrusfb_board_info[cinfo->btype];
 
+	hsyncstart = var->xres + var->right_margin;
+	hsyncend = hsyncstart + var->hsync_len;
+	htotal = (hsyncend + var->left_margin) / 8 - 5;
+	hdispend = var->xres / 8 - 1;
+	hsyncstart = hsyncstart / 8 + 1;
+	hsyncend = hsyncend / 8 + 1;
+
+	yres = var->yres;
+	vsyncstart = yres + var->lower_margin;
+	vsyncend = vsyncstart + var->vsync_len;
+	vtotal = vsyncend + var->upper_margin;
+	vdispend = yres - 1;
+
+	if (var->vmode & FB_VMODE_DOUBLE) {
+		yres *= 2;
+		vsyncstart *= 2;
+		vsyncend *= 2;
+		vtotal *= 2;
+	} else if (var->vmode & FB_VMODE_INTERLACED) {
+		yres = (yres + 1) / 2;
+		vsyncstart = (vsyncstart + 1) / 2;
+		vsyncend = (vsyncend + 1) / 2;
+		vtotal = (vtotal + 1) / 2;
+	}
+
+	vtotal -= 2;
+	vsyncstart -= 1;
+	vsyncend -= 1;
+
+	if (yres >= 1024) {
+		vtotal /= 2;
+		vsyncstart /= 2;
+		vsyncend /= 2;
+		vdispend /= 2;
+	}
+	if (regs.multiplexing) {
+		htotal /= 2;
+		hsyncstart /= 2;
+		hsyncend /= 2;
+		hdispend /= 2;
+	}
 	/* unlock register VGA_CRTC_H_TOTAL..CRT7 */
 	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, 0x20);	/* previously: 0x00) */
 
 	/* if debugging is enabled, all parameters get output before writing */
-	DPRINTK("CRT0: %ld\n", regs.HorizTotal);
-	vga_wcrt(regbase, VGA_CRTC_H_TOTAL, regs.HorizTotal);
+	DPRINTK("CRT0: %ld\n", htotal);
+	vga_wcrt(regbase, VGA_CRTC_H_TOTAL, htotal);
 
-	DPRINTK("CRT1: %ld\n", regs.HorizDispEnd);
-	vga_wcrt(regbase, VGA_CRTC_H_DISP, regs.HorizDispEnd);
+	DPRINTK("CRT1: %ld\n", hdispend);
+	vga_wcrt(regbase, VGA_CRTC_H_DISP, hdispend);
 
-	DPRINTK("CRT2: %ld\n", regs.HorizBlankStart);
-	vga_wcrt(regbase, VGA_CRTC_H_BLANK_START, regs.HorizBlankStart);
+	DPRINTK("CRT2: %ld\n", var->xres / 8);
+	vga_wcrt(regbase, VGA_CRTC_H_BLANK_START, var->xres / 8);
 
 	/*  + 128: Compatible read */
-	DPRINTK("CRT3: 128+%ld\n", regs.HorizBlankEnd % 32);
+	DPRINTK("CRT3: 128+%ld\n", (htotal + 5) % 32);
 	vga_wcrt(regbase, VGA_CRTC_H_BLANK_END,
-		 128 + (regs.HorizBlankEnd % 32));
+		 128 + ((htotal + 5) % 32));
 
-	DPRINTK("CRT4: %ld\n", regs.HorizSyncStart);
-	vga_wcrt(regbase, VGA_CRTC_H_SYNC_START, regs.HorizSyncStart);
+	DPRINTK("CRT4: %ld\n", hsyncstart);
+	vga_wcrt(regbase, VGA_CRTC_H_SYNC_START, hsyncstart);
 
-	tmp = regs.HorizSyncEnd % 32;
-	if (regs.HorizBlankEnd & 32)
+	tmp = hsyncend % 32;
+	if ((htotal + 5) & 32)
 		tmp += 128;
 	DPRINTK("CRT5: %d\n", tmp);
 	vga_wcrt(regbase, VGA_CRTC_H_SYNC_END, tmp);
 
-	DPRINTK("CRT6: %ld\n", regs.VertTotal & 0xff);
-	vga_wcrt(regbase, VGA_CRTC_V_TOTAL, (regs.VertTotal & 0xff));
+	DPRINTK("CRT6: %ld\n", vtotal & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_TOTAL, vtotal & 0xff);
 
 	tmp = 16;		/* LineCompare bit #9 */
-	if (regs.VertTotal & 256)
+	if (vtotal & 256)
 		tmp |= 1;
-	if (regs.VertDispEnd & 256)
+	if (vdispend & 256)
 		tmp |= 2;
-	if (regs.VertSyncStart & 256)
+	if (vsyncstart & 256)
 		tmp |= 4;
-	if (regs.VertBlankStart & 256)
+	if ((vdispend + 1) & 256)
 		tmp |= 8;
-	if (regs.VertTotal & 512)
+	if (vtotal & 512)
 		tmp |= 32;
-	if (regs.VertDispEnd & 512)
+	if (vdispend & 512)
 		tmp |= 64;
-	if (regs.VertSyncStart & 512)
+	if (vsyncstart & 512)
 		tmp |= 128;
 	DPRINTK("CRT7: %d\n", tmp);
 	vga_wcrt(regbase, VGA_CRTC_OVERFLOW, tmp);
 
 	tmp = 0x40;		/* LineCompare bit #8 */
-	if (regs.VertBlankStart & 512)
+	if ((vdispend + 1) & 512)
 		tmp |= 0x20;
 	if (var->vmode & FB_VMODE_DOUBLE)
 		tmp |= 0x80;
 	DPRINTK("CRT9: %d\n", tmp);
 	vga_wcrt(regbase, VGA_CRTC_MAX_SCAN, tmp);
 
-	DPRINTK("CRT10: %ld\n", regs.VertSyncStart & 0xff);
-	vga_wcrt(regbase, VGA_CRTC_V_SYNC_START, regs.VertSyncStart & 0xff);
+	DPRINTK("CRT10: %ld\n", vsyncstart & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_SYNC_START, vsyncstart & 0xff);
 
-	DPRINTK("CRT11: 64+32+%ld\n", regs.VertSyncEnd % 16);
-	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, regs.VertSyncEnd % 16 + 64 + 32);
+	DPRINTK("CRT11: 64+32+%ld\n", vsyncend % 16);
+	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, vsyncend % 16 + 64 + 32);
 
-	DPRINTK("CRT12: %ld\n", regs.VertDispEnd & 0xff);
-	vga_wcrt(regbase, VGA_CRTC_V_DISP_END, regs.VertDispEnd & 0xff);
+	DPRINTK("CRT12: %ld\n", vdispend & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_DISP_END, vdispend & 0xff);
 
-	DPRINTK("CRT15: %ld\n", regs.VertBlankStart & 0xff);
-	vga_wcrt(regbase, VGA_CRTC_V_BLANK_START, regs.VertBlankStart & 0xff);
+	DPRINTK("CRT15: %ld\n", (vdispend + 1) & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_BLANK_START, (vdispend + 1) & 0xff);
 
-	DPRINTK("CRT16: %ld\n", regs.VertBlankEnd & 0xff);
-	vga_wcrt(regbase, VGA_CRTC_V_BLANK_END, regs.VertBlankEnd & 0xff);
+	DPRINTK("CRT16: %ld\n", vtotal & 0xff);
+	vga_wcrt(regbase, VGA_CRTC_V_BLANK_END, vtotal & 0xff);
 
 	DPRINTK("CRT18: 0xff\n");
 	vga_wcrt(regbase, VGA_CRTC_LINE_COMPARE, 0xff);
@@ -917,13 +891,13 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	tmp = 0;
 	if (var->vmode & FB_VMODE_INTERLACED)
 		tmp |= 1;
-	if (regs.HorizBlankEnd & 64)
+	if ((htotal + 5) & 64)
 		tmp |= 16;
-	if (regs.HorizBlankEnd & 128)
+	if ((htotal + 5) & 128)
 		tmp |= 32;
-	if (regs.VertBlankEnd & 256)
+	if (vtotal & 256)
 		tmp |= 64;
-	if (regs.VertBlankEnd & 512)
+	if (vtotal & 512)
 		tmp |= 128;
 
 	DPRINTK("CRT1a: %d\n", tmp);
@@ -948,7 +922,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	DPRINTK("CL_SEQR1B: %ld\n", (long) tmp);
 	vga_wseq(regbase, CL_SEQR1B, tmp);
 
-	if (regs.VertRes >= 1024)
+	if (yres >= 1024)
 		/* 1280x1024 */
 		vga_wcrt(regbase, VGA_CRTC_MODE, 0xc7);
 	else
@@ -962,7 +936,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	/* don't know if it would hurt to also program this if no interlaced */
 	/* mode is used, but I feel better this way.. :-) */
 	if (var->vmode & FB_VMODE_INTERLACED)
-		vga_wcrt(regbase, VGA_CRTC_REGS, regs.HorizTotal / 2);
+		vga_wcrt(regbase, VGA_CRTC_REGS, htotal / 2);
 	else
 		vga_wcrt(regbase, VGA_CRTC_REGS, 0x00);	/* interlace control */
 
@@ -1208,7 +1182,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 
 		case BT_ALPINE:
 			DPRINTK(" (for GD543x)\n");
-			if (regs.HorizRes >= 1024)
+			if (var->xres >= 1024)
 				vga_wseq(regbase, CL_SEQR7, 0xa7);
 			else
 				vga_wseq(regbase, CL_SEQR7, 0xa3);
-- 
1.5.2.2


----------------------------------------------------------------------
Tylko u nas - swieza krew w rozsadnych cenach!
>> http://link.interia.pl/f1eed


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
