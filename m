From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: [PATCH]: cfb_imageblit() fix: handle
	widths not divisible by 8
Date: 15 Jan 2003 19:48:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042631288.1292.11.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301151020270.4227-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YmAV-0003Tp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jan 2003 03:57:15 -0800
In-Reply-To: <Pine.GSO.4.21.0301151020270.4227-100000@vervain.sonytel.be>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-15 at 17:28, Geert Uytterhoeven wrote:
> On 15 Jan 2003, Antonino Daplas wrote:
> > On Wed, 2003-01-15 at 08:26, James Simmons wrote:
> > > Applied.
> > > 
> > > > c. Fix for fast_imageblit() so it always refer to mask tables in 32-bits
> > > > which should make it work for 64-bit machines.
> > > 
> > > Ug. I rather try yo take advantge of using the full 64 bits of data to 
> > > pass across the bus. What I was think is treat the 64 bit case as two 32 
> > > bit cases. The 64 bit data comes in and we run the data twice at tabs[].
> > > 
> > Hi James,
> > 
> > Yes, I was trying to find a way to make fast_imageblit() be fast for all
> > machine architectures.  With the patch attached, there's
> > fast_imageblit32() and fast_imageblit64().  fast_imageblit32() is
> > probably slower than fast_imageblit64 on 64-bit machines and, on the
> > other hand, fast_imageblit64() is 20% slower on 32-bit machines, but is
> > probably faster on 64-bit and higher machines.  So, the only way I can
> > think of doing this on all machine architectures is to have them go
> > separate paths.
> 
> Can't you merge fast_imageblit32() and fast_imageblit64() a bit more (with some
> #ifdef's), and just call the result fast_imageblit()? Then the definition of
> FAST_IMAGEBLIT can go away.
> 
> u32 is the same as unsigned long if BITS_PER_LONG == 32.
> 
That's true.  I don't want to do the merge before you people have seen
it.  Anyway, here's an updated one.

Tony

diff -Naur linux-2.5.56-fbdev/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.56-fbdev/drivers/video/cfbimgblt.c	2003-01-15 01:56:47.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-15 11:43:53.000000000 +0000
@@ -73,14 +73,6 @@
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
 #define LEFT_POS32(bpp)        (32 - bpp)
@@ -95,6 +87,28 @@
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
 #endif
 
+#if BITS_PER_LONG == 32
+#define FB_WRITEL        fb_writel
+#define FB_READL         fb_readl
+#define DECLARE_FASTPATH {}
+#define INIT_FASTPATH    {}
+#define FASTPATH         fb_writel((end_mask & eorx)^bgx, dst++)
+#else
+#define FB_WRITEL        fb_writeq
+#define FB_READL         fb_readq
+#define DECLARE_FASTPATH unsigned long val, bpl
+#define INIT_FASTPATH    { val = 0; bpl = 0; }
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
@@ -242,10 +256,11 @@
 	u32 bit_mask, end_mask, eorx, shift; 
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 *dst;
 	u32 *tab = NULL;
+	unsigned long *dst;
 	char *s = image->data, *src;
-		
+	DECLARE_FASTPATH;
+
 	switch (bpp) {
 	case 8:
 		tab = cfb_tab8;
@@ -270,18 +285,19 @@
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (u32 *) dst1; shift = 8; src = s;
+		dst = (unsigned long *) dst1; shift = 8; src = s;
+		INIT_FASTPATH;
 		for (j = k; j--; ) {
 			shift -= ppw;
 			end_mask = tab[(*src >> shift) & bit_mask]; 
-			fb_writel((end_mask & eorx)^bgx, dst++);
+			FASTPATH;
 			if (!shift) { shift = 8; src++; }
 		}
 		dst1 += p->fix.line_length;
 		s += spitch;
 	}
 }	
-	
+
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
 	int x2, y2, vxres, vyres;
@@ -331,7 +347,7 @@
 		
 		if (BITS_PER_LONG % bpp == 0 && !start_index && 
 		    !pitch_index && bpp >= 8 && bpp <= 32 && 
-		    (image->width & (32/bpp-1)) == 0) 
+		    (image->width & (BITS_PER_LONG/bpp-1)) == 0) 
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor, 



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
