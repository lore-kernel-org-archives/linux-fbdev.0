From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/8] fbdev: Fix broken fb_blank() implementation.
Date: Mon, 8 Nov 2004 05:27:11 +0800
Message-ID: <200411080526.50550.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufn-00048e-2s
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:34:07 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CQufl-00075N-20
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:34:07 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C30E511C60DB
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:50 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This patch fixes some of the drivers' fb_blank() implementation which got
the usage of the VESA_* constants incorrectly and converts them to use the
new FB_BLANK-* constants.

I'm not sure if what I did is correct for all drivers, so maintainers,
please review.

(Note: For most of the drivers, FB_BLANK_NORMAL is treated as
FB_BLANK_UNBLANK, but returns a nonzero so fbcon will do a soft_blank).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 aty/radeon_base.c |   22 +++++++++++++---------
 cirrusfb.c        |   18 +++++++++++-------
 epson1355fb.c     |   13 ++++++++-----
 i810/i810_main.c  |   17 ++++++++++++-----
 radeonfb.c        |   12 +++++++-----
 5 files changed, 51 insertions(+), 31 deletions(-)

diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/aty/radeon_base.c	2004-11-06 18:03:09 +08:00
@@ -947,15 +947,16 @@
         val &= ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
                  CRTC_VSYNC_DIS);
         switch (blank) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
 		break;
-	case VESA_VSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
 		val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
 		break;
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 		val |= (CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS);
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS |
 			CRTC_HSYNC_DIS);
 		break;
@@ -967,7 +968,8 @@
 	case MT_DFP:
 		if (mode_switch)
 			break;
-		if (blank == VESA_NO_BLANKING)
+		if (blank == FB_BLANK_UNBLANK ||
+		    blank == FB_BLANK_NORMAL)
 			OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN),
 				~(FP_FPON | FP_TMDS_EN));
 		else
@@ -975,7 +977,8 @@
 		break;
 	case MT_LCD:
 		val = INREG(LVDS_GEN_CNTL);
-		if (blank == VESA_NO_BLANKING) {
+		if (blank == FB_BLANK_UNBLANK ||
+		    blank == FB_BLANK_NORMAL) {
 			u32 target_val = (val & ~LVDS_DISPLAY_DIS) | LVDS_BLON | LVDS_ON
 				| LVDS_ON | (rinfo->init_state.lvds_gen_cntl & LVDS_DIGON);
 			if ((val ^ target_val) == LVDS_DISPLAY_DIS)
@@ -1023,7 +1026,8 @@
 		break;
 	}
 
-	return 0;
+	/* let fbcon do a soft blank for us */
+	return (blank == FB_BLANK_NORMAL) ? -EINVAL : 0;
 }
 
 int radeonfb_blank (int blank, struct fb_info *info)
@@ -1265,7 +1269,7 @@
 
 	del_timer_sync(&rinfo->lvds_timer);
 
-	radeon_screen_blank(rinfo, VESA_POWERDOWN, 1);
+	radeon_screen_blank(rinfo, FB_BLANK_POWERDOWN, 1);
 	msleep(100);
 
 	radeon_fifo_wait(31);
@@ -1308,7 +1312,7 @@
 		OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
 	}
 
-	radeon_screen_blank(rinfo, VESA_NO_BLANKING, 1);
+	radeon_screen_blank(rinfo, FB_BLANK_UNBLANK, 1);
 
 	radeon_fifo_wait(2);
 	OUTPLL(VCLK_ECP_CNTL, mode->vclk_ecp_cntl);
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/cirrusfb.c	2004-11-06 18:03:09 +08:00
@@ -1727,7 +1727,8 @@
 	}
 
 	/* Undo current */
-	if (current_mode != VESA_NO_BLANKING) {
+	if (current_mode == FB_BLANK_NORMAL ||
+	    current_mode == FB_BLANK_UNBLANK) {
 		/* unblank the screen */
 		val = vga_rseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE);
 		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, val & 0xdf);	/* clear "FullBandwidth" bit */
@@ -1736,22 +1737,23 @@
 	}
 
 	/* set new */
-	if(blank_mode != VESA_NO_BLANKING) {
+	if(blank_mode > FB_BLANK_NORMAL) {
 		/* blank the screen */
 		val = vga_rseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE);
 		vga_wseq (cinfo->regbase, VGA_SEQ_CLOCK_MODE, val | 0x20);	/* set "FullBandwidth" bit */
 	}
 
 	switch (blank_mode) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
 		break;
-	case VESA_VSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
 		vga_wgfx (cinfo->regbase, CL_GRE, 0x04);
 		break;
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 		vga_wgfx (cinfo->regbase, CL_GRE, 0x02);
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		vga_wgfx (cinfo->regbase, CL_GRE, 0x06);
 		break;
 	default:
@@ -1761,7 +1763,9 @@
 
 	cinfo->blank_mode = blank_mode;
 	DPRINTK ("EXIT, returning 0\n");
-	return 0;
+
+	/* Let fbcon do a soft blank for us */
+	return (blank_mode == FB_BLANK_NORMAL) ? 1 : 0;
 }
 /**** END   Hardware specific Routines **************************************/
 /****************************************************************************/
diff -Nru a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
--- a/drivers/video/epson1355fb.c	2004-10-19 20:21:38 +08:00
+++ b/drivers/video/epson1355fb.c	2004-11-06 18:03:09 +08:00
@@ -288,22 +288,25 @@
 	struct epson1355_par *par = info->par;
 
 	switch (blank_mode) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANKING:
+	case FB_BLANK_NORMAL:
 		lcd_enable(par, 1);
 		backlight_enable(1);
 		break;
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 		backlight_enable(0);
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		backlight_enable(0);
 		lcd_enable(par, 0);
 		break;
 	default:
 		return -EINVAL;
 	}
-	return 0;
+
+	/* let fbcon do a soft blank for us */
+	return (blank_mode == FB_BLANK_NORMAL) ? 1 : 0;
 }
 
 /* ------------------------------------------------------------------------- */
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-11-07 21:31:13 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-11-06 18:03:10 +08:00
@@ -1323,23 +1323,28 @@
 	
 	pwr = i810_readl(PWR_CLKC, mmio);
 
-	switch(blank_mode) {
-	case VESA_NO_BLANKING:
+	switch (blank_mode) {
+	case FB_BLANK_UNBLANK:
 		mode = POWERON;
 		pwr |= 1;
 		scr_off = ON;
 		break;
-	case VESA_VSYNC_SUSPEND:
+	case FB_BLANK_NORMAL:
+		mode = POWERON;
+		pwr |= 1;
+		scr_off = OFF;
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
 		mode = STANDBY;
 		pwr |= 1;
 		scr_off = OFF;
 		break;
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 		mode = SUSPEND;
 		pwr |= 1;
 		scr_off = OFF;
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		mode = POWERDOWN;
 		pwr &= ~1;
 		scr_off = OFF;
@@ -1347,9 +1352,11 @@
 	default:
 		return -EINVAL; 
 	}
+
 	i810_screen_off(mmio, scr_off);
 	i810_writel(HVSYNC, mmio, mode);
 	i810_writel(PWR_CLKC, mmio, pwr);
+
 	return 0;
 }
 
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/radeonfb.c	2004-11-06 18:03:10 +08:00
@@ -1629,15 +1629,16 @@
 	val2 &= ~(LVDS_DISPLAY_DIS);
 
         switch (blank) {
-                case VESA_NO_BLANKING:
+	        case FB_BLANK_UNBLANK:
+	        case FB_BLANK_NORMAL:
                         break;
-                case VESA_VSYNC_SUSPEND:
+                case FB_BLANK_VSYNC_SUSPEND:
                         val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
                         break;
-                case VESA_HSYNC_SUSPEND:
+                case FB_BLANK_HSYNC_SUSPEND:
                         val |= (CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS);
                         break;
-                case VESA_POWERDOWN:
+                case FB_BLANK_POWERDOWN:
                         val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS | 
                                 CRTC_HSYNC_DIS);
 			val2 |= (LVDS_DISPLAY_DIS);
@@ -1654,7 +1655,8 @@
 			break;
 	}
 
-	return 0;
+	/* let fbcon do a soft blank for us */
+	return (blank == FB_BLANK_NORMAL) ? 1 : 0;
 }
 
 




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
