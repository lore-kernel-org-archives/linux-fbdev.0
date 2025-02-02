Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAE1DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500085; cv=none; b=FcHIG9AqtVD59z4hdmyBYjBpF6S2YEmZTcE/1HXVMrkYWz/FEmb3PwhhTt2ZeMCxmNEAC/QFF5BEszNtZipd70gtRqpZxtL8/tmV/d5nQdHIIQI63ZuvIQH+Nk4D+Jnp2DAulGVj8IxSeTaikhsA04ky8BxOuifgKhE6HRZrIMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500085; c=relaxed/simple;
	bh=PGWa/A93iO0Di96lNG7c3vftxtQOea6Cjtb+xRAq+bA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=pkU9RGq4+lPCVMJgEamgwKlbKWgQXLbfGsfD8bJfwO9kyTJdnBwPAtn80M/GvkOyPppwBRJCuSfQyNPOOmh9keA2TtT9l1GGhIK2ZNPI4smhyOQEmkIg5aLgRHRGRNgoYcAV+FIrLztGVqTNS94k+097fTWuCpnAopuj1/OOssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id BF3BB100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:41:20 +0100 (CET)
Message-ID: <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:41:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 02/12] Deduplicate cfb/sys drawing fbops
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
In-Reply-To: <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JEQZdj4SxYBNemU2xb5T1Znv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JEQZdj4SxYBNemU2xb5T1Znv
Content-Type: multipart/mixed; boundary="------------2A5ZPQL4p4S2HmrvJMDLpy1a";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
Subject: Re: [RFC PATCH 02/12] Deduplicate cfb/sys drawing fbops
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
In-Reply-To: <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>

--------------2A5ZPQL4p4S2HmrvJMDLpy1a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Make fb_copyarea generic

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_copyarea.h | 145 +++++++++++--------------
 1 file changed, 63 insertions(+), 82 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_copyarea.h b/drivers/video/fbdev=
/core/fb_copyarea.h
index a271f57d9..688b9cc95 100644
--- a/drivers/video/fbdev/core/fb_copyarea.h
+++ b/drivers/video/fbdev/core/fb_copyarea.h
@@ -21,30 +21,15 @@
  *  the ones for filling, i.e. in aligned and unaligned versions. This w=
ould
  *  help moving some redundant computations and branches out of the loop=
, too.
  */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/fb.h>
-#include <asm/types.h>
-#include <asm/io.h>
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
      *  Generic bitwise copy algorithm
      */
=20
 static void
-bitcpy(struct fb_info *p, unsigned long __iomem *dst, unsigned dst_idx,
-		const unsigned long __iomem *src, unsigned src_idx, int bits,
+bitcpy(struct fb_info *p, unsigned long FB_MEM *dst, unsigned dst_idx,
+		const unsigned long FB_MEM *src, unsigned src_idx, int bits,
 		unsigned n, u32 bswapmask)
 {
 	unsigned long first, last;
@@ -64,17 +49,17 @@ bitcpy(struct fb_info *p, unsigned long __iomem *dst,=
 unsigned dst_idx,
 	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
=20
 	if (!shift) {
-		// Same alignment for source and dest
+		/* Same alignment for source and dest */
=20
 		if (dst_idx+n <=3D bits) {
-			// Single word
+			/* Single word */
 			if (last)
 				first &=3D last;
 			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 		} else {
-			// Multiple destination words
+			/* Multiple destination words */
=20
-			// Leading bits
+			/* Leading bits */
 			if (first !=3D ~0UL) {
 				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 				dst++;
@@ -82,7 +67,7 @@ bitcpy(struct fb_info *p, unsigned long __iomem *dst, u=
nsigned dst_idx,
 				n -=3D bits - dst_idx;
 			}
=20
-			// Main chunk
+			/* Main chunk */
 			n /=3D bits;
 			while (n >=3D 8) {
 				FB_WRITEL(FB_READL(src++), dst++);
@@ -98,7 +83,7 @@ bitcpy(struct fb_info *p, unsigned long __iomem *dst, u=
nsigned dst_idx,
 			while (n--)
 				FB_WRITEL(FB_READL(src++), dst++);
=20
-			// Trailing bits
+			/* Trailing bits */
 			if (last)
 				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
 		}
@@ -111,19 +96,19 @@ bitcpy(struct fb_info *p, unsigned long __iomem *dst=
, unsigned dst_idx,
 		int const right =3D -shift & (bits - 1);
=20
 		if (dst_idx+n <=3D bits) {
-			// Single destination word
+			/* Single destination word */
 			if (last)
 				first &=3D last;
 			d0 =3D FB_READL(src);
 			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
 			if (shift > 0) {
-				// Single source word
+				/* Single source word */
 				d0 <<=3D left;
 			} else if (src_idx+n <=3D bits) {
-				// Single source word
+				/* Single source word */
 				d0 >>=3D right;
 			} else {
-				// 2 source words
+				/* 2 source words */
 				d1 =3D FB_READL(src + 1);
 				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
 				d0 =3D d0 >> right | d1 << left;
@@ -131,22 +116,23 @@ bitcpy(struct fb_info *p, unsigned long __iomem *ds=
t, unsigned dst_idx,
 			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
 			FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
 		} else {
-			// Multiple destination words
-			/** We must always remember the last value read, because in case
-			SRC and DST overlap bitwise (e.g. when moving just one pixel in
-			1bpp), we always collect one full long for DST and that might
-			overlap with the current long from SRC. We store this value in
-			'd0'. */
+			/* Multiple destination words */
+			/** We must always remember the last value read,
+			    because in case SRC and DST overlap bitwise (e.g.
+			    when moving just one pixel in 1bpp), we always
+			    collect one full long for DST and that might
+			    overlap with the current long from SRC. We store
+			    this value in 'd0'. */
 			d0 =3D FB_READL(src++);
 			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			// Leading bits
+			/* Leading bits */
 			if (shift > 0) {
-				// Single source word
+				/* Single source word */
 				d1 =3D d0;
 				d0 <<=3D left;
 				n -=3D bits - dst_idx;
 			} else {
-				// 2 source words
+				/* 2 source words */
 				d1 =3D FB_READL(src++);
 				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
=20
@@ -158,7 +144,7 @@ bitcpy(struct fb_info *p, unsigned long __iomem *dst,=
 unsigned dst_idx,
 			d0 =3D d1;
 			dst++;
=20
-			// Main chunk
+			/* Main chunk */
 			m =3D n % bits;
 			n /=3D bits;
 			while ((n >=3D 4) && !bswapmask) {
@@ -185,13 +171,13 @@ bitcpy(struct fb_info *p, unsigned long __iomem *ds=
t, unsigned dst_idx,
 				d0 =3D d1;
 			}
=20
-			// Trailing bits
+			/* Trailing bits */
 			if (m) {
 				if (m <=3D bits - right) {
-					// Single source word
+					/* Single source word */
 					d0 >>=3D right;
 				} else {
-					// 2 source words
+					/* 2 source words */
 					d1 =3D FB_READL(src);
 					d1 =3D fb_rev_pixels_in_long(d1,
 								bswapmask);
@@ -209,8 +195,8 @@ bitcpy(struct fb_info *p, unsigned long __iomem *dst,=
 unsigned dst_idx,
      */
=20
 static void
-bitcpy_rev(struct fb_info *p, unsigned long __iomem *dst, unsigned dst_i=
dx,
-		const unsigned long __iomem *src, unsigned src_idx, int bits,
+bitcpy_rev(struct fb_info *p, unsigned long FB_MEM *dst, unsigned dst_id=
x,
+		const unsigned long FB_MEM *src, unsigned src_idx, int bits,
 		unsigned n, u32 bswapmask)
 {
 	unsigned long first, last;
@@ -237,17 +223,17 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem=
 *dst, unsigned dst_idx,
 	last =3D fb_shifted_pixels_mask_long(p, (bits + dst_idx + 1 - n) % bits=
, bswapmask);
=20
 	if (!shift) {
-		// Same alignment for source and dest
+		/* Same alignment for source and dest */
=20
 		if ((unsigned long)dst_idx+1 >=3D n) {
-			// Single word
+			/* Single word */
 			if (first)
 				last &=3D first;
 			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
 		} else {
-			// Multiple destination words
+			/* Multiple destination words */
=20
-			// Leading bits
+			/* Leading bits */
 			if (first) {
 				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 				dst--;
@@ -255,7 +241,7 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem *=
dst, unsigned dst_idx,
 				n -=3D dst_idx+1;
 			}
=20
-			// Main chunk
+			/* Main chunk */
 			n /=3D bits;
 			while (n >=3D 8) {
 				FB_WRITEL(FB_READL(src--), dst--);
@@ -271,12 +257,12 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem=
 *dst, unsigned dst_idx,
 			while (n--)
 				FB_WRITEL(FB_READL(src--), dst--);
=20
-			// Trailing bits
+			/* Trailing bits */
 			if (last !=3D -1UL)
 				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
 		}
 	} else {
-		// Different alignment for source and dest
+		/* Different alignment for source and dest */
 		unsigned long d0, d1;
 		int m;
=20
@@ -284,18 +270,18 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem=
 *dst, unsigned dst_idx,
 		int const right =3D -shift & (bits-1);
=20
 		if ((unsigned long)dst_idx+1 >=3D n) {
-			// Single destination word
+			/* Single destination word */
 			if (first)
 				last &=3D first;
 			d0 =3D FB_READL(src);
 			if (shift < 0) {
-				// Single source word
+				/* Single source word */
 				d0 >>=3D right;
 			} else if (1+(unsigned long)src_idx >=3D n) {
-				// Single source word
+				/* Single source word */
 				d0 <<=3D left;
 			} else {
-				// 2 source words
+				/* 2 source words */
 				d1 =3D FB_READL(src - 1);
 				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
 				d0 =3D d0 << left | d1 >> right;
@@ -303,22 +289,23 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem=
 *dst, unsigned dst_idx,
 			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
 			FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
 		} else {
-			// Multiple destination words
-			/** We must always remember the last value read, because in case
-			SRC and DST overlap bitwise (e.g. when moving just one pixel in
-			1bpp), we always collect one full long for DST and that might
-			overlap with the current long from SRC. We store this value in
-			'd0'. */
+			/* Multiple destination words */
+			/** We must always remember the last value read,
+			    because in case SRC and DST overlap bitwise (e.g.
+			    when moving just one pixel in 1bpp), we always
+			    collect one full long for DST and that might
+			    overlap with the current long from SRC. We store
+			    this value in 'd0'. */
=20
 			d0 =3D FB_READL(src--);
 			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			// Leading bits
+			/* Leading bits */
 			if (shift < 0) {
-				// Single source word
+				/* Single source word */
 				d1 =3D d0;
 				d0 >>=3D right;
 			} else {
-				// 2 source words
+				/* 2 source words */
 				d1 =3D FB_READL(src--);
 				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
 				d0 =3D d0 << left | d1 >> right;
@@ -332,7 +319,7 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem *=
dst, unsigned dst_idx,
 			dst--;
 			n -=3D dst_idx+1;
=20
-			// Main chunk
+			/* Main chunk */
 			m =3D n % bits;
 			n /=3D bits;
 			while ((n >=3D 4) && !bswapmask) {
@@ -359,13 +346,13 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem=
 *dst, unsigned dst_idx,
 				d0 =3D d1;
 			}
=20
-			// Trailing bits
+			/* Trailing bits */
 			if (m) {
 				if (m <=3D bits - left) {
-					// Single source word
+					/* Single source word */
 					d0 <<=3D left;
 				} else {
-					// 2 source words
+					/* 2 source words */
 					d1 =3D FB_READL(src);
 					d1 =3D fb_rev_pixels_in_long(d1,
 								bswapmask);
@@ -378,12 +365,12 @@ bitcpy_rev(struct fb_info *p, unsigned long __iomem=
 *dst, unsigned dst_idx,
 	}
 }
=20
-void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
+void FB_COPYAREA(struct fb_info *p, const struct fb_copyarea *area)
 {
 	u32 dx =3D area->dx, dy =3D area->dy, sx =3D area->sx, sy =3D area->sy;=

 	u32 height =3D area->height, width =3D area->width;
 	unsigned int const bits_per_line =3D p->fix.line_length * 8u;
-	unsigned long __iomem *base =3D NULL;
+	unsigned long FB_MEM *base =3D NULL;
 	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
 	unsigned dst_idx =3D 0, src_idx =3D 0, rev_copy =3D 0;
 	u32 bswapmask =3D fb_compute_bswapmask(p);
@@ -391,8 +378,9 @@ void cfb_copyarea(struct fb_info *p, const struct fb_=
copyarea *area)
 	if (p->state !=3D FBINFO_STATE_RUNNING)
 		return;
=20
-	if (p->flags & FBINFO_VIRTFB)
-		fb_warn_once(p, "Framebuffer is not in I/O address space.");
+	if ((p->flags & FBINFO_VIRTFB) !=3D FB_SPACE)
+		fb_warn_once(p, "Framebuffer is not in " FB_SPACE_NAME
+                             " address space.");
=20
 	/* if the beginning of the target area might overlap with the end of
 	the source area, be have to copy the area reverse. */
@@ -402,11 +390,11 @@ void cfb_copyarea(struct fb_info *p, const struct f=
b_copyarea *area)
 		rev_copy =3D 1;
 	}
=20
-	// split the base of the framebuffer into a long-aligned address and th=
e
-	// index of the first bit
-	base =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(by=
tes-1));
-	dst_idx =3D src_idx =3D 8*((unsigned long)p->screen_base & (bytes-1));
-	// add offset of source and target area
+	/* split the base of the framebuffer into a long-aligned address and
+	   the index of the first bit */
+	base =3D (unsigned long FB_MEM *)((unsigned long)FB_SCREEN_BASE(p) & ~(=
bytes-1));
+	dst_idx =3D src_idx =3D 8*((unsigned long)FB_SCREEN_BASE(p) & (bytes-1)=
);
+	/* add offset of source and target area */
 	dst_idx +=3D dy*bits_per_line + dx*p->var.bits_per_pixel;
 	src_idx +=3D sy*bits_per_line + sx*p->var.bits_per_pixel;
=20
@@ -431,10 +419,3 @@ void cfb_copyarea(struct fb_info *p, const struct fb=
_copyarea *area)
 		}
 	}
 }
-
-EXPORT_SYMBOL(cfb_copyarea);
-
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-MODULE_DESCRIPTION("Generic software accelerated copyarea");
-MODULE_LICENSE("GPL");
-
--=20
2.30.2



--------------2A5ZPQL4p4S2HmrvJMDLpy1a--

--------------JEQZdj4SxYBNemU2xb5T1Znv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefZ/AFAwAAAAAACgkQWOeEu4KftGuM
SAgApkqo5+XDiAB43HuejF6KAh0vWQwEQZPyansk8NY2V6dk3e9Z2QlegBdMi5AAUDPlm/6g6Kkl
c+5H4+02+v6hEpn4SritfW/gXFT9inEexaK2HY+xZA4RwqpTpvmGXWbXB2rlTfKWUNoK4ePcJEYL
wBBC2MBlU0q1iI2FcJcQpEX7lQH2HvQwyxj+7/L0EUFDRzcUS5FJ8WeO8ZsmWCqD5W/TcYUVpLga
59gF+1V9aPwohW2LHgCY+6Bst6voyvoQ4InJtSH6wTovSFONUtwN9YLFHUCA+xGdKzKg3jfxuWM9
Jf+CqVBswPRSp9p8PaBXWSocrj4qxqTfEzQ5+2zKIA==
=Uw9c
-----END PGP SIGNATURE-----

--------------JEQZdj4SxYBNemU2xb5T1Znv--
