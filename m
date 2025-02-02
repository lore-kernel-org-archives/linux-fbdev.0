Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA61DFDE
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500184; cv=none; b=p3gLs/QVwSqZSO2efJci6ajiUq020Qr3U08zGWZ06djE9LuKGeF/VIxhLYE2HfVJ108v7XBLolNan/+sX8LDDC3+O5TgDaeHQgqvJEHAdqbfngLP5G7X6RHrDPMOMV3oLHC/SfKLVN1De594bgTVn4oqyM4bzzCCZySMYZnAMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500184; c=relaxed/simple;
	bh=G4qx893KhBVwJjFvGwXqIrwItvWFwjEEBMfuXI4lbWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RYJS4fXvJ8AlomMwcW8DQAAZCzgi2K/pXOZtweS10KTUXwqe1ag7NubrNCSeWp3KCp5NDABnR4RXsRajm5IbFqEVQt3N+gbJ7uZwPpoWIzPBujoiIiwVvh8e9mNkA/SIE+5z/rYpqLIT+Twkuo+zRyLEvpzPzxLD0QD3F48O3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 88810100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:42:57 +0100 (CET)
Message-ID: <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:42:57 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 04/12] Deduplicate cfb/sys drawing fbops
Content-Language: en-GB
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
In-Reply-To: <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qwGb1PNrkYDqSU0Nqk84O0bb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qwGb1PNrkYDqSU0Nqk84O0bb
Content-Type: multipart/mixed; boundary="------------waTK0ttuFkaLQq9gULPM0tQy";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
Subject: [RFC PATCH 04/12] Deduplicate cfb/sys drawing fbops
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
In-Reply-To: <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>

--------------waTK0ttuFkaLQq9gULPM0tQy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Use generic copyarea for as sys_copyarea

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/syscopyarea.c | 356 +------------------------
 1 file changed, 8 insertions(+), 348 deletions(-)

diff --git a/drivers/video/fbdev/core/syscopyarea.c b/drivers/video/fbdev=
/core/syscopyarea.c
index 75e7001e8..f720301e2 100644
--- a/drivers/video/fbdev/core/syscopyarea.c
+++ b/drivers/video/fbdev/core/syscopyarea.c
@@ -13,357 +13,17 @@
  *
  */
 #include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include <asm/io.h>
-#include "fb_draw.h"
=20
-    /*
-     *  Generic bitwise copy algorithm
-     */
-
-static void
-bitcpy(struct fb_info *p, unsigned long *dst, unsigned dst_idx,
-	const unsigned long *src, unsigned src_idx, int bits, unsigned n)
-{
-	unsigned long first, last;
-	int const shift =3D dst_idx-src_idx;
-	int left, right;
-
-	first =3D FB_SHIFT_HIGH(p, ~0UL, dst_idx);
-	last =3D ~(FB_SHIFT_HIGH(p, ~0UL, (dst_idx+n) % bits));
-
-	if (!shift) {
-		/* Same alignment for source and dest */
-		if (dst_idx+n <=3D bits) {
-			/* Single word */
-			if (last)
-				first &=3D last;
-			*dst =3D comp(*src, *dst, first);
-		} else {
-			/* Multiple destination words */
-			/* Leading bits */
- 			if (first !=3D ~0UL) {
-				*dst =3D comp(*src, *dst, first);
-				dst++;
-				src++;
-				n -=3D bits - dst_idx;
-			}
-
-			/* Main chunk */
-			n /=3D bits;
-			while (n >=3D 8) {
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				*dst++ =3D *src++;
-				n -=3D 8;
-			}
-			while (n--)
-				*dst++ =3D *src++;
-
-			/* Trailing bits */
-			if (last)
-				*dst =3D comp(*src, *dst, last);
-		}
-	} else {
-		unsigned long d0, d1;
-		int m;
-
-		/* Different alignment for source and dest */
-		right =3D shift & (bits - 1);
-		left =3D -shift & (bits - 1);
-
-		if (dst_idx+n <=3D bits) {
-			/* Single destination word */
-			if (last)
-				first &=3D last;
-			if (shift > 0) {
-				/* Single source word */
-				*dst =3D comp(*src << left, *dst, first);
-			} else if (src_idx+n <=3D bits) {
-				/* Single source word */
-				*dst =3D comp(*src >> right, *dst, first);
-			} else {
-				/* 2 source words */
-				d0 =3D *src++;
-				d1 =3D *src;
-				*dst =3D comp(d0 >> right | d1 << left, *dst,
-					    first);
-			}
-		} else {
-			/* Multiple destination words */
-			/** We must always remember the last value read,
-			    because in case SRC and DST overlap bitwise (e.g.
-			    when moving just one pixel in 1bpp), we always
-			    collect one full long for DST and that might
-			    overlap with the current long from SRC. We store
-			    this value in 'd0'. */
-			d0 =3D *src++;
-			/* Leading bits */
-			if (shift > 0) {
-				/* Single source word */
-				*dst =3D comp(d0 << left, *dst, first);
-				dst++;
-				n -=3D bits - dst_idx;
-			} else {
-				/* 2 source words */
-				d1 =3D *src++;
-				*dst =3D comp(d0 >> right | d1 << left, *dst,
-					    first);
-				d0 =3D d1;
-				dst++;
-				n -=3D bits - dst_idx;
-			}
-
-			/* Main chunk */
-			m =3D n % bits;
-			n /=3D bits;
-			while (n >=3D 4) {
-				d1 =3D *src++;
-				*dst++ =3D d0 >> right | d1 << left;
-				d0 =3D d1;
-				d1 =3D *src++;
-				*dst++ =3D d0 >> right | d1 << left;
-				d0 =3D d1;
-				d1 =3D *src++;
-				*dst++ =3D d0 >> right | d1 << left;
-				d0 =3D d1;
-				d1 =3D *src++;
-				*dst++ =3D d0 >> right | d1 << left;
-				d0 =3D d1;
-				n -=3D 4;
-			}
-			while (n--) {
-				d1 =3D *src++;
-				*dst++ =3D d0 >> right | d1 << left;
-				d0 =3D d1;
-			}
-
-			/* Trailing bits */
-			if (m) {
-				if (m <=3D bits - right) {
-					/* Single source word */
-					d0 >>=3D right;
-				} else {
-					/* 2 source words */
- 					d1 =3D *src;
-					d0 =3D d0 >> right | d1 << left;
-				}
-				*dst =3D comp(d0, *dst, last);
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
-bitcpy_rev(struct fb_info *p, unsigned long *dst, unsigned dst_idx,
-	   const unsigned long *src, unsigned src_idx, unsigned bits,
-	   unsigned n)
-{
-	unsigned long first, last;
-	int shift;
-
-	dst +=3D (dst_idx + n - 1) / bits;
-	src +=3D (src_idx + n - 1) / bits;
-	dst_idx =3D (dst_idx + n - 1) % bits;
-	src_idx =3D (src_idx + n - 1) % bits;
-
-	shift =3D dst_idx-src_idx;
-
-	first =3D ~FB_SHIFT_HIGH(p, ~0UL, (dst_idx + 1) % bits);
-	last =3D FB_SHIFT_HIGH(p, ~0UL, (bits + dst_idx + 1 - n) % bits);
-
-	if (!shift) {
-		/* Same alignment for source and dest */
-		if ((unsigned long)dst_idx+1 >=3D n) {
-			/* Single word */
-			if (first)
-				last &=3D first;
-			*dst =3D comp(*src, *dst, last);
-		} else {
-			/* Multiple destination words */
-
-			/* Leading bits */
-			if (first) {
-				*dst =3D comp(*src, *dst, first);
-				dst--;
-				src--;
-				n -=3D dst_idx+1;
-			}
-
-			/* Main chunk */
-			n /=3D bits;
-			while (n >=3D 8) {
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				*dst-- =3D *src--;
-				n -=3D 8;
-			}
-			while (n--)
-				*dst-- =3D *src--;
-			/* Trailing bits */
-			if (last !=3D -1UL)
-				*dst =3D comp(*src, *dst, last);
-		}
-	} else {
-		/* Different alignment for source and dest */
-
-		int const left =3D shift & (bits-1);
-		int const right =3D -shift & (bits-1);
-
-		if ((unsigned long)dst_idx+1 >=3D n) {
-			/* Single destination word */
-			if (first)
-				last &=3D first;
-			if (shift < 0) {
-				/* Single source word */
-				*dst =3D comp(*src >> right, *dst, last);
-			} else if (1+(unsigned long)src_idx >=3D n) {
-				/* Single source word */
-				*dst =3D comp(*src << left, *dst, last);
-			} else {
-				/* 2 source words */
-				*dst =3D comp(*src << left | *(src-1) >> right,
-					    *dst, last);
-			}
-		} else {
-			/* Multiple destination words */
-			/** We must always remember the last value read,
-			    because in case SRC and DST overlap bitwise (e.g.
-			    when moving just one pixel in 1bpp), we always
-			    collect one full long for DST and that might
-			    overlap with the current long from SRC. We store
-			    this value in 'd0'. */
-			unsigned long d0, d1;
-			int m;
-
-			d0 =3D *src--;
-			/* Leading bits */
-			if (shift < 0) {
-				/* Single source word */
-				d1 =3D d0;
-				d0 >>=3D right;
-			} else {
-				/* 2 source words */
-				d1 =3D *src--;
-				d0 =3D d0 << left | d1 >> right;
-			}
-			if (!first)
-				*dst =3D d0;
-			else
-				*dst =3D comp(d0, *dst, first);
-			d0 =3D d1;
-			dst--;
-			n -=3D dst_idx+1;
-
-			/* Main chunk */
-			m =3D n % bits;
-			n /=3D bits;
-			while (n >=3D 4) {
-				d1 =3D *src--;
-				*dst-- =3D d0 << left | d1 >> right;
-				d0 =3D d1;
-				d1 =3D *src--;
-				*dst-- =3D d0 << left | d1 >> right;
-				d0 =3D d1;
-				d1 =3D *src--;
-				*dst-- =3D d0 << left | d1 >> right;
-				d0 =3D d1;
-				d1 =3D *src--;
-				*dst-- =3D d0 << left | d1 >> right;
-				d0 =3D d1;
-				n -=3D 4;
-			}
-			while (n--) {
-				d1 =3D *src--;
-				*dst-- =3D d0 << left | d1 >> right;
-				d0 =3D d1;
-			}
-
-			/* Trailing bits */
-			if (m) {
-				if (m <=3D bits - left) {
-					/* Single source word */
-					d0 <<=3D left;
-				} else {
-					/* 2 source words */
-					d1 =3D *src;
-					d0 =3D d0 << left | d1 >> right;
-				}
-				*dst =3D comp(d0, *dst, last);
-			}
-		}
-	}
-}
-
-void sys_copyarea(struct fb_info *p, const struct fb_copyarea *area)
-{
-	u32 dx =3D area->dx, dy =3D area->dy, sx =3D area->sx, sy =3D area->sy;=

-	u32 height =3D area->height, width =3D area->width;
-	unsigned int const bits_per_line =3D p->fix.line_length * 8u;
-	unsigned long *base =3D NULL;
-	int bits =3D BITS_PER_LONG, bytes =3D bits >> 3;
-	unsigned dst_idx =3D 0, src_idx =3D 0, rev_copy =3D 0;
-
-	if (p->state !=3D FBINFO_STATE_RUNNING)
-		return;
-
-	if (!(p->flags & FBINFO_VIRTFB))
-		fb_warn_once(p, "Framebuffer is not in virtual address space.");
-
-	/* if the beginning of the target area might overlap with the end of
-	the source area, be have to copy the area reverse. */
-	if ((dy =3D=3D sy && dx > sx) || (dy > sy)) {
-		dy +=3D height;
-		sy +=3D height;
-		rev_copy =3D 1;
-	}
-
-	/* split the base of the framebuffer into a long-aligned address and
-	   the index of the first bit */
-	base =3D (unsigned long *)((unsigned long)p->screen_base & ~(bytes-1));=

-	dst_idx =3D src_idx =3D 8*((unsigned long)p->screen_base & (bytes-1));
-	/* add offset of source and target area */
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
-				width*p->var.bits_per_pixel);
-		}
-	} else {
-		while (height--) {
-			bitcpy(p, base + (dst_idx / bits), dst_idx % bits,
-				base + (src_idx / bits), src_idx % bits, bits,
-				width*p->var.bits_per_pixel);
-			dst_idx +=3D bits_per_line;
-			src_idx +=3D bits_per_line;
-		}
-	}
-}
+#define FB_READL(a)       (*a)
+#define FB_WRITEL(a,b)    do { *(b) =3D (a); } while (false)
+#define FB_MEM            /* nothing */
+#define FB_COPYAREA       sys_copyarea
+#define FB_SPACE          FBINFO_VIRTFB
+#define FB_SPACE_NAME     "virtual"
+#define FB_SCREEN_BASE(a) ((a)->screen_buffer)
+#include "fb_copyarea.h"
=20
 EXPORT_SYMBOL(sys_copyarea);
=20
--=20
2.30.2



--------------waTK0ttuFkaLQq9gULPM0tQy--

--------------qwGb1PNrkYDqSU0Nqk84O0bb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaFEFAwAAAAAACgkQWOeEu4KftGu1
6Qf+N0fLsIsLXhH5DgLk8SoEXd92aNuAynSnJ41arPRbCkihvBNB2krtLJZwqoCNBmkfTlamDbtZ
A+y7+KjT6xrKIjSiWxHBjscrQAy73akz5IBSE2zScgv8kcDDBPdcjzLHUOCJajkvslro/0QQeZh3
3NrNDtxxFEc+oI635KkoG7JzvfuZs4gUploB+SonG3L2RujVSMqowxtJKXLvtIA+w7aK4rjUkfEz
OzTzqJ96hxLtWe96WeftqXQHIHvvX5bcWeCm8G1rLuOPPLwPDU+1bUeuBxXPk4vuNqCtkWy+XWqh
h96fcafqSp4gon9WpiQW6wH2yUFD/tV+BGWpPZPgNA==
=tzg2
-----END PGP SIGNATURE-----

--------------qwGb1PNrkYDqSU0Nqk84O0bb--
