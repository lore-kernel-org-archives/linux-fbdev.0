From: Antonino Daplas <adaplas@pol.net>
Subject: [patch 1] Console Rotation
Date: 09 Sep 2002 22:21:31 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031580667.632.7.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPPE-0002aA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:20:49 -0700
Received: from AP-202-70-99-9.compass.com.ph (AP-202-70-99-9.compass.com.ph [202.70.99.9])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id WAA90329
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Sep 2002 22:20:39 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


The patch (fb_rotate.diff) adds console rotation support to the fb
framework. Console rotation wrappers are lumped in fbcon-rotate.h and
fbcon-rotate.c.  

p->fontdata is pre-rotated during fbcon_xx_setup(), thus changing fonts
may corrupt the display until fbcon_setup() is called again. 

Tony 

<<----------------------------------------------------------------------->> 
diff -Naur linux-2.5.33/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.5.33/drivers/video/Config.in	Sun Sep  8 19:38:45 2002
+++ linux/drivers/video/Config.in	Sun Sep  8 19:45:59 2002
@@ -227,6 +227,7 @@
       tristate '    24 bpp packed pixels support' CONFIG_FBCON_CFB24
       tristate '    32 bpp packed pixels support' CONFIG_FBCON_CFB32
       tristate '    Hardware acceleration support' CONFIG_FBCON_ACCEL
+      dep_tristate '    Console Display Rotation support' CONFIG_FBCON_ROTATE $CONFIG_FBCON_ACCEL	
       tristate '    Amiga bitplanes support' CONFIG_FBCON_AFB
       tristate '    Amiga interleaved bitplanes support' CONFIG_FBCON_ILBM
       tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG_FBCON_IPLAN2P2
diff -Naur linux-2.5.33/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.33/drivers/video/Makefile	Sun Sep  8 19:38:45 2002
+++ linux/drivers/video/Makefile	Sun Sep  8 19:45:59 2002
@@ -6,7 +6,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
 export-objs    	:= fbmem.o fbcmap.o fbcon.o fbmon.o modedb.o \
-		   fbcon-afb.o fbcon-ilbm.o fbcon-accel.o \
+		   fbcon-afb.o fbcon-ilbm.o fbcon-accel.o fbcon-rotate.o \
 		   fbcon-vga.o fbcon-iplan2p2.o fbcon-iplan2p4.o \
 		   fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		   fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
@@ -118,6 +118,7 @@
 obj-$(CONFIG_FBCON_HGA)           += fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
 obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
+obj-$(CONFIG_FBCON_ROTATE)	  += fbcon-rotate.o 
 
 include $(TOPDIR)/Rules.make
 
diff -Naur linux-2.5.33/drivers/video/fbcon-rotate.c linux/drivers/video/fbcon-rotate.c
--- linux-2.5.33/drivers/video/fbcon-rotate.c	Thu Jan  1 00:00:00 1970
+++ linux/drivers/video/fbcon-rotate.c	Sun Sep  8 19:46:35 2002
@@ -0,0 +1,611 @@
+/*
+ *  linux/drivers/video/fbcon-accel.c -- Framebuffer Display Rotation
+ *
+ *      Created 20 Feb 2001 by James Simmons <jsimmons@users.sf.net>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <video/fbcon.h>
+#include "fbcon-rotate.h"
+
+#define FONTDATAMAX 4096
+
+static unsigned char fontcache[FONTDATAMAX];
+
+static int pattern_test_bit(u32 x, u32 y, u32 pitch, char *pat)
+{
+	u32 tmp = (y * pitch) + x;
+	u32 index = tmp / 8;
+	u32 bit = tmp % 8;
+	
+#if defined (__LITTLE_ENDIAN)
+	return (pat[index] & (1 << (7 - bit)));
+#else
+	return (pat[index] & (1 >> bit));
+#endif
+}
+
+static void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
+{
+	u32 tmp = (y * pitch) + x;
+	u32 index = tmp/8;
+	u32 bit = tmp % 8;
+
+#if defined (__LITTLE_ENDIAN)
+	pat[index] |= 1 << (7 - bit);
+#else
+	pat[index] |= 1 >> bit;
+#endif 
+}
+
+static void rotate_cw(char *in, char *out, u32 width, u32 height)
+{
+	int i, j;
+	
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(height - 1 - i, j, height, out);
+		}
+	}
+}
+
+static void rotate_ccw(char *in, char *out, u32 width, u32 height)
+{
+	int i, j;
+	
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(i, width - 1 - j, height, out);
+		}
+	}
+}
+
+static void rotate_ud(char *in, char *out, u32 width, u32 height)
+{
+	int i, j;
+	
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(width - 1 - j, height - 1 - i, width, out);
+		}
+	}
+}
+
+/*
+ * Clockwise (90 degree) Rotation
+ */
+void fbcon_rr_setup(struct display *p)
+{
+	u32 i, cell_size;
+	char *src, *dst;
+
+	p->next_line = p->fb_info->fix.line_length;
+	p->next_plane = 0;
+	
+	memset(fontcache, 0, FONTDATAMAX);
+	
+	cell_size = (fontwidth(p) + 7)/ 8;
+	cell_size *= fontheight(p);
+	src = p->fontdata;
+	dst = fontcache;
+
+	for (i = FONTDATAMAX/cell_size; i--; ) {
+		rotate_cw(src, dst, fontwidth(p), fontheight(p));
+		src += cell_size;
+		dst += cell_size;
+	}
+}
+
+void fbcon_rr_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_copyarea area;
+
+	area.sx = info->var.yres_virtual - ((sy + height) * fontheight(p));
+	area.sy = sx * fontwidth(p);
+	area.dx = info->var.yres_virtual - ((dy + height) * fontheight(p));
+	area.dy = dx * fontwidth(p);
+	area.width = height * fontheight(p);
+	area.height  = width * fontwidth(p);
+
+	info->fbops->fb_copyarea(info, &area);
+}
+
+void fbcon_rr_clear(struct vc_data *vc, struct display *p, int sy, int sx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.dx = info->var.yres_virtual - ((sy + height) * fontheight(p));
+	region.dy = sx * fontwidth(p);
+	region.height = width * fontwidth(p);
+	region.width = height * fontheight(p);
+	region.rop = ROP_COPY;
+
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_rr_putc(struct vc_data *vc, struct display *p, int c, int yy,
+		      int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, c);
+	image.bg_color = attr_bgcol(p, c);
+	image.dx = info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(p));
+	image.dy = xx * fontwidth(p);
+	image.width = fontheight(p);
+	image.height = fontwidth(p);
+	image.data = fontcache + (c & charmask)*fontheight(p) * width;
+	image.depth = 1;
+	info->fbops->fb_imageblit(info, &image);
+}
+
+void fbcon_rr_putcs(struct vc_data *vc, struct display *p,
+		       const unsigned short *s, int count, int yy, int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	unsigned int cell_size = width * fontheight(p);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, *s);
+	image.bg_color = attr_bgcol(p, *s);
+	image.dx = info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(p));
+	image.dy = xx * fontwidth(p);
+	image.width = fontheight(p);
+	image.height = fontwidth(p);
+	image.depth = 1;
+	while (count--) {
+		image.data = fontcache + (scr_readw(s++) & charmask) * cell_size;
+		info->fbops->fb_imageblit(info, &image);
+		image.dy += fontwidth(p);
+	}
+}
+
+void fbcon_rr_revc(struct display *p, int xx, int yy)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_fgcol_ec(p, p->conp);
+	region.dx = info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(p));
+	region.dy = xx * fontwidth(p);
+	region.width  = fontheight(p);
+	region.height = fontwidth(p); 
+	region.rop = ROP_XOR;
+	
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_rr_clear_margins(struct vc_data *vc, struct display *p,
+			       int bottom_only)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned int cw = fontwidth(p);
+	unsigned int ch = fontheight(p);
+	unsigned int rw = info->var.xres % cw;
+	unsigned int bh = info->var.yres % ch;
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.rop = ROP_COPY;
+
+	if (rw && !bottom_only) {
+		region.dx = 0;
+		region.dy = info->var.xoffset + rs;
+		region.height  = rw;
+		region.width = info->var.yres_virtual;
+		info->fbops->fb_fillrect(info, &region); 
+	}
+
+	if (bh) {
+		region.dx = info->var.yres_virtual - (info->var.yoffset + bs + bh);
+		region.dy = info->var.xoffset;
+                region.width  = bh;
+                region.height = rs;
+		info->fbops->fb_fillrect(info, &region);
+	}
+}
+
+    /*
+     *  `switch' for the low level operations
+     */
+
+struct display_switch fbcon_rr = {
+	setup:		fbcon_rr_setup,
+	bmove:		fbcon_rr_bmove,
+	clear:		fbcon_rr_clear,
+	putc:		fbcon_rr_putc,
+	putcs:		fbcon_rr_putcs,
+	revc:		fbcon_rr_revc,
+	clear_margins:	fbcon_rr_clear_margins,
+	fontwidthmask:	FONTWIDTHRANGE(1, 16)	
+};
+
+/*
+ * Counterclockwise (270 degree) Rotation
+ */
+void fbcon_rl_setup(struct display *p)
+{
+	u32 i, cell_size;
+	char *src, *dst;
+
+	p->next_line = p->fb_info->fix.line_length;
+	p->next_plane = 0;
+	
+	memset(fontcache, 0, FONTDATAMAX);
+	
+	cell_size = (fontwidth(p) + 7)/ 8;
+	cell_size *= fontheight(p);
+	src = p->fontdata;
+	dst = fontcache;
+
+	for (i = FONTDATAMAX/cell_size; i--; ) {
+		rotate_ccw(src, dst, (fontwidth(p) + 7) & ~7, fontheight(p));
+		src += cell_size;
+		dst += cell_size;
+	}
+}
+
+void fbcon_rl_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_copyarea area;
+
+	area.sx = sy * fontheight(p);
+	area.sy = info->var.xres_virtual - ((sx + width) * fontwidth(p));
+	area.dx = dy * fontheight(p);
+	area.dy = info->var.xres_virtual - ((dx + width) * fontwidth(p));
+	area.width = height * fontheight(p);
+	area.height  = width * fontwidth(p);
+
+	info->fbops->fb_copyarea(info, &area);
+}
+
+void fbcon_rl_clear(struct vc_data *vc, struct display *p, int sy, int sx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.dx = sy * fontheight(p);
+	region.dy = info->var.xres_virtual - ((sx + width)  *  fontwidth(p));
+	region.height = width * fontwidth(p);
+	region.width = height * fontheight(p);
+	region.rop = ROP_COPY;
+
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_rl_putc(struct vc_data *vc, struct display *p, int c, int yy,
+		      int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, c);
+	image.bg_color = attr_bgcol(p, c);
+	image.dx = yy * fontheight(p);
+	image.dy = info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p));
+	image.width = fontheight(p);
+	image.height = fontwidth(p);
+	image.data = fontcache + (c & charmask)*fontheight(p) * width;
+	image.depth = 1;
+	info->fbops->fb_imageblit(info, &image);
+}
+
+void fbcon_rl_putcs(struct vc_data *vc, struct display *p,
+		       const unsigned short *s, int count, int yy, int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	unsigned int cell_size = width * fontheight(p);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, *s);
+	image.bg_color = attr_bgcol(p, *s);
+	image.dx = yy * fontheight(p);
+	image.dy = info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p));
+	image.width = fontheight(p);
+	image.height = fontwidth(p);
+	image.depth = 1;
+	while (count--) {
+		image.data = fontcache + (scr_readw(s++) & charmask) * cell_size;
+		info->fbops->fb_imageblit(info, &image);
+		image.dy -= fontwidth(p);
+	}
+}
+
+void fbcon_rl_revc(struct display *p, int xx, int yy)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_fgcol_ec(p, p->conp);
+	region.dx = yy * fontheight(p);
+	region.dy = info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p));
+	region.width  = fontheight(p);
+	region.height = fontwidth(p); 
+	region.rop = ROP_XOR;
+	
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_rl_clear_margins(struct vc_data *vc, struct display *p,
+			       int bottom_only)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned int cw = fontwidth(p);
+	unsigned int ch = fontheight(p);
+	unsigned int rw = info->var.xres % cw;
+	unsigned int bh = info->var.yres % ch;
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.rop = ROP_COPY;
+
+	if (rw && !bottom_only) {
+		region.dx = 0;
+		region.dy = info->var.xres_virtual - (info->var.xoffset + rs + rw);
+		region.height  = rw;
+		region.width = info->var.yres_virtual;
+		info->fbops->fb_fillrect(info, &region); 
+	}
+
+	if (bh) {
+		region.dx = info->var.yoffset + bs;
+		region.dy = info->var.xres_virtual - (info->var.xoffset + rs + rw);
+                region.width  = bh;
+                region.height = rs;
+		info->fbops->fb_fillrect(info, &region);
+	}
+}
+
+    /*
+     *  `switch' for the low level operations
+     */
+
+struct display_switch fbcon_rl = {
+	setup:		fbcon_rl_setup,
+	bmove:		fbcon_rl_bmove,
+	clear:		fbcon_rl_clear,
+	putc:		fbcon_rl_putc,
+	putcs:		fbcon_rl_putcs,
+	revc:		fbcon_rl_revc,
+	clear_margins:	fbcon_rl_clear_margins,
+	fontwidthmask:	FONTWIDTHRANGE(1, 16)	
+};
+
+/*
+ * 180 degree Rotation
+ */
+void fbcon_ud_setup(struct display *p)
+{
+	u32 i, cell_size;
+	char *src, *dst;
+
+	p->next_line = p->fb_info->fix.line_length;
+	p->next_plane = 0;
+	
+	memset(fontcache, 0, FONTDATAMAX);
+	
+	cell_size = (fontwidth(p) + 7)/ 8;
+	cell_size *= fontheight(p);
+	src = p->fontdata;
+	dst = fontcache;
+
+	for (i = FONTDATAMAX/cell_size; i--; ) {
+		rotate_ud(src, dst, (fontwidth(p) + 7) & ~7, fontheight(p));
+		src += cell_size;
+		dst += cell_size;
+	}
+}
+
+void fbcon_ud_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_copyarea area;
+
+	area.sy = info->var.yres_virtual - ((sy + height) * fontheight(p));
+	area.sx = info->var.xres_virtual - ((sx + width) * fontwidth(p));
+	area.dy = info->var.yres_virtual - ((dy + height) * fontheight(p));
+	area.dx = info->var.xres_virtual - ((dx + width) * fontwidth(p));
+	area.height = height * fontheight(p);
+	area.width  = width * fontwidth(p);
+
+	info->fbops->fb_copyarea(info, &area);
+}
+
+void fbcon_ud_clear(struct vc_data *vc, struct display *p, int sy, int sx,
+		       int height, int width)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.dy = info->var.yres_virtual - ((sy + height) * fontheight(p));
+	region.dx = info->var.xres_virtual - ((sx + width) *  fontwidth(p));
+	region.width = width * fontwidth(p);
+	region.height = height * fontheight(p);
+	region.rop = ROP_COPY;
+
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_ud_putc(struct vc_data *vc, struct display *p, int c, int yy,
+		      int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, c);
+	image.bg_color = attr_bgcol(p, c);
+	image.dy = info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(p));
+	image.dx = info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p));
+	image.height = fontheight(p);
+	image.width = fontwidth(p);
+	image.depth = 1;
+	image.data = fontcache + (c & charmask)*fontheight(p) * width;
+	info->fbops->fb_imageblit(info, &image);
+}
+
+void fbcon_ud_putcs(struct vc_data *vc, struct display *p,
+		       const unsigned short *s, int count, int yy, int xx)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned short charmask = p->charmask;
+	unsigned int width = ((fontwidth(p)+7)>>3);
+	unsigned int cell_size = width * fontheight(p);
+	struct fb_image image;
+
+	image.fg_color = attr_fgcol(p, *s);
+	image.bg_color = attr_bgcol(p, *s);
+	image.dy = info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(p));
+	image.dx = info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p));
+	image.height = fontheight(p);
+	image.width = fontwidth(p);
+	image.depth = 1;
+	while (count--) {
+		image.data = fontcache + (scr_readw(s++) & charmask) * cell_size;
+		info->fbops->fb_imageblit(info, &image);
+		image.dx -= fontwidth(p);
+	}
+}
+
+void fbcon_ud_revc(struct display *p, int xx, int yy)
+{
+	struct fb_info *info = p->fb_info;
+	struct fb_fillrect region;
+
+	region.color = attr_fgcol_ec(p, p->conp);
+	region.dy = info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(p));
+	region.dx = info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p));
+	region.height  = fontheight(p);
+	region.width = fontwidth(p); 
+	region.rop = ROP_XOR;
+	
+	info->fbops->fb_fillrect(info, &region);
+}
+
+void fbcon_ud_clear_margins(struct vc_data *vc, struct display *p,
+			       int bottom_only)
+{
+	struct fb_info *info = p->fb_info;
+	unsigned int cw = fontwidth(p);
+	unsigned int ch = fontheight(p);
+	unsigned int rw = info->var.xres % cw;
+	unsigned int bh = info->var.yres % ch;
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	struct fb_fillrect region;
+
+	region.color = attr_bgcol_ec(p,vc);
+	region.rop = ROP_COPY;
+
+	if (rw && !bottom_only) {
+		region.dy = 0;
+		region.dx = info->var.xres_virtual - (info->var.xoffset + rs + rw);
+		region.width  = rw;
+		region.height = info->var.yres_virtual;
+		info->fbops->fb_fillrect(info, &region); 
+	}
+
+	if (bh) {
+		region.dy = info->var.yres_virtual - (info->var.yoffset + bs + bh);
+		region.dx = info->var.xres_virtual - (info->var.xoffset + rs + rw);
+                region.height  = bh;
+                region.width = rs;
+		info->fbops->fb_fillrect(info, &region);
+	}
+}
+
+    /*
+     *  `switch' for the low level operations
+     */
+
+struct display_switch fbcon_ud = {
+	setup:		fbcon_ud_setup,
+	bmove:		fbcon_ud_bmove,
+	clear:		fbcon_ud_clear,
+	putc:		fbcon_ud_putc,
+	putcs:		fbcon_ud_putcs,
+	revc:		fbcon_ud_revc,
+	clear_margins:	fbcon_ud_clear_margins,
+	fontwidthmask:	FONTWIDTHRANGE(1, 16)	
+};
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+    return 0;
+}
+
+void cleanup_module(void)
+{}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(fbcon_rr);
+EXPORT_SYMBOL(fbcon_rr_setup);
+EXPORT_SYMBOL(fbcon_rr_bmove);
+EXPORT_SYMBOL(fbcon_rr_clear);
+EXPORT_SYMBOL(fbcon_rr_putc);
+EXPORT_SYMBOL(fbcon_rr_putcs);
+EXPORT_SYMBOL(fbcon_rr_revc);
+EXPORT_SYMBOL(fbcon_rr_clear_margins);
+
+EXPORT_SYMBOL(fbcon_rl);
+EXPORT_SYMBOL(fbcon_rl_setup);
+EXPORT_SYMBOL(fbcon_rl_bmove);
+EXPORT_SYMBOL(fbcon_rl_clear);
+EXPORT_SYMBOL(fbcon_rl_putc);
+EXPORT_SYMBOL(fbcon_rl_putcs);
+EXPORT_SYMBOL(fbcon_rl_revc);
+EXPORT_SYMBOL(fbcon_rl_clear_margins);
+
+EXPORT_SYMBOL(fbcon_ud);
+EXPORT_SYMBOL(fbcon_ud_setup);
+EXPORT_SYMBOL(fbcon_ud_bmove);
+EXPORT_SYMBOL(fbcon_ud_clear);
+EXPORT_SYMBOL(fbcon_ud_putc);
+EXPORT_SYMBOL(fbcon_ud_putcs);
+EXPORT_SYMBOL(fbcon_ud_revc);
+EXPORT_SYMBOL(fbcon_ud_clear_margins);
diff -Naur linux-2.5.33/drivers/video/fbcon-rotate.h linux/drivers/video/fbcon-rotate.h
--- linux-2.5.33/drivers/video/fbcon-rotate.h	Thu Jan  1 00:00:00 1970
+++ linux/drivers/video/fbcon-rotate.h	Sun Sep  8 19:45:59 2002
@@ -0,0 +1,62 @@
+/*
+ *  FBcon low-level driver wrapper for the display rotation. 
+ */
+
+#ifndef _VIDEO_FBCON_ROTATE_H
+#define _VIDEO_FBCON_ROTATE_H
+
+#include <linux/config.h>
+
+#ifdef MODULE
+#if defined(CONFIG_FBCON_ROTATE) || defined(CONFIG_FBCON_ROTATE_MODULE)
+#define FBCON_HAS_ROTATE
+#endif
+#else
+#if defined(CONFIG_FBCON_ROTATE)
+#define FBCON_HAS_ROTATE
+#endif
+#endif
+
+extern struct display_switch fbcon_rr;
+extern void fbcon_rr_setup(struct display *p);
+extern void fbcon_rr_bmove(struct display *p, int sy, int sx, int dy,
+			   int dx, int height, int width);
+extern void fbcon_rr_clear(struct vc_data *vc, struct display *p, int sy,
+			   int sx, int height, int width);
+extern void fbcon_rr_putc(struct vc_data *vc, struct display *p, int c,
+			  int yy, int xx);
+extern void fbcon_rr_putcs(struct vc_data *vc, struct display *p,
+			   const unsigned short *s, int count, int yy, int xx);
+extern void fbcon_rr_revc(struct display *p, int xx, int yy);
+extern void fbcon_rr_clear_margins(struct vc_data *vc, struct display *p,
+				   int bottom_only);
+
+extern struct display_switch fbcon_rl;
+extern void fbcon_rl_setup(struct display *p);
+extern void fbcon_rl_bmove(struct display *p, int sy, int sx, int dy,
+			   int dx, int height, int width);
+extern void fbcon_rl_clear(struct vc_data *vc, struct display *p, int sy,
+			   int sx, int height, int width);
+extern void fbcon_rl_putc(struct vc_data *vc, struct display *p, int c,
+			  int yy, int xx);
+extern void fbcon_rl_putcs(struct vc_data *vc, struct display *p,
+			   const unsigned short *s, int count, int yy, int xx);
+extern void fbcon_rl_revc(struct display *p, int xx, int yy);
+extern void fbcon_rl_clear_margins(struct vc_data *vc, struct display *p,
+				   int bottom_only);
+
+extern struct display_switch fbcon_ud;
+extern void fbcon_ud_setup(struct display *p);
+extern void fbcon_ud_bmove(struct display *p, int sy, int sx, int dy,
+			   int dx, int height, int width);
+extern void fbcon_ud_clear(struct vc_data *vc, struct display *p, int sy,
+			   int sx, int height, int width);
+extern void fbcon_ud_putc(struct vc_data *vc, struct display *p, int c,
+			  int yy, int xx);
+extern void fbcon_ud_putcs(struct vc_data *vc, struct display *p,
+			   const unsigned short *s, int count, int yy, int xx);
+extern void fbcon_ud_revc(struct display *p, int xx, int yy);
+extern void fbcon_ud_clear_margins(struct vc_data *vc, struct display *p,
+				   int bottom_only);
+
+#endif /* _VIDEO_FBCON_ROTATE_H */
diff -Naur linux-2.5.33/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux-2.5.33/drivers/video/fbgen.c	Sun Sep  8 19:38:45 2002
+++ linux/drivers/video/fbgen.c	Sun Sep  8 19:45:59 2002
@@ -29,6 +29,7 @@
 #include <video/fbcon-cfb24.h>
 #include <video/fbcon-cfb32.h>
 #include "fbcon-accel.h"
+#include "fbcon-rotate.h"
 
 int gen_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
 {
@@ -156,10 +157,19 @@
 
 #ifdef FBCON_HAS_ACCEL
 	display->scrollmode = SCROLL_YNOMOVE;
-	display->dispsw = &fbcon_accel;
+#ifdef FBCON_HAS_ROTATE
+	if (info->var.vmode & FB_VMODE_ROTATE_CW)
+		display->dispsw = &fbcon_rr;
+	else if (info->var.vmode & FB_VMODE_ROTATE_CCW)
+		display->dispsw = &fbcon_rl;
+	else if (info->var.vmode & FB_VMODE_ROTATE_UD)
+		display->dispsw = &fbcon_ud;
+	else 
+#endif /* FBCON_HAS_ROTATE */
+		display->dispsw = &fbcon_accel;
 #else
 	display->dispsw = &fbcon_dummy;
-#endif
+#endif /* FBCON_HAS_ACCEL */
 	return;
 }
 
diff -Naur linux-2.5.33/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.33/include/linux/fb.h	Sun Sep  8 19:45:40 2002
+++ linux/include/linux/fb.h	Sun Sep  8 19:45:59 2002
@@ -166,6 +166,11 @@
 #define FB_VMODE_DOUBLE		2	/* double scan */
 #define FB_VMODE_MASK		255
 
+#define FB_VMODE_ROTATE_CW      0x010000 /* rotate console by 90 degrees  */
+#define FB_VMODE_ROTATE_CCW     0x020000 /* rotate console by 270 degrees */
+#define FB_VMODE_ROTATE_UD      0x040000 /* rotate console by 180 degrees */
+#define FB_ROTATE_MASK          0xFF0000
+
 #define FB_VMODE_YWRAP		256	/* ywrap instead of panning     */
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
