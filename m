From: Antonino Daplas <adaplas@pol.net>
Subject: Re: fonts
Date: 12 Jan 2003 18:26:02 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042366917.1016.9.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301112010020.18673-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XfSv-0007h4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 12 Jan 2003 02:35:41 -0800
In-Reply-To: <Pine.GSO.4.21.0301112010020.18673-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-01-12 at 03:15, Geert Uytterhoeven wrote:
> 
> I'm trying out different fonts with amifb (based on 2.5.56 from Linus).
>   - PEARL8x8: OK
>   - SUN12x22: garbage (random characters)
>   - ProFont6x11: garbage (each different line is filled with a different
>     character)
>   - MINI4x6: garbage (each different line is filled with a different
>     character)
> 
> At first I thought it may be caused by xres and yres not divisible by the
> fontsize, so I tried a 800x600 mode with MINI4x6. But the problem stayed the
> same, except that only a 640x600 window in the right part of the screen was
> used.
> 
> Is my planar code in amifb to blane, or have other people seen the same?
> 

The cfb_imageblit() function exhibited the same behavior.  I think we
both made the wrong assumption that all monochrome bitmaps are packed. I
think the rule is:

    The first pixel on the next scanline is always at the next byte from
    the last pixel of the current scanline.  

So a 12x22 font has 16 bits per scanline but only 12 are usable, and the
last 4 are used as padding.  It's worse with a 4x6 fonts where the
4-bits are just duplicated in the other nibble.

It's a simple fix for imageblit. So here's a patch.

a. Fix for slow_imageblit() so fonts with widths not a multiple of 8
will work.

b. Fixed fast_imageblit() so it always access tables as 32-bit for it to
to work with a 64-bit machine.

James, can you apply?
 
Tony

diff -Naur linux-2.5.54/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.54/drivers/video/cfbimgblt.c	2003-01-12 09:48:47.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-12 10:06:59.000000000 +0000
@@ -88,11 +88,13 @@
 
 #if defined (__BIG_ENDIAN)
 #define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
+#define LEFT_POS32(bpp)        (32 - bpp)
 #define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
 #define LEFT_POS(bpp)          (0)
+#define LEFT_POS32(bpp)        (0)
 #define NEXT_POS(pos, bpp)     ((pos) += (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
@@ -161,7 +163,7 @@
 				  unsigned long fgcolor, unsigned long bgcolor, 
 				  unsigned long start_index, unsigned long pitch_index)
 {
-	unsigned long i, j, l = 8;
+	unsigned long i, j, l;
 	unsigned long shift, color, bpp = p->var.bits_per_pixel;
 	unsigned long *dst, *dst2, val, pitch = p->fix.line_length;
 	unsigned long null_bits = BITS_PER_LONG - bpp;
@@ -170,10 +172,11 @@
 	dst2 = (unsigned long *) dst1;
 
 	for (i = image->height; i--; ) {
-		shift = 0;
-		val = 0;
+		shift = val = 0;
+		l = 8;
 		j = image->width;
 		dst = (unsigned long *) dst1;
+		s = src;
 
 		/* write leading bits */
 		if (start_index) {
@@ -182,35 +185,33 @@
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
 		}
+
 		while (j--) {
 			l--;
-			if (*src & (1 << l)) 
-				color = fgcolor;
-			else 
-				color = bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
-				if (shift == null_bits)
-					val = 0;
-				else
-					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+				val = (shift == null_bits) ? 
+					0 : SHIFT_LOW(color, BITS_PER_LONG - shift);
 			}
 			shift += bpp;
 			shift &= (BITS_PER_LONG - 1);
-			if (!l) { l = 8; src++; };
+			if (!l) { l = 8; s++; };
 		}
+
 		/* write trailing bits */
  		if (shift) {
 			unsigned long end_mask = SHIFT_HIGH(~0UL, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
-		dst1 += pitch;	
 
+		dst1 += pitch;	
+		src += (image->width + 7)/8;
 		if (pitch_index) {
 			dst2 += pitch;
 			dst1 = (char *) dst2;
@@ -224,25 +225,25 @@
 }
 
 static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				  unsigned long fgcolor, unsigned long bgcolor) 
+				  u32 fgcolor, u32 bgcolor) 
 {
 	int i, j, k, l = 8, n;
-	unsigned long bit_mask, end_mask, eorx; 
-	unsigned long fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
-	unsigned long tmp = (1 << bpp) - 1;
-	unsigned long ppw = BITS_PER_LONG/bpp, ppos;
-	unsigned long *dst;
+	u32 bit_mask, end_mask, eorx; 
+	u32 fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
+	u32 tmp = (1 << bpp) - 1;
+	u32 ppw = 32/bpp, ppos;
+	u32 *dst;
 	u32 *tab = NULL;
 	char *src = image->data;
 		
-	switch (ppw) {
-	case 4:
+	switch (bpp) {
+	case 8:
 		tab = cfb_tab8;
 		break;
-	case 2:
+	case 16:
 		tab = cfb_tab16;
 		break;
-	case 1:
+	case 32:
 		tab = cfb_tab32;
 		break;
 	}
@@ -264,17 +265,17 @@
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (unsigned long *) dst1;
-		
+		dst = (u32 *) dst1;
 		for (j = k; j--; ) {
 			l -= ppw;
 			end_mask = tab[(*src >> l) & bit_mask]; 
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			fb_writel((end_mask & eorx)^bgx, dst++);
 			if (!l) { l = 8; src++; }
 		}
+
 		if (n) {
 			end_mask = 0;	
-			ppos = LEFT_POS(bpp);
+			ppos = LEFT_POS32(bpp);
 			for (j = n; j > 0; j--) {
 				l--;
 				if (*src & (1 << l))
@@ -282,9 +283,9 @@
 				NEXT_POS(ppos, bpp);
 				if (!l) { l = 8; src++; }
 			}
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			fb_writel((end_mask & eorx)^bgx, dst++);
 		}
-		l -= pad;		
+		l -= pad;
 		dst1 += p->fix.line_length;	
 	}
 }	



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
