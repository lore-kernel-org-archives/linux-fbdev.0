From: Cristian Ardelean <cristian97.ardelean@gmail.com>
Date: Sat, 11 Jul 2015 05:27:29 +0000
Subject: [PATCH 2/2] drivers: video: fbdev: vga: fixed coding style
Message-Id: <1436592450-5388-1-git-send-email-cristian97.ardelean@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Cristian Ardelean <cristian97.ardelean@gmail.com>

Fixed most of the coding style issues suggested by checkpatch.pl
tool. Mainly converted spaces to tabs. Left remaining errors and
warnings up to decision of the developers.

Signed-off-by: Cristian Ardelean <cristian97.ardelean@gmail.com>
---
 drivers/video/fbdev/vga16fb.c |  386 ++++++++++++++++++++---------------------
 1 file changed, 193 insertions(+), 193 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 283d335..2c035a7 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1,13 +1,13 @@
 /*
  * linux/drivers/video/vga16.c -- VGA 16-color framebuffer driver
- * 
+ *
  * Copyright 1999 Ben Pfaff <pfaffben@debian.org> and Petr Vandrovec <VANDROVE@vc.cvut.cz>
  * Based on VGA info at http://www.goodnet.com/~tinara/FreeVGA/home.htm
  * Based on VESA framebuffer (c) 1998 Gerd Knorr <kraxel@goldbach.in-berlin.de>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
- * archive for more details.  
+ * archive for more details.
  */
 
 #include <linux/module.h>
@@ -41,7 +41,7 @@
 
 struct vga16fb_par {
 	/* structure holding original VGA register settings when the
-           screen is blanked */
+	   screen is blanked */
 	struct {
 		unsigned char	SeqCtrlIndex;	  /* Sequencer Index reg.   */
 		unsigned char	CrtCtrlIndex;	  /* CRT-Contr. Index reg.  */
@@ -70,7 +70,7 @@ static struct fb_var_screeninfo vga16fb_defined = {
 	.yres		= 480,
 	.xres_virtual	= 640,
 	.yres_virtual	= 480,
-	.bits_per_pixel	= 4,	
+	.bits_per_pixel	= 4,
 	.activate	= FB_ACTIVATE_TEST,
 	.height		= -1,
 	.width		= -1,
@@ -120,7 +120,7 @@ static inline void rmw(volatile char __iomem *p)
 static inline int setmode(int mode)
 {
 	int oldmode;
-	
+
 	oldmode = vga_io_rgfx(VGA_GFX_MODE);
 	vga_io_w(VGA_GFX_D, mode);
 	return oldmode;
@@ -139,19 +139,19 @@ static inline void setmask(int mask)
 	vga_io_w(VGA_GFX_D, mask);
 }
 
-/* Set the Data Rotate Register and return its old value. 
+/* Set the Data Rotate Register and return its old value.
    Bits 0-2 are rotate count, bits 3-4 are logical operation
    (0=NOP, 1=AND, 2=OR, 3=XOR). */
 static inline int setop(int op)
 {
 	int oldop;
-	
+
 	oldop = vga_io_rgfx(VGA_GFX_DATA_ROTATE);
 	vga_io_w(VGA_GFX_D, op);
 	return oldop;
 }
 
-/* Set the Enable Set/Reset Register and return its old value.  
+/* Set the Enable Set/Reset Register and return its old value.
    The code here always uses value 0xf for this register. */
 static inline int setsr(int sr)
 {
@@ -184,7 +184,7 @@ static inline void setindex(int index)
 	vga_io_w(VGA_GFX_I, index);
 }
 
-static void vga16fb_pan_var(struct fb_info *info, 
+static void vga16fb_pan_var(struct fb_info *info,
 			    struct fb_var_screeninfo *var)
 {
 	struct vga16fb_par *par = info->par;
@@ -194,7 +194,7 @@ static void vga16fb_pan_var(struct fb_info *info,
 	if (info->var.bits_per_pixel = 8) {
 		pos = (info->var.xres_virtual * var->yoffset + xoffset) >> 2;
 	} else if (par->mode & MODE_TEXT) {
-		int fh = 16; // FIXME !!! font height. Fugde for now.
+		int fh = 16; /* FIXME !!! font height. Fugde for now. */
 		pos = (info->var.xres_virtual * (var->yoffset / fh) + xoffset) >> 3;
 	} else {
 		if (info->var.nonstd)
@@ -262,12 +262,14 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
 	pixclock = (pixclock * mul) / div;
 	best = vgaclocks;
 	err = pixclock - best->pixclock;
-	if (err < 0) err = -err;
+	if (err < 0)
+		err = -err;
 	for (ptr = vgaclocks + 1; ptr->pixclock; ptr++) {
 		int tmp;
 
 		tmp = pixclock - ptr->pixclock;
-		if (tmp < 0) tmp = -tmp;
+		if (tmp < 0)
+			tmp = -tmp;
 		if (tmp < err) {
 			err = tmp;
 			best = ptr;
@@ -275,9 +277,9 @@ static void vga16fb_clock_chip(struct vga16fb_par *par,
 	}
 	par->misc |= best->misc;
 	par->clkdiv = best->seq_clock_mode;
-	pixclock = (best->pixclock * div) / mul;		
+	pixclock = (best->pixclock * div) / mul;
 }
-			       
+
 #define FAIL(X) return -EINVAL
 
 static int vga16fb_open(struct fb_info *info, int user)
@@ -439,8 +441,10 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
 		FAIL("vslen too big");
 	par->crtc[VGA_CRTC_V_TOTAL] = ytotal - 2;
 	r7 = 0x10;	/* disable linecompare */
-	if (ytotal & 0x100) r7 |= 0x01;
-	if (ytotal & 0x200) r7 |= 0x20;
+	if (ytotal & 0x100)
+		r7 |= 0x01;
+	if (ytotal & 0x200)
+		r7 |= 0x20;
 	par->crtc[VGA_CRTC_PRESET_ROW] = 0;
 	par->crtc[VGA_CRTC_MAX_SCAN] = 0x40;	/* 1 scanline, no linecmp */
 	if (var->vmode & FB_VMODE_DOUBLE)
@@ -473,7 +477,7 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
 	par->crtc[VGA_CRTC_V_SYNC_END] = (pos & 0x0F) & ~0x10; /* disabled IRQ */
 	pos += upper - 1; /* blank_end + 1 <= ytotal + 2 */
 	par->crtc[VGA_CRTC_V_BLANK_END] = pos & 0xFF; /* 0x7F for original VGA,
-                     but some SVGA chips requires all 8 bits to set */
+			but some SVGA chips requires all 8 bits to set */
 	if (vxres >= 512)
 		FAIL("vxres too long");
 	par->crtc[VGA_CRTC_OFFSET] = vxres >> 1;
@@ -492,7 +496,7 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
 		par->misc &= ~0x40;
 	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
 		par->misc &= ~0x80;
-	
+
 	par->mode = mode;
 
 	if (mode & MODE_8BPP)
@@ -501,8 +505,8 @@ static int vga16fb_check_var(struct fb_var_screeninfo *var,
 	else
 		/* pixel clock = vga clock */
 		vga16fb_clock_chip(par, var->pixclock, info, 1, 1);
-	
-	var->red.offset = var->green.offset = var->blue.offset = 
+
+	var->red.offset = var->green.offset = var->blue.offset  	var->transp.offset = 0;
 	var->red.length = var->green.length = var->blue.length  		(par->isVGA) ? 6 : 2;
@@ -569,10 +573,10 @@ static int vga16fb_set_par(struct fb_info *info)
 	else
 		atc[VGA_ATC_PEL] = info->var.xoffset & 7;
 	atc[VGA_ATC_COLOR_PAGE] = 0x00;
-	
+
 	if (par->mode & MODE_TEXT) {
-		fh = 16; // FIXME !!! Fudge font height. 
-		par->crtc[VGA_CRTC_MAX_SCAN] = (par->crtc[VGA_CRTC_MAX_SCAN] 
+		fh = 16; /* FIXME !!! Fudge font height. */
+		par->crtc[VGA_CRTC_MAX_SCAN] = (par->crtc[VGA_CRTC_MAX_SCAN]
 					       & ~0x1F) | (fh - 1);
 	}
 
@@ -583,10 +587,10 @@ static int vga16fb_set_par(struct fb_info *info)
 		vga_io_w(EGA_GFX_E0, 0x00);
 		vga_io_w(EGA_GFX_E1, 0x01);
 	}
-	
+
 	/* update misc output register */
 	vga_io_w(VGA_MIS_W, par->misc);
-	
+
 	/* synchronous reset on */
 	vga_io_wseq(0x00, 0x01);
 
@@ -595,10 +599,9 @@ static int vga16fb_set_par(struct fb_info *info)
 
 	/* write sequencer registers */
 	vga_io_wseq(VGA_SEQ_CLOCK_MODE, seq[VGA_SEQ_CLOCK_MODE] | 0x20);
-	for (i = 2; i < VGA_SEQ_C; i++) {
+	for (i = 2; i < VGA_SEQ_C; i++)
 		vga_io_wseq(i, seq[i]);
-	}
-	
+
 	/* synchronous reset off */
 	vga_io_wseq(0x00, 0x03);
 
@@ -606,15 +609,13 @@ static int vga16fb_set_par(struct fb_info *info)
 	vga_io_wcrt(VGA_CRTC_V_SYNC_END, par->crtc[VGA_CRTC_V_SYNC_END]);
 
 	/* write CRT registers */
-	for (i = 0; i < VGA_CRTC_REGS; i++) {
+	for (i = 0; i < VGA_CRTC_REGS; i++)
 		vga_io_wcrt(i, par->crtc[i]);
-	}
-	
+
 	/* write graphics controller registers */
-	for (i = 0; i < VGA_GFX_C; i++) {
+	for (i = 0; i < VGA_GFX_C; i++)
 		vga_io_wgfx(i, gdc[i]);
-	}
-	
+
 	/* write attribute controller registers */
 	for (i = 0; i < VGA_ATT_C; i++) {
 		vga_io_r(VGA_IS1_RC);		/* reset flip-flop */
@@ -637,7 +638,7 @@ static void ega16_setpalette(int regno, unsigned red, unsigned green, unsigned b
 {
 	static const unsigned char map[] = { 000, 001, 010, 011 };
 	int val;
-	
+
 	if (regno >= 16)
 		return;
 	val = map[red>>14] | ((map[green>>14]) << 1) | ((map[blue>>14]) << 2);
@@ -668,25 +669,25 @@ static int vga16fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	 *  (according to the entries in the `var' structure). Return
 	 *  != 0 for invalid regno.
 	 */
-	
+
 	if (regno >= 256)
 		return 1;
 
 	gray = info->var.grayscale;
-	
+
 	if (gray) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
 	}
-	if (par->isVGA) 
-		vga16_setpalette(regno,red,green,blue);
+	if (par->isVGA)
+		vga16_setpalette(regno, red, green, blue);
 	else
-		ega16_setpalette(regno,red,green,blue);
+		ega16_setpalette(regno, red, green, blue);
 	return 0;
 }
 
 static int vga16fb_pan_display(struct fb_var_screeninfo *var,
-			       struct fb_info *info) 
+			       struct fb_info *info)
 {
 	vga16fb_pan_var(info, var);
 	return 0;
@@ -701,11 +702,11 @@ static void vga_vesa_blank(struct vga16fb_par *par, int mode)
 {
 	unsigned char SeqCtrlIndex = vga_io_r(VGA_SEQ_I);
 	unsigned char CrtCtrlIndex = vga_io_r(VGA_CRT_IC);
-	
+
 	/* save original values of VGA controller registers */
-	if(!par->vesa_blanked) {
+	if (!par->vesa_blanked) {
 		par->vga_state.CrtMiscIO = vga_io_r(VGA_MIS_R);
-		//sti();
+		/* sti(); */
 
 		par->vga_state.HorizontalTotal = vga_io_rcrt(0x00);	/* HorizontalTotal */
 		par->vga_state.HorizDisplayEnd = vga_io_rcrt(0x01);	/* HorizDisplayEnd */
@@ -757,7 +758,7 @@ static void vga_vesa_unblank(struct vga16fb_par *par)
 {
 	unsigned char SeqCtrlIndex = vga_io_r(VGA_SEQ_I);
 	unsigned char CrtCtrlIndex = vga_io_r(VGA_CRT_IC);
-	
+
 	/* restore original values of VGA controller registers */
 	vga_io_w(VGA_MIS_W, par->vga_state.CrtMiscIO);
 
@@ -789,7 +790,7 @@ static void vga_pal_blank(void)
 {
 	int i;
 
-	for (i=0; i<16; i++) {
+	for (i = 0; i < 16; i++) {
 		outb_p(i, VGA_PEL_IW);
 		outb_p(0, VGA_PEL_D);
 		outb_p(0, VGA_PEL_D);
@@ -808,9 +809,8 @@ static int vga16fb_blank(int blank, struct fb_info *info)
 			vga_vesa_unblank(par);
 			par->vesa_blanked = 0;
 		}
-		if (par->palette_blanked) {
+		if (par->palette_blanked)
 			par->palette_blanked = 0;
-		}
 		break;
 	case FB_BLANK_NORMAL:				/* blank */
 		vga_pal_blank();
@@ -827,55 +827,55 @@ static int vga16fb_blank(int blank, struct fb_info *info)
 static void vga_8planes_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
 	u32 dx = rect->dx, width = rect->width;
-        char oldindex = getindex();
-        char oldmode = setmode(0x40);
-        char oldmask = selectmask();
-        int line_ofs, height;
-        char oldop, oldsr;
-        char __iomem *where;
-
-        dx /= 4;
-        where = info->screen_base + dx + rect->dy * info->fix.line_length;
-
-        if (rect->rop = ROP_COPY) {
-                oldop = setop(0);
-                oldsr = setsr(0);
-
-                width /= 4;
-                line_ofs = info->fix.line_length - width;
-                setmask(0xff);
-
-                height = rect->height;
-
-                while (height--) {
-                        int x;
-
-                        /* we can do memset... */
-                        for (x = width; x > 0; --x) {
-                                writeb(rect->color, where);
-                                where++;
-                        }
-                        where += line_ofs;
-                }
-        } else {
-                char oldcolor = setcolor(0xf);
-                int y;
-
-                oldop = setop(0x18);
-                oldsr = setsr(0xf);
-                setmask(0x0F);
-                for (y = 0; y < rect->height; y++) {
-                        rmw(where);
-                        rmw(where+1);
-                        where += info->fix.line_length;
-                }
-                setcolor(oldcolor);
-        }
-        setmask(oldmask);
-        setsr(oldsr);
-        setop(oldop);
-        setmode(oldmode);
-        setindex(oldindex);
+	char oldindex = getindex();
+	char oldmode = setmode(0x40);
+	char oldmask = selectmask();
+	int line_ofs, height;
+	char oldop, oldsr;
+	char __iomem *where;
+
+	dx /= 4;
+	where = info->screen_base + dx + rect->dy * info->fix.line_length;
+
+	if (rect->rop = ROP_COPY) {
+		oldop = setop(0);
+		oldsr = setsr(0);
+
+		width /= 4;
+		line_ofs = info->fix.line_length - width;
+		setmask(0xff);
+
+		height = rect->height;
+
+		while (height--) {
+			int x;
+
+			/* we can do memset... */
+			for (x = width; x > 0; --x) {
+				writeb(rect->color, where);
+				where++;
+			}
+			where += line_ofs;
+		}
+	} else {
+		char oldcolor = setcolor(0xf);
+		int y;
+
+		oldop = setop(0x18);
+		oldsr = setsr(0xf);
+		setmask(0x0F);
+		for (y = 0; y < rect->height; y++) {
+			rmw(where);
+			rmw(where+1);
+			where += info->fix.line_length;
+		}
+		setcolor(oldcolor);
+	}
+	setmask(oldmask);
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
 }
 
 static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
@@ -943,7 +943,7 @@ static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rec
 				}
 				break;
 			}
-		} else 
+		} else
 			vga_8planes_fillrect(info, rect);
 		break;
 	case FB_TYPE_PACKED_PIXELS:
@@ -955,62 +955,62 @@ static void vga16fb_fillrect(struct fb_info *info, const struct fb_fillrect *rec
 
 static void vga_8planes_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-        char oldindex = getindex();
-        char oldmode = setmode(0x41);
-        char oldop = setop(0);
-        char oldsr = setsr(0xf);
-        int height, line_ofs, x;
+	char oldindex = getindex();
+	char oldmode = setmode(0x41);
+	char oldop = setop(0);
+	char oldsr = setsr(0xf);
+	int height, line_ofs, x;
 	u32 sx, dx, width;
 	char __iomem *dest;
 	char __iomem *src;
 
-        height = area->height;
-
-        sx = area->sx / 4;
-        dx = area->dx / 4;
-        width = area->width / 4;
-
-        if (area->dy < area->sy || (area->dy = area->sy && dx < sx)) {
-                line_ofs = info->fix.line_length - width;
-                dest = info->screen_base + dx + area->dy * info->fix.line_length;
-                src = info->screen_base + sx + area->sy * info->fix.line_length;
-                while (height--) {
-                        for (x = 0; x < width; x++) {
-                                readb(src);
-                                writeb(0, dest);
-                                src++;
-                                dest++;
-                        }
-                        src += line_ofs;
-                        dest += line_ofs;
-                }
-        } else {
-                line_ofs = info->fix.line_length - width;
-                dest = info->screen_base + dx + width +
+	height = area->height;
+
+	sx = area->sx / 4;
+	dx = area->dx / 4;
+	width = area->width / 4;
+
+	if (area->dy < area->sy || (area->dy = area->sy && dx < sx)) {
+		line_ofs = info->fix.line_length - width;
+		dest = info->screen_base + dx + area->dy * info->fix.line_length;
+		src = info->screen_base + sx + area->sy * info->fix.line_length;
+		while (height--) {
+			for (x = 0; x < width; x++) {
+				readb(src);
+				writeb(0, dest);
+				src++;
+				dest++;
+			}
+			src += line_ofs;
+			dest += line_ofs;
+		}
+	} else {
+		line_ofs = info->fix.line_length - width;
+		dest = info->screen_base + dx + width +
 			(area->dy + height - 1) * info->fix.line_length;
-                src = info->screen_base + sx + width +
+		src = info->screen_base + sx + width +
 			(area->sy + height - 1) * info->fix.line_length;
-                while (height--) {
-                        for (x = 0; x < width; x++) {
-                                --src;
-                                --dest;
-                                readb(src);
-                                writeb(0, dest);
-                        }
-                        src -= line_ofs;
-                        dest -= line_ofs;
-                }
-        }
-
-        setsr(oldsr);
-        setop(oldop);
-        setmode(oldmode);
-        setindex(oldindex);
+		while (height--) {
+			for (x = 0; x < width; x++) {
+				--src;
+				--dest;
+				readb(src);
+				writeb(0, dest);
+			}
+			src -= line_ofs;
+			dest -= line_ofs;
+		}
+	}
+
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
 }
 
 static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy; 
+	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	int x, x2, y2, old_dx, old_dy, vxres, vyres;
 	int height, width, line_ofs;
 	char __iomem *dst = NULL;
@@ -1076,9 +1076,9 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 					dst += line_ofs;
 				}
 			} else {
-				dst = info->screen_base + (dx/8) + width + 
+				dst = info->screen_base + (dx/8) + width +
 					(dy + height - 1) * info->fix.line_length;
-				src = info->screen_base + (sx/8) + width + 
+				src = info->screen_base + (sx/8) + width +
 					(sy + height  - 1) * info->fix.line_length;
 				while (height--) {
 					for (x = 0; x < width; x++) {
@@ -1091,7 +1091,7 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 					dst -= line_ofs;
 				}
 			}
-		} else 
+		} else
 			vga_8planes_copyarea(info, area);
 		break;
 	case FB_TYPE_PACKED_PIXELS:
@@ -1101,7 +1101,8 @@ static void vga16fb_copyarea(struct fb_info *info, const struct fb_copyarea *are
 	}
 }
 
-#define TRANS_MASK_LOW  {0x0,0x8,0x4,0xC,0x2,0xA,0x6,0xE,0x1,0x9,0x5,0xD,0x3,0xB,0x7,0xF}
+#define TRANS_MASK_LOW  {0x0, 0x8, 0x4, 0xC, 0x2, 0xA, 0x6, 0xE, \
+			 0x1, 0x9, 0x5, 0xD, 0x3, 0xB, 0x7, 0xF}
 #define TRANS_MASK_HIGH {0x000, 0x800, 0x400, 0xC00, 0x200, 0xA00, 0x600, 0xE00, \
 			 0x100, 0x900, 0x500, 0xD00, 0x300, 0xB00, 0x700, 0xF00}
 
@@ -1117,33 +1118,33 @@ static const u16 transl_h[] = TRANS_MASK_LOW;
 
 static void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-        char oldindex = getindex();
-        char oldmode = setmode(0x40);
-        char oldop = setop(0);
-        char oldsr = setsr(0);
-        char oldmask = selectmask();
-        const char *cdat = image->data;
+	char oldindex = getindex();
+	char oldmode = setmode(0x40);
+	char oldop = setop(0);
+	char oldsr = setsr(0);
+	char oldmask = selectmask();
+	const char *cdat = image->data;
 	u32 dx = image->dx;
-        char __iomem *where;
-        int y;
-
-        dx /= 4;
-        where = info->screen_base + dx + image->dy * info->fix.line_length;
-
-        setmask(0xff);
-        writeb(image->bg_color, where);
-        readb(where);
-        selectmask();
-        setmask(image->fg_color ^ image->bg_color);
-        setmode(0x42);
-        setop(0x18);
-        for (y = 0; y < image->height; y++, where += info->fix.line_length)
-                writew(transl_h[cdat[y]&0xF] | transl_l[cdat[y] >> 4], where);
-        setmask(oldmask);
-        setsr(oldsr);
-        setop(oldop);
-        setmode(oldmode);
-        setindex(oldindex);
+	char __iomem *where;
+	int y;
+
+	dx /= 4;
+	where = info->screen_base + dx + image->dy * info->fix.line_length;
+
+	setmask(0xff);
+	writeb(image->bg_color, where);
+	readb(where);
+	selectmask();
+	setmask(image->fg_color ^ image->bg_color);
+	setmode(0x42);
+	setop(0x18);
+	for (y = 0; y < image->height; y++, where += info->fix.line_length)
+		writew(transl_h[cdat[y]&0xF] | transl_l[cdat[y] >> 4], where);
+	setmask(oldmask);
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
 }
 
 static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *image)
@@ -1164,7 +1165,6 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 				setsr(0xf);
 				setcolor(image->fg_color);
 				selectmask();
-				
 				setmask(0xff);
 				writeb(image->bg_color, where);
 				rmb();
@@ -1173,7 +1173,7 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 				wmb();
 				for (y = 0; y < image->height; y++) {
 					dst = where;
-					for (x = image->width/8; x--;) 
+					for (x = image->width/8; x--;)
 						writeb(*cdat++, dst++);
 					where += info->fix.line_length;
 				}
@@ -1184,11 +1184,10 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 				setsr(0xf);
 				setcolor(image->bg_color);
 				selectmask();
-				
 				setmask(0xff);
 				for (y = 0; y < image->height; y++) {
 					dst = where;
-					for (x=image->width/8; x--;){
+					for (x = image->width/8; x--;) {
 						rmw(dst);
 						setcolor(image->fg_color);
 						selectmask();
@@ -1200,7 +1199,7 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 					where += info->fix.line_length;
 				}
 			}
-		} else 
+		} else
 			vga_8planes_imageblit(info, image);
 		break;
 	case FB_TYPE_PACKED_PIXELS:
@@ -1213,7 +1212,7 @@ static void vga_imageblit_expand(struct fb_info *info, const struct fb_image *im
 static void vga_imageblit_color(struct fb_info *info, const struct fb_image *image)
 {
 	/*
-	 * Draw logo 
+	 * Draw logo
 	 */
 	struct vga16fb_par *par = info->par;
 	char __iomem *where @@ -1230,7 +1229,7 @@ static void vga_imageblit_color(struct fb_info *info, const struct fb_image *ima
 			setsr(0xf);
 			setop(0);
 			setmode(0);
-			
+
 			for (y = 0; y < image->height; y++) {
 				for (x = 0; x < image->width; x++) {
 					dst = where + x/8;
@@ -1254,7 +1253,7 @@ static void vga_imageblit_color(struct fb_info *info, const struct fb_image *ima
 		break;
 	}
 }
-				
+
 static void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	if (image->depth = 1)
@@ -1273,14 +1272,14 @@ static void vga16fb_destroy(struct fb_info *info)
 
 static struct fb_ops vga16fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_open        = vga16fb_open,
-	.fb_release     = vga16fb_release,
+	.fb_open	= vga16fb_open,
+	.fb_release	= vga16fb_release,
 	.fb_destroy	= vga16fb_destroy,
 	.fb_check_var	= vga16fb_check_var,
 	.fb_set_par	= vga16fb_set_par,
-	.fb_setcolreg 	= vga16fb_setcolreg,
-	.fb_pan_display = vga16fb_pan_display,
-	.fb_blank 	= vga16fb_blank,
+	.fb_setcolreg	= vga16fb_setcolreg,
+	.fb_pan_display	= vga16fb_pan_display,
+	.fb_blank	= vga16fb_blank,
 	.fb_fillrect	= vga16fb_fillrect,
 	.fb_copyarea	= vga16fb_copyarea,
 	.fb_imageblit	= vga16fb_imageblit,
@@ -1290,12 +1289,13 @@ static struct fb_ops vga16fb_ops = {
 static int __init vga16fb_setup(char *options)
 {
 	char *this_opt;
-	
+
 	if (!options || !*options)
 		return 0;
-	
+
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt) continue;
+		if (!*this_opt)
+			continue;
 	}
 	return 0;
 }
@@ -1337,11 +1337,11 @@ static int vga16fb_probe(struct platform_device *dev)
 	par->palette_blanked = 0;
 	par->vesa_blanked = 0;
 
-	i = par->isVGA? 6 : 2;
-	
+	i = par->isVGA ? 6 : 2;
+
 	vga16fb_defined.red.length   = i;
 	vga16fb_defined.green.length = i;
-	vga16fb_defined.blue.length  = i;	
+	vga16fb_defined.blue.length  = i;
 
 	/* name should not depend on EGA/VGA */
 	info->fbops = &vga16fb_ops;
-- 
1.7.9.5

