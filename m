Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CF1DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500216; cv=none; b=SuulUJQX5vDi8K+fPS06Q0Mv5LybN/CkN/TT2GtTTCa1OJw0P70UAYycjkf90f1cYF4jIR9BgbBhyY8HJyTUy1kma/fgd45M2f734DpYe4QIByFY/QQ/6S5dkB1oFx0TJkc9V9uMFAp3wSdSWj24H6qBMeC0pe2CIncK2It90q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500216; c=relaxed/simple;
	bh=qeiUnr3S5o50ZlIc/DV8ZR8WTQOYeoE5tExn5gVcmYY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qQDhCS6K5p/Hr8wxlO9Pqy/nyYnaHB5sxhuUgd3K4ot1CWH3KCXmuyMWDNawJJDJcNdASgO1YxHhO+byYEaost2NO3fls5qlvqy38mazAU6v4FWZfU0wV4UR22ILLLzTft+iun8YRfO6qOZPRC6WZtbCJhu3oUAA7pfya5oevcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id BBF08100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:43:30 +0100 (CET)
Message-ID: <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 05/12] Deduplicate cfb/sys drawing fbops
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
In-Reply-To: <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------688ji4ybwVE0PporwLb5vq7I"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------688ji4ybwVE0PporwLb5vq7I
Content-Type: multipart/mixed; boundary="------------wmsSjfpC6zs9qR2lTOUPpmGB";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
Subject: [RFC PATCH 05/12] Deduplicate cfb/sys drawing fbops
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
In-Reply-To: <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>

--------------wmsSjfpC6zs9qR2lTOUPpmGB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Copy cfbfillrect to fb_fillrect

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_fillrect.h | 374 +++++++++++++++++++++++++
 1 file changed, 374 insertions(+)
 create mode 100644 drivers/video/fbdev/core/fb_fillrect.h

diff --git a/drivers/video/fbdev/core/fb_fillrect.h b/drivers/video/fbdev=
/core/fb_fillrect.h
new file mode 100644
index 000000000..cbaa4c9e2
--- /dev/null
+++ b/drivers/video/fbdev/core/fb_fillrect.h
@@ -0,0 +1,374 @@
+/*
+ *  Generic fillrect for frame buffers with packed pixels of any depth.
+ *
+ *      Copyright (C)  2000 James Simmons (jsimmons@linux-fbdev.org)
+ *
+ *  This file is subject to the terms and conditions of the GNU General =
Public
+ *  License.  See the file COPYING in the main directory of this archive=
 for
+ *  more details.
+ *
+ * NOTES:
+ *
+ *  Also need to add code to deal with cards endians that are different =
than
+ *  the native cpu endians. I also need to deal with MSB position in the=
 word.
+ *
+ */
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <asm/types.h>
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
+     *  Aligned pattern fill using 32/64-bit memory accesses
+     */
+
+static void
+bitfill_aligned(struct fb_info *p, unsigned long __iomem *dst, int dst_i=
dx,
+		unsigned long pat, unsigned n, int bits, u32 bswapmask)
+{
+	unsigned long first, last;
+
+	if (!n)
+		return;
+
+	first =3D fb_shifted_pixels_mask_long(p, dst_idx, bswapmask);
+	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
+
+	if (dst_idx+n <=3D bits) {
+		// Single word
+		if (last)
+			first &=3D last;
+		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+	} else {
+		// Multiple destination words
+
+		// Leading bits
+		if (first!=3D ~0UL) {
+			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+			dst++;
+			n -=3D bits - dst_idx;
+		}
+
+		// Main chunk
+		n /=3D bits;
+		while (n >=3D 8) {
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			n -=3D 8;
+		}
+		while (n--)
+			FB_WRITEL(pat, dst++);
+
+		// Trailing bits
+		if (last)
+			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
+	}
+}
+
+
+    /*
+     *  Unaligned generic pattern fill using 32/64-bit memory accesses
+     *  The pattern must have been expanded to a full 32/64-bit value
+     *  Left/right are the appropriate shifts to convert to the pattern =
to be
+     *  used for the next 32/64-bit word
+     */
+
+static void
+bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst=
_idx,
+		  unsigned long pat, int left, int right, unsigned n, int bits)
+{
+	unsigned long first, last;
+
+	if (!n)
+		return;
+
+	first =3D FB_SHIFT_HIGH(p, ~0UL, dst_idx);
+	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
+
+	if (dst_idx+n <=3D bits) {
+		// Single word
+		if (last)
+			first &=3D last;
+		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+	} else {
+		// Multiple destination words
+		// Leading bits
+		if (first) {
+			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+			n -=3D bits - dst_idx;
+		}
+
+		// Main chunk
+		n /=3D bits;
+		while (n >=3D 4) {
+			FB_WRITEL(pat, dst++);
+			pat =3D pat << left | pat >> right;
+			FB_WRITEL(pat, dst++);
+			pat =3D pat << left | pat >> right;
+			FB_WRITEL(pat, dst++);
+			pat =3D pat << left | pat >> right;
+			FB_WRITEL(pat, dst++);
+			pat =3D pat << left | pat >> right;
+			n -=3D 4;
+		}
+		while (n--) {
+			FB_WRITEL(pat, dst++);
+			pat =3D pat << left | pat >> right;
+		}
+
+		// Trailing bits
+		if (last)
+			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
+	}
+}
+
+    /*
+     *  Aligned pattern invert using 32/64-bit memory accesses
+     */
+static void
+bitfill_aligned_rev(struct fb_info *p, unsigned long __iomem *dst,
+		    int dst_idx, unsigned long pat, unsigned n, int bits,
+		    u32 bswapmask)
+{
+	unsigned long val =3D pat, dat;
+	unsigned long first, last;
+
+	if (!n)
+		return;
+
+	first =3D fb_shifted_pixels_mask_long(p, dst_idx, bswapmask);
+	last =3D ~fb_shifted_pixels_mask_long(p, (dst_idx+n) % bits, bswapmask)=
;
+
+	if (dst_idx+n <=3D bits) {
+		// Single word
+		if (last)
+			first &=3D last;
+		dat =3D FB_READL(dst);
+		FB_WRITEL(comp(dat ^ val, dat, first), dst);
+	} else {
+		// Multiple destination words
+		// Leading bits
+		if (first!=3D0UL) {
+			dat =3D FB_READL(dst);
+			FB_WRITEL(comp(dat ^ val, dat, first), dst);
+			dst++;
+			n -=3D bits - dst_idx;
+		}
+
+		// Main chunk
+		n /=3D bits;
+		while (n >=3D 8) {
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+			n -=3D 8;
+		}
+		while (n--) {
+			FB_WRITEL(FB_READL(dst) ^ val, dst);
+			dst++;
+		}
+		// Trailing bits
+		if (last) {
+			dat =3D FB_READL(dst);
+			FB_WRITEL(comp(dat ^ val, dat, last), dst);
+		}
+	}
+}
+
+
+    /*
+     *  Unaligned generic pattern invert using 32/64-bit memory accesses=

+     *  The pattern must have been expanded to a full 32/64-bit value
+     *  Left/right are the appropriate shifts to convert to the pattern =
to be
+     *  used for the next 32/64-bit word
+     */
+
+static void
+bitfill_unaligned_rev(struct fb_info *p, unsigned long __iomem *dst,
+		      int dst_idx, unsigned long pat, int left, int right,
+		      unsigned n, int bits)
+{
+	unsigned long first, last, dat;
+
+	if (!n)
+		return;
+
+	first =3D FB_SHIFT_HIGH(p, ~0UL, dst_idx);
+	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
+
+	if (dst_idx+n <=3D bits) {
+		// Single word
+		if (last)
+			first &=3D last;
+		dat =3D FB_READL(dst);
+		FB_WRITEL(comp(dat ^ pat, dat, first), dst);
+	} else {
+		// Multiple destination words
+
+		// Leading bits
+		if (first !=3D 0UL) {
+			dat =3D FB_READL(dst);
+			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+			n -=3D bits - dst_idx;
+		}
+
+		// Main chunk
+		n /=3D bits;
+		while (n >=3D 4) {
+			FB_WRITEL(FB_READL(dst) ^ pat, dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+			FB_WRITEL(FB_READL(dst) ^ pat, dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+			FB_WRITEL(FB_READL(dst) ^ pat, dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+			FB_WRITEL(FB_READL(dst) ^ pat, dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+			n -=3D 4;
+		}
+		while (n--) {
+			FB_WRITEL(FB_READL(dst) ^ pat, dst);
+			dst++;
+			pat =3D pat << left | pat >> right;
+		}
+
+		// Trailing bits
+		if (last) {
+			dat =3D FB_READL(dst);
+			FB_WRITEL(comp(dat ^ pat, dat, last), dst);
+		}
+	}
+}
+
+void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
+{
+	unsigned long pat, pat2, fg;
+	unsigned long width =3D rect->width, height =3D rect->height;
+	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
+	u32 bpp =3D p->var.bits_per_pixel;
+	unsigned long __iomem *dst;
+	int dst_idx, left;
+
+	if (p->state !=3D FBINFO_STATE_RUNNING)
+		return;
+
+	if (p->flags & FBINFO_VIRTFB)
+		fb_warn_once(p, "Framebuffer is not in I/O address space.");
+
+	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
+	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
+		fg =3D ((u32 *) (p->pseudo_palette))[rect->color];
+	else
+		fg =3D rect->color;
+
+	pat =3D pixel_to_pat(bpp, fg);
+
+	dst =3D (unsigned long __iomem *)((unsigned long)p->screen_base & ~(byt=
es-1));
+	dst_idx =3D ((unsigned long)p->screen_base & (bytes - 1))*8;
+	dst_idx +=3D rect->dy*p->fix.line_length*8+rect->dx*bpp;
+	/* FIXME For now we support 1-32 bpp only */
+	left =3D bits % bpp;
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
+	if (!left) {
+		u32 bswapmask =3D fb_compute_bswapmask(p);
+		void (*fill_op32)(struct fb_info *p,
+				  unsigned long __iomem *dst, int dst_idx,
+		                  unsigned long pat, unsigned n, int bits,
+				  u32 bswapmask) =3D NULL;
+
+		switch (rect->rop) {
+		case ROP_XOR:
+			fill_op32 =3D bitfill_aligned_rev;
+			break;
+		case ROP_COPY:
+			fill_op32 =3D bitfill_aligned;
+			break;
+		default:
+			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY=
\n");
+			fill_op32 =3D bitfill_aligned;
+			break;
+		}
+		while (height--) {
+			dst +=3D dst_idx >> (ffs(bits) - 1);
+			dst_idx &=3D (bits - 1);
+			fill_op32(p, dst, dst_idx, pat, width*bpp, bits,
+				  bswapmask);
+			dst_idx +=3D p->fix.line_length*8;
+		}
+	} else {
+		int right, r;
+		void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
+				int dst_idx, unsigned long pat, int left,
+				int right, unsigned n, int bits) =3D NULL;
+#ifdef __LITTLE_ENDIAN
+		right =3D left;
+		left =3D bpp - right;
+#else
+		right =3D bpp - left;
+#endif
+		switch (rect->rop) {
+		case ROP_XOR:
+			fill_op =3D bitfill_unaligned_rev;
+			break;
+		case ROP_COPY:
+			fill_op =3D bitfill_unaligned;
+			break;
+		default:
+			printk(KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\=
n");
+			fill_op =3D bitfill_unaligned;
+			break;
+		}
+		while (height--) {
+			dst +=3D dst_idx / bits;
+			dst_idx &=3D (bits - 1);
+			r =3D dst_idx % bpp;
+			/* rotate pattern to the correct start position */
+			pat2 =3D le_long_to_cpu(rolx(cpu_to_le_long(pat), r, bpp));
+			fill_op(p, dst, dst_idx, pat2, left, right,
+				width*bpp, bits);
+			dst_idx +=3D p->fix.line_length*8;
+		}
+	}
+}
+
+EXPORT_SYMBOL(cfb_fillrect);
+
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
+MODULE_DESCRIPTION("Generic software accelerated fill rectangle");
+MODULE_LICENSE("GPL");
--=20
2.30.2



--------------wmsSjfpC6zs9qR2lTOUPpmGB--

--------------688ji4ybwVE0PporwLb5vq7I
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaHIFAwAAAAAACgkQWOeEu4KftGs3
Fwf8DXYOWGyMIpj7+NonKwzQ8NwBQE5fa/KkibiTSOo0LVTHeCSuuAE95P0ugCcPhHkhNSe7Tntt
zt6AmJYWYPiX23OgHDqDbppx3NYNiUOXJ6QSd6prnDGzFRV0R6yB1LDiqG++xFcIGenZAUEsooIi
oRl0qgppeso+hcQW/EoTW9GGGCBsl+IMJ1UKTMbgoW7qkSSca1Sj2EDvKA/RyABnAj2kNVeE40Wk
3Mz+jrFvF0c3xewWXng1dsjaUX/Lsl5uKDLppcmlgKuEUTLTlelNpA9xNJykNXzsmJhaSAKQigsX
I8c8OKAsT6AtlRiSjOdsUiXUat+WqER6fcX3RYYhOw==
=tFGe
-----END PGP SIGNATURE-----

--------------688ji4ybwVE0PporwLb5vq7I--
