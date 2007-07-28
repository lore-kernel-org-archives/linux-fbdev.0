From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] tdfxfb: hardware cursor
Date: Sat, 28 Jul 2007 10:26:35 +0200
Message-ID: <20070728102635.d31fa8ea.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IEha2-0000Nf-TY for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Jul 2007 01:23:18 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IEha2-0003A9-1x
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Jul 2007 01:23:18 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	28 Jul 2007 10:23:13 +0200
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds hardware cursor support to the tdfxfb driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch requires all tdfxfb patches from the -mm tree and the source code 
improvement patch sent yesterday to this list.

I am not sure if the FB_CUR_SETIMAGE and FB_CUR_SETSHAPE are implemented
correctly (the mask is always mask and the image is xor or and of the mask and data).
The cursor works correctly on Voodoo3 2000 PCI with this patch.

I added a separate option to Kconfig to enable this feature but I am eager to remove
the option and make the hardware cursor always used after someone can confirm
it is ok on Banshee and Voodoo4/5 (no ifdefs).

Regards,
Krzysztof

--- linux-2.6.22/drivers/video/Kconfig	2007-07-27 22:36:26.548435617 +0200
+++ linux-2.6.23/drivers/video/Kconfig	2007-07-28 00:07:38.488263696 +0200
@@ -1458,6 +1458,13 @@ config FB_3DFX_ACCEL
 	with acceleration functions.
 
 
+config FB_3DFX_HW_CURSOR
+	bool "3Dfx Banshee/Voodoo3 hardware cursor functions (EXPERIMENTAL)"
+	depends on FB_3DFX && EXPERIMENTAL
+	---help---
+	This will compile the 3Dfx Banshee/Voodoo3 frame buffer device
+	with hardware cursor support.
+
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
 	depends on FB && PCI
--- linux-2.6.22.old/drivers/video/tdfxfb.c	2007-07-26 17:45:15.000000000 +0200
+++ linux-2.6.22/drivers/video/tdfxfb.c	2007-07-27 23:36:39.000000000 +0200
@@ -67,7 +67,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <asm/io.h>
-#include <linux/timer.h>
 #include <linux/spinlock.h>
 
 #include <video/tdfx.h>
@@ -378,7 +377,7 @@ static void do_write_regs(struct fb_info
 	tdfx_outl(par, VGAINIT0, reg->vgainit0);
 	tdfx_outl(par, DACMODE, reg->dacmode);
 	tdfx_outl(par, VIDDESKSTRIDE, reg->stride);
-	tdfx_outl(par, HWCURPATADDR, 0);
+	tdfx_outl(par, HWCURPATADDR, reg->curspataddr);
 
 	tdfx_outl(par, VIDSCREENSIZE, reg->screensize);
 	tdfx_outl(par, VIDDESKSTART, reg->startaddr);
@@ -453,6 +452,7 @@ static int tdfxfb_check_var(struct fb_va
 		DPRINTK("xoffset not supported\n");
 		return -EINVAL;
 	}
+	var->yoffset = 0;
 
 	/* Banshee doesn't support interlace, but Voodoo4/5 and probably Voodoo3 do. */
 	/* no direct information about device id now? use max_pixclock for this... */
@@ -663,6 +663,9 @@ static int tdfxfb_set_par(struct fb_info
 			VGAINIT0_EXTSHIFTOUT;
 	reg.vgainit1 = tdfx_inl(par, VGAINIT1) & 0x1fffff;
 
+#ifdef CONFIG_FB_3DFX_HW_CURSOR
+	reg.curspataddr = info->fix.smem_len;
+#endif
 	reg.cursloc   = 0;
 
 	reg.cursc0    = 0;
@@ -1012,11 +1015,11 @@ static void tdfxfb_imageblit(struct fb_i
 }
 #endif /* CONFIG_FB_3DFX_ACCEL */
 
-#ifdef TDFX_HARDWARE_CURSOR
+#ifdef CONFIG_FB_3DFX_HW_CURSOR
 static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct tdfx_par *par = info->par;
-	unsigned long flags;
+	u32 vidcfg;
 
 	/*
 	 * If the cursor is not be changed this means either we want the
@@ -1026,69 +1029,46 @@ static int tdfxfb_cursor(struct fb_info 
 	if (!cursor->set)
 		return 0;
 
-	/* Too large of a cursor :-( */
-	if (cursor->image.width > 64 || cursor->image.height > 64)
-		return -ENXIO;
-
-	/*
-	 * If we are going to be changing things we should disable
-	 * the cursor first
-	 */
-	if (info->cursor.enable) {
-		spin_lock_irqsave(&par->DAClock, flags);
-		info->cursor.enable = 0;
-		del_timer(&(par->hwcursor.timer));
-		tdfx_outl(par, VIDPROCCFG, par->hwcursor.disable);
-		spin_unlock_irqrestore(&par->DAClock, flags);
-	}
+	/* Too large of a cursor or wrong bpp :-( */
+	if (cursor->image.width > 64 ||
+	    cursor->image.height > 64 ||
+	    cursor->image.depth > 1)
+		return -EINVAL;
 
-	/* Disable the Cursor */
-	if ((cursor->set && FB_CUR_SETCUR) && !cursor->enable)
-		return 0;
+	vidcfg = tdfx_inl(par, VIDPROCCFG);
+	if (cursor->enable)
+		tdfx_outl(par, VIDPROCCFG, vidcfg | VIDCFG_HWCURSOR_ENABLE);
+	else
+		tdfx_outl(par, VIDPROCCFG, vidcfg & ~VIDCFG_HWCURSOR_ENABLE);
 
 	/* fix cursor color - XFree86 forgets to restore it properly */
-	if (cursor->set && FB_CUR_SETCMAP) {
-		struct fb_cmap cmap = cursor->image.cmap;
+	if (cursor->set & FB_CUR_SETCMAP) {
+		struct fb_cmap cmap = info->cmap;
+		u32 bg_idx = cursor->image.bg_color;
+		u32 fg_idx = cursor->image.fg_color;
 		unsigned long bg_color, fg_color;
 
-		cmap.len = 2; /* Voodoo 3+ only support 2 color cursors */
-		fg_color = ((cmap.red[cmap.start] << 16) |
-			    (cmap.green[cmap.start] << 8) |
-			    (cmap.blue[cmap.start]));
-		bg_color = ((cmap.red[cmap.start + 1] << 16) |
-			    (cmap.green[cmap.start + 1] << 8) |
-			    (cmap.blue[cmap.start + 1]));
-		fb_copy_cmap(&cmap, &info->cursor.image.cmap);
-		spin_lock_irqsave(&par->DAClock, flags);
+		fg_color = (((u32)cmap.red[fg_idx]   & 0xff00) << 8) |
+			   (((u32)cmap.green[fg_idx] & 0xff00) << 0) |
+			   (((u32)cmap.blue[fg_idx]  & 0xff00) >> 8);
+		bg_color = (((u32)cmap.red[bg_idx]   & 0xff00) << 8) |
+			   (((u32)cmap.green[bg_idx] & 0xff00) << 0) |
+			   (((u32)cmap.blue[bg_idx]  & 0xff00) >> 8);
 		banshee_make_room(par, 2);
 		tdfx_outl(par, HWCURC0, bg_color);
 		tdfx_outl(par, HWCURC1, fg_color);
-		spin_unlock_irqrestore(&par->DAClock, flags);
 	}
 
-	if (cursor->set && FB_CUR_SETPOS) {
-		int x, y;
+	if (cursor->set & FB_CUR_SETPOS) {
+		int x = cursor->image.dx;
+		int y = cursor->image.dy - info->var.yoffset;
 
-		x = cursor->image.dx;
-		y = cursor->image.dy;
-		y -= info->var.yoffset;
-		info->cursor.image.dx = x;
-		info->cursor.image.dy = y;
 		x += 63;
 		y += 63;
-		spin_lock_irqsave(&par->DAClock, flags);
 		banshee_make_room(par, 1);
 		tdfx_outl(par, HWCURLOC, (y << 16) + x);
-		spin_unlock_irqrestore(&par->DAClock, flags);
 	}
-
-	/* Not supported so we fake it */
-	if (cursor->set && FB_CUR_SETHOT) {
-		info->cursor.hot.x = cursor->hot.x;
-		info->cursor.hot.y = cursor->hot.y;
-	}
-
-	if (cursor->set && FB_CUR_SETSHAPE) {
+	if (cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
 		/*
 		 * Voodoo 3 and above cards use 2 monochrome cursor patterns.
 		 *    The reason is so the card can fetch 8 words at a time
@@ -1096,7 +1076,7 @@ static int tdfxfb_cursor(struct fb_info 
 		 * This reduces the number of times for access to draw the
 		 * cursor for each screen refresh.
 		 *    Each pattern is a bitmap of 64 bit wide and 64 bit high
-		 * (total of 8192 bits or 1024 Kbytes). The two patterns are
+		 * (total of 8192 bits or 1024 bytes). The two patterns are
 		 * stored in such a way that pattern 0 always resides in the
 		 * lower half (least significant 64 bits) of a 128 bit word
 		 * and pattern 1 the upper half. If you examine the data of
@@ -1107,47 +1087,32 @@ static int tdfxfb_cursor(struct fb_info 
 		 * (128 bits) which is the maximum cursor width times two for
 		 * the two monochrome patterns.
 		 */
-		u8 *cursorbase = (u8 *)info->cursor.image.data;
-		char *bitmap = (char *)cursor->image.data;
-		char *mask = (char *)cursor->mask;
-		int i, j, k, h = 0;
-
-		for (i = 0; i < 64; i++) {
-			if (i < cursor->image.height) {
-				j = (cursor->image.width + 7) >> 3;
-				k = 8 - j;
-
-				for (; j > 0; j--) {
-					/* Pattern 0. Copy the cursor bitmap to it */
-					fb_writeb(*bitmap, cursorbase + h);
-					bitmap++;
-					/* Pattern 1. Copy the cursor mask to it */
-					fb_writeb(*mask, cursorbase + h + 8);
-					mask++;
-					h++;
-				}
-				for (; k > 0; k--) {
-					fb_writeb(0, cursorbase + h);
-					fb_writeb(~0, cursorbase + h + 8);
-					h++;
-				}
-			} else {
-				fb_writel(0, cursorbase + h);
-				fb_writel(0, cursorbase + h + 4);
-				fb_writel(~0, cursorbase + h + 8);
-				fb_writel(~0, cursorbase + h + 12);
-				h += 16;
+		u8 __iomem *cursorbase = info->screen_base + info->fix.smem_len;
+		u8 *bitmap = (u8 *)cursor->image.data;
+		u8 *mask = (u8 *)cursor->mask;
+		int i;
+
+		fb_memset(cursorbase, 0, 1024);
+
+		for (i = 0; i < cursor->image.height; i++) {
+			int h = 0;
+			int j = (cursor->image.width + 7) >> 3;
+
+			for (; j > 0; j--) {
+				u8 data = *mask ^ *bitmap;
+				if (cursor->rop == ROP_COPY)
+					data = *mask & *bitmap;
+				/* Pattern 0. Copy the cursor mask to it */
+				fb_writeb(*mask, cursorbase + h);
+				mask++;
+				/* Pattern 1. Copy the cursor bitmap to it */
+				fb_writeb(data, cursorbase + h + 8);
+				bitmap++;
+				h++;
 			}
+			cursorbase += 16;
 		}
 	}
-	/* Turn the cursor on */
-	cursor->enable = 1;
-	info->cursor = *cursor;
-	mod_timer(&par->hwcursor.timer, jiffies + HZ / 2);
-	spin_lock_irqsave(&par->DAClock, flags);
-	banshee_make_room(par, 1);
-	tdfx_outl(par, VIDPROCCFG, par->hwcursor.enable);
-	spin_unlock_irqrestore(&par->DAClock, flags);
 	return 0;
 }
 #endif
@@ -1160,6 +1125,9 @@ static struct fb_ops tdfxfb_ops = {
 	.fb_blank	= tdfxfb_blank,
 	.fb_pan_display	= tdfxfb_pan_display,
 	.fb_sync	= banshee_wait_idle,
+#ifdef CONFIG_FB_3DFX_HW_CURSOR
+	.fb_cursor	= tdfxfb_cursor,
+#endif
 #ifdef CONFIG_FB_3DFX_ACCEL
 	.fb_fillrect	= tdfxfb_fillrect,
 	.fb_copyarea	= tdfxfb_copyarea,
@@ -1272,6 +1240,11 @@ static int __devinit tdfxfb_probe(struct
 				   FBINFO_HWACCEL_IMAGEBLIT |
 				   FBINFO_READS_FAST;
 #endif
+#ifdef CONFIG_FB_3DFX_HW_CURSOR
+	/* reserve 8192 bits for cursor */
+	/* the 2.4 driver says PAGE_MASK boundary is not enough for Voodoo4 */
+	info->fix.smem_len = (info->fix.smem_len - 1024) & (PAGE_MASK << 1);
+#endif
 
 	if (!mode_option)
 		mode_option = "640x480@60";
--- linux-2.6.22.old/include/video/tdfx.h	2007-07-26 17:45:15.000000000 +0200
+++ linux-2.6.22/include/video/tdfx.h	2007-07-26 17:52:57.000000000 +0200
@@ -175,14 +175,6 @@ struct tdfx_par {
 	u32 palette[16];
 	void __iomem *regbase_virt;
 	unsigned long iobase;
-
-	struct {
-		int w, u, d;
-		unsigned long enable, disable;
-		struct timer_list timer;
-	} hwcursor;
-
-	spinlock_t DAClock;
 };
 
 #endif	/* __KERNEL__ */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
