From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH]: cfb_imageblit() fix: handle widths not divisible by 8
Date: 15 Jan 2003 10:11:00 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042596659.1101.21.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0301150023570.23774-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Yd9j-0000yn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 18:19:52 -0800
In-Reply-To: <Pine.LNX.4.44.0301150023570.23774-100000@phoenix.infradead.org>
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

On Wed, 2003-01-15 at 08:26, James Simmons wrote:
> 
> Applied.
> 
> > c. Fix for fast_imageblit() so it always refer to mask tables in 32-bits
> > which should make it work for 64-bit machines.
> 
> Ug. I rather try yo take advantge of using the full 64 bits of data to 
> pass across the bus. What I was think is treat the 64 bit case as two 32 
> bit cases. The 64 bit data comes in and we run the data twice at tabs[].
> 
Hi James,

Yes, I was trying to find a way to make fast_imageblit() be fast for all
machine architectures.  With the patch attached, there's
fast_imageblit32() and fast_imageblit64().  fast_imageblit32() is
probably slower than fast_imageblit64 on 64-bit machines and, on the
other hand, fast_imageblit64() is 20% slower on 32-bit machines, but is
probably faster on 64-bit and higher machines.  So, the only way I can
think of doing this on all machine architectures is to have them go
separate paths.

Note:  both fast_imageblit32() and fast_imageblit64(), in theory, should
work will all machine archs.  Your call.

Tony 

PS:  the diff should be applied with the previous patch I submitted.


diff -Naur linux-2.5.56-fbdev/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.56-fbdev/drivers/video/cfbimgblt.c	2003-01-15 01:56:47.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-15 01:57:01.000000000 +0000
@@ -74,11 +74,13 @@
 };
 
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
+#define FB_WRITEL       fb_writel
+#define FB_READL        fb_readl
+#define FAST_IMAGEBLIT  fast_imageblit32
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
+#define FB_WRITEL       fb_writeq
+#define FB_READL        fb_readq
+#define FAST_IMAGEBLIT  fast_imageblit64
 #endif 
 
 #if defined (__BIG_ENDIAN)
@@ -235,15 +237,16 @@
  *           fix->next_line is divisible by 4;
  *           beginning and end of a scanline is dword aligned
  */
-static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, 
-				  u8 *dst1, u32 fgcolor, u32 bgcolor) 
+#if BITS_PER_LONG == 32
+static inline void fast_imageblit32(struct fb_image *image, struct fb_info *p, 
+				    u8 *dst1, u32 fgcolor, u32 bgcolor) 
 {
 	int i, j, k; 
 	u32 bit_mask, end_mask, eorx, shift; 
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 *dst;
 	u32 *tab = NULL;
+	u32 *dst;
 	char *s = image->data, *src;
 		
 	switch (bpp) {
@@ -281,7 +284,61 @@
 		s += spitch;
 	}
 }	
+#else
+static inline void fast_imageblit64(struct fb_image *image, struct fb_info *p, 
+				    u8 *dst1, u32 fgcolor, u32 bgcolor) 
+{
+	int i, j, k; 
+	u32 bit_mask, end_mask, eorx, shift; 
+	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
+	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
+	u32 *tab = NULL, bpl;
+	unsigned long *dst, val;
+	char *s = image->data, *src;
+		
+	switch (bpp) {
+	case 8:
+		tab = cfb_tab8;
+		break;
+	case 16:
+		tab = cfb_tab16;
+		break;
+	case 32:
+		tab = cfb_tab32;
+		break;
+	}
+
+	for (i = ppw-1; i--; ) {
+		fgx <<= bpp;
+		bgx <<= bpp;
+		fgx |= fgcolor;
+		bgx |= bgcolor;
+	}
 	
+	bit_mask = (1 << ppw) - 1;
+	eorx = fgx ^ bgx;
+	k = image->width/ppw;
+
+	for (i = image->height; i--; ) {
+		dst = (unsigned long *) dst1; shift = 8; src = s;
+		val = 0, bpl = 0;
+		for (j = k; j--; ) {
+			shift -= ppw;
+			end_mask = tab[(*src >> shift) & bit_mask]; 
+			val |= SHIFT_HIGH((end_mask & eorx)^bgx, bpl);
+			bpl += 32;
+			bpl &= BITS_PER_LONG - 1;
+			if (!bpl) {
+				FB_WRITEL(val, dst++);
+				val = 0;
+			}
+			if (!shift) { shift = 8; src++; }
+		}
+		dst1 += p->fix.line_length;
+		s += spitch;
+	}
+}	
+#endif
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
 	int x2, y2, vxres, vyres;
@@ -331,8 +388,8 @@
 		
 		if (BITS_PER_LONG % bpp == 0 && !start_index && 
 		    !pitch_index && bpp >= 8 && bpp <= 32 && 
-		    (image->width & (32/bpp-1)) == 0) 
-			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
+		    (image->width & (BITS_PER_LONG/bpp-1)) == 0) 
+			FAST_IMAGEBLIT(image, p, dst1, fgcolor, bgcolor);
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor, 
 				       start_index, pitch_index);




-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
