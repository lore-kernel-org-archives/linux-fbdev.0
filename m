From: Alexander Kern <alex.kern@gmx.de>
Subject: Fwd: [PATCH] ATI Mach64 accelerated imgblit (sligthly improved)
Date: Sat, 17 Jan 2004 01:23:23 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401170123.23351.alex.kern@gmx.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7BICApHzXog9AxN"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AheFY-00070C-HB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Jan 2004 16:23:40 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AheFX-000102-FJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 16 Jan 2004 16:23:39 -0800
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


--Boundary-00=_7BICApHzXog9AxN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry, forgot to say it's against 2.6.1-mm1 + last fbdev.diff.gz.

--Boundary-00=_7BICApHzXog9AxN
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Alexander Kern <alex.kern@gmx.de>: [PATCH] ATI Mach64 accelerated imgblit (sligthly improved)

From: Alexander Kern <alex.kern@gmx.de>
To: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] ATI Mach64 accelerated imgblit (sligthly improved)
Date: Sat, 17 Jan 2004 01:20:25 +0100
User-Agent: KMail/1.5.4
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J/HCA8XGMYhA9o5"
Message-Id: <200401170120.25603.alex.kern@gmx.de>
Status: RO
X-Status: S
X-KMail-EncryptionState: 
X-KMail-SignatureState: 


--Boundary-00=_J/HCA8XGMYhA9o5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

here is a patch. Now it works with SUN12x22 font and 8, 16 and 32 bpp. I have 
the strange issues with 24bpp. Should we simply drop acceleration for this 
resolution?

Regards Alex

--Boundary-00=_J/HCA8XGMYhA9o5
Content-Type: text/x-diff;
  charset="us-ascii";
  name="accel_imgblit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="accel_imgblit.patch"

diff -r -u -X /data/patches/exclude /usr/src/linux-2.6.orig/drivers/video/aty/atyfb_base.c /usr/src/linux-2.6.dev/drivers/video/aty/atyfb_base.c
--- /usr/src/linux-2.6.orig/drivers/video/aty/atyfb_base.c	2004-01-17 00:48:16.000000000 +0100
+++ /usr/src/linux-2.6.dev/drivers/video/aty/atyfb_base.c	2004-01-13 17:38:03.000000000 +0100
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
diff -r -u -X /data/patches/exclude /usr/src/linux-2.6.orig/drivers/video/aty/mach64_accel.c /usr/src/linux-2.6.dev/drivers/video/aty/mach64_accel.c
--- /usr/src/linux-2.6.orig/drivers/video/aty/mach64_accel.c	2004-01-09 07:59:04.000000000 +0100
+++ /usr/src/linux-2.6.dev/drivers/video/aty/mach64_accel.c	2004-01-17 00:23:23.000000000 +0100
@@ -12,23 +12,42 @@
     /*
      *  Generic Mach64 routines
      */
+     
+/* this is for DMA GUI engine! work to be continue */
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
+	u32 dwords, dx = image->dx, dy = image->dy, width = image->width;
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
+		/* ab IIC we have DP_HOST_TRIPLE_EN bit */
+		/* FIXME: 24bpp + SUN12x22 corruption
+		if (image->width % 8 == 0) */
+			pix_width |= DP_HOST_TRIPLE_EN;
+	}
+
+	dwords = (((((image->width * image->depth) + 7) / 8) * image->height * image->depth)+ 3) / 4 ;
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
+
+	/* manual triple each pixel, freezes the box */
+	if (0 && info->var.bits_per_pixel == 24 && !(pix_width & DP_HOST_TRIPLE_EN)) {
+		int inbit, outbit, mult24, byte_id_in_dword, width;
+		u8 *pbitmapin, *pbitmapout;
+		u32 hostdword;
+
+		pbitmapin = (u8*)image->data;
+
+		for(width = image->width, inbit = 7, mult24 = 0; dwords; dwords--) {
+			for(hostdword = 0, pbitmapout = (u8*)&hostdword, byte_id_in_dword = 0;
+				byte_id_in_dword < 4;
+				byte_id_in_dword++, pbitmapout++) {
+				for(outbit = 7; outbit >= 0; outbit--) {
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
+						pbitmapin++;
+						inbit = 7;
+
+						if(width == 0) {
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
+		u32 *pbitmap;
+		for(pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
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
diff -r -u -X /data/patches/exclude /usr/src/linux-2.6.orig/include/video/mach64.h /usr/src/linux-2.6.dev/include/video/mach64.h
--- /usr/src/linux-2.6.orig/include/video/mach64.h	2004-01-17 00:48:16.000000000 +0100
+++ /usr/src/linux-2.6.dev/include/video/mach64.h	2004-01-15 00:27:29.000000000 +0100
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

--Boundary-00=_J/HCA8XGMYhA9o5--

--Boundary-00=_7BICApHzXog9AxN--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
