From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Resource management.
Date: Thu, 24 Feb 2005 19:57:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502241951001.5491@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
 <200502220653.01286.adaplas@hotpop.com> <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
 <200502222206.31364.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4P7G-0008Bp-Jr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 11:57:42 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D4P6v-0000Jp-P9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 24 Feb 2005 11:57:42 -0800
In-Reply-To: <200502222206.31364.adaplas@hotpop.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@pentafluge.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>


> If you intend to insist on doing this, this is my proposal:
> 
> The linked list of resources per fb_info can be kept. However, instead
> of doing an fb_find_resource() per call to putcs and cursor, this can
> be done only once, during initialization of fbcon or set_con2fb_map.
> This resource can then be stored in an fbcon-private area. 

I fixed this in my latest work. Alot of cleanups has happened. Still a few 
issues to work out.

> The advantage of this is that fbcon will only look for the resource that
> it needs, ie "scratchpad" but not, for example, "overlay". Similarly, 
> a user video application can totally ignore "scratchpad" but will search for
> "overlay".  Secondly, the performance penalty suffered by the your initial
> patch will be eliminated. We also eliminate one or two more fields in
> fb_info directly accessed by fbcon.

I removed the scratch pad. We use the data reflecting the "drawable" 
properties. 

> Also, instead of storing the resource type as a string, why not use a
> constant?

We would run out very fast. Plus we would need a index field in the case 
we have more than one of the same kind.

Here is the latest work.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/Makefile fbdev-2.6/drivers/video/Makefile
--- linus-2.6/drivers/video/Makefile	2005-02-24 10:39:32.000000000 -0800
+++ fbdev-2.6/drivers/video/Makefile	2005-02-17 14:26:42.000000000 -0800
@@ -8,7 +8,7 @@
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o resmgt.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 += macmodes.o
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/bitblit.c fbdev-2.6/drivers/video/console/bitblit.c
--- linus-2.6/drivers/video/console/bitblit.c	2005-02-24 10:39:35.000000000 -0800
+++ fbdev-2.6/drivers/video/console/bitblit.c	2005-02-24 10:00:30.000000000 -0800
@@ -107,25 +107,20 @@
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg)
 {
-	void (*move_unaligned)(struct fb_info *info, struct fb_pixmap *buf,
-			       u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			       u32 height, u32 shift_high, u32 shift_low,
-			       u32 mod);
-	void (*move_aligned)(struct fb_info *info, struct fb_pixmap *buf,
-			     u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			     u32 height);
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width = (vc->vc_font.width + 7) >> 3;
 	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
+	struct fb_pixmap *pad = info->pad;
+	unsigned int maxcnt = pad->size/cellsize;
+	unsigned int scan_align = pad->scan_align - 1;
+	unsigned int buf_align = pad->buf_align - 1;
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
 	unsigned int shift_high = 8, pitch, cnt, size, k;
 	unsigned int idx = vc->vc_font.width >> 3;
 	unsigned int attribute = get_attribute(info, scr_readw(s));
-	struct fb_image image;
 	u8 *src, *dst, *buf = NULL;
+	struct fb_image image;
 
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_KERNEL);
@@ -141,13 +136,6 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (info->pixmap.outbuf && info->pixmap.inbuf) {
-		move_aligned = fb_iomove_buf_aligned;
-		move_unaligned = fb_iomove_buf_unaligned;
-	} else {
-		move_aligned = fb_sysmove_buf_aligned;
-		move_unaligned = fb_sysmove_buf_unaligned;
-	}
 	while (count) {
 		if (count > maxcnt)
 			cnt = k = maxcnt;
@@ -159,7 +147,7 @@
 		pitch &= ~scan_align;
 		size = pitch * image.height + buf_align;
 		size &= ~buf_align;
-		dst = fb_get_buffer_offset(info, &info->pixmap, size);
+		dst = ops->scratch_pad;
 		image.data = dst;
 		if (mod) {
 			while (k--) {
@@ -171,9 +159,9 @@
 					src = buf;
 				}
 
-				move_unaligned(info, &info->pixmap, dst, pitch,
-					       src, idx, image.height,
-					       shift_high, shift_low, mod);
+				fb_pad_unaligned_buffer(info, dst, pitch, src, idx,
+						image.height, shift_high, shift_low,
+						mod);
 				shift_low += mod;
 				dst += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
@@ -189,8 +177,7 @@
 					src = buf;
 				}
 
-				move_aligned(info, &info->pixmap, dst, pitch,
-					     src, idx, image.height);
+				fb_pad_aligned_buffer(info, dst, pitch, src, idx, image.height);
 				dst += width;
 			}
 		}
@@ -238,12 +225,12 @@
 static void bit_cursor(struct vc_data *vc, struct fb_info *info,
 		       struct display *p, int mode, int fg, int bg)
 {
-	struct fb_cursor cursor;
 	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	struct fb_cursor cursor;
 	char *src;
 
 	cursor.set = 0;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.c fbdev-2.6/drivers/video/console/fbcon.c
--- linus-2.6/drivers/video/console/fbcon.c	2005-02-24 10:39:35.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.c	2005-02-24 09:59:37.000000000 -0800
@@ -507,9 +507,10 @@
 static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 				  int unit, int oldidx)
 {
+	int size = sizeof(struct fbcon_ops) + FBPIXMAPSIZE, err = 0;
 	struct fbcon_ops *ops = NULL;
-	int err = 0;
-
+	char *p;
+	
 	if (!try_module_get(info->fbops->owner))
 		err = -ENODEV;
 
@@ -518,13 +519,15 @@
 		err = -ENODEV;
 
 	if (!err) {
-		ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-		if (!ops)
+		p = kmalloc(size, GFP_KERNEL);
+		if (!p)
 			err = -ENOMEM;
 	}
 
 	if (!err) {
-		memset(ops, 0, sizeof(struct fbcon_ops));
+		memset(p, 0, size);
+		ops = (struct fbcon_ops *) p;
+		ops->scratch_pad = p + sizeof(struct fbcon_ops);
 		info->fbcon_par = ops;
 		set_blitting_type(vc, info, NULL);
 	}
@@ -533,7 +536,6 @@
 		con2fb_map[unit] = oldidx;
 		module_put(info->fbops->owner);
 	}
-
 	return err;
 }
 
@@ -720,17 +722,17 @@
 
 static const char *fbcon_startup(void)
 {
+	int rows, cols, size = sizeof(struct fbcon_ops) + FBPIXMAPSIZE;
 	const char *display_desc = "frame buffer device";
 	struct display *p = &fb_display[fg_console];
 	struct vc_data *vc = vc_cons[fg_console].d;
 	struct font_desc *font = NULL;
-	struct module *owner;
 	struct fb_info *info = NULL;
 	struct fbcon_ops *ops;
-	int rows, cols;
-	int irqres;
+	struct module *owner;
+	int irqres = 1;
+	char *q;
 
-	irqres = 1;
 	/*
 	 *  If num_registered_fb is zero, this is a call for the dummy part.
 	 *  The frame buffer devices weren't initialized yet.
@@ -753,13 +755,15 @@
 		return NULL;
 	}
 
-	ops = kmalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-	if (!ops) {
+	q = kmalloc(size, GFP_KERNEL);
+	if (!q) {
 		module_put(owner);
 		return NULL;
 	}
 
-	memset(ops, 0, sizeof(struct fbcon_ops));
+	memset(q, 0, size);
+	ops = (struct fbcon_ops *) q;
+	ops->scratch_pad = q + sizeof(struct fbcon_ops);
 	ops->currcon = -1;
 	info->fbcon_par = ops;
 	set_blitting_type(vc, info, NULL);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/fbcon.h fbdev-2.6/drivers/video/console/fbcon.h
--- linus-2.6/drivers/video/console/fbcon.h	2005-02-24 10:39:35.000000000 -0800
+++ fbdev-2.6/drivers/video/console/fbcon.h	2005-02-23 16:23:26.000000000 -0800
@@ -48,6 +48,8 @@
     struct fb_videomode *mode;
 };
 
+#define FBPIXMAPSIZE	(1024 * 8)
+
 struct fbcon_ops {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
@@ -67,7 +69,8 @@
 	int    cursor_flash;
 	int    cursor_reset;
 	int    blank_state;
-	char  *cursor_data;
+	char	*cursor_data;
+	char	*scratch_pad;
 };
     /*
      *  Attribute Decoding
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/tileblit.c fbdev-2.6/drivers/video/console/tileblit.c
--- linus-2.6/drivers/video/console/tileblit.c	2005-02-24 10:39:36.000000000 -0800
+++ fbdev-2.6/drivers/video/console/tileblit.c	2005-02-23 17:44:59.000000000 -0800
@@ -56,9 +56,10 @@
 		       const unsigned short *s, int count, int yy, int xx,
 		       int fg, int bg)
 {
-	struct fb_tileblit blit;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	struct fb_pixmap *pad = info->pad;
 	int size = sizeof(u32) * count, i;
+	struct fb_tileblit blit;
 
 	blit.sx = xx;
 	blit.sy = yy;
@@ -67,7 +68,7 @@
 	blit.fg = fg;
 	blit.bg = bg;
 	blit.length = count;
-	blit.indices = (u32 *) fb_get_buffer_offset(info, &info->pixmap, size);
+	blit.indices = (u32 *) fb_get_buffer_offset(info, pad, size);
 	for (i = 0; i < count; i++)
 		blit.indices[i] = (u32)(scr_readw(s++) & charmask);
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2005-01-24 09:43:47.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmem.c	2005-02-23 18:53:35.000000000 -0800
@@ -52,8 +52,6 @@
      *  Frame buffer device initialization and setup routines
      */
 
-#define FBPIXMAPSIZE	(1024 * 8)
-
 static struct notifier_block *fb_notifier_list;
 struct fb_info *registered_fb[FB_MAX];
 int num_registered_fb;
@@ -77,134 +75,6 @@
 }
 EXPORT_SYMBOL(fb_get_color_depth);
 
-/*
- * Drawing helpers.
- */
-void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-			   u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			   u32 height)
-{
-	int i;
-
-	for (i = height; i--; ) {
-		buf->outbuf(info, dst, src, s_pitch);
-		src += s_pitch;
-		dst += d_pitch;
-	}
-}
-
-void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-			    u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			    u32 height)
-{
-	int i, j;
-
-	for (i = height; i--; ) {
-		for (j = 0; j < s_pitch; j++)
-			dst[j] = src[j];
-		src += s_pitch;
-		dst += d_pitch;
-	}
-}
-
-void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-			     u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			     u32 height, u32 shift_high, u32 shift_low,
-			     u32 mod)
-{
-	u8 mask = (u8) (0xfff << shift_high), tmp;
-	int i, j;
-
-	for (i = height; i--; ) {
-		for (j = 0; j < idx; j++) {
-			tmp = buf->inbuf(info, dst+j);
-			tmp &= mask;
-			tmp |= *src >> shift_low;
-			buf->outbuf(info, dst+j, &tmp, 1);
-			tmp = *src << shift_high;
-			buf->outbuf(info, dst+j+1, &tmp, 1);
-			src++;
-		}
-		tmp = buf->inbuf(info, dst+idx);
-		tmp &= mask;
-		tmp |= *src >> shift_low;
-		buf->outbuf(info, dst+idx, &tmp, 1);
-		if (shift_high < mod) {
-			tmp = *src << shift_high;
-			buf->outbuf(info, dst+idx+1, &tmp, 1);
-		}	
-		src++;
-		dst += d_pitch;
-	}
-}
-
-void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-			      u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			      u32 height, u32 shift_high, u32 shift_low,
-			      u32 mod)
-{
-	u8 mask = (u8) (0xfff << shift_high), tmp;
-	int i, j;
-
-	for (i = height; i--; ) {
-		for (j = 0; j < idx; j++) {
-			tmp = dst[j];
-			tmp &= mask;
-			tmp |= *src >> shift_low;
-			dst[j] = tmp;
-			tmp = *src << shift_high;
-			dst[j+1] = tmp;
-			src++;
-		}
-		tmp = dst[idx];
-		tmp &= mask;
-		tmp |= *src >> shift_low;
-		dst[idx] = tmp;
-		if (shift_high < mod) {
-			tmp = *src << shift_high;
-			dst[idx+1] = tmp;
-		}
-		src++;
-		dst += d_pitch;
-	}
-}
-
-/*
- * we need to lock this section since fb_cursor
- * may use fb_imageblit()
- */
-char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size)
-{
-	u32 align = buf->buf_align - 1, offset;
-	char *addr = buf->addr;
-
-	/* If IO mapped, we need to sync before access, no sharing of
-	 * the pixmap is done
-	 */
-	if (buf->flags & FB_PIXMAP_IO) {
-		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
-			info->fbops->fb_sync(info);
-		return addr;
-	}
-
-	/* See if we fit in the remaining pixmap space */
-	offset = buf->offset + align;
-	offset &= ~align;
-	if (offset + size > buf->size) {
-		/* We do not fit. In order to be able to re-use the buffer,
-		 * we must ensure no asynchronous DMA'ing or whatever operation
-		 * is in progress, we sync for that.
-		 */
-		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
-			info->fbops->fb_sync(info);
-		offset = 0;
-	}
-	buf->offset = offset + size;
-	addr += offset;
-
-	return addr;
-}
-
 #ifdef CONFIG_LOGO
 #include <linux/linux_logo.h>
 
@@ -1075,18 +945,8 @@
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
 	}
-	
-	if (fb_info->pixmap.addr == NULL) {
-		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
-		if (fb_info->pixmap.addr) {
-			fb_info->pixmap.size = FBPIXMAPSIZE;
-			fb_info->pixmap.buf_align = 1;
-			fb_info->pixmap.scan_align = 1;
-			fb_info->pixmap.access_align = 4;
-			fb_info->pixmap.flags = FB_PIXMAP_DEFAULT;
-		}
-	}	
-	fb_info->pixmap.offset = 0;
+
+	fb_init_resources(fb_info);
 
 	if (!fb_info->modelist.prev ||
 	    !fb_info->modelist.next ||
@@ -1128,9 +988,7 @@
 	if (!registered_fb[i])
 		return -EINVAL;
 	devfs_remove("fb/%d", i);
-
-	if (fb_info->pixmap.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
-		kfree(fb_info->pixmap.addr);
+	fb_release_resources(&fb_info->resources);
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
@@ -1308,11 +1166,6 @@
 EXPORT_SYMBOL(fb_set_var);
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
-EXPORT_SYMBOL(fb_get_buffer_offset);
-EXPORT_SYMBOL(fb_iomove_buf_unaligned);
-EXPORT_SYMBOL(fb_iomove_buf_aligned);
-EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
-EXPORT_SYMBOL(fb_sysmove_buf_aligned);
 EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_accel.c fbdev-2.6/drivers/video/i810/i810_accel.c
--- linus-2.6/drivers/video/i810/i810_accel.c	2005-02-24 10:39:36.000000000 -0800
+++ fbdev-2.6/drivers/video/i810/i810_accel.c	2005-02-24 09:07:12.000000000 -0800
@@ -74,7 +74,7 @@
 	printk("ringbuffer lockup!!!\n");
 	i810_report_error(mmio); 
 	par->dev_flags |= LOCKUP;
-	info->pixmap.scan_align = 1;
+	info->pad->scan_align = 1;
 	return 1;
 }
 
@@ -102,7 +102,7 @@
 	printk("INSTDONE: 0x%04x\n", i810_readl(INSTDONE, mmio));
 	i810_report_error(mmio); 
 	par->dev_flags |= LOCKUP;
-	info->pixmap.scan_align = 1;
+	info->pad->scan_align = 1;
 	return 1;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_main.c fbdev-2.6/drivers/video/i810/i810_main.c
--- linus-2.6/drivers/video/i810/i810_main.c	2005-02-24 10:39:37.000000000 -0800
+++ fbdev-2.6/drivers/video/i810/i810_main.c	2005-02-24 09:06:25.000000000 -0800
@@ -1374,9 +1374,9 @@
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
 		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
 		FBINFO_HWACCEL_IMAGEBLIT;
-		info->pixmap.scan_align = 2;
+		info->pad->scan_align = 2;
 	} else {
-		info->pixmap.scan_align = 1;
+		info->pad->scan_align = 1;
 		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	}
 	return 0;
@@ -1867,15 +1867,6 @@
 	par = (struct i810fb_par *) info->par;
 	par->dev = dev;
 
-	if (!(info->pixmap.addr = kmalloc(8*1024, GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
-		return -ENOMEM;
-	}
-	memset(info->pixmap.addr, 0, 8*1024);
-	info->pixmap.size = 8*1024;
-	info->pixmap.buf_align = 8;
-	info->pixmap.flags = FB_PIXMAP_SYSTEM;
-
 	if ((err = i810_allocate_pci_resource(par, entry))) {
 		i810fb_release_resource(info, par);
 		return err;
@@ -1909,6 +1900,9 @@
     		return err;  
     	}   
 
+	info->pad->buf_align = 8;
+	info->pad->flags = FB_PIXMAP_SYSTEM;
+
 	pci_set_drvdata(dev, info);
 	pixclock = 1000000000/(info->var.pixclock);
 	pixclock *= 1000;
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbdrv.c fbdev-2.6/drivers/video/intelfb/intelfbdrv.c
--- linus-2.6/drivers/video/intelfb/intelfbdrv.c	2005-02-24 10:39:37.000000000 -0800
+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c	2005-02-24 09:14:51.000000000 -0800
@@ -419,7 +419,6 @@
 		return;
 
 	fb_dealloc_cmap(&dinfo->info->cmap);
-	kfree(dinfo->info->pixmap.addr);
 
 	if (dinfo->registered)
 		unregister_framebuffer(dinfo->info);
@@ -496,14 +495,6 @@
 	dinfo->fbops = &intel_fb_ops;
 	dinfo->pdev  = pdev;
 
-	/* Reserve pixmap space. */
-	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
-	if (info->pixmap.addr == NULL) {
-		ERR_MSG("Cannot reserve pixmap memory.\n");
-		goto err_out_pixmap;
-	}
-	memset(info->pixmap.addr, 0, 64 * 1024);
-
 	/* set early this option because it could be changed by tv encoder
 	   driver */
 	dinfo->fixed_mode = fixed;
@@ -843,12 +834,12 @@
 		return -ENODEV;
 	}
 
+	info->pad->buf_align = 8;
+	info->pad->scan_align = 1;
+	info->pad->flags = FB_PIXMAP_SYSTEM;
 	dinfo->registered = 1;
-
 	return 0;
 
-err_out_pixmap:
-	fb_dealloc_cmap(&info->cmap);
 err_out_cmap:
 	framebuffer_release(info);
 	return -ENODEV;
@@ -1039,17 +1030,10 @@
 	info->fbops = &intel_fb_ops;
 	info->pseudo_palette = dinfo->pseudo_palette;
 
-	info->pixmap.size = 64*1024;
-	info->pixmap.buf_align = 8;
-	info->pixmap.flags = FB_PIXMAP_SYSTEM;
-
 	if (intelfb_init_var(dinfo))
 		return 1;
 
-	info->pixmap.scan_align = 1;
-
 	update_dinfo(dinfo, &info->var);
-
 	return 0;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/neofb.c fbdev-2.6/drivers/video/neofb.c
--- linus-2.6/drivers/video/neofb.c	2005-02-24 10:39:33.000000000 -0800
+++ fbdev-2.6/drivers/video/neofb.c	2005-02-23 15:47:45.000000000 -0800
@@ -1474,8 +1474,9 @@
 {
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	int s_pitch = (image->width * image->depth + 7) >> 3;
-	int scan_align = info->pixmap.scan_align - 1;
-	int buf_align = info->pixmap.buf_align - 1;
+	struct fb_pixmap *pad = info->pad;
+	int scan_align = pad->scan_align - 1;
+	int buf_align = pad->buf_align - 1;
 	int bltCntl_flags, d_pitch, data_len;
 
 	// The data is padded for the hardware
@@ -1728,8 +1729,6 @@
 static int __devinit neo_map_video(struct fb_info *info,
 				   struct pci_dev *dev, int video_len)
 {
-	//unsigned long addr;
-
 	DBG("neo_map_video");
 
 	info->fix.smem_start = pci_resource_start(dev, 0);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/resmgt.c fbdev-2.6/drivers/video/resmgt.c
--- linus-2.6/drivers/video/resmgt.c	1969-12-31 16:00:00.000000000 -0800
+++ fbdev-2.6/drivers/video/resmgt.c	2005-02-24 09:56:53.000000000 -0800
@@ -0,0 +1,213 @@
+/*
+ *  linux/drivers/video/resmgt.c -- Manages the resources of a graphics card. 
+ *
+ *	Copyright (C) 2005 James Simmons <jsimmons@www.infradead.org>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/fb.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DPRINTK(fmt, args...)	printk("modedb %s: " fmt, __FUNCTION__ , ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#define FBPIXMAPSIZE	(1024 * 8)
+
+/*
+ * Data padding functions.
+ */
+void fb_pad_aligned_buffer(struct fb_info *info, u8 *dst, u32 d_pitch, 
+			   u8 *src, u32 s_pitch, u32 height)
+{
+	int i, j;
+
+	for (i = height; i--; ) {
+		for (j = 0; j < s_pitch; j++)
+			dst[j] = src[j];
+		src += s_pitch;
+		dst += d_pitch;
+	}
+}
+EXPORT_SYMBOL(fb_pad_aligned_buffer);
+
+void fb_pad_unaligned_buffer(struct fb_info *info, u8 *dst, u32 d_pitch,
+				u8 *src, u32 idx, u32 height, 
+				u32 shift_high, u32 shift_low, u32 mod)
+{
+	u8 mask = (u8) (0xfff << shift_high), tmp;
+	int i, j;
+
+	for (i = height; i--; ) {
+		for (j = 0; j < idx; j++) {
+			tmp = dst[j];
+			tmp &= mask;
+			tmp |= *src >> shift_low;
+			dst[j] = tmp;
+			tmp = *src << shift_high;
+			dst[j+1] = tmp;
+			src++;
+		}
+		tmp = dst[idx];
+		tmp &= mask;
+		tmp |= *src >> shift_low;
+		dst[idx] = tmp;
+		if (shift_high < mod) {
+			tmp = *src << shift_high;
+			dst[idx+1] = tmp;
+		}
+		src++;
+		dst += d_pitch;
+	}
+}
+EXPORT_SYMBOL(fb_pad_unaligned_buffer);
+
+/*
+ * we need to lock this section since fb_cursor
+ * may use fb_imageblit()
+ */
+char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size)
+{
+	u32 align = buf->buf_align - 1, offset;
+	char *addr = buf->addr;
+
+	/* If IO mapped, we need to sync before access, no sharing of
+	 * the pixmap is done
+	 */
+	if (buf->flags & FB_PIXMAP_IO) {
+		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
+			info->fbops->fb_sync(info);
+		return addr;
+	}
+
+	/* See if we fit in the remaining pixmap space */
+	offset = buf->offset + align;
+	offset &= ~align;
+	if (offset + size > buf->size) {
+		/* We do not fit. In order to be able to re-use the buffer,
+		 * we must ensure no asynchronous DMA'ing or whatever operation
+		 * is in progress, we sync for that.
+		 */
+		if (info->fbops->fb_sync && (buf->flags & FB_PIXMAP_SYNC))
+			info->fbops->fb_sync(info);
+		offset = 0;
+	}
+	buf->offset = offset + size;
+	addr += offset;
+	return addr;
+}
+EXPORT_SYMBOL(fb_get_buffer_offset);
+
+struct graphics_resource {
+	struct fb_pixmap *resource;
+	struct list_head list;
+};
+
+struct fb_pixmap * fb_find_resource(const char *name, struct list_head *head)
+{
+	struct graphics_resource *rlist = NULL;
+	struct fb_pixmap *resource;
+	struct list_head *pos;
+
+	list_for_each(pos, head) {
+		rlist = list_entry(pos, struct graphics_resource, list);
+		resource = rlist->resource;
+		if (!strncmp(resource->name, name, strlen(name)))
+			return rlist->resource;
+	}
+	return NULL;
+}
+
+int fb_add_resource(struct fb_pixmap *res, struct list_head *head)
+{
+	struct fb_pixmap *resource = fb_find_resource(res->name, head);
+	struct graphics_resource *rlist = NULL;
+
+	if (resource)
+		return 1;
+	rlist = kmalloc(sizeof(struct graphics_resource), GFP_KERNEL);
+	if (!rlist)
+		return -ENOMEM;
+	rlist->resource = res;
+	list_add(&rlist->list, head);
+	return 0;
+}
+
+int fb_remove_resource(struct fb_pixmap *resource, struct list_head *head)
+{
+	struct graphics_resource *rlist;
+	struct list_head *pos, *n;
+
+	if (!resource)
+		return 0;
+
+	list_for_each_safe(pos, n, head) {
+		rlist = list_entry(pos, struct graphics_resource, list);
+		if (!strncmp(resource->name, rlist->resource->name, strlen(rlist->resource->name))) {
+			if (rlist->resource->addr && (rlist->resource->flags & FB_PIXMAP_DEFAULT))
+				kfree(rlist->resource->addr);
+			kfree(rlist->resource);
+			list_del(pos);
+			kfree(pos);
+		}
+	}
+	return 0;
+}
+
+int fb_init_resources(struct fb_info *info)
+{
+	struct fb_pixmap *pad;
+	char *p;
+
+	if (!info->resources.prev || !info->resources.next ||
+	    list_empty(&info->resources))
+		INIT_LIST_HEAD(&info->resources);
+
+	// First we create our drawing pad
+	pad = fb_find_resource("drawable", &info->resources);
+	if (!pad) {
+		// Next we create our drawing pad.
+		p = kmalloc(sizeof(struct fb_pixmap), GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		memset(p, 0, sizeof(struct fb_pixmap));
+
+		pad = (struct fb_pixmap *) p;
+		strcpy(pad->name, "drawable");
+		pad->addr = info->screen_base;
+		if (info->screen_size)
+			pad->size = info->screen_size;
+		else
+			pad->size = info->fix.smem_len;
+		pad->buf_align = 1;
+		pad->scan_align = 1;
+		pad->access_align = 4;
+		pad->flags = FB_PIXMAP_IO;
+		pad->offset = 0;
+		fb_add_resource(pad, &info->resources);
+	}
+	info->pad = pad;
+	return 0;
+}
+
+void fb_release_resources(struct list_head *head)
+{
+	struct graphics_resource *rlist;
+	struct list_head *pos, *n;
+	
+	list_for_each_safe(pos, n, head) {
+		rlist = list_entry(pos, struct graphics_resource, list);
+		if (rlist->resource->addr && (rlist->resource->flags & FB_PIXMAP_DEFAULT))
+			kfree(rlist->resource->addr);
+		kfree(rlist->resource);
+		list_del(pos);
+		kfree(pos);
+	}
+}
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/riva/fbdev.c fbdev-2.6/drivers/video/riva/fbdev.c
--- linus-2.6/drivers/video/riva/fbdev.c	2005-02-24 10:39:38.000000000 -0800
+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-02-24 08:36:43.000000000 -0800
@@ -1167,6 +1167,7 @@
 static int rivafb_set_par(struct fb_info *info)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
+	struct fb_pixmap *pad = info->pad;
 
 	NVTRACE_ENTER();
 	/* vgaHWunlock() + riva unlock (0x7F) */
@@ -1182,9 +1183,9 @@
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 	if (info->flags & FBINFO_HWACCEL_DISABLED)
-		info->pixmap.scan_align = 1;
+		pad->scan_align = 1;
 	else
-		info->pixmap.scan_align = 4;
+		pad->scan_align = 4;
 	NVTRACE_LEAVE();
 	return 0;
 }
@@ -1581,12 +1582,12 @@
 static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
+	struct fb_pixmap *pad = info->pad;
 	u8 data[MAX_CURS * MAX_CURS/8];
-	u16 fg, bg;
 	int i, set = cursor->set;
+	u16 fg, bg;
 
-	if (cursor->image.width > MAX_CURS ||
-	    cursor->image.height > MAX_CURS)
+	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
 		return soft_cursor(info, cursor);
 
 	par->riva.ShowHideCursor(&par->riva, 0);
@@ -1637,9 +1638,8 @@
 				break;
 			}
 
-			fb_sysmove_buf_aligned(info, &info->pixmap, data,
-					       d_pitch, src, s_pitch,
-					       cursor->image.height);
+			fb_sysmove_buf_aligned(info, pad, data, d_pitch, 
+						src, s_pitch, cursor->image.height);
 
 			bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 				((info->cmap.green[bg_idx] & 0xf8) << 2) |
@@ -1725,10 +1725,6 @@
 
 	cmap_len = riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);	
-
-	info->pixmap.size = 8 * 1024;
-	info->pixmap.buf_align = 4;
-	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 	info->var.yres_virtual = -1;
 	NVTRACE_LEAVE();
 	return (rivafb_check_var(&info->var, info));
@@ -1916,17 +1912,10 @@
 	default_par = (struct riva_par *) info->par;
 	default_par->pdev = pd;
 
-	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
-	if (info->pixmap.addr == NULL) {
-	    	ret = -ENOMEM;
-		goto err_framebuffer_release;
-	}
-	memset(info->pixmap.addr, 0, 8 * 1024);
-
 	ret = pci_enable_device(pd);
 	if (ret < 0) {
 		printk(KERN_ERR PFX "cannot enable PCI device\n");
-		goto err_free_pixmap;
+		goto err_framebuffer_release;
 	}
 
 	ret = pci_request_regions(pd, "rivafb");
@@ -2062,6 +2051,15 @@
 
 	pci_set_drvdata(pd, info);
 
+	/*
+	 * We have special needs for writing to the framebuffer.
+	 * register_framebuffer already created this structure so 
+	 * we can the default values.
+	 */
+	info->pad->buf_align = 4;
+	info->pad->scan_align = 4;
+	info->pad->access_align = 4;
+
 	printk(KERN_INFO PFX
 		"PCI nVidia %s framebuffer ver %s (%dMB @ 0x%lX)\n",
 		info->fix.id,
@@ -2090,8 +2088,6 @@
 	pci_release_regions(pd);
 err_disable_device:
 	pci_disable_device(pd);
-err_free_pixmap:
-	kfree(info->pixmap.addr);
 err_framebuffer_release:
 	framebuffer_release(info);
 err_ret:
@@ -2126,7 +2122,7 @@
 		iounmap(par->riva.PRAMIN);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
-	kfree(info->pixmap.addr);
+	fb_release_resources(&info->resources);
 	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/savage/savagefb.c fbdev-2.6/drivers/video/savage/savagefb.c
--- linus-2.6/drivers/video/savage/savagefb.c	2005-02-24 10:39:39.000000000 -0800
+++ fbdev-2.6/drivers/video/savage/savagefb.c	2005-02-24 08:48:19.000000000 -0800
@@ -687,6 +687,18 @@
 
 	DBG("savagefb_check_var");
 
+#if defined(CONFIG_FB_SAVAGE_ACCEL)
+	/*
+	 * The clipping coordinates are masked with 0xFFF, so limit our
+	 * virtual resolutions to these sizes.
+	 */
+	if (info->var.yres_virtual > 0x1000)
+		info->var.yres_virtual = 0x1000;
+
+	if (info->var.xres_virtual > 0x1000)
+		info->var.xres_virtual = 0x1000;
+#endif
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
@@ -1779,7 +1791,7 @@
 	return videoRambytes;
 }
 
-static int __devinit savage_init_fb_info (struct fb_info *info,
+static void __devinit savage_init_fb_info (struct fb_info *info,
 					  struct pci_dev *dev,
 					  const struct pci_device_id *id)
 {
@@ -1883,27 +1895,7 @@
 	                       FBINFO_MISC_MODESWITCHLATE;
 
 	info->pseudo_palette = par->pseudo_palette;
-
-#if defined(CONFIG_FB_SAVAGE_ACCEL)
-	/* FIFO size + padding for commands */
-	info->pixmap.addr = kmalloc(8*1024, GFP_KERNEL);
-
-	err = -ENOMEM;
-	if (info->pixmap.addr) {
-		memset(info->pixmap.addr, 0, 8*1024);
-		info->pixmap.size = 8*1024;
-		info->pixmap.scan_align = 4;
-		info->pixmap.buf_align = 4;
-		info->pixmap.access_align = 4;
-
-		fb_alloc_cmap (&info->cmap, NR_PALETTE, 0);
-		info->flags |= FBINFO_HWACCEL_COPYAREA |
-	                       FBINFO_HWACCEL_FILLRECT |
-		               FBINFO_HWACCEL_IMAGEBLIT;
-
-		err = 0;
-	}
-#endif
+	fb_alloc_cmap (&info->cmap, NR_PALETTE, 0);
 	return err;
 }
 
@@ -1936,8 +1928,7 @@
 
 	err = -ENOMEM;
 
-	if (savage_init_fb_info(info, dev, id))
-		goto failed_init;
+	savage_init_fb_info(info, dev, id);
 
 	err = savage_map_mmio(info);
 	if (err)
@@ -1996,17 +1987,6 @@
 	if (info->var.yres_virtual < info->var.yres)
 		goto failed;
 
-#if defined(CONFIG_FB_SAVAGE_ACCEL)
-	/*
-	 * The clipping coordinates are masked with 0xFFF, so limit our
-	 * virtual resolutions to these sizes.
-	 */
-	if (info->var.yres_virtual > 0x1000)
-		info->var.yres_virtual = 0x1000;
-
-	if (info->var.xres_virtual > 0x1000)
-		info->var.xres_virtual = 0x1000;
-#endif
 	savagefb_check_var(&info->var, info);
 	savagefb_set_fix(info);
 
@@ -2037,6 +2017,16 @@
 	if (err < 0)
 		goto failed;
 
+#if defined(CONFIG_FB_SAVAGE_ACCEL)
+	/* FIFO size + padding for commands */
+	info->pad->scan_align = 4;
+	info->pad->buf_align = 4;
+	info->pad->access_align = 4;
+
+	info->flags |=	FBINFO_HWACCEL_COPYAREA |
+			FBINFO_HWACCEL_FILLRECT |
+			FBINFO_HWACCEL_IMAGEBLIT;
+#endif
 	printk (KERN_INFO "fb: S3 %s frame buffer device\n",
 		info->fix.id);
 
@@ -2051,17 +2041,14 @@
 #ifdef CONFIG_FB_SAVAGE_I2C
 	savagefb_delete_i2c_busses(info);
 #endif
-	fb_alloc_cmap (&info->cmap, 0, 0);
+	fb_dealloc_cmap(&info->cmap);
 	savage_unmap_video(info);
  failed_video:
 	savage_unmap_mmio (info);
  failed_mmio:
-	kfree(info->pixmap.addr);
- failed_init:
 	pci_release_regions(dev);
  failed_enable:
 	framebuffer_release(info);
-
 	return err;
 }
 
@@ -2085,10 +2072,9 @@
 #ifdef CONFIG_FB_SAVAGE_I2C
 		savagefb_delete_i2c_busses(info);
 #endif
-		fb_alloc_cmap (&info->cmap, 0, 0);
+		fb_dealloc_cmap(&info->cmap);
 		savage_unmap_video (info);
 		savage_unmap_mmio (info);
-		kfree(info->pixmap.addr);
 		pci_release_regions(dev);
 		framebuffer_release(info);
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/softcursor.c fbdev-2.6/drivers/video/softcursor.c
--- linus-2.6/drivers/video/softcursor.c	2005-02-24 10:39:34.000000000 -0800
+++ fbdev-2.6/drivers/video/softcursor.c	2005-02-24 09:58:43.000000000 -0800
@@ -19,8 +19,9 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
+	struct fb_pixmap *pad = info->pad;
+	unsigned int scan_align = pad->scan_align - 1;
+	unsigned int buf_align = pad->buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
 	struct fb_image *image;
 	u8 *dst, *src;
@@ -41,7 +42,7 @@
 
 	size = d_pitch * image->height + buf_align;
 	size &= ~buf_align;
-	dst = fb_get_buffer_offset(info, &info->pixmap, size);
+	dst = fb_get_buffer_offset(info, pad, size);
 
 	if (cursor->enable) {
 		switch (cursor->rop) {
@@ -57,18 +58,11 @@
 		}
 	} else 
 		memcpy(src, image->data, dsize);
-	
-	if (info->pixmap.outbuf)
-		fb_iomove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
-				  s_pitch, image->height);
-	else
-		fb_sysmove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
-				   s_pitch, image->height);
 
+	fb_pad_aligned_buffer(info, dst, d_pitch, src, s_pitch, image->height);
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
 	kfree(src);
-
 	return 0;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2005-02-24 10:41:22.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2005-02-24 09:58:13.000000000 -0800
@@ -514,6 +514,7 @@
 #define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
 
 struct fb_pixmap {
+	char name[16];		/* Name of the resource			*/
 	u8  *addr;		/* pointer to memory			*/
 	u32 size;		/* size of buffer in bytes		*/
 	u32 offset;		/* current offset to buffer		*/
@@ -523,7 +524,7 @@
 	u32 flags;		/* see FB_PIXMAP_*			*/
 	/* access methods */
 	void (*outbuf)(struct fb_info *info, u8 *addr, u8 *src, unsigned int size);
-	u8   (*inbuf) (struct fb_info *info, u8 *addr);
+	u8*  (*inbuf) (struct fb_info *info, u8 *addr, unsigned int size);
 };
 
 
@@ -707,11 +708,12 @@
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
+	struct list_head resources;	/* Graphics resources */
+	struct list_head modelist;      /* mode list */
 	struct work_struct queue;	/* Framebuffer event queue */
-	struct fb_pixmap pixmap;	/* Image hardware mapper */
-	struct fb_pixmap sprite;	/* Cursor hardware mapper */
+	struct fb_pixmap *sprite;	/* Cursor hardware mapper */
+	struct fb_pixmap *pad;		/* Image hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
-	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
 	struct device *device;
 #ifdef CONFIG_FB_TILEBLITTING
@@ -807,19 +809,6 @@
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
-extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
-extern void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-				u32 height, u32 shift_high, u32 shift_low, u32 mod);
-extern void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-				u32 height);
-extern void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-				u32 height, u32 shift_high, u32 shift_low, u32 mod);
-extern void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-				u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_info *info);
 extern int fb_get_options(char *name, char **option);
@@ -827,6 +816,19 @@
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
+/* drivers/video/resmgt.c */
+extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
+extern void fb_pad_unaligned_buffer(struct fb_info *info, u8 *dst, u32 d_pitch,
+				u8 *src, u32 idx, u32 height, u32 shift_high, 
+				u32 shift_low, u32 mod);
+extern void fb_pad_aligned_buffer(struct fb_info *info, u8 *dst, u32 d_pitch,
+				u8 *src, u32 s_pitch, u32 height);
+void fb_release_resources(struct list_head *head);
+int fb_remove_resource(struct fb_pixmap *resource, struct list_head *head);
+int fb_add_resource(struct fb_pixmap *resource, struct list_head *head);
+struct fb_pixmap* fb_find_resource(const char *name, struct list_head *head);
+int fb_init_resources(struct fb_info *info);
+
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
