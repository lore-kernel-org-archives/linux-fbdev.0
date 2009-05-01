From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v3] fbdev: fix fillrect for 24bpp modes
Date: Fri, 1 May 2009 23:47:30 +0200
Message-ID: <20090501214730.GA16860@tria>
References: <20090413170954.GA8403@tria> <20090417183617.ed7553cd.krzysztof.h1@poczta.fm> <20090417115048.0c5ca35d.akpm@linux-foundation.org> <20090418185234.GA17853@tria> <20090420160733.07e27238.akpm@linux-foundation.org>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763073AbZEAVry@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090420160733.07e27238.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: krzysztof.h1@poczta.fm, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The software fillrect routines do not work properly when the number of
pixels per machine word is not an integer.  To see that, run the follow=
ing
command on a fbdev console with a 24bpp video mode, using a non-acceler=
ated
driver such as (u)vesafb:

  reset ; echo -e '\e[41mtest\e[K'

The expected result is 'test' displayed on a line with red background.
Instead of that, 'test' has a red background, but the rest of the line
(rendered using fillrect()) contains a distored colorful pattern.

This patch fixes the problem by correctly computing rotation shifts.
It has been tested in a 24bpp mode on 32- and 64-bit little-endian
machines.

Signed-off-by: Micha=C5=82 Januszewski <spock@gentoo.org>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>=09
---
This is a cleanup of the version 2 of this patch.

diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
index 64b3576..ba9f58b 100644
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -9,10 +9,6 @@
  *
  * NOTES:
  *
- *  The code for depths like 24 that don't have integer number of pixe=
ls per
- *  long is broken and needs to be fixed. For now I turned these types=
 of
- *  mode off.
- *
  *  Also need to add code to deal with cards endians that are differen=
t than
  *  the native cpu endians. I also need to deal with MSB position in t=
he word.
  *
@@ -139,7 +135,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long =
__iomem *dst, int dst_idx,
=20
 		// Trailing bits
 		if (last)
-			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
 	}
 }
=20
@@ -281,7 +277,7 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned l=
ong __iomem *dst,
=20
 void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
-	unsigned long pat, fg;
+	unsigned long pat, pat2, fg;
 	unsigned long width =3D rect->width, height =3D rect->height;
 	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
 	u32 bpp =3D p->var.bits_per_pixel;
@@ -297,7 +293,7 @@ void cfb_fillrect(struct fb_info *p, const struct f=
b_fillrect *rect)
 	else
 		fg =3D rect->color;
=20
-	pat =3D pixel_to_pat( bpp, fg);
+	pat =3D pixel_to_pat(bpp, fg);
=20
 	dst =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(b=
ytes-1));
 	dst_idx =3D ((unsigned long)p->screen_base & (bytes - 1))*8;
@@ -333,17 +329,16 @@ void cfb_fillrect(struct fb_info *p, const struct=
 fb_fillrect *rect)
 			dst_idx +=3D p->fix.line_length*8;
 		}
 	} else {
-		int right;
-		int r;
-		int rot =3D (left-dst_idx) % bpp;
+		int right, r;
 		void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
 				int dst_idx, unsigned long pat, int left,
 				int right, unsigned n, int bits) =3D NULL;
-
-		/* rotate pattern to correct start position */
-		pat =3D pat << rot | pat >> (bpp-rot);
-
-		right =3D bpp-left;
+#ifdef __LITTLE_ENDIAN
+		right =3D left;
+		left =3D bpp - right;
+#else
+		right =3D bpp - left;
+#endif
 		switch (rect->rop) {
 		case ROP_XOR:
 			fill_op =3D bitfill_unaligned_rev;
@@ -352,17 +347,18 @@ void cfb_fillrect(struct fb_info *p, const struct=
 fb_fillrect *rect)
 			fill_op =3D bitfill_unaligned;
 			break;
 		default:
-			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_CO=
PY\n");
+			printk(KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COP=
Y\n");
 			fill_op =3D bitfill_unaligned;
 			break;
 		}
 		while (height--) {
-			dst +=3D dst_idx >> (ffs(bits) - 1);
+			dst +=3D dst_idx / bits;
 			dst_idx &=3D (bits - 1);
-			fill_op(p, dst, dst_idx, pat, left, right,
+			r =3D dst_idx % bpp;
+			/* rotate pattern to the correct start position */
+			pat2 =3D le_long_to_cpu(rolx(cpu_to_le_long(pat), r, bpp));
+			fill_op(p, dst, dst_idx, pat2, left, right,
 				width*bpp, bits);
-			r =3D (p->fix.line_length*8) % bpp;
-			pat =3D pat << (bpp-r) | pat >> r;
 			dst_idx +=3D p->fix.line_length*8;
 		}
 	}
diff --git a/drivers/video/fb_draw.h b/drivers/video/fb_draw.h
index 1db6221..04c01fa 100644
--- a/drivers/video/fb_draw.h
+++ b/drivers/video/fb_draw.h
@@ -33,11 +33,11 @@ pixel_to_pat( u32 bpp, u32 pixel)
 	case 8:
 		return 0x0101010101010101ul*pixel;
 	case 12:
-		return 0x0001001001001001ul*pixel;
+		return 0x1001001001001001ul*pixel;
 	case 16:
 		return 0x0001000100010001ul*pixel;
 	case 24:
-		return 0x0000000001000001ul*pixel;
+		return 0x0001000001000001ul*pixel;
 	case 32:
 		return 0x0000000100000001ul*pixel;
 	default:
@@ -58,11 +58,11 @@ pixel_to_pat( u32 bpp, u32 pixel)
 	case 8:
 		return 0x01010101ul*pixel;
 	case 12:
-		return 0x00001001ul*pixel;
+		return 0x01001001ul*pixel;
 	case 16:
 		return 0x00010001ul*pixel;
 	case 24:
-		return 0x00000001ul*pixel;
+		return 0x01000001ul*pixel;
 	case 32:
 		return 0x00000001ul*pixel;
 	default:
@@ -167,4 +167,17 @@ static inline unsigned long fb_rev_pixels_in_long(=
unsigned long val,
=20
 #endif  /* CONFIG_FB_CFB_REV_PIXELS_IN_BYTE */
=20
+#define cpu_to_le_long _cpu_to_le_long(BITS_PER_LONG)
+#define _cpu_to_le_long(x) __cpu_to_le_long(x)
+#define __cpu_to_le_long(x) cpu_to_le##x
+
+#define le_long_to_cpu _le_long_to_cpu(BITS_PER_LONG)
+#define _le_long_to_cpu(x) __le_long_to_cpu(x)
+#define __le_long_to_cpu(x) le##x##_to_cpu
+
+static inline unsigned long rolx(unsigned long word, unsigned int shif=
t, unsigned int x)
+{
+	return (word << shift) | (word >> (x - shift));
+}
+
 #endif /* FB_DRAW_H */
diff --git a/drivers/video/sysfillrect.c b/drivers/video/sysfillrect.c
index f94d6b6..33ee3d3 100644
--- a/drivers/video/sysfillrect.c
+++ b/drivers/video/sysfillrect.c
@@ -124,7 +124,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long =
*dst, int dst_idx,
=20
 		/* Trailing bits */
 		if (last)
-			*dst =3D comp(pat, *dst, first);
+			*dst =3D comp(pat, *dst, last);
 	}
 }
=20
@@ -242,7 +242,7 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned l=
ong *dst, int dst_idx,
=20
 void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
-	unsigned long pat, fg;
+	unsigned long pat, pat2, fg;
 	unsigned long width =3D rect->width, height =3D rect->height;
 	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
 	u32 bpp =3D p->var.bits_per_pixel;
@@ -292,17 +292,16 @@ void sys_fillrect(struct fb_info *p, const struct=
 fb_fillrect *rect)
 			dst_idx +=3D p->fix.line_length*8;
 		}
 	} else {
-		int right;
-		int r;
-		int rot =3D (left-dst_idx) % bpp;
+		int right, r;
 		void (*fill_op)(struct fb_info *p, unsigned long *dst,
 				int dst_idx, unsigned long pat, int left,
 				int right, unsigned n, int bits) =3D NULL;
-
-		/* rotate pattern to correct start position */
-		pat =3D pat << rot | pat >> (bpp-rot);
-
-		right =3D bpp-left;
+#ifdef __LITTLE_ENDIAN
+		right =3D left;
+		left =3D bpp - right;
+#else
+		right =3D bpp - left;
+#endif
 		switch (rect->rop) {
 		case ROP_XOR:
 			fill_op =3D bitfill_unaligned_rev;
@@ -311,18 +310,19 @@ void sys_fillrect(struct fb_info *p, const struct=
 fb_fillrect *rect)
 			fill_op =3D bitfill_unaligned;
 			break;
 		default:
-			printk(KERN_ERR "cfb_fillrect(): unknown rop, "
+			printk(KERN_ERR "sys_fillrect(): unknown rop, "
 				"defaulting to ROP_COPY\n");
 			fill_op =3D bitfill_unaligned;
 			break;
 		}
 		while (height--) {
-			dst +=3D dst_idx >> (ffs(bits) - 1);
+			dst +=3D dst_idx / bits;
 			dst_idx &=3D (bits - 1);
-			fill_op(p, dst, dst_idx, pat, left, right,
+			r =3D dst_idx % bpp;
+			/* rotate pattern to the correct start position */
+			pat2 =3D le_long_to_cpu(rolx(cpu_to_le_long(pat), r, bpp));
+			fill_op(p, dst, dst_idx, pat2, left, right,
 				width*bpp, bits);
-			r =3D (p->fix.line_length*8) % bpp;
-			pat =3D pat << (bpp-r) | pat >> r;
 			dst_idx +=3D p->fix.line_length*8;
 		}
 	}
