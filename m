Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AE1DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500270; cv=none; b=pcjN9udmpbVuNjL0oLOd+OWYwZhjvd7BMSpSu9L7oHDPR6xb0mINSbnrOrhsiA7aoK8j2IRjAzDxblHfQYh6hg0i5L16yjm37FtBpmU5l53JafbK/E/IYDWNZ8uCpvD+cmn8PoP9i3Qn84o5QUpepCzBSIJOqmvQiJWTDoW7gZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500270; c=relaxed/simple;
	bh=SyNqmKw3UnjhV+zg23p2W2qbzlXnVzcyMGhARp+6fVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Ip4eJGXelbo7uff9XVClZ0lSAC/RGebrzhFNjtAL0eZ0olLamUiLZWTGFDYVLxyZ4un69G1i2ampHWxkEM3Bko/rL72lvx9khDsV54hsrwoIwE/f25tF61a+6xPjkLUa6qI6ExWxQ8XyEncRvslDhHMtfOm9niqdwOVE+0nnb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 43F58100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:44:26 +0100 (CET)
Message-ID: <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:44:26 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 06/12] fbdev: core: Make fb_fillrect generic
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
 <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
In-Reply-To: <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ESpZbXZg6Iozd5OGCohjOHxR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ESpZbXZg6Iozd5OGCohjOHxR
Content-Type: multipart/mixed; boundary="------------3aDjAfUfCz8i1zWuhb7gjVjZ";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
Subject: [RFC PATCH 06/12] fbdev: core: Make fb_fillrect generic
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
 <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
In-Reply-To: <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>

--------------3aDjAfUfCz8i1zWuhb7gjVjZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Make fb_fillrect generic

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_fillrect.h | 89 +++++++++++---------------
 1 file changed, 37 insertions(+), 52 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_fillrect.h b/drivers/video/fbdev=
/core/fb_fillrect.h
index cbaa4c9e2..3ee29e56d 100644
--- a/drivers/video/fbdev/core/fb_fillrect.h
+++ b/drivers/video/fbdev/core/fb_fillrect.h
@@ -13,26 +13,14 @@
  *  the native cpu endians. I also need to deal with MSB position in the=
 word.
  *
  */
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/fb.h>
-#include <asm/types.h>
 #include "fb_draw.h"
=20
-#if BITS_PER_LONG =3D=3D 32
-#  define FB_WRITEL fb_writel
-#  define FB_READL  fb_readl
-#else
-#  define FB_WRITEL fb_writeq
-#  define FB_READL  fb_readq
-#endif
-
     /*
      *  Aligned pattern fill using 32/64-bit memory accesses
      */
=20
 static void
-bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_i=
dx,
+bitfill_aligned(struct fb_info *p, unsigned long FB_MEM *dst, int dst_id=
x,
 		unsigned long pat, unsigned n, int bits, u32 bswapmask)
 {
 	unsigned long first, last;
@@ -44,21 +32,21 @@ bitfill_aligned(struct fb_info *p, unsigned long __io=
mem *dst, int dst_idx,
 	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
=20
 	if (dst_idx+n <=3D bits) {
-		// Single word
+		/* Single word */
 		if (last)
 			first &=3D last;
 		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 	} else {
-		// Multiple destination words
+		/* Multiple destination words */
=20
-		// Leading bits
+		/* Leading bits */
 		if (first!=3D ~0UL) {
 			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 			dst++;
 			n -=3D bits - dst_idx;
 		}
=20
-		// Main chunk
+		/* Main chunk */
 		n /=3D bits;
 		while (n >=3D 8) {
 			FB_WRITEL(pat, dst++);
@@ -74,7 +62,7 @@ bitfill_aligned(struct fb_info *p, unsigned long __iome=
m *dst, int dst_idx,
 		while (n--)
 			FB_WRITEL(pat, dst++);
=20
-		// Trailing bits
+		/* Trailing bits */
 		if (last)
 			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
 	}
@@ -89,7 +77,7 @@ bitfill_aligned(struct fb_info *p, unsigned long __iome=
m *dst, int dst_idx,
      */
=20
 static void
-bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst=
_idx,
+bitfill_unaligned(struct fb_info *p, unsigned long FB_MEM *dst, int dst_=
idx,
 		  unsigned long pat, int left, int right, unsigned n, int bits)
 {
 	unsigned long first, last;
@@ -101,13 +89,13 @@ bitfill_unaligned(struct fb_info *p, unsigned long _=
_iomem *dst, int dst_idx,
 	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
=20
 	if (dst_idx+n <=3D bits) {
-		// Single word
+		/* Single word */
 		if (last)
 			first &=3D last;
 		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 	} else {
-		// Multiple destination words
-		// Leading bits
+		/* Multiple destination words */
+		/* Leading bits */
 		if (first) {
 			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 			dst++;
@@ -115,7 +103,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __=
iomem *dst, int dst_idx,
 			n -=3D bits - dst_idx;
 		}
=20
-		// Main chunk
+		/* Main chunk */
 		n /=3D bits;
 		while (n >=3D 4) {
 			FB_WRITEL(pat, dst++);
@@ -133,7 +121,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __=
iomem *dst, int dst_idx,
 			pat =3D pat << left | pat >> right;
 		}
=20
-		// Trailing bits
+		/* Trailing bits */
 		if (last)
 			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
 	}
@@ -143,7 +131,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __=
iomem *dst, int dst_idx,
      *  Aligned pattern invert using 32/64-bit memory accesses
      */
 static void
-bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
+bitfill_aligned_rev(struct fb_info *p, unsigned long FB_MEM *dst,
 		    int dst_idx, unsigned long pat, unsigned n, int bits,
 		    u32 bswapmask)
 {
@@ -157,14 +145,14 @@ bitfill_aligned_rev(struct fb_info *p, unsigned lon=
g __iomem *dst,
 	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
=20
 	if (dst_idx+n <=3D bits) {
-		// Single word
+		/* Single word */
 		if (last)
 			first &=3D last;
 		dat =3D FB_READL(dst);
 		FB_WRITEL(comp(dat ^ val, dat, first), dst);
 	} else {
-		// Multiple destination words
-		// Leading bits
+		/* Multiple destination words */
+		/* Leading bits */
 		if (first!=3D0UL) {
 			dat =3D FB_READL(dst);
 			FB_WRITEL(comp(dat ^ val, dat, first), dst);
@@ -172,7 +160,7 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long =
__iomem *dst,
 			n -=3D bits - dst_idx;
 		}
=20
-		// Main chunk
+		/* Main chunk */
 		n /=3D bits;
 		while (n >=3D 8) {
 			FB_WRITEL(FB_READL(dst) ^ val, dst);
@@ -197,7 +185,7 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long =
__iomem *dst,
 			FB_WRITEL(FB_READL(dst) ^ val, dst);
 			dst++;
 		}
-		// Trailing bits
+		/* Trailing bits */
 		if (last) {
 			dat =3D FB_READL(dst);
 			FB_WRITEL(comp(dat ^ val, dat, last), dst);
@@ -214,7 +202,7 @@ bitfill_aligned_rev(struct fb_info *p, unsigned long =
__iomem *dst,
      */
=20
 static void
-bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
+bitfill_unaligned_rev(struct fb_info *p, unsigned long FB_MEM *dst,
 		      int dst_idx, unsigned long pat, int left, int right,
 		      unsigned n, int bits)
 {
@@ -227,15 +215,15 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned l=
ong __iomem *dst,
 	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
=20
 	if (dst_idx+n <=3D bits) {
-		// Single word
+		/* Single word */
 		if (last)
 			first &=3D last;
 		dat =3D FB_READL(dst);
 		FB_WRITEL(comp(dat ^ pat, dat, first), dst);
 	} else {
-		// Multiple destination words
+		/* Multiple destination words */
=20
-		// Leading bits
+		/* Leading bits */
 		if (first !=3D 0UL) {
 			dat =3D FB_READL(dst);
 			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
@@ -244,7 +232,7 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned lon=
g __iomem *dst,
 			n -=3D bits - dst_idx;
 		}
=20
-		// Main chunk
+		/* Main chunk */
 		n /=3D bits;
 		while (n >=3D 4) {
 			FB_WRITEL(FB_READL(dst) ^ pat, dst);
@@ -267,7 +255,7 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned lon=
g __iomem *dst,
 			pat =3D pat << left | pat >> right;
 		}
=20
-		// Trailing bits
+		/* Trailing bits */
 		if (last) {
 			dat =3D FB_READL(dst);
 			FB_WRITEL(comp(dat ^ pat, dat, last), dst);
@@ -275,20 +263,21 @@ bitfill_unaligned_rev(struct fb_info *p, unsigned l=
ong __iomem *dst,
 	}
 }
=20
-void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
+void FB_FILLRECT(struct fb_info *p, const struct fb_fillrect *rect)
 {
 	unsigned long pat, pat2, fg;
 	unsigned long width =3D rect->width, height =3D rect->height;
 	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
 	u32 bpp =3D p->var.bits_per_pixel;
-	unsigned long __iomem *dst;
+	unsigned long FB_MEM *dst;
 	int dst_idx, left;
=20
 	if (p->state !=3D FBINFO_STATE_RUNNING)
 		return;
=20
-	if (p->flags & FBINFO_VIRTFB)
-		fb_warn_once(p, "Framebuffer is not in I/O address space.");
+	if ((p->flags & FBINFO_VIRTFB) !=3D FB_SPACE)
+		fb_warn_once(p, "Framebuffer is not in " FB_SPACE_NAME
+                             " address space.");
=20
 	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
 	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
@@ -298,8 +287,8 @@ void cfb_fillrect(struct fb_info *p, const struct fb_=
fillrect *rect)
=20
 	pat =3D pixel_to_pat(bpp, fg);
=20
-	dst =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(byt=
es-1));
-	dst_idx =3D ((unsigned long)p->screen_base & (bytes - 1))*8;
+	dst =3D (unsigned long FB_MEM *)((unsigned long)FB_SCREEN_BASE(p) & ~(b=
ytes-1));
+	dst_idx =3D ((unsigned long)FB_SCREEN_BASE(p) & (bytes - 1))*8;
 	dst_idx +=3D rect->dy*p->fix.line_length*8+rect->dx*bpp;
 	/* FIXME For now we support 1-32 bpp only */
 	left =3D bits % bpp;
@@ -308,7 +297,7 @@ void cfb_fillrect(struct fb_info *p, const struct fb_=
fillrect *rect)
 	if (!left) {
 		u32 bswapmask =3D fb_compute_bswapmask(p);
 		void (*fill_op32)(struct fb_info *p,
-				  unsigned long __iomem *dst, int dst_idx,
+				  unsigned long FB_MEM *dst, int dst_idx,
 		                  unsigned long pat, unsigned n, int bits,
 				  u32 bswapmask) =3D NULL;
=20
@@ -320,7 +309,8 @@ void cfb_fillrect(struct fb_info *p, const struct fb_=
fillrect *rect)
 			fill_op32 =3D bitfill_aligned;
 			break;
 		default:
-			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY=
\n");
+			printk( KERN_ERR FB_FILLRECT_NAME "(): unknown rop, "
+				"defaulting to ROP_COPY\n");
 			fill_op32 =3D bitfill_aligned;
 			break;
 		}
@@ -333,7 +323,7 @@ void cfb_fillrect(struct fb_info *p, const struct fb_=
fillrect *rect)
 		}
 	} else {
 		int right, r;
-		void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
+		void (*fill_op)(struct fb_info *p, unsigned long FB_MEM *dst,
 				int dst_idx, unsigned long pat, int left,
 				int right, unsigned n, int bits) =3D NULL;
 #ifdef __LITTLE_ENDIAN
@@ -350,7 +340,8 @@ void cfb_fillrect(struct fb_info *p, const struct fb_=
fillrect *rect)
 			fill_op =3D bitfill_unaligned;
 			break;
 		default:
-			printk(KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\=
n");
+			printk(KERN_ERR FB_FILLRECT_NAME "(): unknown rop, "
+				"defaulting to ROP_COPY\n");
 			fill_op =3D bitfill_unaligned;
 			break;
 		}
@@ -366,9 +357,3 @@ void cfb_fillrect(struct fb_info *p, const struct fb_=
fillrect *rect)
 		}
 	}
 }
-
-EXPORT_SYMBOL(cfb_fillrect);
-
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-MODULE_DESCRIPTION("Generic software accelerated fill rectangle");
-MODULE_LICENSE("GPL");
--=20
2.30.2



--------------3aDjAfUfCz8i1zWuhb7gjVjZ--

--------------ESpZbXZg6Iozd5OGCohjOHxR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaKoFAwAAAAAACgkQWOeEu4KftGtz
vgf/bLAg1WMsC/NolnPLtz9+kBzB9WQZLK+eq9NasOlmwaak/LmjVHEt28C/hhSEdVeuD0QtB2zI
n8qsWuzjXAlLPlrMoXPuJB9q9oW51qw4WFuSJovpmmZNbk0PFpv5bPftguQq3cIGX8os8S+w5YET
of9RmulGRt19wZ3gKHTxX9djmwVVhsOOwv4yLFETALbVyPipnh5owH75E4+f4Yhmu9a8yNRBJj6f
NKZ9M2zO1wF/aEnZ0UsG2xHj6zHJA/2WWZJEMwWVP24idJyC4YzRJ6IGX3votdYd1N8YxE+xImtX
847INMkn7P4m9HUTHD+ZKuvtZ37Bo3uGTnjSkZr2/w==
=mgls
-----END PGP SIGNATURE-----

--------------ESpZbXZg6Iozd5OGCohjOHxR--
