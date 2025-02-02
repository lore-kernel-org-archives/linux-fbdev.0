Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B01D6DDC
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500303; cv=none; b=kDoxdCjbCh+bfEnkqTnKQPMStnoRy+nyt1H+a5nNcgCZTYN+EZiUdV2gqFaFaOAT5TwAkOSEqAqWTaqkFuNxRTq9aghkj6/hlla/JxTSsP6u+/6Ki28LszKZkP/60KURDYcGI2RCxzI2JQ1qEumULlWhGh8CL3nLYcc0FI60ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500303; c=relaxed/simple;
	bh=SDa6Sqr4Ms7p/aO5OpjLS9VOywpODTTeXGX0BS0oLqM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=f5SkJiSILt+/zvo41YiP/zpJ2ac/GadA3AMSCTAntGVJRoF6v5shR6Wnm87qzJX5XAXQm9n5y6YeOK0u3NZ3F2rFI6RNSoA1IDOEWWpMzKiDIUQ2cnLrzB9z3b1LD0x3EC7pOvseHtTubCtkccYB5TK2nm78pk/HFzE6lzA0xD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id DB9AC100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:44:59 +0100 (CET)
Message-ID: <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:44:59 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 07/12] fbdev: core: Use generic fillrect for as,
 cfb_fillrect
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
 <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
 <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
In-Reply-To: <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kj1Iae0xgrqDbVjAhcBaiI0U"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kj1Iae0xgrqDbVjAhcBaiI0U
Content-Type: multipart/mixed; boundary="------------Qv0RSVREJjCkXsQpPxRxSxR3";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>
Subject: [RFC PATCH 07/12] fbdev: core: Use generic fillrect for as,
 cfb_fillrect
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
 <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
 <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
In-Reply-To: <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>

--------------Qv0RSVREJjCkXsQpPxRxSxR3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Use generic fillrect for as cfb_fillrect

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/cfbfillrect.c | 362 +------------------------
 1 file changed, 11 insertions(+), 351 deletions(-)

diff --git a/drivers/video/fbdev/core/cfbfillrect.c b/drivers/video/fbdev=
/core/cfbfillrect.c
index cbaa4c9e2..116d56de2 100644
--- a/drivers/video/fbdev/core/cfbfillrect.c
+++ b/drivers/video/fbdev/core/cfbfillrect.c
@@ -7,365 +7,25 @@
  *  License.  See the file COPYING in the main directory of this archive=
 for
  *  more details.
  *
- * NOTES:
- *
- *  Also need to add code to deal with cards endians that are different =
than
- *  the native cpu endians. I also need to deal with MSB position in the=
 word.
- *
  */
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include "fb_draw.h"
=20
 #if BITS_PER_LONG =3D=3D 32
-#  define FB_WRITEL fb_writel
-#  define FB_READL  fb_readl
-#else
-#  define FB_WRITEL fb_writeq
-#  define FB_READL  fb_readq
-#endif
-
-    /*
-     *  Aligned pattern fill using 32/64-bit memory accesses
-     */
-
-static void
-bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_i=
dx,
-		unsigned long pat, unsigned n, int bits, u32 bswapmask)
-{
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first =3D fb_shifted_pixels_mask_long(p, dst_idx, bswapmask);
-	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
-
-	if (dst_idx+n <=3D bits) {
-		// Single word
-		if (last)
-			first &=3D last;
-		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
-	} else {
-		// Multiple destination words
-
-		// Leading bits
-		if (first!=3D ~0UL) {
-			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
-			dst++;
-			n -=3D bits - dst_idx;
-		}
-
-		// Main chunk
-		n /=3D bits;
-		while (n >=3D 8) {
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			FB_WRITEL(pat, dst++);
-			n -=3D 8;
-		}
-		while (n--)
-			FB_WRITEL(pat, dst++);
-
-		// Trailing bits
-		if (last)
-			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
-	}
-}
-
-
-    /*
-     *  Unaligned generic pattern fill using 32/64-bit memory accesses
-     *  The pattern must have been expanded to a full 32/64-bit value
-     *  Left/right are the appropriate shifts to convert to the pattern =
to be
-     *  used for the next 32/64-bit word
-     */
-
-static void
-bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst=
_idx,
-		  unsigned long pat, int left, int right, unsigned n, int bits)
-{
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first =3D FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <=3D bits) {
-		// Single word
-		if (last)
-			first &=3D last;
-		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
-	} else {
-		// Multiple destination words
-		// Leading bits
-		if (first) {
-			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			n -=3D bits - dst_idx;
-		}
-
-		// Main chunk
-		n /=3D bits;
-		while (n >=3D 4) {
-			FB_WRITEL(pat, dst++);
-			pat =3D pat << left | pat >> right;
-			FB_WRITEL(pat, dst++);
-			pat =3D pat << left | pat >> right;
-			FB_WRITEL(pat, dst++);
-			pat =3D pat << left | pat >> right;
-			FB_WRITEL(pat, dst++);
-			pat =3D pat << left | pat >> right;
-			n -=3D 4;
-		}
-		while (n--) {
-			FB_WRITEL(pat, dst++);
-			pat =3D pat << left | pat >> right;
-		}
-
-		// Trailing bits
-		if (last)
-			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
-	}
-}
-
-    /*
-     *  Aligned pattern invert using 32/64-bit memory accesses
-     */
-static void
-bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
-		    int dst_idx, unsigned long pat, unsigned n, int bits,
-		    u32 bswapmask)
-{
-	unsigned long val =3D pat, dat;
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first =3D fb_shifted_pixels_mask_long(p, dst_idx, bswapmask);
-	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
-
-	if (dst_idx+n <=3D bits) {
-		// Single word
-		if (last)
-			first &=3D last;
-		dat =3D FB_READL(dst);
-		FB_WRITEL(comp(dat ^ val, dat, first), dst);
-	} else {
-		// Multiple destination words
-		// Leading bits
-		if (first!=3D0UL) {
-			dat =3D FB_READL(dst);
-			FB_WRITEL(comp(dat ^ val, dat, first), dst);
-			dst++;
-			n -=3D bits - dst_idx;
-		}
-
-		// Main chunk
-		n /=3D bits;
-		while (n >=3D 8) {
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-			n -=3D 8;
-		}
-		while (n--) {
-			FB_WRITEL(FB_READL(dst) ^ val, dst);
-			dst++;
-		}
-		// Trailing bits
-		if (last) {
-			dat =3D FB_READL(dst);
-			FB_WRITEL(comp(dat ^ val, dat, last), dst);
-		}
-	}
-}
-
-
-    /*
-     *  Unaligned generic pattern invert using 32/64-bit memory accesses=

-     *  The pattern must have been expanded to a full 32/64-bit value
-     *  Left/right are the appropriate shifts to convert to the pattern =
to be
-     *  used for the next 32/64-bit word
-     */
-
-static void
-bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
-		      int dst_idx, unsigned long pat, int left, int right,
-		      unsigned n, int bits)
-{
-	unsigned long first, last, dat;
-
-	if (!n)
-		return;
-
-	first =3D FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <=3D bits) {
-		// Single word
-		if (last)
-			first &=3D last;
-		dat =3D FB_READL(dst);
-		FB_WRITEL(comp(dat ^ pat, dat, first), dst);
-	} else {
-		// Multiple destination words
-
-		// Leading bits
-		if (first !=3D 0UL) {
-			dat =3D FB_READL(dst);
-			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			n -=3D bits - dst_idx;
-		}
-
-		// Main chunk
-		n /=3D bits;
-		while (n >=3D 4) {
-			FB_WRITEL(FB_READL(dst) ^ pat, dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			FB_WRITEL(FB_READL(dst) ^ pat, dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			FB_WRITEL(FB_READL(dst) ^ pat, dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			FB_WRITEL(FB_READL(dst) ^ pat, dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			n -=3D 4;
-		}
-		while (n--) {
-			FB_WRITEL(FB_READL(dst) ^ pat, dst);
-			dst++;
-			pat =3D pat << left | pat >> right;
-		}
-
-		// Trailing bits
-		if (last) {
-			dat =3D FB_READL(dst);
-			FB_WRITEL(comp(dat ^ pat, dat, last), dst);
-		}
-	}
-}
-
-void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
-{
-	unsigned long pat, pat2, fg;
-	unsigned long width =3D rect->width, height =3D rect->height;
-	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
-	u32 bpp =3D p->var.bits_per_pixel;
-	unsigned long __iomem *dst;
-	int dst_idx, left;
-
-	if (p->state !=3D FBINFO_STATE_RUNNING)
-		return;
-
-	if (p->flags & FBINFO_VIRTFB)
-		fb_warn_once(p, "Framebuffer is not in I/O address space.");
-
-	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
-	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
-		fg =3D ((u32 *) (p->pseudo_palette))[rect->color];
-	else
-		fg =3D rect->color;
-
-	pat =3D pixel_to_pat(bpp, fg);
-
-	dst =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(byt=
es-1));
-	dst_idx =3D ((unsigned long)p->screen_base & (bytes - 1))*8;
-	dst_idx +=3D rect->dy*p->fix.line_length*8+rect->dx*bpp;
-	/* FIXME For now we support 1-32 bpp only */
-	left =3D bits % bpp;
-	if (p->fbops->fb_sync)
-		p->fbops->fb_sync(p);
-	if (!left) {
-		u32 bswapmask =3D fb_compute_bswapmask(p);
-		void (*fill_op32)(struct fb_info *p,
-				  unsigned long __iomem *dst, int dst_idx,
-		                  unsigned long pat, unsigned n, int bits,
-				  u32 bswapmask) =3D NULL;
-
-		switch (rect->rop) {
-		case ROP_XOR:
-			fill_op32 =3D bitfill_aligned_rev;
-			break;
-		case ROP_COPY:
-			fill_op32 =3D bitfill_aligned;
-			break;
-		default:
-			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY=
\n");
-			fill_op32 =3D bitfill_aligned;
-			break;
-		}
-		while (height--) {
-			dst +=3D dst_idx >> (ffs(bits) - 1);
-			dst_idx &=3D (bits - 1);
-			fill_op32(p, dst, dst_idx, pat, width*bpp, bits,
-				  bswapmask);
-			dst_idx +=3D p->fix.line_length*8;
-		}
-	} else {
-		int right, r;
-		void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
-				int dst_idx, unsigned long pat, int left,
-				int right, unsigned n, int bits) =3D NULL;
-#ifdef __LITTLE_ENDIAN
-		right =3D left;
-		left =3D bpp - right;
+#  define FB_WRITEL       fb_writel
+#  define FB_READL        fb_readl
 #else
-		right =3D bpp - left;
+#  define FB_WRITEL       fb_writeq
+#  define FB_READL        fb_readq
 #endif
-		switch (rect->rop) {
-		case ROP_XOR:
-			fill_op =3D bitfill_unaligned_rev;
-			break;
-		case ROP_COPY:
-			fill_op =3D bitfill_unaligned;
-			break;
-		default:
-			printk(KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\=
n");
-			fill_op =3D bitfill_unaligned;
-			break;
-		}
-		while (height--) {
-			dst +=3D dst_idx / bits;
-			dst_idx &=3D (bits - 1);
-			r =3D dst_idx % bpp;
-			/* rotate pattern to the correct start position */
-			pat2 =3D le_long_to_cpu(rolx(cpu_to_le_long(pat), r, bpp));
-			fill_op(p, dst, dst_idx, pat2, left, right,
-				width*bpp, bits);
-			dst_idx +=3D p->fix.line_length*8;
-		}
-	}
-}
+#define FB_MEM            __iomem
+#define FB_FILLRECT       cfb_fillrect
+#define FB_FILLRECT_NAME  "cfb_fillrect"
+#define FB_SPACE          0
+#define FB_SPACE_NAME     "I/O"
+#define FB_SCREEN_BASE(a) ((a)->screen_base)
+#include "fb_fillrect.h"
=20
 EXPORT_SYMBOL(cfb_fillrect);
=20
--=20
2.30.2



--------------Qv0RSVREJjCkXsQpPxRxSxR3--

--------------kj1Iae0xgrqDbVjAhcBaiI0U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaMsFAwAAAAAACgkQWOeEu4KftGue
Tgf/dKmQ6LO4zy/d18CuIO7hALeUqDTfJasfQ23l3LYXyX4oN+53nSR0Je43a8FZoMyHkF3Jn+JA
7EQjXPyvcIsxS+uJapQku15iYqYX5ExuAal59R8qFG5lLhesVDqYm2csEWnz5xB0ejXLeMICtDbw
Jc6y5AbMbQeaRcURD8uYWLxb0c9JX4MwFByg7kdoeB69WX+cG1/THZRaYZcf0lNtLgtNUsEnsYHa
ChpOgcTNuCgc310DdkamlJ0Ouww7EBHlsJzlfFT3vN/pc25PNF1nO5yfDAd/DZvQc2MIa167dN9M
bALmU04x1rtUSR17Ob81BBSmIJVdq0lJTBI1KtYPUQ==
=qtgr
-----END PGP SIGNATURE-----

--------------kj1Iae0xgrqDbVjAhcBaiI0U--
