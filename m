From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: [PATCH] ATI Mach64 accelerated imgblit (sligthly improved)
Date: Fri, 23 Jan 2004 18:58:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401231858.28965.alex.kern@gmx.de>
References: <Pine.LNX.4.44.0401191810530.2709-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EDWEAvapyvt/jSv"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ak5aZ-00040r-Ok
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Jan 2004 09:59:27 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Ak5aY-0001iE-5h
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Jan 2004 09:59:26 -0800
In-Reply-To: <Pine.LNX.4.44.0401191810530.2709-100000@phoenix.infradead.org>
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


--Boundary-00=_EDWEAvapyvt/jSv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Montag, 19. Januar 2004 19:11 schrieben Sie:
> > No, it's only imageblit, which has issue.
> > Regards
> > Alex Kern
>
> Applied your patch. I tested it and it works wonderful. I haven't tested
> in 24 bpp mode tho. I think that is a minor issue.
Hi James,

will you update your fbdev.diff.gz? What about resync and submit it again to 
mm tree?

Here is one better patch for accelerated imageblit. It looks like mach64 has a 
problems with buildin trippler and unaligned data. Manual tripple path works 
now!

Regards Alex

--Boundary-00=_EDWEAvapyvt/jSv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="20040123-mach64-include.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="20040123-mach64-include.diff"

diff -u /usr/src/linux-2.6.dev/include/video/mach64.h /usr/src/linux-2.6.dirty/include/video/mach64.h
--- /usr/src/linux-2.6.dev/include/video/mach64.h	2004-01-23 15:42:01.000000000 +0100
+++ /usr/src/linux-2.6.dirty/include/video/mach64.h	2004-01-15 00:27:29.000000000 +0100
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
@@ -997,6 +998,8 @@
 #define SRC_16BPP		0x400
 #define SRC_24BPP		0x500
 #define SRC_32BPP		0x600
+#define SRC_MASK		0xF00
+#define DP_HOST_TRIPLE_EN	0x2000
 #define HOST_1BPP		0x00000
 #define HOST_4BPP		0x10000
 #define HOST_8BPP		0x20000
@@ -1004,8 +1007,10 @@
 #define HOST_16BPP		0x40000
 #define HOST_24BPP		0x50000
 #define HOST_32BPP		0x60000
+#define HOST_MASK		0xF0000
 #define BYTE_ORDER_MSB_TO_LSB	0
 #define BYTE_ORDER_LSB_TO_MSB	0x1000000
+#define BYTE_ORDER_MASK		0x1000000
 
 /* DP_MIX register constants */
 #define BKGD_MIX_NOT_D			0

--Boundary-00=_EDWEAvapyvt/jSv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="20040123-mach64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="20040123-mach64.diff"

diff -u /usr/src/linux-2.6.dev/drivers/video/aty/atyfb.h /usr/src/linux-2.6.dirty/drivers/video/aty/atyfb.h
--- /usr/src/linux-2.6.dev/drivers/video/aty/atyfb.h	2004-01-23 15:41:52.000000000 +0100
+++ /usr/src/linux-2.6.dirty/drivers/video/aty/atyfb.h	2004-01-23 14:54:39.000000000 +0100
@@ -169,6 +169,7 @@
 #define M64F_LT_SLEEP		0x00040000
 #define M64F_XL_DLL		0x00080000
 #define M64F_MFB_FORCE_4	0x00100000
+#define M64F_NO_HW_TRIPLE       0x00200000
 
     /*
      *  Register access
diff -u /usr/src/linux-2.6.dev/drivers/video/aty/atyfb_base.c /usr/src/linux-2.6.dirty/drivers/video/aty/atyfb_base.c
--- /usr/src/linux-2.6.dev/drivers/video/aty/atyfb_base.c	2004-01-23 15:41:52.000000000 +0100
+++ /usr/src/linux-2.6.dirty/drivers/video/aty/atyfb_base.c	2004-01-23 14:58:31.000000000 +0100
@@ -323,30 +323,29 @@
 } aty_chips[] __initdata = {
 #ifdef CONFIG_FB_ATY_GX
 	/* Mach64 GX */
-	{ 0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, 50, M64F_GX },
-	{ 0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, 50, M64F_GX },
+	{ 0x4758, 0x00d7, 0x00, 0x00, m64n_gx, 135, 50, 50, M64F_GX | M64F_NO_HW_TRIPLE },
+	{ 0x4358, 0x0057, 0x00, 0x00, m64n_cx, 135, 50, 50, M64F_GX | M64F_NO_HW_TRIPLE },
 #endif /* CONFIG_FB_ATY_GX */
 
 #ifdef CONFIG_FB_ATY_CT
 	/* Mach64 CT */
-	{ 0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
-	{ 0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO },
+	{ 0x4354, 0x4354, 0x00, 0x00, m64n_ct, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE },
+	{ 0x4554, 0x4554, 0x00, 0x00, m64n_et, 135, 60, 60, M64F_CT | M64F_INTEGRATED | M64F_CT_BUS | M64F_MAGIC_FIFO | M64F_NO_HW_TRIPLE },
 
 	/* Mach64 VT */
-	{ 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 },
-	{ 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV },
-	{ 0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 },
-	{ 0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL },
-	{ 0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83, 83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP },
+	{ 0x5654, 0x5654, 0xc7, 0x00, m64n_vta3, 170, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
+	{ 0x5654, 0x5654, 0xc7, 0x40, m64n_vta4, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_MAGIC_POSTDIV | M64F_NO_HW_TRIPLE },
+	{ 0x5654, 0x5654, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_NO_HW_TRIPLE },
+	{ 0x5655, 0x5655, 0x00, 0x00, m64n_vtb, 200, 67, 67, M64F_VT | M64F_INTEGRATED | M64F_VT_BUS | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_NO_HW_TRIPLE },
+	{ 0x5656, 0x5656, 0x00, 0x00, m64n_vt4, 230, 83, 83, M64F_VT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_NO_HW_TRIPLE },
 
 	/* Mach64 GT (3D RAGE) */
-	{ 0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT },
-	{ 0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
+	{ 0x4754, 0x4754, 0x07, 0x00, m64n_gt, 135, 63, 63, M64F_GT | M64F_INTEGRATED | M64F_MAGIC_FIFO | M64F_FIFO_24 | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ 0x4754, 0x4754, 0x07, 0x01, m64n_gt, 170, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ 0x4754, 0x4754, 0x07, 0x02, m64n_gt, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
+	{ 0x4755, 0x4755, 0x00, 0x00, m64n_gtb, 200, 67, 67, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_NO_HW_TRIPLE },
 	{ 0x4756, 0x4756, 0x00, 0x00, m64n_iic_p, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x4757, 0x4757, 0x00, 0x00, m64n_iic_a, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
-	{ 0x4759, 0x4759, 0x00, 0x00, m64n_iic_p, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x475a, 0x475a, 0x00, 0x00, m64n_iic_a, 230, 83, 83, M64F_GT | M64F_INTEGRATED | M64F_GTB_DSP | M64F_FIFO_24 | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
 	/* Mach64 LT */
@@ -360,9 +359,6 @@
 	{ 0x4750, 0x4750, 0x00, 0x00, m64n_gtc_pp, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 	{ 0x4751, 0x4751, 0x00, 0x00, m64n_gtc_ppl, 230, 100, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT },
 
-
-	/* 3D RAGE XL Unknown model */
-	{ 0x474d, 0x474d, 0x00, 0x00, m64n_xl_66, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_FORCE_4 },
 	/* 3D RAGE XL PCI-66/BGA */
 	{ 0x474f, 0x474f, 0x00, 0x00, m64n_xl_66, 230, 83, 63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_SDRAM_MAGIC_PLL | M64F_EXTRA_BRIGHT | M64F_XL_DLL | M64F_MFB_FORCE_4 },
 	/* 3D RAGE XL PCI-33/BGA */
@@ -1134,11 +1130,11 @@
 		v_total = v_sync_end + debug.upper_margin;
 
 		hSync = 1000000000 / (pixclock_in_ps * h_total);
-		vRefresh = (hSync * 1000.0) / v_total;
+		vRefresh = (hSync * 1000) / v_total;
         	if (par->crtc.gen_cntl & CRTC_INTERLACE_EN)
-            	vRefresh *= 2.0;
+            	vRefresh *= 2;
         	if (par->crtc.gen_cntl & CRTC_DBL_SCAN_EN)
-            	vRefresh /= 2.0;
+            	vRefresh /= 2;
 
 		printk("atyfb: atyfb_set_par\n");
 		printk(" Set Visible Mode to %ix%i-%i\n", var->xres, var->yres, var->bits_per_pixel);
diff -u /usr/src/linux-2.6.dev/drivers/video/aty/mach64_accel.c /usr/src/linux-2.6.dirty/drivers/video/aty/mach64_accel.c
--- /usr/src/linux-2.6.dev/drivers/video/aty/mach64_accel.c	2004-01-09 07:59:04.000000000 +0100
+++ /usr/src/linux-2.6.dirty/drivers/video/aty/mach64_accel.c	2004-01-23 15:08:29.000000000 +0100
@@ -12,23 +12,42 @@
     /*
      *  Generic Mach64 routines
      */
+     
+/* this is for DMA GUI engine! works to be continue */
+typedef struct {
+	u32 frame_buf_offset;
+	u32 system_mem_addr;
+	u32 command;
+	u32 reserved;
+} BM_DESCRIPTOR_ENTRY;
+
+#define LAST_DESCRIPTOR (1 << 31)
+#define SYSTEM_TO_FRAME_BUFFER 0
+
+static u32 rotation24bpp(u32 dx, u32 direction)
+{
+	u32 rotation;
+	if (direction & DST_X_LEFT_TO_RIGHT) {
+		rotation = (dx / 4) % 6;
+	} else {
+		rotation = ((dx + 2) / 4) % 6;
+	}
+
+	return ((rotation << 8) | DST_24_ROTATION_ENABLE);
+}
 
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
@@ -51,7 +70,7 @@
 	if (info->var.bits_per_pixel == 24) {
 		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
 		/* horizontal coordinates and widths must be adjusted */
-		pitch_value = pitch_value * 3;
+		pitch_value *= 3;
 	}
 
 	/* On GTC (RagePro), we need to reset the 3D engine before */
@@ -146,7 +165,7 @@
 	aty_st_le32(DP_CHAIN_MASK, par->crtc.dp_chain_mask, par);
 
 	wait_for_fifo(5, par);
-	aty_st_le32(SCALE_3D_CNTL, 0, par);
+ 	aty_st_le32(SCALE_3D_CNTL, 0, par);
 	aty_st_le32(Z_CNTL, 0, par);
 	aty_st_le32(CRTC_INT_CNTL, aty_ld_le32(CRTC_INT_CNTL, par) & ~0x20,
 		    par);
@@ -174,8 +193,7 @@
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 dy = area->dy, sy = area->sy, direction = DST_LAST_PEL;
-	u32 sx = area->sx, dx = area->dx, width = area->width;	
-	u32 pitch_value;
+	u32 sx = area->sx, dx = area->dx, width = area->width, rotation = 0;
 
 	if (!area->width || !area->height)
 		return;
@@ -186,11 +204,9 @@
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
@@ -208,18 +224,22 @@
 	} else
 		direction |= DST_X_LEFT_TO_RIGHT;
 
+	if (info->var.bits_per_pixel == 24) {
+		rotation = rotation24bpp(dx, direction);
+	}
+
 	wait_for_fifo(4, par);
 	aty_st_le32(DP_SRC, FRGD_SRC_BLIT, par);
 	aty_st_le32(SRC_Y_X, (sx << 16) | sy, par);
 	aty_st_le32(SRC_HEIGHT1_WIDTH1, (width << 16) | area->height, par);
-	aty_st_le32(DST_CNTL, direction, par);
+	aty_st_le32(DST_CNTL, direction | rotation, par);
 	draw_rect(dx, dy, width, area->height, par);
 }
 
 void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-	u32 color = rect->color, dx = rect->dx, width = rect->width;
+	u32 color = rect->color, dx = rect->dx, width = rect->width, rotation = 0;
 
 	if (!rect->width || !rect->height)
 		return;
@@ -238,6 +258,7 @@
 		/* horizontal coordinates and widths must be adjusted */
 		dx *= 3;
 		width *= 3;
+		rotation = rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
 	}
 
 	wait_for_fifo(3, par);
@@ -247,15 +268,160 @@
 		    par);
 	aty_st_le32(DST_CNTL,
 		    DST_LAST_PEL | DST_Y_TOP_TO_BOTTOM |
-		    DST_X_LEFT_TO_RIGHT, par);
+		    DST_X_LEFT_TO_RIGHT | rotation, par);
 	draw_rect(dx, rect->dy, width, rect->height, par);
 }
 
 void atyfb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
-    
-	if (par->blitter_may_be_busy)
-		wait_for_idle(par);
-	cfb_imageblit(info, image);
+	u32 src_bytes, dx = image->dx, dy = image->dy, width = image->width;
+	u32 pix_width_save, pix_width, host_cntl, rotation = 0, src, mix;
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
+	wait_for_idle(par);
+	pix_width = pix_width_save = aty_ld_le32(DP_PIX_WIDTH, par);
+	host_cntl = aty_ld_le32(HOST_CNTL, par) | HOST_BYTE_ALIGN;
+
+	switch (image->depth) {
+	case 1:
+	    pix_width &= ~(BYTE_ORDER_MASK | HOST_MASK);
+	    pix_width |= (BYTE_ORDER_MSB_TO_LSB | HOST_1BPP);
+	    break;
+	case 4:
+	    pix_width &= ~(BYTE_ORDER_MASK | HOST_MASK);
+	    pix_width |= (BYTE_ORDER_MSB_TO_LSB | HOST_4BPP);
+	    break;
+	case 8:
+	    pix_width &= ~HOST_MASK;
+	    pix_width |= HOST_8BPP;
+	    break;
+	case 15:
+	    pix_width &= ~HOST_MASK;
+	    pix_width |= HOST_15BPP;
+	    break;
+	case 16:
+	    pix_width &= ~HOST_MASK;
+	    pix_width |= HOST_16BPP;
+	    break;
+	case 24:
+	    pix_width &= ~HOST_MASK;
+	    pix_width |= HOST_24BPP;
+	    break;
+	case 32:
+	    pix_width &= ~HOST_MASK;
+	    pix_width |= HOST_32BPP;
+	    break;
+	}
+
+	if (info->var.bits_per_pixel == 24) {
+		/* In 24 bpp, the engine is in 8 bpp - this requires that all */
+		/* horizontal coordinates and widths must be adjusted */
+		dx *= 3;
+		width *= 3;
+
+		rotation = rotation24bpp(dx, DST_X_LEFT_TO_RIGHT);
+
+		pix_width &= ~DST_MASK;
+		pix_width |= DST_8BPP;
+
+		/* 
+		 * ab IIC we have DP_HOST_TRIPLE_EN bit
+		 * this hwaccelerated triple has an issue with not aligned data
+		 */
+		if (!M64_HAS(NO_HW_TRIPLE) && image->width % 8 == 0)
+			pix_width |= DP_HOST_TRIPLE_EN;
+	}
+
+	if (image->depth == 1) {
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
+		wait_for_fifo(2, par);
+		aty_st_le32(DP_BKGD_CLR, bg, par);
+		aty_st_le32(DP_FRGD_CLR, fg, par);
+		src = MONO_SRC_HOST | FRGD_SRC_FRGD_CLR | BKGD_SRC_BKGD_CLR;
+		mix = FRGD_MIX_S | BKGD_MIX_S;
+	} else {
+		src = MONO_SRC_ONE | FRGD_SRC_HOST;
+		mix = FRGD_MIX_D_XOR_S | BKGD_MIX_D;
+	}
+
+	wait_for_fifo(6, par);
+	aty_st_le32(DP_WRITE_MASK, 0xFFFFFFFF, par);
+	aty_st_le32(DP_PIX_WIDTH, pix_width, par);
+	aty_st_le32(DP_MIX, mix, par);
+	aty_st_le32(DP_SRC, src, par);
+	aty_st_le32(HOST_CNTL, host_cntl, par);
+	aty_st_le32(DST_CNTL, DST_Y_TOP_TO_BOTTOM | DST_X_LEFT_TO_RIGHT | rotation, par);
+
+	draw_rect(dx, dy, width, image->height, par);
+	src_bytes = (((image->width * image->depth) + 7) / 8) * image->height;
+
+	/* manual triple each pixel */
+	if (info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
+		int inbit, outbit, mult24, byte_id_in_dword, width;
+		u8 *pbitmapin = (u8*)image->data, *pbitmapout;
+		u32 hostdword;
+
+		for (width = image->width, inbit = 7, mult24 = 0; src_bytes; ) {
+			for (hostdword = 0, pbitmapout = (u8*)&hostdword, byte_id_in_dword = 0;
+				byte_id_in_dword < 4 && src_bytes;
+				byte_id_in_dword++, pbitmapout++) {
+				for (outbit = 7; outbit >= 0; outbit--) {
+					*pbitmapout |= (((*pbitmapin >> inbit) & 1) << outbit);
+					mult24++;
+					/* next bit */
+					if (mult24 == 3) {
+						mult24 = 0;
+						inbit--;
+						width--;
+					}
+
+					/* next byte */
+					if (inbit < 0 || width == 0) {
+						src_bytes--;	
+						pbitmapin++;
+						inbit = 7;
+
+						if (width == 0) {
+						    width = image->width;
+						    outbit = 0;
+						}
+					}
+				}
+			}
+			wait_for_fifo(1, par);
+			aty_st_le32(HOST_DATA0, hostdword, par);
+		}
+	} else {
+		u32 *pbitmap, dwords = (src_bytes + 3) / 4;
+		for (pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
+			wait_for_fifo(1, par);
+			aty_st_le32(HOST_DATA0, *pbitmap, par);
+		}
+	}
+
+	wait_for_idle(par);
+
+	/* restore pix_width */
+	wait_for_fifo(1, par);
+	aty_st_le32(DP_PIX_WIDTH, pix_width_save, par);
 }

--Boundary-00=_EDWEAvapyvt/jSv--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
