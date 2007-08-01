From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] cg6: accelerated copyarea
Date: Thu, 2 Aug 2007 01:17:35 +0200
Message-ID: <20070802011735.a89bf72c.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IGNNz-0002FR-IC for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 16:13:48 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IGNNz-00080j-1U
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 16:13:47 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 Aug 2007 01:13:44 +0200
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
Cc: David Miller <davem@davemloft.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated copyarea and sets READS_FAST flag.
This doubles scrolling speed on SparcStation20 85MHz.

It also fixes a comment in cg6_fillrect function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This patch requires both cg6-cleanup and cg6-fbmem-size-fix patches
to apply cleanly.

--- linux-2.6.23smp/drivers/video/cg6.c	2007-08-02 00:32:01.000000000 +0200
+++ linux-2.6.23/drivers/video/cg6.c	2007-08-02 00:38:11.000000000 +0200
@@ -37,6 +37,7 @@ static void cg6_fillrect(struct fb_info 
 static int cg6_sync(struct fb_info *);
 static int cg6_mmap(struct fb_info *, struct vm_area_struct *);
 static int cg6_ioctl(struct fb_info *, unsigned int, unsigned long);
+static void cg6_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 
 /*
  *  Frame buffer operations
@@ -47,7 +48,7 @@ static struct fb_ops cg6_ops = {
 	.fb_setcolreg		= cg6_setcolreg,
 	.fb_blank		= cg6_blank,
 	.fb_fillrect		= cg6_fillrect,
-	.fb_copyarea		= cfb_copyarea,
+	.fb_copyarea		= cg6_copyarea,
 	.fb_imageblit		= cg6_imageblit,
 	.fb_sync		= cg6_sync,
 	.fb_mmap		= cg6_mmap,
@@ -292,10 +293,12 @@ static void cg6_fillrect(struct fb_info 
 	unsigned long flags;
 	s32 val;
 
-	/* XXX doesn't handle ROP_XOR */
+	/* CG6 doesn't handle ROP_XOR */
 
 	spin_lock_irqsave(&par->lock, flags);
+
 	cg6_sync(info);
+
 	sbus_writel(rect->color, &fbc->fg);
 	sbus_writel(~(u32)0, &fbc->pixelm);
 	sbus_writel(0xea80ff00, &fbc->alu);
@@ -313,6 +316,48 @@ static void cg6_fillrect(struct fb_info 
 }
 
 /**
+ *	cg6_copyarea - Copies one area of the screen to another area.
+ *
+ *	@info: frame buffer structure that represents a single frame buffer
+ *	@area: Structure providing the data to copy the framebuffer contents
+ *		from one region to another.
+ *
+ *	This drawing operation copies a rectangular area from one area of the
+ *	screen to another area.
+ */
+static void cg6_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	struct cg6_par *par = (struct cg6_par *)info->par;
+	struct cg6_fbc __iomem *fbc = par->fbc;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&par->lock, flags);
+
+	cg6_sync(info);
+
+	sbus_writel(0xff, &fbc->fg);
+	sbus_writel(0x00, &fbc->bg);
+	sbus_writel(~0, &fbc->pixelm);
+	sbus_writel(0xe880cccc, &fbc->alu);
+	sbus_writel(0, &fbc->s);
+	sbus_writel(0, &fbc->clip);
+
+	sbus_writel(area->sy, &fbc->y0);
+	sbus_writel(area->sx, &fbc->x0);
+	sbus_writel(area->sy + area->height - 1, &fbc->y1);
+	sbus_writel(area->sx + area->width - 1, &fbc->x1);
+	sbus_writel(area->dy, &fbc->y2);
+	sbus_writel(area->dx, &fbc->x2);
+	sbus_writel(area->dy + area->height - 1, &fbc->y3);
+	sbus_writel(area->dx + area->width - 1, &fbc->x3);
+	do {
+		i = sbus_readl(&fbc->blit);
+	} while (i < 0 && (i & 0x20000000));
+	spin_unlock_irqrestore(&par->lock, flags);
+}
+
+/**
  *	cg6_imageblit -	Copies a image from system memory to the screen.
  *
  *	@info: frame buffer structure that represents a single frame buffer
@@ -708,7 +753,8 @@ static int __devinit cg6_probe(struct of
 				sizeof(u32), "cgsix fhc");
 
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT |
-			FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
+			FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
+			FBINFO_READS_FAST;
 	info->fbops = &cg6_ops;
 
 	info->screen_base = of_ioremap(&op->resource[0], CG6_RAM_OFFSET,

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
