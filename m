From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] cirrusfb: code improvement 2nd part
Date: Sat, 18 Aug 2007 23:36:48 +0200
Message-ID: <20070818233648.8b3df52b.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IMVtx-0002gI-Ml for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Aug 2007 14:32:12 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IMVtv-0001Rb-4e
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Aug 2007 14:32:09 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	18 Aug 2007 23:32:04 +0200
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

This patch removes:
- redundant fields from the cirrusfb_regs structure
- one redundant header
- fixes two includes ("" to <>)

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.23.old/drivers/video/cirrusfb.c	2007-08-18 15:39:02.000000000 +0200
+++ linux-2.6.23/drivers/video/cirrusfb.c	2007-08-18 16:13:26.000000000 +0200
@@ -45,7 +45,6 @@
 #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
-#include <linux/selection.h>
 #include <asm/pgtable.h>
 
 #ifdef CONFIG_ZORRO
@@ -64,8 +63,8 @@
 #define isPReP 0
 #endif
 
-#include "video/vga.h"
-#include "video/cirrus.h"
+#include <video/vga.h>
+#include <video/cirrus.h>
 
 /*****************************************************************
  *
@@ -99,9 +98,6 @@
 #endif
 
 #define MB_ (1024 * 1024)
-#define KB_ (1024)
-
-#define MAX_NUM_BOARDS 7
 
 /*****************************************************************
  *
@@ -331,10 +327,6 @@ static const struct {
 #endif /* CONFIG_ZORRO */
 
 struct cirrusfb_regs {
-	__u32 line_length;	/* in BYTES! */
-	__u32 visual;
-	__u32 type;
-
 	long freq;
 	long nom;
 	long den;
@@ -525,7 +517,7 @@ static struct fb_ops cirrusfb_ops = {
 /*--- Hardware Specific Routines -------------------------------------------*/
 static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 				struct cirrusfb_regs *regs,
-				const struct fb_info *info);
+				struct fb_info *info);
 /*--- Internal routines ----------------------------------------------------*/
 static void init_vgachip(struct fb_info *info);
 static void switch_monitor(struct cirrusfb_info *cinfo, int on);
@@ -792,7 +784,7 @@ static int cirrusfb_check_var(struct fb_
 
 static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 				struct cirrusfb_regs *regs,
-				const struct fb_info *info)
+				struct fb_info *info)
 {
 	long freq;
 	long maxclock;
@@ -803,20 +795,20 @@ static int cirrusfb_decode_var(const str
 
 	switch (var->bits_per_pixel) {
 	case 1:
-		regs->line_length = var->xres_virtual / 8;
-		regs->visual = FB_VISUAL_MONO10;
+		info->fix.line_length = var->xres_virtual / 8;
+		info->fix.visual = FB_VISUAL_MONO10;
 		break;
 
 	case 8:
-		regs->line_length = var->xres_virtual;
-		regs->visual = FB_VISUAL_PSEUDOCOLOR;
+		info->fix.line_length = var->xres_virtual;
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 
 	case 16:
 	case 24:
 	case 32:
-		regs->line_length = var->xres_virtual * maxclockidx;
-		regs->visual = FB_VISUAL_DIRECTCOLOR;
+		info->fix.line_length = var->xres_virtual * maxclockidx;
+		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
 		break;
 
 	default:
@@ -826,7 +818,7 @@ static int cirrusfb_decode_var(const str
 		break;
 	}
 
-	regs->type = FB_TYPE_PACKED_PIXELS;
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
 
 	/* convert from ps to kHz */
 	freq = PICOS2KHZ(var->pixclock);
@@ -1539,9 +1531,6 @@ static int cirrusfb_set_par_foo(struct f
 	DPRINTK("CL_SEQR1: %d\n", tmp);
 
 	cinfo->currentmode = regs;
-	info->fix.type = regs.type;
-	info->fix.visual = regs.visual;
-	info->fix.line_length = regs.line_length;
 
 	/* pan to requested offset */
 	cirrusfb_pan_display(var, info);
@@ -1622,7 +1611,7 @@ static int cirrusfb_pan_display(struct f
 	xoffset = var->xoffset * info->var.bits_per_pixel / 8;
 	yoffset = var->yoffset;
 
-	base = yoffset * cinfo->currentmode.line_length + xoffset;
+	base = yoffset * info->fix.line_length + xoffset;
 
 	if (info->var.bits_per_pixel == 1) {
 		/* base is already correct */
@@ -2081,7 +2070,7 @@ static void cirrusfb_fillrect(struct fb_
 			  (region->dx * m) / 8, region->dy,
 			  (region->width * m) / 8, region->height,
 			  color,
-			  cinfo->currentmode.line_length);
+			  info->fix.line_length);
 }
 
 static void cirrusfb_copyarea(struct fb_info *info,
@@ -2121,7 +2110,7 @@ static void cirrusfb_copyarea(struct fb_
 			(area->sx * m) / 8, area->sy,
 			(area->dx * m) / 8, area->dy,
 			(area->width * m) / 8, area->height,
-			cinfo->currentmode.line_length);
+			info->fix.line_length);
 
 }
 
@@ -2281,13 +2270,10 @@ static int cirrusfb_set_fbinfo(struct fb
 	info->fix.smem_len   = info->screen_size;
 	if (var->bits_per_pixel == 1)
 		info->fix.smem_len /= 4;
-	info->fix.type       = cinfo->currentmode.type;
 	info->fix.type_aux   = 0;
-	info->fix.visual     = cinfo->currentmode.visual;
 	info->fix.xpanstep   = 1;
 	info->fix.ypanstep   = 1;
 	info->fix.ywrapstep  = 0;
-	info->fix.line_length = cinfo->currentmode.line_length;
 
 	/* FIXME: map region at 0xB8000 if available, fill in here */
 	info->fix.mmio_len   = 0;
@@ -2446,7 +2432,7 @@ static int cirrusfb_pci_register(struct 
 	cinfo->unmap = cirrusfb_pci_unmap;
 
 	printk(KERN_INFO " RAM (%lu kB) at 0xx%lx, ",
-		info->screen_size / KB_, board_addr);
+		info->screen_size >> 10, board_addr);
 	printk(KERN_INFO "Cirrus Logic chipset on PCI bus\n");
 	pci_set_drvdata(pdev, info);
 
@@ -2520,7 +2506,6 @@ static int cirrusfb_zorro_register(struc
 	}
 
 	cinfo = info->par;
-	cinfo->info = info;
 	cinfo->btype = btype;
 
 	assert(z > 0);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
