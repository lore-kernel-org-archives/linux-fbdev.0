Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE67156885
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500337; cv=none; b=LjD8fyfFSkMbBS8uTbrhcN4a+wjNPTxzuCAdZYzMKwCkhVgS2d0g7BdDae2aU71XECgIsrtkGRFF8L8kzmgBXFO9aKxB2tT/HPsDRUmTpia7R0hEW0dS8zfqUkabEjWRpCSE/m75e/pYxkUzqnuyl+zVryfZ+GC6sdTuvP4+TEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500337; c=relaxed/simple;
	bh=zXdGKZ8a88/91/7b2h63DQXRghmd/vVjiwcgfI+WrsI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Tp4n8fMWGXjpx2CzSwTzR2VegILy40HhRlfHlcbUXRI3GAg00cgTTnCP36O6y8nU8j9JMYjXRV+yG31vqE815vNwoqibxcUh6bHvi5BK7XGBdtsae2+/etC+bXNS8tclIV4g935m6qmqTQ9daP6xUo48cTFMbedg2IZrduLE9ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 6562F100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:45:34 +0100 (CET)
Message-ID: <7f2cf3dc-ae1e-7b6c-9c71-717b6f4453ea@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:45:34 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 08/12] fbdev: core: Use generic fillrect for as,
 sys_fillrect
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
 <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>
In-Reply-To: <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FV3PzJcWdv2jH3POF1BLVPxw"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FV3PzJcWdv2jH3POF1BLVPxw
Content-Type: multipart/mixed; boundary="------------Ps5xU29qV60yM4rnoaSQ9KIv";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <7f2cf3dc-ae1e-7b6c-9c71-717b6f4453ea@c64.rulez.org>
Subject: [RFC PATCH 08/12] fbdev: core: Use generic fillrect for as,
 sys_fillrect
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
 <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
 <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
 <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>
In-Reply-To: <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>

--------------Ps5xU29qV60yM4rnoaSQ9KIv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Use generic fillrect for as sys_fillrect

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/sysfillrect.c | 314 +------------------------
 1 file changed, 9 insertions(+), 305 deletions(-)

diff --git a/drivers/video/fbdev/core/sysfillrect.c b/drivers/video/fbdev=
/core/sysfillrect.c
index e49221a88..48d0f0efb 100644
--- a/drivers/video/fbdev/core/sysfillrect.c
+++ b/drivers/video/fbdev/core/sysfillrect.c
@@ -12,314 +12,18 @@
  *  more details.
  */
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include "fb_draw.h"
=20
-    /*
-     *  Aligned pattern fill using 32/64-bit memory accesses
-     */
-
-static void
-bitfill_aligned(struct fb_info *p, unsigned long *dst, int dst_idx,
-		unsigned long pat, unsigned n, int bits)
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
-		/* Single word */
-		if (last)
-			first &=3D last;
-		*dst =3D comp(pat, *dst, first);
-	} else {
-		/* Multiple destination words */
-
-		/* Leading bits */
- 		if (first!=3D ~0UL) {
-			*dst =3D comp(pat, *dst, first);
-			dst++;
-			n -=3D bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /=3D bits;
-		memset_l(dst, pat, n);
-		dst +=3D n;
-
-		/* Trailing bits */
-		if (last)
-			*dst =3D comp(pat, *dst, last);
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
-bitfill_unaligned(struct fb_info *p, unsigned long *dst, int dst_idx,
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
-		/* Single word */
-		if (last)
-			first &=3D last;
-		*dst =3D comp(pat, *dst, first);
-	} else {
-		/* Multiple destination words */
-		/* Leading bits */
-		if (first) {
-			*dst =3D comp(pat, *dst, first);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			n -=3D bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /=3D bits;
-		while (n >=3D 4) {
-			*dst++ =3D pat;
-			pat =3D pat << left | pat >> right;
-			*dst++ =3D pat;
-			pat =3D pat << left | pat >> right;
-			*dst++ =3D pat;
-			pat =3D pat << left | pat >> right;
-			*dst++ =3D pat;
-			pat =3D pat << left | pat >> right;
-			n -=3D 4;
-		}
-		while (n--) {
-			*dst++ =3D pat;
-			pat =3D pat << left | pat >> right;
-		}
-
-		/* Trailing bits */
-		if (last)
-			*dst =3D comp(pat, *dst, last);
-	}
-}
-
-    /*
-     *  Aligned pattern invert using 32/64-bit memory accesses
-     */
-static void
-bitfill_aligned_rev(struct fb_info *p, unsigned long *dst, int dst_idx,
-		    unsigned long pat, unsigned n, int bits)
-{
-	unsigned long val =3D pat;
-	unsigned long first, last;
-
-	if (!n)
-		return;
-
-	first =3D FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (dst_idx+n <=3D bits) {
-		/* Single word */
-		if (last)
-			first &=3D last;
-		*dst =3D comp(*dst ^ val, *dst, first);
-	} else {
-		/* Multiple destination words */
-		/* Leading bits */
-		if (first!=3D0UL) {
-			*dst =3D comp(*dst ^ val, *dst, first);
-			dst++;
-			n -=3D bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /=3D bits;
-		while (n >=3D 8) {
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			*dst++ ^=3D val;
-			n -=3D 8;
-		}
-		while (n--)
-			*dst++ ^=3D val;
-		/* Trailing bits */
-		if (last)
-			*dst =3D comp(*dst ^ val, *dst, last);
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
-bitfill_unaligned_rev(struct fb_info *p, unsigned long *dst, int dst_idx=
,
-		      unsigned long pat, int left, int right, unsigned n,
-		      int bits)
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
-		/* Single word */
-		if (last)
-			first &=3D last;
-		*dst =3D comp(*dst ^ pat, *dst, first);
-	} else {
-		/* Multiple destination words */
-
-		/* Leading bits */
-		if (first !=3D 0UL) {
-			*dst =3D comp(*dst ^ pat, *dst, first);
-			dst++;
-			pat =3D pat << left | pat >> right;
-			n -=3D bits - dst_idx;
-		}
-
-		/* Main chunk */
-		n /=3D bits;
-		while (n >=3D 4) {
-			*dst++ ^=3D pat;
-			pat =3D pat << left | pat >> right;
-			*dst++ ^=3D pat;
-			pat =3D pat << left | pat >> right;
-			*dst++ ^=3D pat;
-			pat =3D pat << left | pat >> right;
-			*dst++ ^=3D pat;
-			pat =3D pat << left | pat >> right;
-			n -=3D 4;
-		}
-		while (n--) {
-			*dst ^=3D pat;
-			pat =3D pat << left | pat >> right;
-		}
-
-		/* Trailing bits */
-		if (last)
-			*dst =3D comp(*dst ^ pat, *dst, last);
-	}
-}
-
-void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
-{
-	unsigned long pat, pat2, fg;
-	unsigned long width =3D rect->width, height =3D rect->height;
-	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
-	u32 bpp =3D p->var.bits_per_pixel;
-	unsigned long *dst;
-	int dst_idx, left;
-
-	if (p->state !=3D FBINFO_STATE_RUNNING)
-		return;
-
-	if (!(p->flags & FBINFO_VIRTFB))
-		fb_warn_once(p, "Framebuffer is not in virtual address space.");
-
-	if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
-	    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
-		fg =3D ((u32 *) (p->pseudo_palette))[rect->color];
-	else
-		fg =3D rect->color;
-
-	pat =3D pixel_to_pat( bpp, fg);
-
-	dst =3D (unsigned long *)((unsigned long)p->screen_base & ~(bytes-1));
-	dst_idx =3D ((unsigned long)p->screen_base & (bytes - 1))*8;
-	dst_idx +=3D rect->dy*p->fix.line_length*8+rect->dx*bpp;
-	/* FIXME For now we support 1-32 bpp only */
-	left =3D bits % bpp;
-	if (p->fbops->fb_sync)
-		p->fbops->fb_sync(p);
-	if (!left) {
-		void (*fill_op32)(struct fb_info *p, unsigned long *dst,
-				  int dst_idx, unsigned long pat, unsigned n,
-				  int bits) =3D NULL;
-
-		switch (rect->rop) {
-		case ROP_XOR:
-			fill_op32 =3D bitfill_aligned_rev;
-			break;
-		case ROP_COPY:
-			fill_op32 =3D bitfill_aligned;
-			break;
-		default:
-			printk( KERN_ERR "cfb_fillrect(): unknown rop, "
-				"defaulting to ROP_COPY\n");
-			fill_op32 =3D bitfill_aligned;
-			break;
-		}
-		while (height--) {
-			dst +=3D dst_idx >> (ffs(bits) - 1);
-			dst_idx &=3D (bits - 1);
-			fill_op32(p, dst, dst_idx, pat, width*bpp, bits);
-			dst_idx +=3D p->fix.line_length*8;
-		}
-	} else {
-		int right, r;
-		void (*fill_op)(struct fb_info *p, unsigned long *dst,
-				int dst_idx, unsigned long pat, int left,
-				int right, unsigned n, int bits) =3D NULL;
-#ifdef __LITTLE_ENDIAN
-		right =3D left;
-		left =3D bpp - right;
-#else
-		right =3D bpp - left;
-#endif
-		switch (rect->rop) {
-		case ROP_XOR:
-			fill_op =3D bitfill_unaligned_rev;
-			break;
-		case ROP_COPY:
-			fill_op =3D bitfill_unaligned;
-			break;
-		default:
-			printk(KERN_ERR "sys_fillrect(): unknown rop, "
-				"defaulting to ROP_COPY\n");
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
+#define FB_READL(a)       (*a)
+#define FB_WRITEL(a,b)    do { *(b) =3D (a); } while (false)
+#define FB_MEM            /* nothing */
+#define FB_FILLRECT       sys_fillrect
+#define FB_FILLRECT_NAME  "sys_fillrect"
+#define FB_SPACE          FBINFO_VIRTFB
+#define FB_SPACE_NAME     "virtual"
+#define FB_SCREEN_BASE(a) ((a)->screen_buffer)
+#include "fb_fillrect.h"
=20
 EXPORT_SYMBOL(sys_fillrect);
=20
--=20
2.30.2


--------------Ps5xU29qV60yM4rnoaSQ9KIv--

--------------FV3PzJcWdv2jH3POF1BLVPxw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaO4FAwAAAAAACgkQWOeEu4KftGsg
twgApnqoYlpnUEMTArOb8zvmmYDwnRF2if2kKs5yzxBFTpPRsXV1cyhIrH7NaS9Y5GJPB1krUck9
WFCxXq/gYktbWYimliLVLlnr5pAXbU5kbTxQzfwdLK1dAlEzrJmGo3Yk6Y2vpvl7aiXHfsoP7jlZ
iiOnJHjSkHBr/QI5HKwYGplv1243Vtxm50mU6kD+iQcdoQ1JFJ/5PudRBPaOeX0CNi2l5hxADBPT
UomUzcThns6bD0+QiZBOX4EsXqoUqdgE54PcocXZL9FU0VkWXesCnanP9mYGwzUTTZ4terkxKO2F
hsCI6YXbupTQWrhAgdtkX671cZROKn5CNhGYM/zjDQ==
=wl74
-----END PGP SIGNATURE-----

--------------FV3PzJcWdv2jH3POF1BLVPxw--
