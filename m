From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Framebuffer work is coming back.
Date: Wed, 7 Jan 2004 22:44:55 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401072244.55572.alex.kern@gmx.de>
References: <Pine.LNX.4.44.0401051737550.3150-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X3H//o7+2Qqt7H4"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AeLVD-00066t-Tq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 13:46:11 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AeLVD-0002Fi-2b
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 13:46:11 -0800
In-Reply-To: <Pine.LNX.4.44.0401051737550.3150-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--Boundary-00=_X3H//o7+2Qqt7H4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag, 5. Januar 2004 18:41 schrieb James Simmons:
> Hi folks!!
>
>   Sorry I have been quit for the last few weeks. I just finished moving
> closer to work. I had a two hour commute each way from work for the last 6
> months. Now I live 30 minutes from work. So now I will have more free time
> to work on the framebuffer layer. I have alot of email to cover so be
> patient with me.
Great to hear,

here is a one more patch for MACH64. This is an accelerated imgblit.

Regards Alex

--Boundary-00=_X3H//o7+2Qqt7H4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mach64_accel_img_blit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mach64_accel_img_blit.patch"

diff -r -u -X /data/patches/exclude /usr/src/linux-2.6.orig/drivers/video/aty/mach64_accel.c /usr/src/linux-2.6.dev/drivers/video/aty/mach64_accel.c
--- /usr/src/linux-2.6.orig/drivers/video/aty/mach64_accel.c	2003-12-18 03:58:04.000000000 +0100
+++ /usr/src/linux-2.6.dev/drivers/video/aty/mach64_accel.c	2004-01-07 23:14:00.000000000 +0100
@@ -12,23 +12,30 @@
     /*
      *  Generic Mach64 routines
      */
+     
+/* this is for DMA GUI engine! to be continue */
+typedef struct {
+	u32 frame_buf_offset;
+	u32 system_mem_addr;
+	u32 command;
+	u32 reserved;
+} BM_DESCRIPTOR_ENTRY;
+
+#define LAST_DESCRIPTOR (1 << 31)
+#define SYSTEM_TO_FRAME_BUFFER 0
 
 void aty_reset_engine(const struct atyfb_par *par)
 {
 	/* reset engine */
 	aty_st_le32(GEN_TEST_CNTL,
-		    aty_ld_le32(GEN_TEST_CNTL, par) & ~GUI_ENGINE_ENABLE,
-		    par);
+		aty_ld_le32(GEN_TEST_CNTL, par) & ~GUI_ENGINE_ENABLE, par);
 	/* enable engine */
 	aty_st_le32(GEN_TEST_CNTL,
-		    aty_ld_le32(GEN_TEST_CNTL, par) | GUI_ENGINE_ENABLE,
-		    par);
+		aty_ld_le32(GEN_TEST_CNTL, par) | GUI_ENGINE_ENABLE, par);
 	/* ensure engine is not locked up by clearing any FIFO or */
 	/* HOST errors */
 	aty_st_le32(BUS_CNTL,
-		    aty_ld_le32(BUS_CNTL,
-				par) | BUS_HOST_ERR_ACK | BUS_FIFO_ERR_ACK,
-		    par);
+		aty_ld_le32(BUS_CNTL, par) | BUS_HOST_ERR_ACK | BUS_FIFO_ERR_ACK, par);
 }
 
 static void reset_GTC_3D_engine(const struct atyfb_par *par)
@@ -51,7 +58,7 @@
 	if (info->var.bits_per_pixel == 24) {
 		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
 		/* horizontal coordinates and widths must be adjusted */
-		pitch_value = pitch_value * 3;
+		pitch_value *= 3;
 	}
 
 	/* On GTC (RagePro), we need to reset the 3D engine before */
@@ -146,7 +153,7 @@
 	aty_st_le32(DP_CHAIN_MASK, par->crtc.dp_chain_mask, par);
 
 	wait_for_fifo(5, par);
-	aty_st_le32(SCALE_3D_CNTL, 0, par);
+ 	aty_st_le32(SCALE_3D_CNTL, 0, par);
 	aty_st_le32(Z_CNTL, 0, par);
 	aty_st_le32(CRTC_INT_CNTL, aty_ld_le32(CRTC_INT_CNTL, par) & ~0x20,
 		    par);
@@ -174,8 +181,7 @@
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 dy = area->dy, sy = area->sy, direction = DST_LAST_PEL;
-	u32 sx = area->sx, dx = area->dx, width = area->width;	
-	u32 pitch_value;
+	u32 sx = area->sx, dx = area->dx, width = area->width;
 
 	if (!area->width || !area->height)
 		return;
@@ -186,11 +192,9 @@
 		return;
 	}
 
-	pitch_value = info->var.xres_virtual;
 	if (info->var.bits_per_pixel == 24) {
 		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
 		/* horizontal coordinates and widths must be adjusted */
-		pitch_value *= 3;
 		sx *= 3;
 		dx *= 3;
 		width *= 3;
@@ -254,8 +258,104 @@
 void atyfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-    
-	if (par->blitter_may_be_busy)
-		wait_for_idle(par);
-	cfb_imageblit(info, image);
+	u32 src_writes, src_width, *pbitmap, tmp, pix_width_save;
+	u32 dx = image->dx, dy = image->dy, width = image->width;
+	u32 src_pix_width = 0, src_pix_mask;
+
+	if (!image->width || !image->height)
+		return;
+	if (!par->accel_flags || 
+	    (image->depth != 1 && info->var.bits_per_pixel != image->depth)) {
+		if (par->blitter_may_be_busy)
+			wait_for_idle(par);
+
+		cfb_imageblit(info, image);
+		return;
+	}
+
+	if (info->var.bits_per_pixel == 24) {
+		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
+		/* horizontal coordinates and widths must be adjusted */
+		dx *= 3;
+		width *= 3;
+	}
+
+	src_pix_mask = DST_MASK;
+	switch (image->depth) {
+	case 1:
+	    src_pix_width = BYTE_ORDER_MSB_TO_LSB | HOST_1BPP | SRC_1BPP;
+	    break;
+	case 4:
+	    src_pix_width = BYTE_ORDER_MSB_TO_LSB | HOST_4BPP | SRC_4BPP;
+	    break;
+	case 8:
+	    src_pix_width = HOST_8BPP | SRC_8BPP;
+	    src_pix_mask |= BYTE_ORDER_MASK;
+	    break;
+	case 15:
+	    src_pix_width = HOST_15BPP | SRC_15BPP;
+	    src_pix_mask |= BYTE_ORDER_MASK;
+	    break;
+	case 16:
+	    src_pix_width = HOST_16BPP | SRC_16BPP;
+	    src_pix_mask |= BYTE_ORDER_MASK;
+	    break;
+	case 24:
+	    src_pix_width = HOST_24BPP | SRC_24BPP;
+	    src_pix_mask |= BYTE_ORDER_MASK;
+	    break;
+	case 32:
+	    src_pix_width = HOST_32BPP | SRC_32BPP;
+	    src_pix_mask |= BYTE_ORDER_MASK;
+	    break;
+	}
+	src_width = image->width * image->height * image->depth;
+	src_writes = src_width / 32;
+	if(src_width != (src_writes * 32))
+	    src_writes++;
+
+	pix_width_save = aty_ld_le32(DP_PIX_WIDTH, par);
+	tmp = pix_width_save & src_pix_mask;
+	aty_st_le32(DP_PIX_WIDTH, src_pix_width | tmp, par);
+
+	if(image->depth == 1) {
+		u32 fg, bg;
+		if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+		    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+			fg = ((u32*)(info->pseudo_palette))[image->fg_color];
+			bg = ((u32*)(info->pseudo_palette))[image->bg_color];
+		} else {
+			fg = image->fg_color;
+			bg = image->bg_color;
+		}
+
+		wait_for_fifo(4, par);
+		aty_st_le32(DP_SRC, MONO_SRC_HOST | FRGD_SRC_FRGD_CLR | BKGD_SRC_BKGD_CLR, par);
+		aty_st_le32(DP_MIX, FRGD_MIX_S | BKGD_MIX_S, par);
+		aty_st_le32(DP_BKGD_CLR, bg, par);
+		aty_st_le32(DP_FRGD_CLR, fg, par);
+	} else {
+		wait_for_fifo(2, par);
+		aty_st_le32(DP_SRC, MONO_SRC_ONE | FRGD_SRC_HOST, par);
+		aty_st_le32(DP_MIX, FRGD_MIX_D_XOR_S | BKGD_MIX_D, par);
+	}
+	
+	wait_for_fifo(5, par);
+	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT, par);
+	aty_st_le32(DST_X, dx, par);
+	aty_st_le32(DST_Y, dy, par);
+	aty_st_le32(DST_HEIGHT, image->height, par);
+	aty_st_le32(DST_WIDTH, width, par);
+
+	/* copy host data */
+	pbitmap = (u32*)(image->data);
+	for(; src_writes; src_writes--) {
+	    wait_for_fifo(1, par);
+	    aty_st_le32(HOST_DATA0, *pbitmap, par);
+	    pbitmap++;
+	}
+
+	wait_for_idle(par);
+	/* restore pix_width */
+	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
 }
diff -r -u -X /data/patches/exclude /usr/src/linux-2.6.orig/include/video/mach64.h /usr/src/linux-2.6.dev/include/video/mach64.h
--- /usr/src/linux-2.6.orig/include/video/mach64.h	2004-01-07 14:41:43.000000000 +0100
+++ /usr/src/linux-2.6.dev/include/video/mach64.h	2004-01-07 19:30:33.000000000 +0100
@@ -983,13 +983,14 @@
 #define DP_CHAIN_32BPP		0x8080
 
 /* DP_PIX_WIDTH register constants */
-#define DST_1BPP		0
-#define DST_4BPP		1
-#define DST_8BPP		2
-#define DST_15BPP		3
-#define DST_16BPP		4
-#define DST_24BPP		5
-#define DST_32BPP		6
+#define DST_1BPP		0x0
+#define DST_4BPP		0x1
+#define DST_8BPP		0x2
+#define DST_15BPP		0x3
+#define DST_16BPP		0x4
+#define DST_24BPP		0x5
+#define DST_32BPP		0x6
+#define DST_MASK		0xF
 #define SRC_1BPP		0x000
 #define SRC_4BPP		0x100
 #define SRC_8BPP		0x200
@@ -997,6 +998,7 @@
 #define SRC_16BPP		0x400
 #define SRC_24BPP		0x500
 #define SRC_32BPP		0x600
+#define SRC_MASK		0xF00
 #define HOST_1BPP		0x00000
 #define HOST_4BPP		0x10000
 #define HOST_8BPP		0x20000
@@ -1004,8 +1006,10 @@
 #define HOST_16BPP		0x40000
 #define HOST_24BPP		0x50000
 #define HOST_32BPP		0x60000
+#define HOST_MASK		0xF0000
 #define BYTE_ORDER_MSB_TO_LSB	0
 #define BYTE_ORDER_LSB_TO_MSB	0x1000000
+#define BYTE_ORDER_MASK		0x1000000
 
 /* DP_MIX register constants */
 #define BKGD_MIX_NOT_D			0

--Boundary-00=_X3H//o7+2Qqt7H4--



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
