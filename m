Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE51DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500139; cv=none; b=V4Fmz8beS2TnO89f8fnR1c95tk1T+wU2R4BOs7E6QJj3FE10E+ay72Z+KTBwObwWwx69LCIWbeWb/fFMnGOC+Bp3Sa0DFtsLVbsZzZy9swvVxEDwle8rVMC5Jl19Mi4/zkNe8I927/twykDR2vbfJeIx4Cn3udO32MR9nQz7elQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500139; c=relaxed/simple;
	bh=1k3RRIM8BQwrGtTbiEjL3qJ6NqhZZzK40wzxIRhiYhA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=AIlJ0YkPnj4ilkmqvPBUdxvtrPoyrxzOoJxAlCDHY6q6BlAZDa1SDL1c8WIsh4SGOEhMD5ZVlLPdIR0a71+ZqgQ1WL0J/fAQuVAH3KPS5ld4xJMLoo1ayIWvOE4lxnhehncFbZKT19lgZUFn2I4U2GTw7BRNZs5P+PbJMW1YEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 5B244100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:42:15 +0100 (CET)
Message-ID: <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 03/12] Deduplicate cfb/sys drawing fbops
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
In-Reply-To: <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aMq4fqpU00oWR2ZfBXF3N8tF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aMq4fqpU00oWR2ZfBXF3N8tF
Content-Type: multipart/mixed; boundary="------------03C6M8w1oWCu52vTbuZxaveW";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
Subject: [RFC PATCH 03/12] Deduplicate cfb/sys drawing fbops
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
In-Reply-To: <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>

--------------03C6M8w1oWCu52vTbuZxaveW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Use generic copyarea for as cfb_copyarea

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/cfbcopyarea.c | 425 +------------------------
 1 file changed, 10 insertions(+), 415 deletions(-)

diff --git a/drivers/video/fbdev/core/cfbcopyarea.c b/drivers/video/fbdev=
/core/cfbcopyarea.c
index a271f57d9..a32859b6d 100644
--- a/drivers/video/fbdev/core/cfbcopyarea.c
+++ b/drivers/video/fbdev/core/cfbcopyarea.c
@@ -7,430 +7,25 @@
  *  License.  See the file COPYING in the main directory of this archive=
 for
  *  more details.
  *
- * NOTES:
- *
- *  This is for cfb packed pixels. Iplan and such are incorporated in th=
e
- *  drivers that need them.
- *
- *  FIXME
- *
- *  Also need to add code to deal with cards endians that are different =
than
- *  the native cpu endians. I also need to deal with MSB position in the=
 word.
- *
- *  The two functions or copying forward and backward could be split up =
like
- *  the ones for filling, i.e. in aligned and unaligned versions. This w=
ould
- *  help moving some redundant computations and branches out of the loop=
, too.
  */
=20
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include <asm/io.h>
-#include "fb_draw.h"
=20
 #if BITS_PER_LONG =3D=3D 32
-#  define FB_WRITEL fb_writel
-#  define FB_READL  fb_readl
+#  define FB_WRITEL       fb_writel
+#  define FB_READL        fb_readl
 #else
-#  define FB_WRITEL fb_writeq
-#  define FB_READL  fb_readq
+#  define FB_WRITEL       fb_writeq
+#  define FB_READL        fb_readq
 #endif
-
-    /*
-     *  Generic bitwise copy algorithm
-     */
-
-static void
-bitcpy(struct fb_info *p, unsigned long __iomem *dst, unsigned dst_idx,
-		const unsigned long __iomem *src, unsigned src_idx, int bits,
-		unsigned n, u32 bswapmask)
-{
-	unsigned long first, last;
-	int const shift =3D dst_idx-src_idx;
-
-#if 0
-	/*
-	 * If you suspect bug in this function, compare it with this simple
-	 * memmove implementation.
-	 */
-	memmove((char *)dst + ((dst_idx & (bits - 1))) / 8,
-		(char *)src + ((src_idx & (bits - 1))) / 8, n / 8);
-	return;
-#endif
-
-	first =3D fb_shifted_pixels_mask_long(p, dst_idx, bswapmask);
-	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
-
-	if (!shift) {
-		// Same alignment for source and dest
-
-		if (dst_idx+n <=3D bits) {
-			// Single word
-			if (last)
-				first &=3D last;
-			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
-		} else {
-			// Multiple destination words
-
-			// Leading bits
-			if (first !=3D ~0UL) {
-				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
-				dst++;
-				src++;
-				n -=3D bits - dst_idx;
-			}
-
-			// Main chunk
-			n /=3D bits;
-			while (n >=3D 8) {
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				FB_WRITEL(FB_READL(src++), dst++);
-				n -=3D 8;
-			}
-			while (n--)
-				FB_WRITEL(FB_READL(src++), dst++);
-
-			// Trailing bits
-			if (last)
-				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
-		}
-	} else {
-		/* Different alignment for source and dest */
-		unsigned long d0, d1;
-		int m;
-
-		int const left =3D shift & (bits - 1);
-		int const right =3D -shift & (bits - 1);
-
-		if (dst_idx+n <=3D bits) {
-			// Single destination word
-			if (last)
-				first &=3D last;
-			d0 =3D FB_READL(src);
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			if (shift > 0) {
-				// Single source word
-				d0 <<=3D left;
-			} else if (src_idx+n <=3D bits) {
-				// Single source word
-				d0 >>=3D right;
-			} else {
-				// 2 source words
-				d1 =3D FB_READL(src + 1);
-				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
-				d0 =3D d0 >> right | d1 << left;
-			}
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
-		} else {
-			// Multiple destination words
-			/** We must always remember the last value read, because in case
-			SRC and DST overlap bitwise (e.g. when moving just one pixel in
-			1bpp), we always collect one full long for DST and that might
-			overlap with the current long from SRC. We store this value in
-			'd0'. */
-			d0 =3D FB_READL(src++);
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			// Leading bits
-			if (shift > 0) {
-				// Single source word
-				d1 =3D d0;
-				d0 <<=3D left;
-				n -=3D bits - dst_idx;
-			} else {
-				// 2 source words
-				d1 =3D FB_READL(src++);
-				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
-
-				d0 =3D d0 >> right | d1 << left;
-				n -=3D bits - dst_idx;
-			}
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
-			d0 =3D d1;
-			dst++;
-
-			// Main chunk
-			m =3D n % bits;
-			n /=3D bits;
-			while ((n >=3D 4) && !bswapmask) {
-				d1 =3D FB_READL(src++);
-				FB_WRITEL(d0 >> right | d1 << left, dst++);
-				d0 =3D d1;
-				d1 =3D FB_READL(src++);
-				FB_WRITEL(d0 >> right | d1 << left, dst++);
-				d0 =3D d1;
-				d1 =3D FB_READL(src++);
-				FB_WRITEL(d0 >> right | d1 << left, dst++);
-				d0 =3D d1;
-				d1 =3D FB_READL(src++);
-				FB_WRITEL(d0 >> right | d1 << left, dst++);
-				d0 =3D d1;
-				n -=3D 4;
-			}
-			while (n--) {
-				d1 =3D FB_READL(src++);
-				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
-				d0 =3D d0 >> right | d1 << left;
-				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-				FB_WRITEL(d0, dst++);
-				d0 =3D d1;
-			}
-
-			// Trailing bits
-			if (m) {
-				if (m <=3D bits - right) {
-					// Single source word
-					d0 >>=3D right;
-				} else {
-					// 2 source words
-					d1 =3D FB_READL(src);
-					d1 =3D fb_rev_pixels_in_long(d1,
-								bswapmask);
-					d0 =3D d0 >> right | d1 << left;
-				}
-				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-				FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
-			}
-		}
-	}
-}
-
-    /*
-     *  Generic bitwise copy algorithm, operating backward
-     */
-
-static void
-bitcpy_rev(struct fb_info *p, unsigned long __iomem *dst, unsigned dst_i=
dx,
-		const unsigned long __iomem *src, unsigned src_idx, int bits,
-		unsigned n, u32 bswapmask)
-{
-	unsigned long first, last;
-	int shift;
-
-#if 0
-	/*
-	 * If you suspect bug in this function, compare it with this simple
-	 * memmove implementation.
-	 */
-	memmove((char *)dst + ((dst_idx & (bits - 1))) / 8,
-		(char *)src + ((src_idx & (bits - 1))) / 8, n / 8);
-	return;
-#endif
-
-	dst +=3D (dst_idx + n - 1) / bits;
-	src +=3D (src_idx + n - 1) / bits;
-	dst_idx =3D (dst_idx + n - 1) % bits;
-	src_idx =3D (src_idx + n - 1) % bits;
-
-	shift =3D dst_idx-src_idx;
-
-	first =3D ~fb_shifted_pixels_mask_long(p, (dst_idx + 1) % bits, bswapma=
sk);
-	last =3D fb_shifted_pixels_mask_long(p, (bits + dst_idx + 1 - n) % bits=
, bswapmask);
-
-	if (!shift) {
-		// Same alignment for source and dest
-
-		if ((unsigned long)dst_idx+1 >=3D n) {
-			// Single word
-			if (first)
-				last &=3D first;
-			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
-		} else {
-			// Multiple destination words
-
-			// Leading bits
-			if (first) {
-				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
-				dst--;
-				src--;
-				n -=3D dst_idx+1;
-			}
-
-			// Main chunk
-			n /=3D bits;
-			while (n >=3D 8) {
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				FB_WRITEL(FB_READL(src--), dst--);
-				n -=3D 8;
-			}
-			while (n--)
-				FB_WRITEL(FB_READL(src--), dst--);
-
-			// Trailing bits
-			if (last !=3D -1UL)
-				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
-		}
-	} else {
-		// Different alignment for source and dest
-		unsigned long d0, d1;
-		int m;
-
-		int const left =3D shift & (bits-1);
-		int const right =3D -shift & (bits-1);
-
-		if ((unsigned long)dst_idx+1 >=3D n) {
-			// Single destination word
-			if (first)
-				last &=3D first;
-			d0 =3D FB_READL(src);
-			if (shift < 0) {
-				// Single source word
-				d0 >>=3D right;
-			} else if (1+(unsigned long)src_idx >=3D n) {
-				// Single source word
-				d0 <<=3D left;
-			} else {
-				// 2 source words
-				d1 =3D FB_READL(src - 1);
-				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
-				d0 =3D d0 << left | d1 >> right;
-			}
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
-		} else {
-			// Multiple destination words
-			/** We must always remember the last value read, because in case
-			SRC and DST overlap bitwise (e.g. when moving just one pixel in
-			1bpp), we always collect one full long for DST and that might
-			overlap with the current long from SRC. We store this value in
-			'd0'. */
-
-			d0 =3D FB_READL(src--);
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			// Leading bits
-			if (shift < 0) {
-				// Single source word
-				d1 =3D d0;
-				d0 >>=3D right;
-			} else {
-				// 2 source words
-				d1 =3D FB_READL(src--);
-				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
-				d0 =3D d0 << left | d1 >> right;
-			}
-			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-			if (!first)
-				FB_WRITEL(d0, dst);
-			else
-				FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
-			d0 =3D d1;
-			dst--;
-			n -=3D dst_idx+1;
-
-			// Main chunk
-			m =3D n % bits;
-			n /=3D bits;
-			while ((n >=3D 4) && !bswapmask) {
-				d1 =3D FB_READL(src--);
-				FB_WRITEL(d0 << left | d1 >> right, dst--);
-				d0 =3D d1;
-				d1 =3D FB_READL(src--);
-				FB_WRITEL(d0 << left | d1 >> right, dst--);
-				d0 =3D d1;
-				d1 =3D FB_READL(src--);
-				FB_WRITEL(d0 << left | d1 >> right, dst--);
-				d0 =3D d1;
-				d1 =3D FB_READL(src--);
-				FB_WRITEL(d0 << left | d1 >> right, dst--);
-				d0 =3D d1;
-				n -=3D 4;
-			}
-			while (n--) {
-				d1 =3D FB_READL(src--);
-				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
-				d0 =3D d0 << left | d1 >> right;
-				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-				FB_WRITEL(d0, dst--);
-				d0 =3D d1;
-			}
-
-			// Trailing bits
-			if (m) {
-				if (m <=3D bits - left) {
-					// Single source word
-					d0 <<=3D left;
-				} else {
-					// 2 source words
-					d1 =3D FB_READL(src);
-					d1 =3D fb_rev_pixels_in_long(d1,
-								bswapmask);
-					d0 =3D d0 << left | d1 >> right;
-				}
-				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
-				FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
-			}
-		}
-	}
-}
-
-void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
-{
-	u32 dx =3D area->dx, dy =3D area->dy, sx =3D area->sx, sy =3D area->sy;=

-	u32 height =3D area->height, width =3D area->width;
-	unsigned int const bits_per_line =3D p->fix.line_length * 8u;
-	unsigned long __iomem *base =3D NULL;
-	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
-	unsigned dst_idx =3D 0, src_idx =3D 0, rev_copy =3D 0;
-	u32 bswapmask =3D fb_compute_bswapmask(p);
-
-	if (p->state !=3D FBINFO_STATE_RUNNING)
-		return;
-
-	if (p->flags & FBINFO_VIRTFB)
-		fb_warn_once(p, "Framebuffer is not in I/O address space.");
-
-	/* if the beginning of the target area might overlap with the end of
-	the source area, be have to copy the area reverse. */
-	if ((dy =3D=3D sy && dx > sx) || (dy > sy)) {
-		dy +=3D height;
-		sy +=3D height;
-		rev_copy =3D 1;
-	}
-
-	// split the base of the framebuffer into a long-aligned address and th=
e
-	// index of the first bit
-	base =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(by=
tes-1));
-	dst_idx =3D src_idx =3D 8*((unsigned long)p->screen_base & (bytes-1));
-	// add offset of source and target area
-	dst_idx +=3D dy*bits_per_line + dx*p->var.bits_per_pixel;
-	src_idx +=3D sy*bits_per_line + sx*p->var.bits_per_pixel;
-
-	if (p->fbops->fb_sync)
-		p->fbops->fb_sync(p);
-
-	if (rev_copy) {
-		while (height--) {
-			dst_idx -=3D bits_per_line;
-			src_idx -=3D bits_per_line;
-			bitcpy_rev(p, base + (dst_idx / bits), dst_idx % bits,
-				base + (src_idx / bits), src_idx % bits, bits,
-				width*p->var.bits_per_pixel, bswapmask);
-		}
-	} else {
-		while (height--) {
-			bitcpy(p, base + (dst_idx / bits), dst_idx % bits,
-				base + (src_idx / bits), src_idx % bits, bits,
-				width*p->var.bits_per_pixel, bswapmask);
-			dst_idx +=3D bits_per_line;
-			src_idx +=3D bits_per_line;
-		}
-	}
-}
+#define FB_MEM            /* nothing */
+#define FB_COPYAREA       cfb_copyarea
+#define FB_SPACE          0
+#define FB_SPACE_NAME     "I/O"
+#define FB_SCREEN_BASE(a) ((a)->screen_base)
+#include "fb_copyarea.h"
=20
 EXPORT_SYMBOL(cfb_copyarea);
=20
--=20
2.30.2



--------------03C6M8w1oWCu52vTbuZxaveW--

--------------aMq4fqpU00oWR2ZfBXF3N8tF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaCcFAwAAAAAACgkQWOeEu4KftGsc
VggAqbXLc+hKtRDmSa/wKK9zH+bfbkHBIWeuLK2O2FZOSi7eLjs2mKuCwCa2aAM1heIwBVoDmeM4
6PpjfIb7OjWkjEQDtnsIjUJQssKNuohEQTZ2hf1umbX3UMCTUrnbUicQnPsdqlb9Ad7T1CfAZ2ld
HsXUSCP5HwPoKlZMMABF3SCWi4vzqxu1tuz9VOy2QG3lUaHnncPAbI3c3WSX4C3PJ+KC8VKIAox7
PPEYohtG6bp92HeRRkI5tTit8JoLcHtI1jIZcBjdWcTqqNmzP+mtKLEVvUNkwnNIGVzZHONzTIv7
c7uUcnrcUTEupYnnH0/j3nmMe3gxze8pVK20ZGbNhQ==
=iWqb
-----END PGP SIGNATURE-----

--------------aMq4fqpU00oWR2ZfBXF3N8tF--
