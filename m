From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH]: Various fbdev fixes:
Date: 17 Jan 2003 16:46:19 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042789559.3407.2.camel@localhost.localdomain>
References: <1042688316.970.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ZSH7-0000om-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Jan 2003 00:54:53 -0800
In-Reply-To: <1042688316.970.21.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-01-16 at 11:49, Antonino Daplas wrote:
> Hi James,
> 
> It seems that the 32/64-bit patch for fast_imageblit() and the
> "non-divisible by 8 width" fix for slow_imageblit() did not completely
> take.  So here's an updated patch against linux-2.5.58 + your latest
> fbdev.diff:
> 
> a.  Fix for fast_imageblit() being unclean on 64-bit and higher
> machines:  With the change, the 32-bit tables will be accessed 2 (or
> more) times  on >= 64-bit machines before doing a single FB_WRITEL. 
> Because the extra tests and bit packing impose a performance penalty for
> 32-bit machines, 32-bit machines undergo a different, faster, and
> simpler path.
> 
> c.  Fix for slow_imageblit() being unclean for bitmaps with widths not
> divisible by 8.
> 
> d.  Fix for fbcon_resize().  Update display.vrows after fb_set_var(). 
> This should fix console problems when fb_var_screeninfo.yres_virtual is
> changed and y-panning is enabled. Only activated when fbcon_switch() is
> called.
> 
> e.  Trivial:  info->fbops->fb_sync() may not be necessary in
> accel_putcs().
> 

James,

This is a resend of the same patch against linux-2.5.59.  

Tony

diff -Naur linux-2.5.59/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.59/drivers/video/cfbimgblt.c	2003-01-17 07:40:33.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-17 07:39:54.000000000 +0000
@@ -73,26 +73,36 @@
 	0x00000000, 0xffffffff
 };
 
-#if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-#else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
-#endif 
-
 #if defined (__BIG_ENDIAN)
 #define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
-#define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
 #define LEFT_POS(bpp)          (0)
-#define NEXT_POS(pos, bpp)     ((pos) += (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
 #endif
 
+#if BITS_PER_LONG == 32
+#define FB_WRITEL        fb_writel
+#define FB_READL         fb_readl
+#define INIT_FASTPATH    {}
+#define FASTPATH         fb_writel((end_mask & eorx)^bgx, dst++)
+#else
+#define FB_WRITEL        fb_writeq
+#define FB_READL         fb_readq
+#define INIT_FASTPATH    unsigned val = 0, bpl = 0 
+#define FASTPATH {                                     \
+	val |= SHIFT_HIGH((end_mask & eorx)^bgx, bpl); \
+	bpl += 32;                                     \
+	bpl &= BITS_PER_LONG - 1;                      \
+	if (!bpl) {                                    \
+		FB_WRITEL(val, dst++);                 \
+		val = 0;                               \
+	}                                              \
+}                                                      
+#endif 
+
 static inline void color_imageblit(struct fb_image *image, struct fb_info *p, 
 				   u8 *dst1, unsigned long start_index,
 				   unsigned long pitch_index)
@@ -152,18 +162,16 @@
 	}
 }
 
-static inline void slow_imageblit(struct fb_image *image, struct fb_info *p, 
-				  u8 *dst1, unsigned long fgcolor,
-				  unsigned long bgcolor, 
-				  unsigned long start_index,
-				  unsigned long pitch_index)
+static inline void slow_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1,
+				  unsigned long fgcolor, unsigned long bgcolor, 
+				  unsigned long start_index, unsigned long pitch_index)
 {
-	unsigned long shift, color = 0, bpp = p->var.bits_per_pixel;
+	unsigned long i, j, l = 8;
+	unsigned long shift, color, bpp = p->var.bits_per_pixel;
 	unsigned long *dst, *dst2, val, pitch = p->fix.line_length;
 	unsigned long null_bits = BITS_PER_LONG - bpp;
 	unsigned long spitch = (image->width+7)/8;
-	u8 *src = image->data, *s;
-	unsigned long i, j, l;
+	u8 *s = image->data, *src;
 	
 	dst2 = (unsigned long *) dst1;
 
@@ -172,42 +180,42 @@
 		l = 8;
 		j = image->width;
 		dst = (unsigned long *) dst1;
-		s = src;
-
+		src = s;
 		/* write leading bits */
 		if (start_index) {
-			unsigned long start_mask = ~(SHIFT_HIGH(~0UL,
+			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, 
 								start_index));
+
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
 		}
-
 		while (j--) {
 			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
+			color = (*src & (1 << l)) ? fgcolor : bgcolor;
 			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
-				val = (shift == null_bits) ? 0 :
-					 SHIFT_LOW(color,BITS_PER_LONG - shift);
+				if (shift == null_bits)
+					val = 0;
+				else
+					val = SHIFT_LOW(color, 
+							BITS_PER_LONG - shift);
 			}
 			shift += bpp;
 			shift &= (BITS_PER_LONG - 1);
-			if (!l) { l = 8; s++; };
+			if (!l) { l = 8; src++; };
 		}
-
 		/* write trailing bits */
  		if (shift) {
 			unsigned long end_mask = SHIFT_HIGH(~0UL, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
-		
-		dst1 += pitch;
-		src += spitch;	
+		dst1 += pitch;	
+		s += spitch;
 		if (pitch_index) {
 			dst2 += pitch;
 			dst1 = (char *) dst2;
@@ -229,17 +237,16 @@
  *           beginning and end of a scanline is dword aligned
  */
 static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, 
-				  u8 *dst1, unsigned long fgcolor, 
-				  unsigned long bgcolor) 
+				  u8 *dst1, u32 fgcolor, u32 bgcolor) 
 {
-	unsigned long fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
-	unsigned long ppw = BITS_PER_LONG/bpp, spitch = (image->width + 7)/8;
-	unsigned long bit_mask, end_mask, eorx, shift;
-	char *s = image->data, *src;
-	unsigned long *dst;
+	int i, j, k; 
+	u32 bit_mask, end_mask, eorx, shift; 
+	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
+	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
 	u32 *tab = NULL;
-	int i, j, k;
-		
+	unsigned long *dst;
+	char *s = image->data, *src;
+
 	switch (bpp) {
 	case 8:
 		tab = cfb_tab8;
@@ -264,19 +271,19 @@
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (unsigned long *) dst1, shift = 8; src = s;
-		
+		INIT_FASTPATH;
+		dst = (unsigned long *) dst1; shift = 8; src = s;
 		for (j = k; j--; ) {
 			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
-			if (!shift) { shift = 8; src++; }		
+			end_mask = tab[(*src >> shift) & bit_mask]; 
+			FASTPATH;
+			if (!shift) { shift = 8; src++; }
 		}
 		dst1 += p->fix.line_length;
 		s += spitch;
 	}
 }	
-	
+
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
 	unsigned long fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
@@ -324,12 +331,13 @@
 			bgcolor = image->bg_color;
 		}	
 		
-		if (BITS_PER_LONG % bpp == 0 && !start_index && !pitch_index && 
+		if (BITS_PER_LONG % bpp==0 && !start_index && !pitch_index &&
 		    ((image->width & (BITS_PER_LONG/bpp-1)) == 0) &&
 		    bpp >= 8 && bpp <= 32) 			
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
 		else 
-			slow_imageblit(image, p, dst1, fgcolor, bgcolor, start_index, pitch_index);
+			slow_imageblit(image, p, dst1, fgcolor, bgcolor, 
+				       start_index, pitch_index);
 	}
 	else if (image->depth == bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
diff -Naur linux-2.5.59/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.59/drivers/video/console/fbcon.c	2003-01-17 07:40:40.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-17 07:42:39.000000000 +0000
@@ -399,7 +399,7 @@
 
 	if (!(vc->vc_font.width & 7)) {
 		unsigned int pitch, cnt, i, j, k;
-		unsigned int maxcnt = FB_PIXMAPSIZE/(vc->vc_font.height * width);
+		unsigned int maxcnt = FB_PIXMAPSIZE/cellsize;
 		char *src, *dst, *dst0;
 
 		image.data = pixmap;
@@ -437,8 +437,6 @@
 			image.dx += vc->vc_font.width;
 		}	
 	}
-	if (info->fbops->fb_sync)
-		info->fbops->fb_sync(info);
 }
 
 void accel_clear_margins(struct vc_data *vc, struct display *p,
@@ -1883,10 +1881,11 @@
 	var.activate = FB_ACTIVATE_NOW;
 
 	err = fb_set_var(&var, info);
-	return  (err || var.xres != info->var.xres ||
-		 var.yres != info->var.yres) ?
-		-EINVAL : 0;
-	  
+	if (err || var.xres != info->var.xres ||
+		 var.yres != info->var.yres)
+		return -EINVAL;
+	p->vrows = info->var.yres_virtual/vc->vc_font.height;
+	return 0;
 }
 
 static int fbcon_switch(struct vc_data *vc)



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
