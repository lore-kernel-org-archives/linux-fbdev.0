From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: i810fb updates
Date: 26 Mar 2003 11:37:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048649666.998.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18y1uy-0002zI-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Mar 2003 19:49:37 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Updated i810fb to take advantage of the latest buffering scheme.  This
should squeeze a few more drops of speed from the hardware.

Tony

diff -Naur linux-2.5.66-orig/drivers/video/i810/i810.h linux-2.5.66/drivers/video/i810/i810.h
--- linux-2.5.66-orig/drivers/video/i810/i810.h	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/i810/i810.h	2003-03-26 02:50:43.000000000 +0000
@@ -120,7 +120,6 @@
 #define MMIO_SIZE                   (512*1024)
 #define GTT_SIZE                    (16*1024) 
 #define RINGBUFFER_SIZE             (64*1024)
-#define PIXMAP_SIZE                 (4 * 4096)
 #define CURSOR_SIZE                 4096 
 #define OFF                         0
 #define ON                          1
@@ -251,7 +250,6 @@
 	struct heap_data         fb;
 	struct heap_data         iring;
 	struct heap_data         cursor_heap;
-	struct heap_data         pixmap;
 	struct vgastate          state;
 	drm_agp_t                *drm_agp;
 	atomic_t                 use_count;
@@ -260,10 +258,6 @@
 	unsigned long mmio_start_phys;
 	u8 *mmio_start_virtual;
 	u32 cursor_reset;
-	u8  red[64];
-	u8  green[64];
-	u8  blue[64];
-	u32 pixmap_offset;
 	u32 pitch;
 	u32 pixconf;
 	u32 watermark;
diff -Naur linux-2.5.66-orig/drivers/video/i810/i810_accel.c linux-2.5.66/drivers/video/i810/i810_accel.c
--- linux-2.5.66-orig/drivers/video/i810/i810_accel.c	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/i810/i810_accel.c	2003-03-26 02:50:39.000000000 +0000
@@ -54,8 +54,9 @@
  * The function waits until a free space from the ringbuffer
  * is available 
  */	
-static inline int wait_for_space(struct i810fb_par *par, u32 space)
+static inline int wait_for_space(struct fb_info *info, u32 space)
 {
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u32 head, count = WAIT_COUNT, tail;
 	u8 *mmio = par->mmio_start_virtual;
 
@@ -72,6 +73,7 @@
 	printk("ringbuffer lockup!!!\n");
 	i810_report_error(mmio); 
 	par->dev_flags |= LOCKUP;
+	info->pixmap.scan_align = 1;
 	return 1;
 }
 
@@ -83,11 +85,15 @@
  * This waits for lring(0), iring(1), and batch(3), etc to finish and
  * waits until ringbuffer is empty.
  */
-static inline int wait_for_engine_idle(struct i810fb_par *par)
+static inline int wait_for_engine_idle(struct fb_info *info)
 {
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u8 *mmio = par->mmio_start_virtual;
 	int count = WAIT_COUNT;
 
+	if (wait_for_space(info, par->iring.size)) /* flush */
+		return 1;
+
 	while((i810_readw(INSTDONE, mmio) & 0x7B) != 0x7B && --count); 
 	if (count) return 0;
 
@@ -95,6 +101,7 @@
 	printk("INSTDONE: 0x%04x\n", i810_readl(INSTDONE, mmio));
 	i810_report_error(mmio); 
 	par->dev_flags |= LOCKUP;
+	info->pixmap.scan_align = 1;
 	return 1;
 }
 
@@ -106,11 +113,13 @@
  * Checks/waits for sufficent space in ringbuffer of size
  * space.  Returns the tail of the buffer
  */ 
-static inline u32 begin_iring(struct i810fb_par *par, u32 space)
+static inline u32 begin_iring(struct fb_info *info, u32 space)
 {
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
+
 	if (par->dev_flags & ALWAYS_SYNC) 
-		wait_for_engine_idle(par);
-	return wait_for_space(par, space);
+		wait_for_engine_idle(info);
+	return wait_for_space(info, space);
 }
 
 /**
@@ -149,9 +158,11 @@
  */
 static inline void source_copy_blit(int dwidth, int dheight, int dpitch, 
 				    int xdir, int src, int dest, int rop, 
-				    int blit_bpp, struct i810fb_par *par)
+				    int blit_bpp, struct fb_info *info)
 {
-	if (begin_iring(par, 24 + IRING_PAD)) return;
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
+
+	if (begin_iring(info, 24 + IRING_PAD)) return;
 
 	PUT_RING(BLIT | SOURCE_COPY_BLIT | 4);
 	PUT_RING(xdir | rop << 16 | dpitch | DYN_COLOR_EN | blit_bpp);
@@ -181,9 +192,11 @@
  */
 static inline void color_blit(int width, int height, int pitch,  int dest, 
 			      int rop, int what, int blit_bpp, 
-			      struct i810fb_par *par)
+			      struct fb_info *info)
 {
-	if (begin_iring(par, 24 + IRING_PAD)) return;
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
+
+	if (begin_iring(info, 24 + IRING_PAD)) return;
 
 	PUT_RING(BLIT | COLOR_BLT | 3);
 	PUT_RING(rop << 16 | pitch | SOLIDPATTERN | DYN_COLOR_EN | blit_bpp);
@@ -220,9 +233,11 @@
 static inline void mono_src_copy_imm_blit(int dwidth, int dheight, int dpitch,
 					  int dsize, int blit_bpp, int rop,
 					  int dest, const u32 *src, int bg,
-					  int fg, struct i810fb_par *par)
+					  int fg, struct fb_info *info)
 {
-	if (begin_iring(par, 24 + (dsize << 2) + IRING_PAD)) return;
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
+
+	if (begin_iring(info, 24 + (dsize << 2) + IRING_PAD)) return;
 
 	PUT_RING(BLIT | MONO_SOURCE_COPY_IMMEDIATE | (4 + dsize));
 	PUT_RING(DYN_COLOR_EN | blit_bpp | rop << 16 | dpitch);
@@ -261,9 +276,11 @@
 static inline void mono_src_copy_blit(int dwidth, int dheight, int dpitch, 
 				      int qsize, int blit_bpp, int rop, 
 				      int dest, int src, int bg,
-				      int fg, struct i810fb_par *par)
+				      int fg, struct fb_info *info)
 {
-	if (begin_iring(par, 32 + IRING_PAD)) return;
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
+
+	if (begin_iring(info, 32 + IRING_PAD)) return;
 
 	PUT_RING(BLIT | MONO_SOURCE_COPY_BLIT | 6);
 	PUT_RING(DYN_COLOR_EN | blit_bpp | rop << 16 | dpitch | 1 << 27);
@@ -277,19 +294,23 @@
 	end_iring(par);
 }
 
-static u32 get_buffer_offset(u32 size, struct i810fb_par *par) 
+static inline void load_front(int offset, struct fb_info *info)
 {
-	u32 offset;
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
 
-	if (par->pixmap_offset + size > par->pixmap.size) {
-		wait_for_engine_idle(par);
-		par->pixmap_offset = 0;
-	}
+	if (begin_iring(info, 8 + IRING_PAD)) return;
 
-	offset = par->pixmap_offset;
-	par->pixmap_offset += size;
+	PUT_RING(PARSER | FLUSH);
+	PUT_RING(NOP);
 
-	return offset;
+	end_iring(par);
+
+	if (begin_iring(info, 8 + IRING_PAD)) return;
+
+	PUT_RING(PARSER | FRONT_BUFFER | ((par->pitch >> 3) << 8));
+	PUT_RING((par->fb.offset << 12) + offset);
+
+	end_iring(par);
 }
 
 /**
@@ -338,7 +359,7 @@
 
 	dest = info->fix.smem_start + (dy * info->fix.line_length) + dx;
 	color_blit(width, height, info->fix.line_length, dest, rop, color, 
-		   par->blit_bpp, par);
+		   par->blit_bpp, info);
 }
 	
 void i810fb_copyarea(struct fb_info *info, const struct fb_copyarea *region) 
@@ -377,14 +398,13 @@
 	dest = info->fix.smem_start + (dy * info->fix.line_length) + dx;
 
 	source_copy_blit(width, height, pitch, xdir, src, dest,
-			 PAT_COPY_ROP, par->blit_bpp, par);
+			 PAT_COPY_ROP, par->blit_bpp, info);
 }
 
 void i810fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
-	u32 fg = 0, bg = 0, s_pitch, d_pitch, size, offset, dst, i, j;
-	u8 *s_addr, *d_addr;
+	u32 fg = 0, bg = 0, size, dst;
 	
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP ||
 	    par->depth == 4 || image->depth != 0) 
@@ -405,43 +425,17 @@
 	dst = info->fix.smem_start + (image->dy * info->fix.line_length) + 
 		(image->dx * par->depth);
 
-	s_pitch = (image->width+7)/8;
-	d_pitch = (s_pitch + 1) & ~1;
-	size = d_pitch * image->height;
-	if (s_pitch != d_pitch || size & 7) {
-		size += 7;
-		size &= ~7;
-		offset = get_buffer_offset(size, par);		
-		d_addr = par->pixmap.virtual + offset;
-		s_addr = (u8 *) image->data;
-		
-		if (s_pitch == d_pitch) {
-			memcpy_toio(d_addr, s_addr, s_pitch * image->height);
-		} else { 
-			for (i = image->height; i--; ) {
-				for (j = 0; j < s_pitch; j++) 
-					i810_writeb(j, d_addr, s_addr[j]);
-				s_addr += s_pitch;
-				d_addr += d_pitch;
-			}
-		}
-		mono_src_copy_blit(image->width * par->depth, image->height, 
-				   info->fix.line_length, size/8, 
-				   par->blit_bpp, PAT_COPY_ROP, dst, 
-				   par->pixmap.physical + offset,
-				   bg, fg, par);
-	}
-	/*
-	 * immediate blit if width is a multiple of 16 (hardware requirement)
-	 */
-	else {
-		mono_src_copy_imm_blit(image->width * par->depth, 
-				       image->height, info->fix.line_length, 
-				       size/4, par->blit_bpp,
-				       PAT_COPY_ROP, dst, (u32 *) image->data, 
-				       bg, fg, par);
-	} 
-}
+	size = (image->width+7)/8 + 1;
+	size &= ~1;
+	size *= image->height;
+	size += 7;
+	size &= ~7;
+	mono_src_copy_imm_blit(image->width * par->depth, 
+			       image->height, info->fix.line_length, 
+			       size/4, par->blit_bpp,
+			       PAT_COPY_ROP, dst, (u32 *) image->data, 
+			       bg, fg, info);
+} 
 
 int i810fb_sync(struct fb_info *info)
 {
@@ -450,9 +444,19 @@
 	if (!info->var.accel_flags || par->dev_flags & LOCKUP)
 		return 0;
 
-	return wait_for_engine_idle(par);
+	return wait_for_engine_idle(info);
 }
 
+void i810fb_load_front(u32 offset, struct fb_info *info)
+{
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
+	u8 *mmio = par->mmio_start_virtual;
+
+	if (!info->var.accel_flags || par->dev_flags & LOCKUP)
+		i810_writel(DPLYBASE, mmio, par->fb.physical + offset);
+	else 
+		load_front(offset, info);
+}
 
 /**
  * i810fb_init_ringbuffer - initialize the ringbuffer
@@ -463,12 +467,13 @@
  * size and location of the ringbuffer.  It also sets 
  * the head and tail pointers = 0
  */
-void i810fb_init_ringbuffer(struct i810fb_par *par)
+void i810fb_init_ringbuffer(struct fb_info *info)
 {
+	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u32 tmp1, tmp2;
 	u8 *mmio = par->mmio_start_virtual;
 	
-	wait_for_engine_idle(par);
+	wait_for_engine_idle(info);
 	i810fb_iring_enable(par, OFF);
 	i810_writel(IRING, mmio, 0);
 	i810_writel(IRING + 4, mmio, 0);
diff -Naur linux-2.5.66-orig/drivers/video/i810/i810_dvt.c linux-2.5.66/drivers/video/i810/i810_dvt.c
--- linux-2.5.66-orig/drivers/video/i810/i810_dvt.c	2003-02-16 00:48:53.000000000 +0000
+++ linux-2.5.66/drivers/video/i810/i810_dvt.c	2003-03-26 02:50:39.000000000 +0000
@@ -289,8 +289,7 @@
 		case 32:
 			wmark = params->bpp24_100;
 		}
-	}
-	else {					
+	} else {					
 		switch (var->bits_per_pixel) {
 		case 8:
 			wmark = params->bpp8_133;
diff -Naur linux-2.5.66-orig/drivers/video/i810/i810_gtf.c linux-2.5.66/drivers/video/i810/i810_gtf.c
--- linux-2.5.66-orig/drivers/video/i810/i810_gtf.c	2003-02-16 00:48:02.000000000 +0000
+++ linux-2.5.66/drivers/video/i810/i810_gtf.c	2003-03-26 02:50:39.000000000 +0000
@@ -1,5 +1,5 @@
 /*-*- linux-c -*-
- *  linux/drivers/video/i810_main.h -- Intel 810 Nondiscrete Video Timings 
+ *  linux/drivers/video/i810_main.h -- Intel 810 Non-discrete Video Timings 
  *                                     (VESA GTF)
  *
  *      Copyright (C) 2001 Antonino Daplas<adaplas@pol.net>
@@ -213,7 +213,7 @@
  * @par: pointer to i810fb_par structure
  *
  * DESCRIPTION:
- * Get's the required watermark based on 
+ * Gets the required watermark based on 
  * pixelclock and RAMBUS frequency.
  * 
  * RETURNS:
@@ -240,8 +240,7 @@
 			wmark = i810_wm_24_100;
 			size = ARRAY_SIZE(i810_wm_24_100);
 		}
-	}	
-	else {
+	} else {
 		switch(var->bits_per_pixel) {
 		case 8:
 			wmark = i810_wm_8_133;
diff -Naur linux-2.5.66-orig/drivers/video/i810/i810_main.c linux-2.5.66/drivers/video/i810/i810_main.c
--- linux-2.5.66-orig/drivers/video/i810/i810_main.c	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/i810/i810_main.c	2003-03-26 02:50:40.000000000 +0000
@@ -631,8 +631,7 @@
 		if (f_out <= target_freq) {
 			n_reg++;
 			diff = target_freq - f_out;
-		}
-		else {
+		} else {
 			m_reg++;
 			diff = f_out - target_freq;
 		}
@@ -926,20 +925,21 @@
 	/*
 	 * Monitor limit
 	 */
+	switch (var->bits_per_pixel) {
+	case 8:
+		info->monspecs.dclkmax = 234000000;
+		break;
+	case 16:
+		info->monspecs.dclkmax = 229000000;
+		break;
+	case 24:
+	case 32:
+		info->monspecs.dclkmax = 204000000;
+		break;
+	}
+	info->monspecs.dclkmin = 15000000;
+
 	if (fb_validate_mode(var, info)) {
-		switch (var->bits_per_pixel) {
-		case 8:
-			info->monspecs.dclkmax = 234000000;
-			break;
-		case 16:
-			info->monspecs.dclkmax = 229000000;
-			break;
-		case 24:
-		case 32:
-			info->monspecs.dclkmax = 204000000;
-			break;
-		}
-		info->monspecs.dclkmin = 15000000;
 		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info))
 			return -EINVAL;
 	}
@@ -1177,31 +1177,21 @@
 		for (i = 0; i < 8; i++) 
 			i810_write_dac((u8) (regno * 8) + i, (u8) red, 
 				       (u8) green, (u8) blue, mmio);
-	}
-				
-	else if (info->fix.visual == FB_VISUAL_DIRECTCOLOR && 
+	} else if (info->fix.visual == FB_VISUAL_DIRECTCOLOR && 
 		 info->var.green.length == 6) {
-		if (!regno) {
-			memset(par->red, 0, 64);
-			memset(par->green, 0, 64);
-			memset(par->blue, 0, 64);
-		}
-
-		par->red[regno] = (u8) red;
-		par->green[regno] = (u8) green;
-		par->blue[regno] = (u8) blue;
+		u8 r, g, b;
 
 		if (regno < 32) {
 			for (i = 0; i < 8; i++) 
 				i810_write_dac((u8) (regno * 8) + i,
-					       (u8) red, par->green[regno*2], 
+					       (u8) red, (u8) green, 
 					       (u8) blue, mmio);
 		}
+		i810_read_dac((u8) (regno*4), &r, &g, &b, mmio);
 		for (i = 0; i < 4; i++) 
-			i810_write_dac((u8) (regno*4) + i, par->red[regno/2],
-				       (u8) green, par->blue[regno/2], mmio);
-	}
-	else {
+			i810_write_dac((u8) (regno*4) + i, r, (u8) green, 
+				       b, mmio);
+	} else if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
 		i810_write_dac((u8) regno, (u8) red, (u8) green,
 			       (u8) blue, mmio);
 	}
@@ -1220,16 +1210,14 @@
 					((u32 *)info->pseudo_palette)[regno] = 
 						(regno << 11) | (regno << 5) |
 						regno;
-			}
-			else {
+			} else {
 				if (info->var.green.length == 5) {
 					/* RGB 555 */
 					((u32 *)info->pseudo_palette)[regno] = 
 						((red & 0xf800) >> 1) |
 						((green & 0xf800) >> 6) |
 						((blue & 0xf800) >> 11);
-				}
-				else {
+				} else {
 					/* RGB 565 */
 					((u32 *)info->pseudo_palette)[regno] =
 						(red & 0xf800) |
@@ -1260,11 +1248,10 @@
 {
 	struct i810fb_par *par = (struct i810fb_par *) info->par;
 	u32 total;
-	u8 *mmio = par->mmio_start_virtual;
 	
 	total = var->xoffset * par->depth + 
 		var->yoffset * info->fix.line_length;
-	i810_writel(DPLYBASE, mmio, par->fb.physical + total);
+	i810fb_load_front(total, info);
 
 	return 0;
 }
@@ -1315,8 +1302,14 @@
 	i810_load_regs(par);
 	i810_init_cursor(par);
 	par->cursor_reset = 1;
+
 	encode_fix(&info->fix, info);
 
+	if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) 
+		info->pixmap.scan_align = 2;
+	else 
+		info->pixmap.scan_align = 1;
+	
 	return 0;
 }
 
@@ -1512,10 +1505,6 @@
 		(par->iring.offset << 12);
 	par->cursor_heap.virtual = par->aperture.virtual+
 		(par->cursor_heap.offset << 12);
-	par->pixmap.virtual = par->aperture.virtual + 
-		(par->pixmap.offset << 12);
-	par->pixmap.physical = par->aperture.physical + 
-		(par->pixmap.offset << 12);
 }
 
 static void __init i810_fix_offsets(struct i810fb_par *par)
@@ -1531,10 +1520,7 @@
 	par->fb.offset = v_offset_default << 20;
 	par->fb.offset >>= 12;
 
-	par->pixmap.offset = par->fb.offset + (par->fb.size >> 12);
-	par->pixmap.size = PIXMAP_SIZE;
-
-	par->iring.offset = par->pixmap.offset + (PIXMAP_SIZE >> 12);
+	par->iring.offset = par->fb.offset + (par->fb.size >> 12);
 	par->iring.size = RINGBUFFER_SIZE;
 
 	par->cursor_heap.offset = par->iring.offset + (RINGBUFFER_SIZE >> 12);
@@ -1547,7 +1533,7 @@
 	int size;
 	
 	i810_fix_offsets(par);
-	size = par->fb.size + par->iring.size + par->pixmap.size;
+	size = par->fb.size + par->iring.size;
 
 	par->drm_agp = (drm_agp_t *) inter_module_get("drm_agp");
 	if (!par->drm_agp) {
@@ -1637,23 +1623,20 @@
 static void __init i810_init_defaults(struct i810fb_par *par, 
 				      struct fb_info *info)
 {
-	if (voffset) {
+	if (voffset) 
 		v_offset_default = voffset;
-	}
-	else {
-		if (par->aperture.size > 32 * 1024 * 1024)
-			v_offset_default = 16;
-		else
-			v_offset_default = 8;
-	}
+	else if (par->aperture.size > 32 * 1024 * 1024)
+		v_offset_default = 16;
+	else
+		v_offset_default = 8;
 
 	if (!vram) 
 		vram = 1;
 
-	if (accel)
+	if (accel) 
 		par->dev_flags |= HAS_ACCELERATION;
 
-	if (sync)
+	if (sync) 
 		par->dev_flags |= ALWAYS_SYNC;
 
 	if (bpp < 8)
@@ -1698,8 +1681,6 @@
 	pci_read_config_byte(par->dev, 0x50, &reg);
 	reg &= FREQ_MASK;
 	par->mem_freq = (reg) ? 133 : 100;
-
-	i810fb_init_ringbuffer(par);
 }
 
 static int __init 
@@ -1718,8 +1699,7 @@
 		par->aperture.physical = pci_resource_start(par->dev, 0);
 		par->aperture.size = pci_resource_len(par->dev, 0);
 		par->mmio_start_phys = pci_resource_start(par->dev, 1);
-	}
-	else {
+	} else {
 		par->aperture.physical = pci_resource_start(par->dev, 1);
 		par->aperture.size = pci_resource_len(par->dev, 1);
 		par->mmio_start_phys = pci_resource_start(par->dev, 0);
@@ -1737,7 +1717,7 @@
 	}
 	par->res_flags |= FRAMEBUFFER_REQ;
 
-	par->aperture.virtual = ioremap(par->aperture.physical, 
+	par->aperture.virtual = ioremap_nocache(par->aperture.physical, 
 					par->aperture.size);
 	if (!par->aperture.virtual) {
 		printk("i810fb_init: cannot remap framebuffer region\n");
@@ -1766,7 +1746,6 @@
 {
 	char *this_opt, *suffix = NULL;
 
-	i810_init = 1;
 	if (!options || !*options)
 		return 0;
 	
@@ -1795,13 +1774,11 @@
 			hsync1 = simple_strtoul(this_opt+7, &suffix, 0);
 			if (strncmp(suffix, "H", 1)) 
 				hsync1 *= 1000;
-		} 
-		else if (!strncmp(this_opt, "hsync2:", 7)) {
+		} else if (!strncmp(this_opt, "hsync2:", 7)) {
 			hsync2 = simple_strtoul(this_opt+7, &suffix, 0);
 			if (strncmp(suffix, "H", 1)) 
 				hsync2 *= 1000;
-		} 
-		else if (!strncmp(this_opt, "vsync1:", 7)) 
+		} else if (!strncmp(this_opt, "vsync1:", 7)) 
 			vsync1 = simple_strtoul(this_opt+7, NULL, 0);
 		else if (!strncmp(this_opt, "vsync2:", 7))
 			vsync2 = simple_strtoul(this_opt+7, NULL, 0);
@@ -1812,15 +1789,12 @@
 }
 
 static int __init i810fb_init_pci (struct pci_dev *dev, 
-				      const struct pci_device_id *entry)
+				   const struct pci_device_id *entry)
 {
 	struct fb_info    *info;
 	struct i810fb_par *par = NULL;
 	int err, vfreq, hfreq, pixclock;
 
-	if (!i810_init)
-		return -EINVAL;
-
 	if (!(info = kmalloc(sizeof(struct fb_info), GFP_KERNEL))) {
 		i810fb_release_resource(info, par);
 		return -ENOMEM;
@@ -1836,6 +1810,15 @@
 	par->dev = dev;
 	info->par = par;
 
+	if (!(info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL))) {
+		i810fb_release_resource(info, par);
+		return -ENOMEM;
+	}
+	memset(info->pixmap.addr, 0, 64*1024);
+	info->pixmap.size = 64*1024;
+	info->pixmap.buf_align = 8;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	if ((err = i810_allocate_pci_resource(par, entry))) {
 		i810fb_release_resource(info, par);
 		return err;
@@ -1864,6 +1847,7 @@
 	}
 	encode_fix(&info->fix, info); 
 	 	    
+	i810fb_init_ringbuffer(info);
 	err = register_framebuffer(info);
 	if (err < 0) {
     		i810fb_release_resource(info, par); 
@@ -1894,7 +1878,7 @@
 }
 
 /***************************************************************
- *                     Deinitialization                        *
+ *                     De-initialization                        *
  ***************************************************************/
 
 static void i810fb_release_resource(struct fb_info *info, 
@@ -1931,7 +1915,7 @@
 
 		kfree(par);
 	}
-	if (info)
+	if (info) 
 		kfree(info);
 }
 
@@ -1974,7 +1958,6 @@
 
 int __init i810fb_init(void)
 {
-	i810_init = 1;
 	hsync1 *= 1000;
 	hsync2 *= 1000;
 
@@ -1994,14 +1977,14 @@
 MODULE_PARM_DESC(bpp, "Color depth for display in bits per pixel"
 		 " (default = 8)");
 MODULE_PARM(xres, "i");
-MODULE_PARM_DESC(xres, "Hozizontal resolution in pixels (default = 640)");
+MODULE_PARM_DESC(xres, "Horizontal resolution in pixels (default = 640)");
 MODULE_PARM(yres, "i");
 MODULE_PARM_DESC(yres, "Vertical resolution in scanlines (default = 480)");
 MODULE_PARM(vyres, "i");
 MODULE_PARM_DESC(vyres, "Virtual vertical resolution in scanlines"
 		 " (default = 480)");
 MODULE_PARM(hsync1, "i");
-MODULE_PARM_DESC(hsync1, "Mimimum horizontal frequency of monitor in KHz"
+MODULE_PARM_DESC(hsync1, "Minimum horizontal frequency of monitor in KHz"
 		 " (default = 31)");
 MODULE_PARM(hsync2, "i");
 MODULE_PARM_DESC(hsync2, "Maximum horizontal frequency of monitor in KHz"
diff -Naur linux-2.5.66-orig/drivers/video/i810/i810_main.h linux-2.5.66/drivers/video/i810/i810_main.h
--- linux-2.5.66-orig/drivers/video/i810/i810_main.h	2003-03-26 02:25:01.000000000 +0000
+++ linux-2.5.66/drivers/video/i810/i810_main.h	2003-03-26 02:50:43.000000000 +0000
@@ -55,7 +55,6 @@
 	.resume   =     i810fb_resume,
 };	
 
-static int i810_init  __initdata = 0;
 static int vram       __initdata = 4;
 static int bpp        __initdata = 8;
 static int mtrr       __initdata = 0;
@@ -132,7 +131,8 @@
 extern void i810fb_imageblit(struct fb_info *p, const struct fb_image *image);
 extern int  i810fb_sync     (struct fb_info *p);
 
-extern void i810fb_init_ringbuffer   (struct i810fb_par *par);
+extern void i810fb_init_ringbuffer(struct fb_info *info);
+extern void i810fb_load_front     (u32 offset, struct fb_info *info);
 
 /* Conditionals */
 #if defined(__i386__)





-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
