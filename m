From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: cfb_{copyarea,fillrect}()
Date: Tue, 2 Jul 2002 13:38:42 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0207021330420.25055-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17PM0D-0004Ew-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 02 Jul 2002 04:39:26 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

	Hi,

This (untested) patch replaces the #if/#else/#endif clutter in cfb_fillrect()
with one #if/#else/#endif clause at the top of the file.

It also adds 64-bit support to cfb_copyarea().

Other comments/notes:

  - Shouldn't cfb_fillrect() use the pseudo_palette in DIRECTCOLOR mode?

  - I think the cfb_*() routines can easily be modified to work for bpp < 8,
    and for bpp == 24:
      o initialize src/dst indices to be bit indices instead of byte indices
      o remove shifts by 3
      o n is number of bits to copy/fill

  - I think that line length is not guaranteed to be a multiple of
    sizeof(unsigned long). Hence a different start/end mask per line is
    possible as well.

James: keep up the great work!

--- linux-2.5.24/drivers/video/cfbcopyarea.c	Fri Jun  7 11:06:41 2002
+++ linux-geert-2.5.24/drivers/video/cfbcopyarea.c	Wed Jun 26 04:04:09 2002
@@ -28,6 +28,14 @@
 #include <asm/io.h>
 #include <video/fbcon.h>
 
+#if BITS_PER_LONG == 32
+#define FB_READ		fb_readl
+#define FB_WRITE	fb_writel
+#else
+#define FB_READ		fb_readq
+#define FB_WRITE	fb_writeq
+#endif
+
 void cfb_copyarea(struct fb_info *p, struct fb_copyarea *area)
 {
 	int x2, y2, lineincr, shift, shift_right, shift_left, old_dx, old_dy;
@@ -137,19 +145,19 @@
 					dst = (unsigned long *) dst1;
 					src = (unsigned long *) src1;
 
-					last = (fb_readl(src) & start_mask);
+					last = (FB_READ(src) & start_mask);
 
 					if (shift > 0)
-						fb_writel(fb_readl(dst) | (last >> shift_right), dst);
+						FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
 					for (j = 0; j < n; j++) {
 						dst++;
-						tmp = fb_readl(src);
+						tmp = FB_READ(src);
 						src++;
-						fb_writel((last << shift_left) | (tmp >> shift_right), dst);
+						FB_WRITE((last << shift_left) | (tmp >> shift_right), dst);
 						last = tmp;
 						src++;
 					}
-					fb_writel(fb_readl(dst) | (last << shift_left), dst);
+					FB_WRITE(FB_READ(dst) | (last << shift_left), dst);
 					src1 += lineincr;
 					dst1 += lineincr;
 				} while (--height);
@@ -161,19 +169,19 @@
 					dst = (unsigned long *) dst1;
 					src = (unsigned long *) src1;
 
-					last = (fb_readl(src) & end_mask);
+					last = (FB_READ(src) & end_mask);
 
 					if (shift < 0)
-						fb_writel(fb_readl(dst) | (last >> shift_right), dst);
+						FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
 					for (j = 0; j < n; j++) {
 						dst--;
-						tmp = fb_readl(src);
+						tmp = FB_READ(src);
 						src--;
-						fb_writel((tmp << shift_left) | (last >> shift_right), dst);
+						FB_WRITE((tmp << shift_left) | (last >> shift_right), dst);
 						last = tmp;
 						src--;
 					}
-					fb_writel(fb_readl(dst) | (last >> shift_right), dst);
+					FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
 					src1 += lineincr;
 					dst1 += lineincr;
 				} while (--height);
@@ -187,16 +195,16 @@
 					src = (unsigned long *) (src1 - start_index);
 
 					if (start_mask)
-						fb_writel(fb_readl(src) | start_mask, dst);
+						FB_WRITE(FB_READ(src) | start_mask, dst);
 
 					for (j = 0; j < n; j++) {
-						fb_writel(fb_readl(src), dst);
+						FB_WRITE(FB_READ(src), dst);
 						dst++;
 						src++;
 					}
 
 					if (end_mask)
-						fb_writel(fb_readl(src) | end_mask, dst);
+						FB_WRITE(FB_READ(src) | end_mask, dst);
 					src1 += lineincr;
 					dst1 += lineincr;
 				} while (--height);
@@ -207,9 +215,9 @@
 					src = (unsigned long *) src1;
 
 					if (start_mask)
-						fb_writel(fb_readl(src) | start_mask, dst);
+						FB_WRITE(FB_READ(src) | start_mask, dst);
 					for (j = 0; j < n; j++) {
-						fb_writel(fb_readl(src), dst);
+						FB_WRITE(FB_READ(src), dst);
 						dst--;
 						src--;
 					}
--- linux-2.5.24/drivers/video/cfbfillrect.c	Thu May 30 08:10:36 2002
+++ linux-geert-2.5.24/drivers/video/cfbfillrect.c	Wed Jun 26 03:59:45 2002
@@ -22,6 +22,14 @@
 #include <asm/types.h>
 #include <video/fbcon.h>
 
+#if BITS_PER_LONG == 32
+#define FB_READ		fb_readl
+#define FB_WRITE	fb_writel
+#else
+#define FB_READ		fb_readq
+#define FB_WRITE	fb_writeq
+#endif
+
 void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect)
 {
 	unsigned long start_index, end_index, start_mask = 0, end_mask = 0;
@@ -93,33 +101,18 @@
 				dst = (unsigned long *) (dst1 - start_index);
 
 				if (start_mask) {
-#if BITS_PER_LONG == 32
-					fb_writel(fb_readl(dst) |
-						  start_mask, dst);
-#else
-					fb_writeq(fb_readq(dst) |
-						  start_mask, dst);
-#endif
+					FB_WRITE(FB_READ(dst) | start_mask,
+						 dst);
 					dst++;
 				}
 
 				for (i = 0; i < n; i++) {
-#if BITS_PER_LONG == 32
-					fb_writel(fg, dst);
-#else
-					fb_writeq(fg, dst);
-#endif
+					FB_WRITE(fg, dst);
 					dst++;
 				}
 
 				if (end_mask)
-#if BITS_PER_LONG == 32
-					fb_writel(fb_readl(dst) | end_mask,
-						  dst);
-#else
-					fb_writeq(fb_readq(dst) | end_mask,
-						  dst);
-#endif
+					FB_WRITE(FB_READ(dst) | end_mask, dst);
 				dst1 += linesize;
 			} while (--height);
 			break;
@@ -128,33 +121,18 @@
 				dst = (unsigned long *) (dst1 - start_index);
 
 				if (start_mask) {
-#if BITS_PER_LONG == 32
-					fb_writel(fb_readl(dst) ^
-						  start_mask, dst);
-#else
-					fb_writeq(fb_readq(dst) ^
-						  start_mask, dst);
-#endif
+					FB_WRITE(FB_READ(dst) ^ start_mask,
+						 dst);
 					dst++;
 				}
 
 				for (i = 0; i < n; i++) {
-#if BITS_PER_LONG == 32
-					fb_writel(fb_readl(dst) ^ fg, dst);
-#else
-					fb_writeq(fb_readq(dst) ^ fg, dst);
-#endif
+					FB_WRITE(FB_READ(dst) ^ fg, dst);
 					dst++;
 				}
 
 				if (end_mask) {
-#if BITS_PER_LONG == 32
-					fb_writel(fb_readl(dst) ^ end_mask,
-						  dst);
-#else
-					fb_writeq(fb_readq(dst) ^ end_mask,
-						  dst);
-#endif
+					FB_WRITE(FB_READ(dst) ^ end_mask, dst);
 				}
 				dst1 += linesize;
 			} while (--height);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
