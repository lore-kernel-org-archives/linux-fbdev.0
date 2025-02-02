Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777621DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500022; cv=none; b=aGFhAG4itv8FdIKTwj6gNvnVvyixvteL+EGOhiDzNS792/iOYTs8h9j+eNXwkbYqbBOd/N5NlzWbV0wXC/T0Uy8afxrpRNhkXGGzfTF3xLw4MLqGTXXgoc89pP+V9o92AtFHcDpe3C4yXV21EL3D2+dOLGsWGkzw/WggLtkeZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500022; c=relaxed/simple;
	bh=ggdaDmnMdP2zkYq6YsTuYl3zyA3wIV9cx3rS7rOxRdc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=MPGQwmxpEWFADlzmNcTIwv7j07+iQxjWd5MS7sMhFlDxDhc0OM4gxG1G/bdA23MRQrviinkD0sBy1Yw5eGZ/mLnfJPRYutftXTPdetjipluYX9bO6LK89gkWCZIBBZUia2xy/WGSbrsrkLcbWbwq2y1mcZlphY9muH6iLTq5dLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id A2888100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:40:16 +0100 (CET)
Message-ID: <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 01/12] Deduplicate cfb/sys drawing fbops
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
In-Reply-To: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------D9PBFOURLrAdYNGx01r7EmML"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------D9PBFOURLrAdYNGx01r7EmML
Content-Type: multipart/mixed; boundary="------------px4gZdcFKzWSNcQDZPqcrt96";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
Subject: [RFC PATCH 01/12] Deduplicate cfb/sys drawing fbops
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
In-Reply-To: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>

--------------px4gZdcFKzWSNcQDZPqcrt96
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_copyarea.h | 440 +++++++++++++++++++++++++
 1 file changed, 440 insertions(+)
 create mode 100644 drivers/video/fbdev/core/fb_copyarea.h

diff --git a/drivers/video/fbdev/core/fb_copyarea.h b/drivers/video/fbdev=
/core/fb_copyarea.h
new file mode 100644
index 000000000..a271f57d9
--- /dev/null
+++ b/drivers/video/fbdev/core/fb_copyarea.h
@@ -0,0 +1,440 @@
+/*
+ *  Generic function for frame buffer with packed pixels of any depth.
+ *
+ *      Copyright (C)  1999-2005 James Simmons <jsimmons@www.infradead.o=
rg>
+ *
+ *  This file is subject to the terms and conditions of the GNU General =
Public
+ *  License.  See the file COPYING in the main directory of this archive=
 for
+ *  more details.
+ *
+ * NOTES:
+ *
+ *  This is for cfb packed pixels. Iplan and such are incorporated in th=
e
+ *  drivers that need them.
+ *
+ *  FIXME
+ *
+ *  Also need to add code to deal with cards endians that are different =
than
+ *  the native cpu endians. I also need to deal with MSB position in the=
 word.
+ *
+ *  The two functions or copying forward and backward could be split up =
like
+ *  the ones for filling, i.e. in aligned and unaligned versions. This w=
ould
+ *  help moving some redundant computations and branches out of the loop=
, too.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <asm/types.h>
+#include <asm/io.h>
+#include "fb_draw.h"
+
+#if BITS_PER_LONG =3D=3D 32
+#  define FB_WRITEL fb_writel
+#  define FB_READL  fb_readl
+#else
+#  define FB_WRITEL fb_writeq
+#  define FB_READL  fb_readq
+#endif
+
+    /*
+     *  Generic bitwise copy algorithm
+     */
+
+static void
+bitcpy(struct fb_info *p, unsigned long __iomem *dst, unsigned dst_idx,
+		const unsigned long __iomem *src, unsigned src_idx, int bits,
+		unsigned n, u32 bswapmask)
+{
+	unsigned long first, last;
+	int const shift =3D dst_idx-src_idx;
+
+#if 0
+	/*
+	 * If you suspect bug in this function, compare it with this simple
+	 * memmove implementation.
+	 */
+	memmove((char *)dst + ((dst_idx & (bits - 1))) / 8,
+		(char *)src + ((src_idx & (bits - 1))) / 8, n / 8);
+	return;
+#endif
+
+	first =3D fb_shifted_pixels_mask_long(p, dst_idx, bswapmask);
+	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
+
+	if (!shift) {
+		// Same alignment for source and dest
+
+		if (dst_idx+n <=3D bits) {
+			// Single word
+			if (last)
+				first &=3D last;
+			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
+		} else {
+			// Multiple destination words
+
+			// Leading bits
+			if (first !=3D ~0UL) {
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
+				dst++;
+				src++;
+				n -=3D bits - dst_idx;
+			}
+
+			// Main chunk
+			n /=3D bits;
+			while (n >=3D 8) {
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				FB_WRITEL(FB_READL(src++), dst++);
+				n -=3D 8;
+			}
+			while (n--)
+				FB_WRITEL(FB_READL(src++), dst++);
+
+			// Trailing bits
+			if (last)
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
+		}
+	} else {
+		/* Different alignment for source and dest */
+		unsigned long d0, d1;
+		int m;
+
+		int const left =3D shift & (bits - 1);
+		int const right =3D -shift & (bits - 1);
+
+		if (dst_idx+n <=3D bits) {
+			// Single destination word
+			if (last)
+				first &=3D last;
+			d0 =3D FB_READL(src);
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			if (shift > 0) {
+				// Single source word
+				d0 <<=3D left;
+			} else if (src_idx+n <=3D bits) {
+				// Single source word
+				d0 >>=3D right;
+			} else {
+				// 2 source words
+				d1 =3D FB_READL(src + 1);
+				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
+				d0 =3D d0 >> right | d1 << left;
+			}
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
+		} else {
+			// Multiple destination words
+			/** We must always remember the last value read, because in case
+			SRC and DST overlap bitwise (e.g. when moving just one pixel in
+			1bpp), we always collect one full long for DST and that might
+			overlap with the current long from SRC. We store this value in
+			'd0'. */
+			d0 =3D FB_READL(src++);
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			// Leading bits
+			if (shift > 0) {
+				// Single source word
+				d1 =3D d0;
+				d0 <<=3D left;
+				n -=3D bits - dst_idx;
+			} else {
+				// 2 source words
+				d1 =3D FB_READL(src++);
+				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
+
+				d0 =3D d0 >> right | d1 << left;
+				n -=3D bits - dst_idx;
+			}
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
+			d0 =3D d1;
+			dst++;
+
+			// Main chunk
+			m =3D n % bits;
+			n /=3D bits;
+			while ((n >=3D 4) && !bswapmask) {
+				d1 =3D FB_READL(src++);
+				FB_WRITEL(d0 >> right | d1 << left, dst++);
+				d0 =3D d1;
+				d1 =3D FB_READL(src++);
+				FB_WRITEL(d0 >> right | d1 << left, dst++);
+				d0 =3D d1;
+				d1 =3D FB_READL(src++);
+				FB_WRITEL(d0 >> right | d1 << left, dst++);
+				d0 =3D d1;
+				d1 =3D FB_READL(src++);
+				FB_WRITEL(d0 >> right | d1 << left, dst++);
+				d0 =3D d1;
+				n -=3D 4;
+			}
+			while (n--) {
+				d1 =3D FB_READL(src++);
+				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
+				d0 =3D d0 >> right | d1 << left;
+				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL(d0, dst++);
+				d0 =3D d1;
+			}
+
+			// Trailing bits
+			if (m) {
+				if (m <=3D bits - right) {
+					// Single source word
+					d0 >>=3D right;
+				} else {
+					// 2 source words
+					d1 =3D FB_READL(src);
+					d1 =3D fb_rev_pixels_in_long(d1,
+								bswapmask);
+					d0 =3D d0 >> right | d1 << left;
+				}
+				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
+			}
+		}
+	}
+}
+
+    /*
+     *  Generic bitwise copy algorithm, operating backward
+     */
+
+static void
+bitcpy_rev(struct fb_info *p, unsigned long __iomem *dst, unsigned dst_i=
dx,
+		const unsigned long __iomem *src, unsigned src_idx, int bits,
+		unsigned n, u32 bswapmask)
+{
+	unsigned long first, last;
+	int shift;
+
+#if 0
+	/*
+	 * If you suspect bug in this function, compare it with this simple
+	 * memmove implementation.
+	 */
+	memmove((char *)dst + ((dst_idx & (bits - 1))) / 8,
+		(char *)src + ((src_idx & (bits - 1))) / 8, n / 8);
+	return;
+#endif
+
+	dst +=3D (dst_idx + n - 1) / bits;
+	src +=3D (src_idx + n - 1) / bits;
+	dst_idx =3D (dst_idx + n - 1) % bits;
+	src_idx =3D (src_idx + n - 1) % bits;
+
+	shift =3D dst_idx-src_idx;
+
+	first =3D ~fb_shifted_pixels_mask_long(p, (dst_idx + 1) % bits, bswapma=
sk);
+	last =3D fb_shifted_pixels_mask_long(p, (bits + dst_idx + 1 - n) % bits=
, bswapmask);
+
+	if (!shift) {
+		// Same alignment for source and dest
+
+		if ((unsigned long)dst_idx+1 >=3D n) {
+			// Single word
+			if (first)
+				last &=3D first;
+			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
+		} else {
+			// Multiple destination words
+
+			// Leading bits
+			if (first) {
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
+				dst--;
+				src--;
+				n -=3D dst_idx+1;
+			}
+
+			// Main chunk
+			n /=3D bits;
+			while (n >=3D 8) {
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				FB_WRITEL(FB_READL(src--), dst--);
+				n -=3D 8;
+			}
+			while (n--)
+				FB_WRITEL(FB_READL(src--), dst--);
+
+			// Trailing bits
+			if (last !=3D -1UL)
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
+		}
+	} else {
+		// Different alignment for source and dest
+		unsigned long d0, d1;
+		int m;
+
+		int const left =3D shift & (bits-1);
+		int const right =3D -shift & (bits-1);
+
+		if ((unsigned long)dst_idx+1 >=3D n) {
+			// Single destination word
+			if (first)
+				last &=3D first;
+			d0 =3D FB_READL(src);
+			if (shift < 0) {
+				// Single source word
+				d0 >>=3D right;
+			} else if (1+(unsigned long)src_idx >=3D n) {
+				// Single source word
+				d0 <<=3D left;
+			} else {
+				// 2 source words
+				d1 =3D FB_READL(src - 1);
+				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
+				d0 =3D d0 << left | d1 >> right;
+			}
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
+		} else {
+			// Multiple destination words
+			/** We must always remember the last value read, because in case
+			SRC and DST overlap bitwise (e.g. when moving just one pixel in
+			1bpp), we always collect one full long for DST and that might
+			overlap with the current long from SRC. We store this value in
+			'd0'. */
+
+			d0 =3D FB_READL(src--);
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			// Leading bits
+			if (shift < 0) {
+				// Single source word
+				d1 =3D d0;
+				d0 >>=3D right;
+			} else {
+				// 2 source words
+				d1 =3D FB_READL(src--);
+				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
+				d0 =3D d0 << left | d1 >> right;
+			}
+			d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+			if (!first)
+				FB_WRITEL(d0, dst);
+			else
+				FB_WRITEL(comp(d0, FB_READL(dst), first), dst);
+			d0 =3D d1;
+			dst--;
+			n -=3D dst_idx+1;
+
+			// Main chunk
+			m =3D n % bits;
+			n /=3D bits;
+			while ((n >=3D 4) && !bswapmask) {
+				d1 =3D FB_READL(src--);
+				FB_WRITEL(d0 << left | d1 >> right, dst--);
+				d0 =3D d1;
+				d1 =3D FB_READL(src--);
+				FB_WRITEL(d0 << left | d1 >> right, dst--);
+				d0 =3D d1;
+				d1 =3D FB_READL(src--);
+				FB_WRITEL(d0 << left | d1 >> right, dst--);
+				d0 =3D d1;
+				d1 =3D FB_READL(src--);
+				FB_WRITEL(d0 << left | d1 >> right, dst--);
+				d0 =3D d1;
+				n -=3D 4;
+			}
+			while (n--) {
+				d1 =3D FB_READL(src--);
+				d1 =3D fb_rev_pixels_in_long(d1, bswapmask);
+				d0 =3D d0 << left | d1 >> right;
+				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL(d0, dst--);
+				d0 =3D d1;
+			}
+
+			// Trailing bits
+			if (m) {
+				if (m <=3D bits - left) {
+					// Single source word
+					d0 <<=3D left;
+				} else {
+					// 2 source words
+					d1 =3D FB_READL(src);
+					d1 =3D fb_rev_pixels_in_long(d1,
+								bswapmask);
+					d0 =3D d0 << left | d1 >> right;
+				}
+				d0 =3D fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL(comp(d0, FB_READL(dst), last), dst);
+			}
+		}
+	}
+}
+
+void cfb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
+{
+	u32 dx =3D area->dx, dy =3D area->dy, sx =3D area->sx, sy =3D area->sy;=

+	u32 height =3D area->height, width =3D area->width;
+	unsigned int const bits_per_line =3D p->fix.line_length * 8u;
+	unsigned long __iomem *base =3D NULL;
+	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
+	unsigned dst_idx =3D 0, src_idx =3D 0, rev_copy =3D 0;
+	u32 bswapmask =3D fb_compute_bswapmask(p);
+
+	if (p->state !=3D FBINFO_STATE_RUNNING)
+		return;
+
+	if (p->flags & FBINFO_VIRTFB)
+		fb_warn_once(p, "Framebuffer is not in I/O address space.");
+
+	/* if the beginning of the target area might overlap with the end of
+	the source area, be have to copy the area reverse. */
+	if ((dy =3D=3D sy && dx > sx) || (dy > sy)) {
+		dy +=3D height;
+		sy +=3D height;
+		rev_copy =3D 1;
+	}
+
+	// split the base of the framebuffer into a long-aligned address and th=
e
+	// index of the first bit
+	base =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(by=
tes-1));
+	dst_idx =3D src_idx =3D 8*((unsigned long)p->screen_base & (bytes-1));
+	// add offset of source and target area
+	dst_idx +=3D dy*bits_per_line + dx*p->var.bits_per_pixel;
+	src_idx +=3D sy*bits_per_line + sx*p->var.bits_per_pixel;
+
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
+
+	if (rev_copy) {
+		while (height--) {
+			dst_idx -=3D bits_per_line;
+			src_idx -=3D bits_per_line;
+			bitcpy_rev(p, base + (dst_idx / bits), dst_idx % bits,
+				base + (src_idx / bits), src_idx % bits, bits,
+				width*p->var.bits_per_pixel, bswapmask);
+		}
+	} else {
+		while (height--) {
+			bitcpy(p, base + (dst_idx / bits), dst_idx % bits,
+				base + (src_idx / bits), src_idx % bits, bits,
+				width*p->var.bits_per_pixel, bswapmask);
+			dst_idx +=3D bits_per_line;
+			src_idx +=3D bits_per_line;
+		}
+	}
+}
+
+EXPORT_SYMBOL(cfb_copyarea);
+
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
+MODULE_DESCRIPTION("Generic software accelerated copyarea");
+MODULE_LICENSE("GPL");
+
--=20
2.30.2



--------------px4gZdcFKzWSNcQDZPqcrt96--

--------------D9PBFOURLrAdYNGx01r7EmML
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefZ7AFAwAAAAAACgkQWOeEu4KftGuj
UwgAoleQkn7wCTUMeJJGtW0hp6cctKE1PH1snG/sWLJSEjWsBFOY4wicvwZute8OqRGsk+n0kQWr
Ra2WK22FIDZ6+0/Yejngkziwy5bsaiiES2QoacdL5ri2sJWK3fIr7axnWOORRrx4AubVo5A8tA3J
mF5pqTEeFlnnm6DEixjC8yZq6BEyOGdQUqPeondFY6shCaIXFaaWyoNkQ4yk0bA7ET1HeFFpe3ha
xUlde0OQzLaOqfquAQj0PLQ88mu41DGpqqDdq6xf252tw+E7AYVd+oWWB9hDQ6WVp6HyZVM/78Ln
OiZ/YWkEphGU+SrdLC5KMWwipnioW8CowKtJmNl/ng==
=LICV
-----END PGP SIGNATURE-----

--------------D9PBFOURLrAdYNGx01r7EmML--
