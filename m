From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/8] fbdev: Convert drivers to use the new FB_BLANK_* constants
Date: Mon, 8 Nov 2004 05:26:22 +0800
Message-ID: <20041107213337.8EDCD11C461C@smtp-3.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQufg-00045a-Ir
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:34:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CQufd-0008Kd-Jr
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Nov 2004 13:34:00 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4973011C60D4
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  7 Nov 2004 21:33:43 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch converts most drivers to use the new FB_BLANK_* constants. These
drivers have correct fb_blank() implementations.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 amifb.c                |    9 +++++----
 aty/aty128fb.c         |    6 +++---
 aty/atyfb_base.c       |   23 ++++++++++++-----------
 bw2.c                  |   10 +++++-----
 cg3.c                  |   10 +++++-----
 cg6.c                  |   10 +++++-----
 controlfb.c            |   10 +++++-----
 cyber2000fb.c          |    8 ++++----
 ffb.c                  |   10 +++++-----
 gbefb.c                |    4 ++--
 imsttfb.c              |   10 +++++-----
 intelfb/intelfbdrv.c   |    4 ++--
 intelfb/intelfbhw.c    |   10 +++++-----
 leo.c                  |   10 +++++-----
 matrox/matroxfb_base.c |   10 +++++-----
 neofb.c                |   10 +++++-----
 p9100.c                |   10 +++++-----
 pm2fb.c                |   10 +++++-----
 pxafb.c                |    9 +++++----
 riva/fbdev.c           |   32 ++++++++++++++++++--------------
 sa1100fb.c             |    9 +++++----
 tcx.c                  |   10 +++++-----
 tdfxfb.c               |   10 +++++-----
 tgafb.c                |   10 +++++-----
 tridentfb.c            |   14 +++++++++-----
 valkyriefb.c           |   10 +++++-----
 vga16fb.c              |   10 +++++-----
 27 files changed, 150 insertions(+), 138 deletions(-)

diff -Nru a/drivers/video/amifb.c b/drivers/video/amifb.c
--- a/drivers/video/amifb.c	2004-10-19 20:21:15 +08:00
+++ b/drivers/video/amifb.c	2004-11-06 17:59:45 +08:00
@@ -2469,6 +2469,7 @@
 static int amifb_blank(int blank, struct fb_info *info)
 {
 	do_blank = blank ? blank : -1;
+
 	return 0;
 }
 
@@ -3247,20 +3248,20 @@
 		custom.dmacon = DMAF_RASTER | DMAF_SPRITE;
 		red = green = blue = 0;
 		if (!IS_OCS && do_blank > 1) {
-			switch (do_blank-1) {
-				case VESA_VSYNC_SUSPEND:
+			switch (do_blank) {
+				case FB_BLANK_VSYNC_SUSPEND:
 					custom.hsstrt = hsstrt2hw(par->hsstrt);
 					custom.hsstop = hsstop2hw(par->hsstop);
 					custom.vsstrt = vsstrt2hw(par->vtotal+4);
 					custom.vsstop = vsstop2hw(par->vtotal+4);
 					break;
-				case VESA_HSYNC_SUSPEND:
+				case FB_BLANK_HSYNC_SUSPEND:
 					custom.hsstrt = hsstrt2hw(par->htotal+16);
 					custom.hsstop = hsstop2hw(par->htotal+16);
 					custom.vsstrt = vsstrt2hw(par->vsstrt);
 					custom.vsstop = vsstrt2hw(par->vsstop);
 					break;
-				case VESA_POWERDOWN:
+				case FB_BLANK_POWERDOWN:
 					custom.hsstrt = hsstrt2hw(par->htotal+16);
 					custom.hsstop = hsstop2hw(par->htotal+16);
 					custom.vsstrt = vsstrt2hw(par->vtotal+4);
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	2004-11-06 06:21:25 +08:00
+++ b/drivers/video/aty/aty128fb.c	2004-11-06 17:59:45 +08:00
@@ -2042,11 +2042,11 @@
 		set_backlight_enable(0);
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-	if (blank & VESA_VSYNC_SUSPEND)
+	if (blank & FB_BLANK_VSYNC_SUSPEND)
 		state |= 2;
-	if (blank & VESA_HSYNC_SUSPEND)
+	if (blank & FB_BLANK_HSYNC_SUSPEND)
 		state |= 1;
-	if (blank & VESA_POWERDOWN)
+	if (blank & FB_BLANK_POWERDOWN)
 		state |= 4;
 
 	aty_st_8(CRTC_EXT_CNTL+1, state);
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2004-11-06 06:21:25 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2004-11-06 17:59:46 +08:00
@@ -2045,7 +2045,7 @@
 	aty_reset_engine(par);
 
 	/* Blank display and LCD */
-	atyfb_blank(VESA_POWERDOWN + 1, info);
+	atyfb_blank(FB_BLANK_POWERDOWN, info);
 
 	par->asleep = 1;
 	par->lock_blank = 1;
@@ -2054,7 +2054,7 @@
 	if (aty_power_mgmt(1, par)) {
 		par->asleep = 0;
 		par->lock_blank = 0;
-		atyfb_blank(0, info);
+		atyfb_blank(FB_BLANK_UNBLANK, info);
 		fb_set_suspend(info, 0);
 		release_console_sem();
 		return -EIO;
@@ -2089,7 +2089,7 @@
 
 	/* Unblank */
 	par->lock_blank = 0;
-	atyfb_blank(0, info);
+	atyfb_blank(FB_BLANK_UNBLANK, info);
 
 	release_console_sem();
 
@@ -2625,22 +2625,23 @@
 #endif
 
 	gen_cntl = aty_ld_8(CRTC_GEN_CNTL, par);
-	if (blank > 0)
-		switch (blank - 1) {
-		case VESA_NO_BLANKING:
+	switch (blank) {
+        	case FB_BLANK_UNBLANK:
+			gen_cntl &= ~(0x4c);
+			break;
+		case FB_BLANK_NORMAL:
 			gen_cntl |= 0x40;
 			break;
-		case VESA_VSYNC_SUSPEND:
+		case FB_BLANK_VSYNC_SUSPEND:
 			gen_cntl |= 0x8;
 			break;
-		case VESA_HSYNC_SUSPEND:
+		case FB_BLANK_HSYNC_SUSPEND:
 			gen_cntl |= 0x4;
 			break;
-		case VESA_POWERDOWN:
+		case FB_BLANK_POWERDOWN:
 			gen_cntl |= 0x4c;
 			break;
-	} else
-		gen_cntl &= ~(0x4c);
+	}
 	aty_st_8(CRTC_GEN_CNTL, gen_cntl, par);
 
 #ifdef CONFIG_PMAC_BACKLIGHT
diff -Nru a/drivers/video/bw2.c b/drivers/video/bw2.c
--- a/drivers/video/bw2.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/bw2.c	2004-11-06 17:59:46 +08:00
@@ -138,17 +138,17 @@
 	spin_lock_irqsave(&par->lock, flags);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		val = sbus_readb(&regs->control);
 		val |= BWTWO_CTL_ENABLE_VIDEO;
 		sbus_writeb(val, &regs->control);
 		par->flags &= ~BW2_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
-	case 2: /* VESA blank (vsync off) */
-	case 3: /* VESA blank (hsync off) */
-	case 4: /* Poweroff */
+	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		val = sbus_readb(&regs->control);
 		val &= ~BWTWO_CTL_ENABLE_VIDEO;
 		sbus_writeb(val, &regs->control);
diff -Nru a/drivers/video/cg3.c b/drivers/video/cg3.c
--- a/drivers/video/cg3.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/cg3.c	2004-11-06 17:59:47 +08:00
@@ -197,17 +197,17 @@
 	spin_lock_irqsave(&par->lock, flags);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		val = sbus_readl(&regs->control);
 		val |= CG3_CR_ENABLE_VIDEO;
 		sbus_writel(val, &regs->control);
 		par->flags &= ~CG3_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
-	case 2: /* VESA blank (vsync off) */
-	case 3: /* VESA blank (hsync off) */
-	case 4: /* Poweroff */
+	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		val = sbus_readl(&regs->control);
 		val |= CG3_CR_ENABLE_VIDEO;
 		sbus_writel(val, &regs->control);
diff -Nru a/drivers/video/cg6.c b/drivers/video/cg6.c
--- a/drivers/video/cg6.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/cg6.c	2004-11-06 17:59:47 +08:00
@@ -456,17 +456,17 @@
 	spin_lock_irqsave(&par->lock, flags);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		val = sbus_readl(&thc->thc_misc);
 		val |= CG6_THC_MISC_VIDEO;
 		sbus_writel(val, &thc->thc_misc);
 		par->flags &= ~CG6_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
-	case 2: /* VESA blank (vsync off) */
-	case 3: /* VESA blank (hsync off) */
-	case 4: /* Poweroff */
+	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		val = sbus_readl(&thc->thc_misc);
 		val &= ~CG6_THC_MISC_VIDEO;
 		sbus_writel(val, &thc->thc_misc);
diff -Nru a/drivers/video/controlfb.c b/drivers/video/controlfb.c
--- a/drivers/video/controlfb.c	2004-10-19 20:21:30 +08:00
+++ b/drivers/video/controlfb.c	2004-11-06 17:59:47 +08:00
@@ -329,17 +329,17 @@
 
 	ctrl = ld_le32(CNTRL_REG(p,ctrl));
 	if (blank_mode > 0)
-		switch (blank_mode - 1) {
-		case VESA_VSYNC_SUSPEND:
+		switch (blank_mode) {
+		case FB_BLANK_VSYNC_SUSPEND:
 			ctrl &= ~3;
 			break;
-		case VESA_HSYNC_SUSPEND:
+		case FB_BLANK_HSYNC_SUSPEND:
 			ctrl &= ~0x30;
 			break;
-		case VESA_POWERDOWN:
+		case FB_BLANK_POWERDOWN:
 			ctrl &= ~0x33;
 			/* fall through */
-		case VESA_NO_BLANKING:
+		case FB_BLANK_NORMAL:
 			ctrl |= 0x400;
 			break;
 		default:
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/cyber2000fb.c	2004-11-06 17:59:48 +08:00
@@ -1003,16 +1003,16 @@
 	int i;
 
 	switch (blank) {
-	case 4:	/* powerdown - both sync lines down */
+	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
 		sync = EXT_SYNC_CTL_VS_0 | EXT_SYNC_CTL_HS_0;
 		break;	
-	case 3:	/* hsync off */
+	case FB_BLANK_HSYNC_SUSPEND:	/* hsync off */
 		sync = EXT_SYNC_CTL_VS_NORMAL | EXT_SYNC_CTL_HS_0;
 		break;	
-	case 2:	/* vsync off */
+	case FB_BLANK_VSYNC_SUSPEND:	/* vsync off */
 		sync = EXT_SYNC_CTL_VS_0 | EXT_SYNC_CTL_HS_NORMAL;
 		break;
-	case 1:	/* soft blank */
+	case FB_BLANK_NORMAL:	        /* soft blank */
 	default: /* unblank */
 		break;
 	}
diff -Nru a/drivers/video/ffb.c b/drivers/video/ffb.c
--- a/drivers/video/ffb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/ffb.c	2004-11-06 17:59:48 +08:00
@@ -676,7 +676,7 @@
 	FFBWait(par);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		upa_writel(0x6000, &dac->type);
 		tmp = (upa_readl(&dac->value) | 0x1);
 		upa_writel(0x6000, &dac->type);
@@ -684,10 +684,10 @@
 		par->flags &= ~FFB_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
-	case 2: /* VESA blank (vsync off) */
-	case 3: /* VESA blank (hsync off) */
-	case 4: /* Poweroff */
+	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		upa_writel(0x6000, &dac->type);
 		tmp = (upa_readl(&dac->value) & ~0x1);
 		upa_writel(0x6000, &dac->type);
diff -Nru a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/gbefb.c	2004-11-06 17:59:48 +08:00
@@ -384,11 +384,11 @@
 {
 	/* 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off */
 	switch (blank) {
-	case 0:		/* unblank */
+	case FB_BLANK_UNBLANK:		/* unblank */
 		gbe_turn_on();
 		break;
 
-	case 1:		/* blank */
+	case FB_BLANK_NORMAL:		/* blank */
 		gbe_turn_off();
 		break;
 
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	2004-10-19 20:21:51 +08:00
+++ b/drivers/video/imsttfb.c	2004-11-06 17:59:49 +08:00
@@ -940,9 +940,9 @@
 
 	ctrl = read_reg_le32(par->dc_regs, STGCTL);
 	if (blank > 0) {
-		switch (blank - 1) {
-		case VESA_NO_BLANKING:
-		case VESA_POWERDOWN:
+		switch (blank) {
+		case FB_BLANK_NORMAL:
+		case FB_BLANK_POWERDOWN:
 			ctrl &= ~0x00000380;
 			if (par->ramdac == IBM) {
 				par->cmap_regs[PIDXHI] = 0;		eieio();
@@ -958,10 +958,10 @@
 				par->cmap_regs[PIDXDATA] = 0xc0;
 			}
 			break;
-		case VESA_VSYNC_SUSPEND:
+		case FB_BLANK_VSYNC_SUSPEND:
 			ctrl &= ~0x00000020;
 			break;
-		case VESA_HSYNC_SUSPEND:
+		case FB_BLANK_HSYNC_SUSPEND:
 			ctrl &= ~0x00000010;
 			break;
 		}
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-11-06 17:59:49 +08:00
@@ -1191,7 +1191,7 @@
 	DBG_MSG("intelfb_set_par (%dx%d-%d)\n", info->var.xres,
 		info->var.yres, info->var.bits_per_pixel);
 
-	intelfb_blank(1, info);
+	intelfb_blank(FB_BLANK_POWERDOWN, info);
 
 	if (dinfo->accel)
 		intelfbhw_2d_stop(dinfo);
@@ -1214,7 +1214,7 @@
 
 	intelfb_pan_display(&info->var, info);
 
-	intelfb_blank(0, info);
+	intelfb_blank(FB_BLANK_UNBLANK, info);
 
 	if (ACCEL(dinfo, info)) {
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
diff -Nru a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
--- a/drivers/video/intelfb/intelfbhw.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/intelfb/intelfbhw.c	2004-11-06 17:59:49 +08:00
@@ -341,17 +341,17 @@
 	/* Set DPMS level */
 	tmp = INREG(ADPA) & ~ADPA_DPMS_CONTROL_MASK;
 	switch (blank) {
-	case 0:
-	case 1:
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
 		tmp |= ADPA_DPMS_D0;
 		break;
-	case 2:
+	case FB_BLANK_VSYNC_SUSPEND:
 		tmp |= ADPA_DPMS_D1;
 		break;
-	case 3:
+	case FB_BLANK_HSYNC_SUSPEND:
 		tmp |= ADPA_DPMS_D2;
 		break;
-	case 4:
+	case FB_BLANK_POWERDOWN:
 		tmp |= ADPA_DPMS_D3;
 		break;
 	}
diff -Nru a/drivers/video/leo.c b/drivers/video/leo.c
--- a/drivers/video/leo.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/leo.c	2004-11-06 17:59:50 +08:00
@@ -270,17 +270,17 @@
 	spin_lock_irqsave(&par->lock, flags);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		val = sbus_readl(&lx_krn->krn_csr);
 		val |= LEO_KRN_CSR_ENABLE;
 		sbus_writel(val, &lx_krn->krn_csr);
 		par->flags &= ~LEO_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
-	case 2: /* VESA blank (vsync off) */
-	case 3: /* VESA blank (hsync off) */
-	case 4: /* Poweroff */
+	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		val = sbus_readl(&lx_krn->krn_csr);
 		val &= ~LEO_KRN_CSR_ENABLE;
 		sbus_writel(val, &lx_krn->krn_csr);
diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/matrox/matroxfb_base.c	2004-11-06 17:59:50 +08:00
@@ -1183,11 +1183,11 @@
 		return 1;
 
 	switch (blank) {
-		case 1:  seq = 0x20; crtc = 0x00; break; /* works ??? */
-		case 2:  seq = 0x20; crtc = 0x10; break;
-		case 3:  seq = 0x20; crtc = 0x20; break;
-		case 4:  seq = 0x20; crtc = 0x30; break;
-		default: seq = 0x00; crtc = 0x00; break;
+	case FB_BLANK_NORMAL:  seq = 0x20; crtc = 0x00; break; /* works ??? */
+	case FB_BLANK_VSYNC_SUSPEND:  seq = 0x20; crtc = 0x10; break;
+	case FB_BLANK_HSYNC_SUSPEND:  seq = 0x20; crtc = 0x20; break;
+	case FB_BLANK_POWERDOWN:  seq = 0x20; crtc = 0x30; break;
+	default: seq = 0x00; crtc = 0x00; break;
 	}
 
 	CRITBEGIN
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2004-11-06 12:21:50 +08:00
+++ b/drivers/video/neofb.c	2004-11-06 17:59:51 +08:00
@@ -1340,7 +1340,7 @@
 	int seqflags, lcdflags, dpmsflags, reg;
 
 	switch (blank_mode) {
-	case 4:		/* powerdown - both sync lines down */
+	case FB_BLANK_POWERDOWN:	/* powerdown - both sync lines down */
 		seqflags = VGA_SR01_SCREEN_OFF; /* Disable sequencer */
 		lcdflags = 0;			/* LCD off */
 		dpmsflags = NEO_GR01_SUPPRESS_HSYNC |
@@ -1358,22 +1358,22 @@
 		}
 #endif
 		break;
-	case 3:		/* hsync off */
+	case FB_BLANK_HSYNC_SUSPEND:		/* hsync off */
 		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags = 0;			/* LCD off */
 		dpmsflags = NEO_GR01_SUPPRESS_HSYNC;
 		break;
-	case 2:		/* vsync off */
+	case FB_BLANK_VSYNC_SUSPEND:		/* vsync off */
 		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags = 0;			/* LCD off */
 		dpmsflags = NEO_GR01_SUPPRESS_VSYNC;
 		break;
-	case 1:		/* just blank screen (backlight stays on) */
+	case FB_BLANK_NORMAL:		/* just blank screen (backlight stays on) */
 		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
 		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
 		dpmsflags = 0;			/* no hsync/vsync suppression */
 		break;
-	case 0:		/* unblank */
+	case FB_BLANK_UNBLANK:		/* unblank */
 		seqflags = 0;			/* Enable sequencer */
 		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
 		dpmsflags = 0x00;	/* no hsync/vsync suppression */
diff -Nru a/drivers/video/p9100.c b/drivers/video/p9100.c
--- a/drivers/video/p9100.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/p9100.c	2004-11-06 17:59:51 +08:00
@@ -193,17 +193,17 @@
 	spin_lock_irqsave(&par->lock, flags);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		val = sbus_readl(&regs->vid_screenpaint_timectl1);
 		val |= SCREENPAINT_TIMECTL1_ENABLE_VIDEO;
 		sbus_writel(val, &regs->vid_screenpaint_timectl1);
 		par->flags &= ~P9100_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
-	case 2: /* VESA blank (vsync off) */
-	case 3: /* VESA blank (hsync off) */
-	case 4: /* Poweroff */
+	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		val = sbus_readl(&regs->vid_screenpaint_timectl1);
 		val &= ~SCREENPAINT_TIMECTL1_ENABLE_VIDEO;
 		sbus_writel(val, &regs->vid_screenpaint_timectl1);
diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	2004-10-30 19:10:42 +08:00
+++ b/drivers/video/pm2fb.c	2004-11-06 17:59:51 +08:00
@@ -971,23 +971,23 @@
 	DPRINTK("blank_mode %d\n", blank_mode);
 
 	switch (blank_mode) {
-	case 0:
+	case FB_BLANK_UNBLANK:
 		/* Screen: On */
 		video |= PM2F_VIDEO_ENABLE;
 		break;
-	case VESA_NO_BLANKING + 1:
+	case FB_BLANK_NORMAL:
 		/* Screen: Off */
 		video &= ~PM2F_VIDEO_ENABLE;
 		break;
-	case VESA_VSYNC_SUSPEND + 1:
+	case FB_BLANK_VSYNC_SUSPEND:
 		/* VSync: Off */
 		video &= ~(PM2F_VSYNC_MASK | PM2F_BLANK_LOW );
 		break;
-	case VESA_HSYNC_SUSPEND + 1:
+	case FB_BLANK_HSYNC_SUSPEND:
 		/* HSync: Off */
 		video &= ~(PM2F_HSYNC_MASK | PM2F_BLANK_LOW );
 		break;
-	case VESA_POWERDOWN + 1:
+	case FB_BLANK_POWERDOWN:
 		/* HSync: Off, VSync: Off */
 		video &= ~(PM2F_VSYNC_MASK | PM2F_HSYNC_MASK| PM2F_BLANK_LOW);
 		break;
diff -Nru a/drivers/video/pxafb.c b/drivers/video/pxafb.c
--- a/drivers/video/pxafb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/pxafb.c	2004-11-06 17:59:52 +08:00
@@ -371,9 +371,10 @@
 	DPRINTK("pxafb_blank: blank=%d\n", blank);
 
 	switch (blank) {
-	case VESA_POWERDOWN:
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_NORMAL:
 		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
 		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
 			for (i = 0; i < fbi->palette_size; i++)
@@ -383,7 +384,7 @@
 		//TODO if (pxafb_blank_helper) pxafb_blank_helper(blank);
 		break;
 
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		//TODO if (pxafb_blank_helper) pxafb_blank_helper(blank);
 		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
 		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-11-07 21:32:09 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-11-06 17:59:52 +08:00
@@ -1240,22 +1240,25 @@
 	vesa = CRTCin(par, 0x1a) & ~0xc0;	/* sync on/off */
 
 	NVTRACE_ENTER();
-	if (blank) {
+
+	if (blank)
 		tmp |= 0x20;
-		switch (blank - 1) {
-		case VESA_NO_BLANKING:
-			break;
-		case VESA_VSYNC_SUSPEND:
-			vesa |= 0x80;
-			break;
-		case VESA_HSYNC_SUSPEND:
-			vesa |= 0x40;
-			break;
-		case VESA_POWERDOWN:
-			vesa |= 0xc0;
-			break;
-		}
+
+	switch (blank) {
+	case FB_BLANK_UNBLANK:
+	case FB_BLANK_NORMAL:
+		break;
+	case FB_BLANK_VSYNC_SUSPEND:
+		vesa |= 0x80;
+		break;
+	case FB_BLANK_HSYNC_SUSPEND:
+		vesa |= 0x40;
+		break;
+	case FB_BLANK_POWERDOWN:
+		vesa |= 0xc0;
+		break;
 	}
+
 	SEQout(par, 0x01, tmp);
 	CRTCout(par, 0x1a, vesa);
 
@@ -1266,6 +1269,7 @@
 #endif
 
 	NVTRACE_LEAVE();
+
 	return 0;
 }
 
diff -Nru a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/sa1100fb.c	2004-11-06 17:59:52 +08:00
@@ -1061,9 +1061,10 @@
 	DPRINTK("sa1100fb_blank: blank=%d\n", blank);
 
 	switch (blank) {
-	case VESA_POWERDOWN:
-	case VESA_VSYNC_SUSPEND:
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_NORMAL:
 		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
 		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
 			for (i = 0; i < fbi->palette_size; i++)
@@ -1071,7 +1072,7 @@
 		sa1100fb_schedule_work(fbi, C_DISABLE);
 		break;
 
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
 		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
 			fb_set_cmap(&fbi->fb.cmap, info);
diff -Nru a/drivers/video/tcx.c b/drivers/video/tcx.c
--- a/drivers/video/tcx.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/tcx.c	2004-11-06 17:59:53 +08:00
@@ -207,26 +207,26 @@
 	val = sbus_readl(&thc->thc_misc);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLAnK_UNBLANK: /* Unblanking */
 		val &= ~(TCX_THC_MISC_VSYNC_DIS |
 			 TCX_THC_MISC_HSYNC_DIS);
 		val |= TCX_THC_MISC_VIDEO;
 		par->flags &= ~TCX_FLAG_BLANKED;
 		break;
 
-	case 1: /* Normal blanking */
+	case FB_BLANK_NORMAL: /* Normal blanking */
 		val &= ~TCX_THC_MISC_VIDEO;
 		par->flags |= TCX_FLAG_BLANKED;
 		break;
 
-	case 2: /* VESA blank (vsync off) */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
 		val |= TCX_THC_MISC_VSYNC_DIS;
 		break;
-	case 3: /* VESA blank (hsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
 		val |= TCX_THC_MISC_HSYNC_DIS;
 		break;
 
-	case 4: /* Poweroff */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		break;
 	};
 
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	2004-10-19 20:22:25 +08:00
+++ b/drivers/video/tdfxfb.c	2004-11-06 17:59:53 +08:00
@@ -837,23 +837,23 @@
 	dacmode = tdfx_inl(par, DACMODE);
 
 	switch (blank) {
-		case 0: /* Screen: On; HSync: On, VSync: On */    
+		case FB_BLANK_UNBLANK: /* Screen: On; HSync: On, VSync: On */
 			state    = 0;
 			vgablank = 0;
 			break;
-		case 1: /* Screen: Off; HSync: On, VSync: On */
+		case FB_BLANK_NORMAL: /* Screen: Off; HSync: On, VSync: On */
 			state    = 0;
 			vgablank = 1;
 			break;
-		case 2: /* Screen: Off; HSync: On, VSync: Off */
+		case FB_BLANK_VSYNC_SUSPEND: /* Screen: Off; HSync: On, VSync: Off */
 			state    = BIT(3);
 			vgablank = 1;
 			break;
-		case 3: /* Screen: Off; HSync: Off, VSync: On */
+		case FB_BLANK_HSYNC_SUSPEND: /* Screen: Off; HSync: Off, VSync: On */
 			state    = BIT(1);
 			vgablank = 1;
 			break;
-		case 4: /* Screen: Off; HSync: Off, VSync: Off */
+		case FB_BLANK_POWERDOWN: /* Screen: Off; HSync: Off, VSync: Off */
 			state    = BIT(1) | BIT(3);
 			vgablank = 1;
 			break;
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	2004-11-06 06:21:26 +08:00
+++ b/drivers/video/tgafb.c	2004-11-06 17:59:53 +08:00
@@ -468,7 +468,7 @@
 	vvvr &= ~(TGA_VALID_VIDEO | TGA_VALID_BLANK);
 
 	switch (blank) {
-	case 0: /* Unblanking */
+	case FB_BLANK_UNBLANK: /* Unblanking */
 		if (par->vesa_blanked) {
 			TGA_WRITE_REG(par, vhcr & 0xbfffffff, TGA_HORIZ_REG);
 			TGA_WRITE_REG(par, vvcr & 0xbfffffff, TGA_VERT_REG);
@@ -477,24 +477,24 @@
 		TGA_WRITE_REG(par, vvvr | TGA_VALID_VIDEO, TGA_VALID_REG);
 		break;
 
-	case 1: /* Normal blanking */
+	case FB_BLANK_NORMAL: /* Normal blanking */
 		TGA_WRITE_REG(par, vvvr | TGA_VALID_VIDEO | TGA_VALID_BLANK,
 			      TGA_VALID_REG);
 		break;
 
-	case 2: /* VESA blank (vsync off) */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
 		TGA_WRITE_REG(par, vvcr | 0x40000000, TGA_VERT_REG);
 		TGA_WRITE_REG(par, vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
 		par->vesa_blanked = 1;
 		break;
 
-	case 3: /* VESA blank (hsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
 		TGA_WRITE_REG(par, vhcr | 0x40000000, TGA_HORIZ_REG);
 		TGA_WRITE_REG(par, vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
 		par->vesa_blanked = 1;
 		break;
 
-	case 4: /* Poweroff */
+	case FB_BLANK_POWERDOWN: /* Poweroff */
 		TGA_WRITE_REG(par, vhcr | 0x40000000, TGA_HORIZ_REG);
 		TGA_WRITE_REG(par, vvcr | 0x40000000, TGA_VERT_REG);
 		TGA_WRITE_REG(par, vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2004-10-27 14:58:08 +08:00
+++ b/drivers/video/tridentfb.c	2004-11-06 17:59:54 +08:00
@@ -1017,22 +1017,24 @@
 	DPMSCont = read3CE(PowerStatus) & 0xFC;
 	switch (blank_mode)
 	{
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		/* Screen: On, HSync: On, VSync: On */
+	case FB_BLANK_NORMAL:
+		/* Screen: Off, HSync: On, VSync: On */
 		PMCont |= 0x03;
 		DPMSCont |= 0x00;
 		break;
-	case VESA_HSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 		/* Screen: Off, HSync: Off, VSync: On */
 		PMCont |= 0x02;
 		DPMSCont |= 0x01;
 		break;
-	case VESA_VSYNC_SUSPEND:
+	case FB_BLANK_VSYNC_SUSPEND:
 		/* Screen: Off, HSync: On, VSync: Off */
 		PMCont |= 0x02;
 		DPMSCont |= 0x02;
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		/* Screen: Off, HSync: Off, VSync: Off */
 		PMCont |= 0x00;
 		DPMSCont |= 0x03;
@@ -1044,7 +1046,9 @@
 	t_outb(PMCont,0x83C6);
 
 	debug("exit\n");
-	return 0;
+
+	/* let fbcon do a softblank for us */
+	return (blank_mode == FB_BLANK_NORMAL) ? 1 : 0;
 }
 
 static int __devinit trident_pci_probe(struct pci_dev * dev, const struct pci_device_id * id)
diff -Nru a/drivers/video/valkyriefb.c b/drivers/video/valkyriefb.c
--- a/drivers/video/valkyriefb.c	2004-10-19 20:22:29 +08:00
+++ b/drivers/video/valkyriefb.c	2004-11-06 17:59:54 +08:00
@@ -207,13 +207,13 @@
 		return 1;
 
 	switch (blank_mode) {
-	case 0:			/* unblank */
+	case FB_BLANK_UNBLANK:			/* unblank */
 		out_8(&p->valkyrie_regs->mode.r, init->mode);
 		break;
-	case 1:
+	case FB_BLANK_NORMAL:
 		return 1;	/* get caller to set CLUT to all black */
-	case VESA_VSYNC_SUSPEND+1:
-	case VESA_HSYNC_SUSPEND+1:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 		/*
 		 * [kps] Value extracted from MacOS. I don't know
 		 * whether this bit disables hsync or vsync, or
@@ -221,7 +221,7 @@
 		 */
 		out_8(&p->valkyrie_regs->mode.r, init->mode | 0x40);
 		break;
-	case VESA_POWERDOWN+1:
+	case FB_BLANK_POWERDOWN:
 		out_8(&p->valkyrie_regs->mode.r, 0x66);
 		break;
 	}
diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c	2004-11-06 06:21:27 +08:00
+++ b/drivers/video/vga16fb.c	2004-11-06 17:59:54 +08:00
@@ -771,7 +771,7 @@
 	 * <Start of vertical Retrace> to maximum (incl. overflow)
 	 * Result: turn off vertical sync (VSync) pulse.
 	 */
-	if (mode & VESA_VSYNC_SUSPEND) {
+	if (mode & FB_BLANK_VSYNC_SUSPEND) {
 		outb_p(0x10,vga_video_port_reg);	/* StartVertRetrace */
 		outb_p(0xff,vga_video_port_val); 	/* maximum value */
 		outb_p(0x11,vga_video_port_reg);	/* EndVertRetrace */
@@ -780,7 +780,7 @@
 		outb_p(par->vga_state.Overflow | 0x84,vga_video_port_val); /* bits 9,10 of vert. retrace */
 	}
 
-	if (mode & VESA_HSYNC_SUSPEND) {
+	if (mode & FB_BLANK_HSYNC_SUSPEND) {
 		/*
 		 * Set <End of horizontal retrace> to minimum (0) and
 		 *  <Start of horizontal Retrace> to maximum
@@ -853,7 +853,7 @@
 	struct vga16fb_par *par = (struct vga16fb_par *) info->par;
 
 	switch (blank) {
-	case 0:				/* Unblank */
+	case FB_BLANK_UNBLANK:				/* Unblank */
 		if (par->vesa_blanked) {
 			vga_vesa_unblank(par);
 			par->vesa_blanked = 0;
@@ -862,12 +862,12 @@
 			par->palette_blanked = 0;
 		}
 		break;
-	case 1:				/* blank */
+	case FB_BLANK_NORMAL:				/* blank */
 		vga_pal_blank();
 		par->palette_blanked = 1;
 		break;
 	default:			/* VESA blanking */
-		vga_vesa_blank(par, blank-1);
+		vga_vesa_blank(par, blank);
 		par->vesa_blanked = 1;
 		break;
 	}




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
