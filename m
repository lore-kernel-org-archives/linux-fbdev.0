From: Jakub Bogusz <qboosh@pld-linux.org>
Subject: [PATCH] interlace and doublescan modes support for tdfxfb in 2.6
Date: Sun, 10 Aug 2003 01:24:55 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030809232455.GC28322@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pg104.warszawa.cvx.ppp.tpnet.pl ([213.76.102.104] helo=satan.blackhosts)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ld4u-00013Q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 09 Aug 2003 16:24:56 -0700
Received: from satan.blackhosts (localhost [127.0.0.1])
	by satan.blackhosts (8.12.9/8.12.9) with ESMTP id h79NQNPl028795
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Aug 2003 01:26:25 +0200
Received: (from qboosh@localhost)
	by satan.blackhosts (8.12.9/8.12.9/Submit) id h79NOtu7028370
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Aug 2003 01:24:55 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

this patch adds interlace and doublescan modes support to tdfxfb in 2.6
(it's a port of changes already incorporated into 2.4.21).

Also please look at my last two patches (for fillrect in tdfxfb and
margins in fbcon) sent to this list recently.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-interlace+double.patch"

This patch adds interlace and double-scan mode support to tdfxfb in 2.6.
It's a port of my changes (incorporated into 2.4.21) to Linux 2.6.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.0-test3/include/video/tdfx.h.orig	2003-07-14 05:32:41.000000000 +0200
+++ linux-2.6.0-test3/include/video/tdfx.h	2003-08-09 21:28:04.000000000 +0200
@@ -114,6 +114,7 @@
 #define VGAINIT1_MASK                   0x1fffff
 #define VIDCFG_VIDPROC_ENABLE           BIT(0)
 #define VIDCFG_CURS_X11                 BIT(1)
+#define VIDCFG_INTERLACE                BIT(3)
 #define VIDCFG_HALF_MODE                BIT(4)
 #define VIDCFG_DESK_ENABLE              BIT(7)
 #define VIDCFG_CLUT_BYPASS              BIT(10)
--- linux-2.6.0-test3/drivers/video/tdfxfb.c.orig	2003-08-09 21:26:11.000000000 +0200
+++ linux-2.6.0-test3/drivers/video/tdfxfb.c	2003-08-09 22:52:20.000000000 +0200
@@ -508,8 +508,10 @@
 		return -EINVAL;
 	}
 
-	/* fixme: does Voodoo3 support interlace? Banshee doesn't */
-	if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
+	/* Banshee doesn't support interlace, but Voodoo4/5 and probably Voodoo3 do. */
+	/* no direct information about device id now? use max_pixclock for this... */
+	if (((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) &&
+			(par->max_pixclock < VOODOO3_MAX_PIXCLOCK)) {
 		DPRINTK("interlace not supported\n");
 		return -EINVAL;
 	}
@@ -616,10 +618,17 @@
 	hbs = hd;
 	hbe = ht;
 
-	vbs = vd = info->var.yres - 1;
-	vs  = vd + info->var.lower_margin;
-	ve  = vs + info->var.vsync_len;
-	vbe = vt = ve + info->var.upper_margin - 1;
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		vbs = vd = (info->var.yres << 1) - 1;
+		vs  = vd + (info->var.lower_margin << 1);
+		ve  = vs + (info->var.vsync_len << 1);
+		vbe = vt = ve + (info->var.upper_margin << 1) - 1;
+	} else {
+		vbs = vd = info->var.yres - 1;
+		vs  = vd + info->var.lower_margin;
+		ve  = vs + info->var.vsync_len;
+		vbe = vt = ve + info->var.upper_margin - 1;
+	}
   
 	/* this is all pretty standard VGA register stuffing */
 	reg.misc[0x00] = 0x0f | 
@@ -742,8 +751,16 @@
 	reg.gfxpll = do_calc_pll(..., &fout);
 #endif
 
-	reg.screensize = info->var.xres | (info->var.yres << 12);
-	reg.vidcfg &= ~VIDCFG_HALF_MODE;
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		reg.screensize = info->var.xres | (info->var.yres << 13);
+		reg.vidcfg |= VIDCFG_HALF_MODE;
+		reg.crt[0x09] |= 0x80;
+	} else {
+		reg.screensize = info->var.xres | (info->var.yres << 12);
+		reg.vidcfg &= ~VIDCFG_HALF_MODE;
+	}
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+		reg.vidcfg |= VIDCFG_INTERLACE;
 	reg.miscinit0 = tdfx_inl(par, MISCINIT0);
 
 #if defined(__BIG_ENDIAN)

--sm4nu43k4a2Rpi4c--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
