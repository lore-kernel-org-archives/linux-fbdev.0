From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/15] fbdev: Fix io access in neofb
Date: Fri, 29 Oct 2004 09:58:24 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.24611.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM2f-00062G-59
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:01 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM2e-0000AM-10
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:01 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6836494C92D
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:58:53 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Denis Oliver Kropp <dok@directfb.org>

  - Fix IO access in neofb
  - Use readl/writel
  - add __iomem annotations

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/neofb.c    |   84 +++++++++++++++++++++++------------------------
 include/video/neomagic.h |    4 +-
 2 files changed, 44 insertions(+), 44 deletions(-)

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2004-10-28 21:01:11 +08:00
+++ b/drivers/video/neofb.c	2004-10-28 21:57:03 +08:00
@@ -493,7 +493,7 @@
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	int waitcycles;
 
-	while (par->neo2200->bltStat & 1)
+	while (readl(&par->neo2200->bltStat) & 1)
 		waitcycles++;
 	return 0;
 }
@@ -531,7 +531,7 @@
 				      struct fb_var_screeninfo *var)
 {
 	struct neofb_par *par = (struct neofb_par *) info->par;
-	Neo2200 *neo2200 = par->neo2200;
+	Neo2200 __iomem *neo2200 = par->neo2200;
 	u32 bltMod, pitch;
 
 	neo2200_sync(info);
@@ -556,8 +556,8 @@
 		return;
 	}
 
-	neo2200->bltStat = bltMod << 16;
-	neo2200->pitch = (pitch << 16) | pitch;
+	writel(bltMod << 16, &neo2200->bltStat);
+	writel((pitch << 16) | pitch, &neo2200->pitch);
 }
 
 /* --------------------------------------------------------------------- */
@@ -1418,27 +1418,27 @@
 	neo2200_wait_fifo(info, 4);
 
 	/* set blt control */
-	par->neo2200->bltCntl = NEO_BC3_FIFO_EN |
-	    NEO_BC0_SRC_IS_FG | NEO_BC3_SKIP_MAPPING |
-	    //               NEO_BC3_DST_XY_ADDR  |
-	    //               NEO_BC3_SRC_XY_ADDR  |
-	    rop;
+	writel(NEO_BC3_FIFO_EN |
+	       NEO_BC0_SRC_IS_FG | NEO_BC3_SKIP_MAPPING |
+	       //               NEO_BC3_DST_XY_ADDR  |
+	       //               NEO_BC3_SRC_XY_ADDR  |
+	       rop, &par->neo2200->bltCntl);
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		par->neo2200->fgColor = rect->color;
+		writel(rect->color, &par->neo2200->fgColor);
 		break;
 	case 16:
 	case 24:
-		par->neo2200->fgColor =
-		    ((u32 *) (info->pseudo_palette))[rect->color];
+		writel(((u32 *) (info->pseudo_palette))[rect->color],
+		       &par->neo2200->fgColor);
 		break;
 	}
 
-	par->neo2200->dstStart =
-	    dst * ((info->var.bits_per_pixel + 7) >> 3);
-	par->neo2200->xyExt =
-	    (rect->height << 16) | (rect->width & 0xffff);
+	writel(dst * ((info->var.bits_per_pixel + 7) >> 3),
+	       &par->neo2200->dstStart);
+	writel((rect->height << 16) | (rect->width & 0xffff),
+	       &par->neo2200->xyExt);
 }
 
 static void
@@ -1466,12 +1466,12 @@
 	neo2200_wait_fifo(info, 4);
 
 	/* set blt control */
-	par->neo2200->bltCntl = bltCntl;
+	writel(bltCntl, &par->neo2200->bltCntl);
 
-	par->neo2200->srcStart = src;
-	par->neo2200->dstStart = dst;
-	par->neo2200->xyExt =
-	    (area->height << 16) | (area->width & 0xffff);
+	writel(src, &par->neo2200->srcStart);
+	writel(dst, &par->neo2200->dstStart);
+	writel((area->height << 16) | (area->width & 0xffff),
+	       &par->neo2200->xyExt);
 }
 
 static void
@@ -1481,7 +1481,7 @@
 	int s_pitch = (image->width * image->depth + 7) >> 3;
 	int scan_align = info->pixmap.scan_align - 1;
 	int buf_align = info->pixmap.buf_align - 1;
-	int bltCntl_flags, d_pitch, data_len;
+	int bltCntl_flags, d_pitch, data_len, i;
 
 	// The data is padded for the hardware
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
@@ -1509,32 +1509,32 @@
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		par->neo2200->fgColor = image->fg_color;
-		par->neo2200->bgColor = image->bg_color;
+		writel(image->fg_color, &par->neo2200->fgColor);
+		writel(image->bg_color, &par->neo2200->bgColor);
 		break;
 	case 16:
 	case 24:
-		par->neo2200->fgColor =
-		    ((u32 *) (info->pseudo_palette))[image->fg_color];
-		par->neo2200->bgColor =
-		    ((u32 *) (info->pseudo_palette))[image->bg_color];
+		writel(((u32 *) (info->pseudo_palette))[image->fg_color],
+		       &par->neo2200->fgColor);
+		writel(((u32 *) (info->pseudo_palette))[image->bg_color],
+		       &par->neo2200->bgColor);
 		break;
 	}
 
-	par->neo2200->bltCntl = NEO_BC0_SYS_TO_VID |
+	writel(NEO_BC0_SYS_TO_VID |
 		NEO_BC3_SKIP_MAPPING | bltCntl_flags |
 		// NEO_BC3_DST_XY_ADDR |
-		0x0c0000;
+		0x0c0000, &par->neo2200->bltCntl);
 
-	par->neo2200->srcStart = 0;
+	writel(0, &par->neo2200->srcStart);
 //      par->neo2200->dstStart = (image->dy << 16) | (image->dx & 0xffff);
-	par->neo2200->dstStart =
-	    ((image->dx & 0xffff) * (info->var.bits_per_pixel >> 3) +
-	     image->dy * info->fix.line_length);
-	par->neo2200->xyExt =
-	    (image->height << 16) | (image->width & 0xffff);
+	writel(((image->dx & 0xffff) * (info->var.bits_per_pixel >> 3) +
+		image->dy * info->fix.line_length), &par->neo2200->dstStart);
+	writel((image->height << 16) | (image->width & 0xffff),
+	       &par->neo2200->xyExt);
 
-	memcpy(par->mmio_vbase + 0x100000, image->data, data_len);
+	for (i = 0; i < data_len; i++)
+		writeb(image->data[i], par->mmio_vbase + 0x100000);
 }
 
 static void
@@ -1765,7 +1765,7 @@
 #endif
 
 	/* Clear framebuffer, it's all white in memory after boot */
-	memset(info->screen_base, 0, info->fix.smem_len);
+	memset_io(info->screen_base, 0, info->fix.smem_len);
 
 	/* Allocate Cursor drawing pad.
 	info->fix.smem_len -= PAGE_SIZE;
@@ -1946,7 +1946,7 @@
 		maxWidth = 1280;
 		maxHeight = 1024;	/* ???? */
 
-		par->neo2200 = (Neo2200 *) par->mmio_vbase;
+		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2230:
 		videoRam = 3008;
@@ -1957,7 +1957,7 @@
 		maxWidth = 1280;
 		maxHeight = 1024;	/* ???? */
 
-		par->neo2200 = (Neo2200 *) par->mmio_vbase;
+		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2360:
 		videoRam = 4096;
@@ -1968,7 +1968,7 @@
 		maxWidth = 1280;
 		maxHeight = 1024;	/* ???? */
 
-		par->neo2200 = (Neo2200 *) par->mmio_vbase;
+		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2380:
 		videoRam = 6144;
@@ -1979,7 +1979,7 @@
 		maxWidth = 1280;
 		maxHeight = 1024;	/* ???? */
 
-		par->neo2200 = (Neo2200 *) par->mmio_vbase;
+		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	}
 /*
diff -Nru a/include/video/neomagic.h b/include/video/neomagic.h
--- a/include/video/neomagic.h	2004-10-19 22:44:47 +08:00
+++ b/include/video/neomagic.h	2004-10-28 21:57:03 +08:00
@@ -179,11 +179,11 @@
 #ifdef CONFIG_MTRR
 	int mtrr;
 #endif
-	u8 *mmio_vbase;
+	u8 __iomem *mmio_vbase;
 	u8 cursorOff;
 	u8 *cursorPad;		/* Must die !! */
 
-	Neo2200 *neo2200;
+	Neo2200 __iomem *neo2200;
 
 	/* Panels size */
 	int NeoPanelWidth;




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
