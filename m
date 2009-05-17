From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [REPOST][PATCH 7/7] tcx: use standard fields
 for framebuffer physical address and length
Date: Sun, 17 May 2009 14:31:07 +0200
Message-ID: <20090517143107.8fa3828c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M5fQO-0001UT-Un
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 12:25:04 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5fQN-0008SJ-Md for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 12:25:04 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use standard fields fbinfo.fix.smem_start and fbinfo.fix.smem_len
for physical address and length of framebuffer.

This also fixes output of the 'fbset -i' command - address and length 
of the framebuffer are displayed correctly.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Acked-by: David S. Miller <davem@davemloft.net>
---

diff -urp linux-orig/drivers/video/tcx.c linux-2.6.30/drivers/video/tcx.c
--- linux-orig/drivers/video/tcx.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/tcx.c	2009-05-04 00:59:47.000000000 +0200
@@ -116,17 +116,16 @@ struct tcx_par {
 	u32			flags;
 #define TCX_FLAG_BLANKED	0x00000001
 
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
 
 	struct sbus_mmap_map	mmap_map[TCX_MMAP_ENTRIES];
 	int			lowdepth;
 };
 
 /* Reset control plane so that WID is 8-bit plane. */
-static void __tcx_set_control_plane(struct tcx_par *par)
+static void __tcx_set_control_plane(struct fb_info *info)
 {
+	struct tcx_par *par = info->par;
 	u32 __iomem *p, *pend;
 
 	if (par->lowdepth)
@@ -135,7 +134,7 @@ static void __tcx_set_control_plane(stru
 	p = par->cplane;
 	if (p == NULL)
 		return;
-	for (pend = p + par->fbsize; p < pend; p++) {
+	for (pend = p + info->fix.smem_len; p < pend; p++) {
 		u32 tmp = sbus_readl(p);
 
 		tmp &= 0xffffff;
@@ -149,7 +148,7 @@ static void tcx_reset(struct fb_info *in
 	unsigned long flags;
 
 	spin_lock_irqsave(&par->lock, flags);
-	__tcx_set_control_plane(par);
+	__tcx_set_control_plane(info);
 	spin_unlock_irqrestore(&par->lock, flags);
 }
 
@@ -304,7 +303,7 @@ static int tcx_mmap(struct fb_info *info
 	struct tcx_par *par = (struct tcx_par *)info->par;
 
 	return sbusfb_mmap_helper(par->mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io, vma);
 }
 
@@ -316,7 +315,7 @@ static int tcx_ioctl(struct fb_info *inf
 	return sbusfb_ioctl_helper(cmd, arg, info,
 				   FBTYPE_TCXCOLOR,
 				   (par->lowdepth ? 8 : 24),
-				   par->fbsize);
+				   info->fix.smem_len);
 }
 
 /*
@@ -358,10 +357,10 @@ static void tcx_unmap_regs(struct of_dev
 			   par->bt, sizeof(struct bt_regs));
 	if (par->cplane)
 		of_iounmap(&op->resource[4],
-			   par->cplane, par->fbsize * sizeof(u32));
+			   par->cplane, info->fix.smem_len * sizeof(u32));
 	if (info->screen_base)
 		of_iounmap(&op->resource[0],
-			   info->screen_base, par->fbsize);
+			   info->screen_base, info->fix.smem_len);
 }
 
 static int __devinit tcx_probe(struct of_device *op,
@@ -391,7 +390,7 @@ static int __devinit tcx_probe(struct of
 
 	linebytes = of_getintprop_default(dp, "linebytes",
 					  info->var.xres);
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	par->tec = of_ioremap(&op->resource[7], 0,
 				  sizeof(struct tcx_tec), "tcx tec");
@@ -400,7 +399,7 @@ static int __devinit tcx_probe(struct of
 	par->bt = of_ioremap(&op->resource[8], 0,
 				 sizeof(struct bt_regs), "tcx dac");
 	info->screen_base = of_ioremap(&op->resource[0], 0,
-					   par->fbsize, "tcx ram");
+					   info->fix.smem_len, "tcx ram");
 	if (!par->tec || !par->thc ||
 	    !par->bt || !info->screen_base)
 		goto out_unmap_regs;
@@ -408,7 +407,7 @@ static int __devinit tcx_probe(struct of
 	memcpy(&par->mmap_map, &__tcx_mmap_map, sizeof(par->mmap_map));
 	if (!par->lowdepth) {
 		par->cplane = of_ioremap(&op->resource[4], 0,
-					     par->fbsize * sizeof(u32),
+					     info->fix.smem_len * sizeof(u32),
 					     "tcx cplane");
 		if (!par->cplane)
 			goto out_unmap_regs;
@@ -419,7 +418,7 @@ static int __devinit tcx_probe(struct of
 		par->mmap_map[6].size = SBUS_MMAP_EMPTY;
 	}
 
-	par->physbase = op->resource[0].start;
+	info->fix.smem_start = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	for (i = 0; i < TCX_MMAP_ENTRIES; i++) {
@@ -473,7 +472,7 @@ static int __devinit tcx_probe(struct of
 	printk(KERN_INFO "%s: TCX at %lx:%lx, %s\n",
 	       dp->full_name,
 	       par->which_io,
-	       par->physbase,
+	       info->fix.smem_start,
 	       par->lowdepth ? "8-bit only" : "24-bit depth");
 
 	return 0;

----------------------------------------------------------------------
Fantastyczne nagrody do zgarniecia!
Zagraj >> http://link.interia.pl/f2177 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
