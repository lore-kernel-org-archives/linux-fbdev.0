From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [REPOST][PATCH 6/7] p9100: use standard fields
 for framebuffer physical address and length
Date: Sun, 17 May 2009 14:31:02 +0200
Message-ID: <20090517143102.5d881de9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M5fQM-0008Oq-R5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 12:25:02 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5fQI-00079p-MH for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 May 2009 12:25:02 +0000
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

diff -urp linux-orig/drivers/video/p9100.c linux-2.6.30/drivers/video/p9100.c
--- linux-orig/drivers/video/p9100.c	2008-10-13 18:03:36.000000000 +0200
+++ linux-2.6.30/drivers/video/p9100.c	2009-05-04 00:59:22.000000000 +0200
@@ -134,9 +134,7 @@ struct p9100_par {
 	u32			flags;
 #define P9100_FLAG_BLANKED	0x00000001
 
-	unsigned long		physbase;
 	unsigned long		which_io;
-	unsigned long		fbsize;
 };
 
 /**
@@ -224,18 +222,16 @@ static int p9100_mmap(struct fb_info *in
 	struct p9100_par *par = (struct p9100_par *)info->par;
 
 	return sbusfb_mmap_helper(p9100_mmap_map,
-				  par->physbase, par->fbsize,
+				  info->fix.smem_start, info->fix.smem_len,
 				  par->which_io, vma);
 }
 
 static int p9100_ioctl(struct fb_info *info, unsigned int cmd,
 		       unsigned long arg)
 {
-	struct p9100_par *par = (struct p9100_par *) info->par;
-
 	/* Make it look like a cg3. */
 	return sbusfb_ioctl_helper(cmd, arg, info,
-				   FBTYPE_SUN3COLOR, 8, par->fbsize);
+				   FBTYPE_SUN3COLOR, 8, info->fix.smem_len);
 }
 
 /*
@@ -271,7 +267,7 @@ static int __devinit p9100_probe(struct 
 	spin_lock_init(&par->lock);
 
 	/* This is the framebuffer and the only resource apps can mmap.  */
-	par->physbase = op->resource[2].start;
+	info->fix.smem_start = op->resource[2].start;
 	par->which_io = op->resource[2].flags & IORESOURCE_BITS;
 
 	sbusfb_fill_var(&info->var, dp, 8);
@@ -280,7 +276,7 @@ static int __devinit p9100_probe(struct 
 	info->var.blue.length = 8;
 
 	linebytes = of_getintprop_default(dp, "linebytes", info->var.xres);
-	par->fbsize = PAGE_ALIGN(linebytes * info->var.yres);
+	info->fix.smem_len = PAGE_ALIGN(linebytes * info->var.yres);
 
 	par->regs = of_ioremap(&op->resource[0], 0,
 			       sizeof(struct p9100_regs), "p9100 regs");
@@ -290,7 +286,7 @@ static int __devinit p9100_probe(struct 
 	info->flags = FBINFO_DEFAULT;
 	info->fbops = &p9100_ops;
 	info->screen_base = of_ioremap(&op->resource[2], 0,
-				       par->fbsize, "p9100 ram");
+				       info->fix.smem_len, "p9100 ram");
 	if (!info->screen_base)
 		goto out_unmap_regs;
 
@@ -311,7 +307,7 @@ static int __devinit p9100_probe(struct 
 
 	printk(KERN_INFO "%s: p9100 at %lx:%lx\n",
 	       dp->full_name,
-	       par->which_io, par->physbase);
+	       par->which_io, info->fix.smem_start);
 
 	return 0;
 
@@ -319,7 +315,7 @@ out_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
 
 out_unmap_screen:
-	of_iounmap(&op->resource[2], info->screen_base, par->fbsize);
+	of_iounmap(&op->resource[2], info->screen_base, info->fix.smem_len);
 
 out_unmap_regs:
 	of_iounmap(&op->resource[0], par->regs, sizeof(struct p9100_regs));
@@ -340,7 +336,7 @@ static int __devexit p9100_remove(struct
 	fb_dealloc_cmap(&info->cmap);
 
 	of_iounmap(&op->resource[0], par->regs, sizeof(struct p9100_regs));
-	of_iounmap(&op->resource[2], info->screen_base, par->fbsize);
+	of_iounmap(&op->resource[2], info->screen_base, info->fix.smem_len);
 
 	framebuffer_release(info);
 

----------------------------------------------------------------------
Zrob sobie prezent. Wygraj nagrode!
Sprawdz >>  http://link.interia.pl/f2176 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
