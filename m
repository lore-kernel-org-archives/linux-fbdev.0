From: Antonino Daplas <adaplas@pol.net>
Subject: Re: 2.5 atyfb on Sparc question
Date: 09 Aug 2002 05:55:58 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1028843807.547.47.camel@daplas>
References: <1730A970D4F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-N4xGL2F2LIynwkg4eM8G"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cvBd-0005nV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 14:51:17 -0700
Received: from [203.167.30.22] (cwd22.compass.com.ph [203.167.30.22])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id FAA77392
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 9 Aug 2002 05:51:03 +0800 (PHT)
	(envelope-from adaplas@pol.net)
In-Reply-To: <1730A970D4F@vcnet.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-N4xGL2F2LIynwkg4eM8G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-08-09 at 02:51, Petr Vandrovec wrote:

> 
> Message from Antonio Daplas
> (http://www.geocrawler.com/lists/3/SourceForge/9276/0/9249087/)
> says:
> 2.5 old (with offscreen buffers) 10.708
> 2.5 new                           4.378
> 2.4                               2.098
> 
> His first message 
> (http://www.geocrawler.com/lists/3/SourceForge/9276/25/9237029/)
> listed 13.586 for old 2.5 code.
> 
> So you are right, old code was not 1000% slowdown, only 500%. But main
> problem is not speed of old code, but speed of new code. And if numbers
> are right, new code is still 100% slower than 2.4.x code was.
>                                                 Petr Vandrovec

The numbers are correct. However I'm only talking about software drawing
here.  With a few more optimizations with the code, the scroll time was
further cut down to 3.780s.  Also, 16bpp and 32bpp is now faster in 2.5
than in 2.4, although 24bpp is still a bit slower because of problems of
its weird alignmment.

However, ALL hardware accelerated code is much faster than the old one,
and will be much, much faster if hardware sync on demand is implemented.
(I really want this James :)

The extra processing of the font bitmap in putcs() outweighs the benefit
of "bulk" writing the data in 8bpp, but becomes insignificant as we go
to higher color depths, or as we take advantage of hardware
acceleration.

I'm attaching diffs for cfbimgblt.c, cfbfillrect.c, cfbcopyarea.c and
fbcon-accel.c.  This is against vanilla 2.5.27.

fbcon-accel.c:  
	process 4 characters at a time, if possible, to squeeze a few more CPU
cycles

cfbimgblt.c
	divided into fast_imageblit (for 8, 16, 32 bpp), slow_imageblit (24
bpp) and bitwise_imageblit (default).  

slow_imageblit involves packaging 4 pixels (or 8 if we have color depths
> 32) which are written as double words (1 - 8bpp, 2 - 16bpp, 3 -
24bpp).

cfbcopyarea.c
	uses fast_memmove and fb_memmove for 24 bpp.  Anthing wrong with this
fb string functions?  I seem not to see any performance degradation by
using them.

cfbfillarea.c
	Similar concept as slow_imageblit, packages 4-pixels in 24 bpp that are
written as 3 double words to the framebuffer.


	Also is the double word access alignment a strict or optional
requirement? 

Any comments?

Tony 



--=-N4xGL2F2LIynwkg4eM8G
Content-Disposition: attachment; filename=fb-opt.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fb-opt.diff; charset=ISO-8859-1

diff -Naur linux-2.5.27/drivers/video/cfbcopyarea.c linux/drivers/video/cfb=
copyarea.c
--- linux-2.5.27/drivers/video/cfbcopyarea.c	Thu Aug  8 21:42:21 2002
+++ linux/drivers/video/cfbcopyarea.c	Thu Aug  8 21:42:54 2002
@@ -83,7 +83,7 @@
 		lineincr =3D -linesize;
 	}
=20
-	if ((BITS_PER_LONG % p->var.bits_per_pixel) =3D=3D 0) {
+	if ((BITS_PER_LONG % p->var.bits_per_pixel) =3D=3D 0) {  =20
 		int ppw =3D BITS_PER_LONG / p->var.bits_per_pixel;
 		int n =3D ((area->width * p->var.bits_per_pixel) >> 3);
=20
@@ -103,7 +103,6 @@
 			n -=3D end_index;
 		}
 		n /=3D bpl;
-
 		if (n <=3D 0) {
 			if (start_mask) {
 				if (end_mask)
@@ -219,4 +218,32 @@
 			}
 		}
 	}
+	else {
+		int n =3D ((area->width * p->var.bits_per_pixel) >> 3);
+		int n16 =3D (n >> 4) << 4;
+		int n_fract =3D n - n16;
+		int rows;
+
+		if (area->dy < area->sy
+		    || (area->dy =3D=3D area->sy && area->dx < area->sx)) {
+			for (rows =3D height; rows--; ) {
+				if (n16)
+					fast_memmove(dst1, src1, n16);
+				if (n_fract)
+					fb_memmove(dst1+n16, src1+n16, n_fract);
+				dst1 +=3D linesize;
+				src1 +=3D linesize;
+			}
+		}
+		else {
+			for (rows =3D height; rows--; ) {
+				if (n16)
+					fast_memmove(dst1, src1, n16);
+				if (n_fract)
+					fb_memmove(dst1+n16, src1+n16, n_fract);
+				dst1 -=3D linesize;
+				src1 -=3D linesize;
+			}
+		}
+	}		=09
 }
diff -Naur linux-2.5.27/drivers/video/cfbfillrect.c linux/drivers/video/cfb=
fillrect.c
--- linux-2.5.27/drivers/video/cfbfillrect.c	Thu Aug  8 21:42:26 2002
+++ linux/drivers/video/cfbfillrect.c	Thu Aug  8 21:42:50 2002
@@ -28,7 +28,7 @@
 	unsigned long height, ppw, fg, fgcolor;
 	int i, n, x2, y2, linesize =3D p->fix.line_length;
 	int bpl =3D sizeof(unsigned long);
-	unsigned long *dst;
+	unsigned long *dst =3D NULL;
 	char *dst1;
=20
 	if (!rect->width || !rect->height)
@@ -57,7 +57,7 @@
 	else
 		fg =3D fgcolor =3D rect->color;
=20
-	for (i =3D 0; i < ppw - 1; i++) {
+	for (i =3D 0; i < ppw-1; i++) {
 		fg <<=3D p->var.bits_per_pixel;
 		fg |=3D fgcolor;
 	}
@@ -85,7 +85,7 @@
 		n =3D 0;
 	}
=20
-	if ((BITS_PER_LONG % p->var.bits_per_pixel) =3D=3D 0) {
+	if ((BITS_PER_LONG % p->var.bits_per_pixel) =3D=3D 0) {=20
 		switch (rect->rop) {
 		case ROP_COPY:
 			do {
@@ -161,49 +161,76 @@
 			break;
 		}
 	} else {
-		/* Odd modes like 24 or 80 bits per pixel */
-		start_mask =3D fg >> (start_index * p->var.bits_per_pixel);
-		end_mask =3D fg << (end_index * p->var.bits_per_pixel);
-		/* start_mask =3D& PFILL24(x1,fg);
-		   end_mask_or =3D end_mask & PFILL24(x1+width-1,fg); */
-
-		n =3D (rect->width - start_index - end_index) / ppw;
+		/*=20
+		 * Slow Method:  The aim is to find the number of pixels to
+		 * pack in order to write doubleword multiple data.
+		 * For 24 bpp, 4 pixels are packed which are written as=20
+		 * 3 dwords.
+		 */
+		char *dst2, *dst3;
+		int bytes =3D (p->var.bits_per_pixel + 7) >> 3;
+		int read, write, total, pack_size;
+		u32 pixarray[BITS_PER_LONG >> 3], m;
+	=09
+		fg =3D fgcolor;
+		read =3D (bytes + (bpl - 1)) & ~(bpl - 1);=20
+		write =3D bytes;
+		total =3D (rect->width * bytes);
+		=09
+		pack_size =3D bpl * write;
+
+		dst3 =3D (char *) pixarray;
+
+		for (n =3D read; n--; ) {
+			*(u32 *) dst3 =3D fg;
+			dst3 +=3D bytes;
+		}
=20
 		switch (rect->rop) {
 		case ROP_COPY:
 			do {
-				dst =3D (unsigned long *) dst1;
-				if (start_mask)
-					*dst |=3D start_mask;
-				if ((start_index + rect->width) > ppw)
-					dst++;
+				dst2 =3D dst1;
+				n =3D total;
=20
-				/* XXX: slow */
-				for (i =3D 0; i < n; i++) {
-					*dst++ =3D fg;
+				while (n >=3D pack_size) {
+					for (m =3D 0; m < write; m++) {
+						fb_writel(pixarray[m], (u32 *) dst2);
+						dst2 +=3D 4;
+					}
+					n -=3D pack_size;
+				}
+				if (n) {
+					m =3D 0;
+					while (n--)=20
+						fb_writeb(((u8 *)pixarray)[m++], dst2++);
 				}
-				if (end_mask)
-					*dst |=3D end_mask;
 				dst1 +=3D linesize;
 			} while (--height);
 			break;
 		case ROP_XOR:
 			do {
-				dst =3D (unsigned long *) dst1;
-				if (start_mask)
-					*dst ^=3D start_mask;
-				if ((start_mask + rect->width) > ppw)
-					dst++;
+				dst2 =3D dst1;
+				n =3D total;
=20
-				for (i =3D 0; i < n; i++) {
-					*dst++ ^=3D fg;	/* PFILL24(fg,x1+i); */
+				while (n >=3D pack_size) {
+					for (m =3D 0; m < write; m++) {
+						fb_writel(fb_readl((u32 *) dst2) ^ pixarray[m], (u32 *) dst2);
+						dst2 +=3D 4;
+					}
+					n -=3D pack_size;
+				}
+				if (n) {
+					m =3D 0;
+					while (n--) {
+						fb_writeb(fb_readb(dst2) ^ ((u8 *)pixarray)[m++], dst2);
+						dst2++;
+					}
 				}
-				if (end_mask)
-					*dst ^=3D end_mask;
 				dst1 +=3D linesize;
 			} while (--height);
 			break;
 		}
+		=09
 	}
 	return;
 }
diff -Naur linux-2.5.27/drivers/video/cfbimgblt.c linux/drivers/video/cfbim=
gblt.c
--- linux-2.5.27/drivers/video/cfbimgblt.c	Thu Aug  8 21:42:17 2002
+++ linux/drivers/video/cfbimgblt.c	Thu Aug  8 21:42:42 2002
@@ -22,6 +22,13 @@
  *  FIXME
  *  The code for 24 bit is horrible. It copies byte by byte size instead o=
f
  *  longs like the other sizes. Needs to be optimized.
+ * =20
+ *  Tony:=20
+ *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This spee=
ds=20
+ *  up the code significantly.
+ * =20
+ *  Code for depths not multiples of BITS_PER_LONG is still kludgy, which =
is
+ *  still processed a bit at a time.  =20
  *
  *  Also need to add code to deal with cards endians that are different th=
an
  *  the native cpu endians. I also need to deal with MSB position in the w=
ord.
@@ -41,16 +48,222 @@
 #define DPRINTK(fmt, args...)
 #endif
=20
-void cfb_imageblit(struct fb_info *p, struct fb_image *image)
+static u32 cfb_tab8[] =3D {
+#if defined(__BIG_ENDIAN)
+    0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
+    0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
+    0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
+    0xffff0000,0xffff00ff,0xffffff00,0xffffffff
+#elif defined(__LITTLE_ENDIAN)
+    0x00000000,0xff000000,0x00ff0000,0xffff0000,
+    0x0000ff00,0xff00ff00,0x00ffff00,0xffffff00,
+    0x000000ff,0xff0000ff,0x00ff00ff,0xffff00ff,
+    0x0000ffff,0xff00ffff,0x00ffffff,0xffffffff
+#else
+#error FIXME: No endianness??
+#endif
+};
+
+static u32 cfb_tab16[] =3D {
+#if defined(__BIG_ENDIAN)
+    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
+#elif defined(__LITTLE_ENDIAN)
+    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
+#else
+#error FIXME: No endianness??
+#endif
+};
+
+static u32 cfb_tab32[] =3D {
+	0x00000000, 0xffffffff
+};
+
+static u32 cfb_pixarray[4];
+static u32 cfb_tabdef[2];
+
+
+static inline void fast_imageblit(struct fb_image *image, struct fb_info *=
p, char *dst1,=20
+				  int fgcolor, int bgcolor)=20
 {
-	int pad, ppw;
-	int x2, y2, n, i, j, k, l =3D 7;
+	int i, j, k, l =3D 8, n;
+	int bit_mask, end_mask, eorx;=20
+	unsigned long fgx =3D fgcolor, bgx =3D bgcolor, pad;
 	unsigned long tmp =3D ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
-	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;=09
+	unsigned long ppw =3D BITS_PER_LONG/p->var.bits_per_pixel;
+	unsigned long *dst;
+	u32 *tab =3D NULL;
+	char *src =3D image->data;
+	=09
+	switch (ppw) {
+	case 4:
+		tab =3D cfb_tab8;
+		break;
+	case 2:
+		tab =3D cfb_tab16;
+		break;
+	case 1:
+		tab =3D cfb_tab32;
+		break;
+	}
+
+	for (i =3D ppw-1; i--; ) {
+		fgx <<=3D p->var.bits_per_pixel;
+		bgx <<=3D p->var.bits_per_pixel;
+		fgx |=3D fgcolor;
+		bgx |=3D bgcolor;
+	}
+=09
+	n =3D ((image->width + 7) >> 3);
+	pad =3D (n << 3) - image->width;
+	n =3D image->width % ppw;
+=09
+	bit_mask =3D (1 << ppw) - 1;
+	eorx =3D fgx ^ bgx;
+
+	k =3D image->width/ppw;
+
+	for (i =3D image->height; i--; ) {
+		dst =3D (unsigned long *) dst1;
+	=09
+		for (j =3D k; j--; ) {
+			l -=3D ppw;
+			end_mask =3D tab[(*src >> l) & bit_mask];=20
+			fb_writel((end_mask & eorx)^bgx, dst++);
+			if (!l) { l =3D 8; src++; }
+		}
+		if (n) {
+			end_mask =3D 0;=09
+			for (j =3D n; j > 0; j--) {
+				l--;
+				if (test_bit(l, (unsigned long *) src))
+					end_mask |=3D (tmp >> (p->var.bits_per_pixel*(j-1)));
+				if (!l) { l =3D 8; src++; }
+			}
+			fb_writel((end_mask & eorx)^bgx, dst++);
+		}
+		l -=3D pad;	=09
+		dst1 +=3D p->fix.line_length;=09
+	}
+}=09
+=09
+
+/*
+ * Slow method:  The idea is to find the number of pixels necessary to for=
m
+ * dword-sized multiples that will be written to the framebuffer.  For BPP=
24,=20
+ * 4 pixels has to be read which are then packed into 3 double words that=20
+ * are then written to the framebuffer.
+ *=20
+ * With this method, processing is done 1 pixel at a time.
+ */
+static inline void slow_imageblit(struct fb_image *image, struct fb_info *=
p, char * dst1,
+				  int fgcolor, int bgcolor)
+{
+	int bytes =3D (p->var.bits_per_pixel + 7) >> 3;
+	int tmp =3D ~0UL >> (BITS_PER_LONG - p->var.bits_per_pixel);
+	int i, j, k, l =3D 8, m, end_mask, eorx;
+	int read, write, total, pack_size, bpl =3D sizeof(unsigned long);
+	unsigned long *dst;
+	char *dst2 =3D (char *) cfb_pixarray, *src =3D image->data;
+
+	cfb_tabdef[0] =3D 0;
+	cfb_tabdef[1] =3D tmp;
+=09
+	eorx =3D fgcolor ^ bgcolor;
+	read =3D (bytes + (bpl - 1)) & ~(bpl - 1);
+	write =3D bytes;
+	total =3D image->width * bytes;
+	pack_size =3D bpl * write;
+=09
+	for (i =3D image->height; i--; ) {
+		dst =3D (unsigned long *) dst1;
+		j =3D total;
+		m =3D read;
+	=09
+		while (j >=3D pack_size) {
+			l--; m--;
+			end_mask =3D cfb_tabdef[(*src >> l) & 1];=20
+			*(unsigned long *) dst2 =3D (end_mask & eorx)^bgcolor;
+			dst2 +=3D bytes;
+			if (!m) {
+				for (k =3D 0; k < write; k++ )=20
+					fb_writel(cfb_pixarray[k], dst++);
+				dst2 =3D (char *) cfb_pixarray;
+				j -=3D pack_size;
+				m =3D read;
+			}
+			if (!l) { l =3D 8; src++; }
+		}
+		/* write residual pixels */
+		if (j) {
+			k =3D 0;
+			while (j--)
+				fb_writeb(((u8 *) cfb_pixarray)[k++], dst++);
+		}
+		dst1 +=3D p->fix.line_length;=09
+	}
+}
+
+static inline void bitwise_blit(struct fb_image *image, struct fb_info *p,=
 char *dst1,
+				int fgcolor, int bgcolor)
+{
+	int i, j, k, l =3D 8, n, pad, ppw;
+	unsigned long tmp =3D ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
+	unsigned long fgx =3D fgcolor, bgx =3D bgcolor, eorx;
 	unsigned long end_mask;
 	unsigned long *dst =3D NULL;
+	char *src =3D image->data;
+
+	ppw =3D BITS_PER_LONG/p->var.bits_per_pixel;
+
+	for (i =3D 0; i < ppw-1; i++) {
+		fgx <<=3D p->var.bits_per_pixel;
+		bgx <<=3D p->var.bits_per_pixel;
+		fgx |=3D fgcolor;
+		bgx |=3D bgcolor;
+	}
+	eorx =3D fgx ^ bgx;
+	n =3D ((image->width + 7) >> 3);
+	pad =3D (n << 3) - image->width;
+	n =3D image->width % ppw;
+
+	for (i =3D 0; i < image->height; i++) {
+		dst =3D (unsigned long *) dst1;
+	=09
+		for (j =3D image->width/ppw; j > 0; j--) {
+			end_mask =3D 0;
+		=09
+			for (k =3D ppw; k > 0; k--) {
+				l--;
+				if (test_bit(l, (unsigned long *) src))
+					end_mask |=3D (tmp >> (p->var.bits_per_pixel*(k-1)));
+				if (!l) { l =3D 8; src++; }
+			}
+			fb_writel((end_mask & eorx)^bgx, dst);
+			dst++;
+		}
+	=09
+		if (n) {
+			end_mask =3D 0;=09
+			for (j =3D n; j > 0; j--) {
+				l--;
+				if (test_bit(l, (unsigned long *) src))
+					end_mask |=3D (tmp >> (p->var.bits_per_pixel*(j-1)));
+				if (!l) { l =3D 8; src++; }
+			}
+			fb_writel((end_mask & eorx)^bgx, dst);
+			dst++;
+		}
+		l -=3D pad;	=09
+		dst1 +=3D p->fix.line_length;=09
+	}=09
+}
+
+void cfb_imageblit(struct fb_info *p, struct fb_image *image)
+{
+	int x2, y2, n;
+	unsigned long fgcolor, bgcolor;=09
+	unsigned long end_mask;
 	u8 *dst1;
-	u8 *src;
=20
 	/*=20
 	 * We could use hardware clipping but on many cards you get around hardwa=
re
@@ -64,66 +277,32 @@
 	y2 =3D y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
 	image->width  =3D x2 - image->dx;
 	image->height =3D y2 - image->dy;
- =20
+
 	dst1 =3D p->screen_base + image->dy * p->fix.line_length +=20
 		((image->dx * p->var.bits_per_pixel) >> 3);
  =20
-	ppw =3D BITS_PER_LONG/p->var.bits_per_pixel;
-
-	src =3D image->data;=09
-
 	if (image->depth =3D=3D 1) {
-
 		if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {
-			fgx =3D fgcolor =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
-			bgx =3D bgcolor =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
+			fgcolor =3D ((u32 *)(p->pseudo_palette))[image->fg_color];
+			bgcolor =3D ((u32 *)(p->pseudo_palette))[image->bg_color];
 		} else {
-			fgx =3D fgcolor =3D image->fg_color;
-			bgx =3D bgcolor =3D image->bg_color;
+			fgcolor =3D image->fg_color;
+			bgcolor =3D image->bg_color;
 		}=09
 =20
-		for (i =3D 0; i < ppw-1; i++) {
-			fgx <<=3D p->var.bits_per_pixel;
-			bgx <<=3D p->var.bits_per_pixel;
-			fgx |=3D fgcolor;
-			bgx |=3D bgcolor;
-		}
-		eorx =3D fgx ^ bgx;
-		n =3D ((image->width + 7) >> 3);
-		pad =3D (n << 3) - image->width;
-		n =3D image->width % ppw;
-
-		for (i =3D 0; i < image->height; i++) {
-			dst =3D (unsigned long *) dst1;
-	=09
-			for (j =3D image->width/ppw; j > 0; j--) {
-				end_mask =3D 0;
-	=09
-				for (k =3D ppw; k > 0; k--) {
-					if (test_bit(l, (unsigned long *) src))
-						end_mask |=3D (tmp >> (p->var.bits_per_pixel*(k-1)));
-					l--;
-					if (l < 0) { l =3D 7; src++; }
-				}
-				fb_writel((end_mask & eorx)^bgx, dst);
-				dst++;
-			}
+		if (p->var.bits_per_pixel >=3D 8)  {
+			if (BITS_PER_LONG % p->var.bits_per_pixel =3D=3D 0)=20
+				fast_imageblit(image, p, dst1, fgcolor, bgcolor);
+			else=20
+				slow_imageblit(image, p, dst1, fgcolor, bgcolor);
+		}
+		else=20
+			/* Is there such a thing as 3 or 5 bits per pixel? */
+			slow_imageblit(image, p, dst1, fgcolor, bgcolor);
 	=09
-			if (n) {
-				end_mask =3D 0;=09
-				for (j =3D n; j > 0; j--) {
-					if (test_bit(l, (unsigned long *) src))
-						end_mask |=3D (tmp >> (p->var.bits_per_pixel*(j-1)));
-					l--;
-					if (l < 0) { l =3D 7; src++; }
-				}
-				fb_writel((end_mask & eorx)^bgx, dst);
-				dst++;
-			}
-			l -=3D pad;	=09
-			dst1 +=3D p->fix.line_length;=09
-		}=09
-	} else {
+	}
+=09
+	else {
 		/* Draw the penguin */
 		n =3D ((image->width * p->var.bits_per_pixel) >> 3);
 		end_mask =3D 0;
diff -Naur linux-2.5.27/drivers/video/fbcon-accel.c linux/drivers/video/fbc=
on-accel.c
--- linux-2.5.27/drivers/video/fbcon-accel.c	Thu Aug  8 21:42:11 2002
+++ linux/drivers/video/fbcon-accel.c	Thu Aug  8 21:43:00 2002
@@ -70,9 +70,44 @@
 	image.width =3D fontwidth(p);
 	image.height =3D fontheight(p);
 	image.depth =3D 1;
-	image.data =3D p->fontdata + (c & charmask)*fontheight(p)*width;
+	if (!info->pixmap.addr) {
+		image.data =3D p->fontdata + (c & charmask)*fontheight(p) * width;
+		info->fbops->fb_imageblit(info, &image);
+	}
+	else {
+		unsigned int d_size, d_pitch, i, j;=20
+		unsigned int scan_align =3D (info->pixmap.scan_align) ? info->pixmap.sca=
n_align - 1 : 0;
+		unsigned int buf_align =3D (info->pixmap.buf_align) ? info->pixmap.buf_a=
lign - 1 : 0;
+		char *d_addr, *s_addr;
+
+		d_pitch =3D (width + scan_align) & ~scan_align;
+		d_size =3D d_pitch * image.height;
+
+		if (d_size > info->pixmap.size) {
+			BUG();
+			return;
+		}
+	=09
+		info->pixmap.offset =3D (info->pixmap.offset + buf_align) & ~buf_align;
+
+		if (info->pixmap.offset + d_size > info->pixmap.size) {
+			if (info->fbops->fb_sync)=20
+				info->fbops->fb_sync(info);
+			info->pixmap.offset =3D 0;
+		}
+		s_addr =3D p->fontdata + (c & charmask)*fontheight(p)*width;
+		image.data =3D (char *) (info->pixmap.addr + info->pixmap.offset);
+		d_addr =3D image.data;
=20
-	info->fbops->fb_imageblit(info, &image);
+		for (i =3D image.height; i--; ) {
+			for (j =3D 0; j < width; j++)=20
+				d_addr[j] =3D *s_addr++;
+			d_addr +=3D d_pitch;
+		}
+
+		info->fbops->fb_imageblit(info, &image);
+		info->pixmap.offset +=3D d_size;
+	}
 }
=20
 void fbcon_accel_putcs(struct vc_data *vc, struct display *p,
@@ -81,21 +116,87 @@
 	struct fb_info *info =3D p->fb_info;
 	unsigned short charmask =3D p->charmask;
 	unsigned int width =3D ((fontwidth(p)+7)>>3);
+	unsigned int cell_size;
 	struct fb_image image;
=20
 	image.fg_color =3D attr_fgcol(p, *s);
 	image.bg_color =3D attr_bgcol(p, *s);
 	image.dx =3D xx * fontwidth(p);
 	image.dy =3D yy * fontheight(p);
-	image.width =3D fontwidth(p);
 	image.height =3D fontheight(p);
 	image.depth =3D 1;
+	cell_size =3D fontheight(p)*width;
+	if (!info->pixmap.addr) {
+		image.width =3D fontwidth(p);
+		while (count--) {
+			image.data =3D p->fontdata + (scr_readw(s++) & charmask) * cell_size;
+			info->fbops->fb_imageblit(info, &image);
+			image.dx +=3D fontwidth(p);
+		}
+	}
+	else {
+		unsigned int d_pitch, d_size, i, j;=20
+		unsigned int scan_align =3D (info->pixmap.scan_align) ? info->pixmap.sca=
n_align - 1 : 0;
+		unsigned int buf_align =3D (info->pixmap.buf_align) ? info->pixmap.buf_a=
lign - 1 : 0;
+		char *s_addr, *d_addr, *d_addr0;
+
+		d_pitch =3D (width * count) + scan_align;
+		d_pitch &=3D ~scan_align;
+		d_size =3D d_pitch * image.height;
+
+		if (d_size > info->pixmap.size) {
+			BUG();
+			return;
+		}
+
+		info->pixmap.offset =3D (info->pixmap.offset + buf_align) & ~buf_align;
+
+		if (info->pixmap.offset + d_size > info->pixmap.size) {=20
+			if (info->fbops->fb_sync)
+				info->fbops->fb_sync(info);
+			info->pixmap.offset =3D 0;
+		}
+
+		image.width =3D fontwidth(p) * count;
+		image.data =3D (char *) (info->pixmap.addr + info->pixmap.offset);
+		d_addr =3D image.data;
+
+		if (width =3D=3D 1 && count > 3) {
+			char *s1, *s2, *s3, *s4;
+
+			while (count > 3) {
+				s1 =3D p->fontdata + (scr_readw(s++) & charmask) * cell_size;
+				s2 =3D p->fontdata + (scr_readw(s++) & charmask) * cell_size;
+				s3 =3D p->fontdata + (scr_readw(s++) & charmask) * cell_size;
+				s4 =3D p->fontdata + (scr_readw(s++) & charmask) * cell_size;
+				d_addr0 =3D d_addr;
+
+				for (i =3D image.height; i--; ) {
+					*(unsigned long *) d_addr0 =3D=20
+						(unsigned long) ((*s1++ & 0xff)       |
+								 (*s2++ & 0xff) << 8  |
+								 (*s3++ & 0xff) << 16 |
+								 (*s4++ & 0xff) << 24   );
+					d_addr0 +=3D d_pitch;
+				}
+				count -=3D 4;
+				d_addr +=3D 4;
+			}
+		}
+
+		while (count--) {
+			s_addr =3D p->fontdata + (scr_readw(s++) & charmask) * cell_size;
+			d_addr0 =3D d_addr;
=20
-	while (count--) {
-		image.data =3D p->fontdata +
-			(scr_readw(s++) & charmask) * fontheight(p) * width;
+			for (i =3D image.height; i--; ) {
+				for (j =3D 0; j < width; j++)
+					d_addr0[j] =3D *s_addr++;
+				d_addr0 +=3D d_pitch;
+			}
+			d_addr +=3D width;
+		}
 		info->fbops->fb_imageblit(info, &image);
-		image.dx +=3D fontwidth(p);
+		info->pixmap.offset +=3D d_size;
 	}
 }
=20

--=-N4xGL2F2LIynwkg4eM8G--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
