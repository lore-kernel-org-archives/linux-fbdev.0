From: James Simmons <jsimmons@www.infradead.org>
Subject: Resource management.
Date: Mon, 21 Feb 2005 19:11:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3Ixp-0005nG-LS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:11:25 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D3Ixn-0006XG-GJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:11:25 -0800
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

   This is my first run at the resource management code. Comments are 
welcomed :-)

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/Makefile fbdev-2.6/drivers/video/Makefile
--- linus-2.6/drivers/video/Makefile	2005-02-21 10:38:42.000000000 -0800
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
--- linus-2.6/drivers/video/console/bitblit.c	2005-02-21 10:38:47.000000000 -0800
+++ fbdev-2.6/drivers/video/console/bitblit.c	2005-02-18 10:35:23.000000000 -0800
@@ -114,12 +114,13 @@
 	void (*move_aligned)(struct fb_info *info, struct fb_pixmap *buf,
 			     u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 			     u32 height);
+	struct fb_pixmap *pad = fb_find_resource("scratchpad", &info->resources);
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width = (vc->vc_font.width + 7) >> 3;
 	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int maxcnt = pad->size/cellsize;
+	unsigned int scan_align = pad->scan_align - 1;
+	unsigned int buf_align = pad->buf_align - 1;
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
 	unsigned int shift_high = 8, pitch, cnt, size, k;
 	unsigned int idx = vc->vc_font.width >> 3;
@@ -141,7 +142,7 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (info->pixmap.outbuf && info->pixmap.inbuf) {
+	if (pad->outbuf && pad->inbuf) {
 		move_aligned = fb_iomove_buf_aligned;
 		move_unaligned = fb_iomove_buf_unaligned;
 	} else {
@@ -159,7 +160,7 @@
 		pitch &= ~scan_align;
 		size = pitch * image.height + buf_align;
 		size &= ~buf_align;
-		dst = fb_get_buffer_offset(info, &info->pixmap, size);
+		dst = fb_get_buffer_offset(info, pad, size);
 		image.data = dst;
 		if (mod) {
 			while (k--) {
@@ -171,9 +172,9 @@
 					src = buf;
 				}
 
-				move_unaligned(info, &info->pixmap, dst, pitch,
-					       src, idx, image.height,
-					       shift_high, shift_low, mod);
+				move_unaligned(info, pad, dst, pitch, src, idx,
+						image.height, shift_high, shift_low,
+						mod);
 				shift_low += mod;
 				dst += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
@@ -189,8 +190,7 @@
 					src = buf;
 				}
 
-				move_aligned(info, &info->pixmap, dst, pitch,
-					     src, idx, image.height);
+				move_aligned(info, pad, dst, pitch, src, idx, image.height);
 				dst += width;
 			}
 		}
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/console/tileblit.c fbdev-2.6/drivers/video/console/tileblit.c
--- linus-2.6/drivers/video/console/tileblit.c	2005-02-21 10:38:47.000000000 -0800
+++ fbdev-2.6/drivers/video/console/tileblit.c	2005-02-18 10:35:42.000000000 -0800
@@ -56,9 +56,10 @@
 		       const unsigned short *s, int count, int yy, int xx,
 		       int fg, int bg)
 {
-	struct fb_tileblit blit;
+	struct fb_pixmap *pad = fb_find_resource("scratchpad", &info->resources);
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
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
+++ fbdev-2.6/drivers/video/fbmem.c	2005-02-21 10:31:38.000000000 -0800
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
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/neofb.c fbdev-2.6/drivers/video/neofb.c
--- linus-2.6/drivers/video/neofb.c	2005-02-21 10:38:44.000000000 -0800
+++ fbdev-2.6/drivers/video/neofb.c	2005-02-18 14:55:58.000000000 -0800
@@ -1472,10 +1472,11 @@
 static void
 neo2200_imageblit(struct fb_info *info, const struct fb_image *image)
 {
+	struct fb_pixmap *pad = fb_find_resource("drawable", &info->resources);
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	int s_pitch = (image->width * image->depth + 7) >> 3;
-	int scan_align = info->pixmap.scan_align - 1;
-	int buf_align = info->pixmap.buf_align - 1;
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
+++ fbdev-2.6/drivers/video/resmgt.c	2005-02-18 12:23:43.000000000 -0800
@@ -0,0 +1,279 @@
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
+void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+			    u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+			    u32 height)
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
+EXPORT_SYMBOL(fb_sysmove_buf_aligned);
+
+void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+			      u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
+			      u32 shift_high, u32 shift_low, u32 mod)
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
+EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
+
+void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *pad,
+			   u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,		
+			   u32 height)
+{
+	int i;
+
+	for (i = height; i--; ) {
+		pad->outbuf(info, dst, src, s_pitch);
+		src += s_pitch;
+		dst += d_pitch;
+	}
+}
+EXPORT_SYMBOL(fb_iomove_buf_aligned);
+
+void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *pad,
+			     u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
+			     u32 shift_high, u32 shift_low, u32 mod)
+{
+	u8 mask = (u8) (0xfff << shift_high), tmp;
+	u8 __iomem *buf;
+	int i, j;
+
+	for (i = height; i--; ) {
+		for (j = 0; j < idx; j++) {
+			buf = pad->inbuf(info, dst+j, 1);
+			tmp = *buf;
+			tmp &= mask;
+			tmp |= *src >> shift_low;
+			pad->outbuf(info, dst+j, &tmp, 1);
+			tmp = *src << shift_high;
+			pad->outbuf(info, dst+j+1, &tmp, 1);
+			src++;
+		}
+		buf = pad->inbuf(info, dst+idx, 1);
+		tmp = *buf;
+		tmp &= mask;
+		tmp |= *src >> shift_low;
+		pad->outbuf(info, dst+idx, &tmp, 1);
+		if (shift_high < mod) {
+			tmp = *src << shift_high;
+			pad->outbuf(info, dst+idx+1, &tmp, 1);
+		}
+		src++;
+		dst += d_pitch;
+	}
+}
+EXPORT_SYMBOL(fb_iomove_buf_unaligned);
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
+	int size = sizeof(struct fb_pixmap) + FBPIXMAPSIZE;
+	struct fb_pixmap *pad, *buf;
+	char *p;
+
+	if (!info->resources.prev || !info->resources.next ||
+	    list_empty(&info->resources))
+		INIT_LIST_HEAD(&info->resources);
+
+	// First we create our drawing pad
+	pad = fb_find_resource("scratchpad", &info->resources);
+	if (!pad) {
+		// Next we create our scratch pad.
+		p = kmalloc(size, GFP_KERNEL);
+		if (!p)
+			return -ENOMEM;
+		memset(p, 0, size);
+		
+		pad = (struct fb_pixmap *) p;
+		pad->addr = p + sizeof(struct fb_pixmap);
+		strcpy(pad->name, "scratchpad");
+		pad->size = FBPIXMAPSIZE;
+		pad->buf_align = 1;
+		pad->scan_align = 1;
+		pad->access_align = 4;
+		pad->flags = FB_PIXMAP_DEFAULT;
+		pad->offset = 0;
+		fb_add_resource(pad, &info->resources);
+	}
+	// Now we create the framebuffer drawable surface
+	p = kmalloc(sizeof(struct fb_pixmap), GFP_KERNEL);
+	if (!p) {
+		fb_remove_resource(pad, &info->resources);
+		return -ENOMEM;
+	}
+	memset(p, 0, sizeof(struct fb_pixmap));
+	buf = (struct fb_pixmap *) p;
+	strcpy(buf->name, "drawable");
+	buf->addr = info->screen_base;
+	if (info->screen_size)
+		buf->size = info->screen_size;
+	else
+		buf->size = info->fix.smem_len;
+	buf->buf_align = pad->buf_align;
+	buf->scan_align = pad->scan_align;
+	buf->access_align = pad->access_align;
+	buf->flags = FB_PIXMAP_IO;
+	buf->offset = 0;
+	fb_add_resource(buf, &info->resources);
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
--- linus-2.6/drivers/video/riva/fbdev.c	2005-02-21 10:38:49.000000000 -0800
+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-02-21 09:22:04.000000000 -0800
@@ -1166,6 +1166,7 @@
 
 static int rivafb_set_par(struct fb_info *info)
 {
+	struct fb_pixmap *pad = fb_find_resource("scratchpad", &info->resources);
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
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
@@ -1580,6 +1581,7 @@
  */
 static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
+	struct fb_pixmap *pad = fb_find_resource("scratchpad", &info->resources);
 	struct riva_par *par = (struct riva_par *) info->par;
 	u8 data[MAX_CURS * MAX_CURS/8];
 	u16 fg, bg;
@@ -1637,9 +1639,8 @@
 				break;
 			}
 
-			fb_sysmove_buf_aligned(info, &info->pixmap, data,
-					       d_pitch, src, s_pitch,
-					       cursor->image.height);
+			fb_sysmove_buf_aligned(info, pad, data, d_pitch, 
+						src, s_pitch, cursor->image.height);
 
 			bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 				((info->cmap.green[bg_idx] & 0xf8) << 2) |
@@ -1725,10 +1726,6 @@
 
 	cmap_len = riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);	
-
-	info->pixmap.size = 8 * 1024;
-	info->pixmap.buf_align = 4;
-	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 	info->var.yres_virtual = -1;
 	NVTRACE_LEAVE();
 	return (rivafb_check_var(&info->var, info));
@@ -1901,8 +1898,10 @@
 			     	const struct pci_device_id *ent)
 {
 	struct riva_par *default_par;
+	struct fb_pixmap *pad;
 	struct fb_info *info;
-	int ret;
+	int size, ret;
+	char *p;
 
 	NVTRACE_ENTER();
 	assert(pd != NULL);
@@ -1916,12 +1915,25 @@
 	default_par = (struct riva_par *) info->par;
 	default_par->pdev = pd;
 
-	info->pixmap.addr = kmalloc(8 * 1024, GFP_KERNEL);
-	if (info->pixmap.addr == NULL) {
+	// We have special needs for writing to the framebuffer.
+	INIT_LIST_HEAD(&info->resources);
+	size = sizeof(struct fb_pixmap) + 1024*8;
+	p = kmalloc(size, GFP_KERNEL);
+	if (!p) {
 	    	ret = -ENOMEM;
 		goto err_framebuffer_release;
 	}
-	memset(info->pixmap.addr, 0, 8 * 1024);
+	memset(p, 0, size);
+	pad = (struct fb_pixmap *) p;
+	pad->addr = p + sizeof(struct fb_pixmap);
+	strcpy(pad->name, "scratchpad");
+	pad->size = 8*1024;
+	pad->buf_align = 4;
+	pad->scan_align = 1;
+	pad->access_align = 4;
+	pad->flags = FB_PIXMAP_DEFAULT;
+	pad->offset = 0;
+	fb_add_resource(pad, &info->resources);
 
 	ret = pci_enable_device(pd);
 	if (ret < 0) {
@@ -2091,7 +2103,7 @@
 err_disable_device:
 	pci_disable_device(pd);
 err_free_pixmap:
-	kfree(info->pixmap.addr);
+	fb_add_resource(pad, &info->resources);
 err_framebuffer_release:
 	framebuffer_release(info);
 err_ret:
@@ -2126,7 +2138,7 @@
 		iounmap(par->riva.PRAMIN);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
-	kfree(info->pixmap.addr);
+	fb_release_resources(&info->resources);
 	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/softcursor.c fbdev-2.6/drivers/video/softcursor.c
--- linus-2.6/drivers/video/softcursor.c	2005-02-21 10:38:44.000000000 -0800
+++ fbdev-2.6/drivers/video/softcursor.c	2005-02-18 10:57:01.000000000 -0800
@@ -19,8 +19,9 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
+	struct fb_pixmap *pad = fb_find_resource("scratchpad", &info->resources);
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
@@ -57,18 +58,16 @@
 		}
 	} else 
 		memcpy(src, image->data, dsize);
-	
-	if (info->pixmap.outbuf)
-		fb_iomove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
+
+	if (pad->outbuf)
+		fb_iomove_buf_aligned(info, pad, dst, d_pitch, src,
 				  s_pitch, image->height);
 	else
-		fb_sysmove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
+		fb_sysmove_buf_aligned(info, pad, dst, d_pitch, src,
 				   s_pitch, image->height);
-
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
 	kfree(src);
-
 	return 0;
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-2.6/include/linux/fb.h
--- linus-2.6/include/linux/fb.h	2005-02-21 10:40:46.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2005-02-18 12:00:40.000000000 -0800
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
 
 
@@ -707,11 +708,10 @@
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
+	struct list_head resources;	/* Graphics resources */
+	struct list_head modelist;      /* mode list */
 	struct work_struct queue;	/* Framebuffer event queue */
-	struct fb_pixmap pixmap;	/* Image hardware mapper */
-	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
-	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
 	struct device *device;
 #ifdef CONFIG_FB_TILEBLITTING
@@ -807,6 +807,14 @@
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
+extern void fb_set_suspend(struct fb_info *info, int state);
+extern int fb_get_color_depth(struct fb_info *info);
+extern int fb_get_options(char *name, char **option);
+
+extern struct fb_info *registered_fb[FB_MAX];
+extern int num_registered_fb;
+
+/* drivers/video/resmgt.c */
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
 extern void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
 				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
@@ -820,12 +828,11 @@
 extern void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
 				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 				u32 height);
-extern void fb_set_suspend(struct fb_info *info, int state);
-extern int fb_get_color_depth(struct fb_info *info);
-extern int fb_get_options(char *name, char **option);
-
-extern struct fb_info *registered_fb[FB_MAX];
-extern int num_registered_fb;
+void fb_release_resources(struct list_head *head);
+int fb_remove_resource(struct fb_pixmap *resource, struct list_head *head);
+int fb_add_resource(struct fb_pixmap *resource, struct list_head *head);
+struct fb_pixmap* fb_find_resource(const char *name, struct list_head *head);
+int fb_init_resources(struct fb_info *info);
 
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
