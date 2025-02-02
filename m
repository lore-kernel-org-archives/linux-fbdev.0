Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214B1D6DB6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500451; cv=none; b=YwwiBwQiExryvkH0RoARpDbhgbA31PJJVOKaN86hhC0f4Hc8ype+nhLzlRQslcvj8sjmmb8bbTCzztJj+xmtbAM6PUNcwJNw9zq12HHAWtGNQU15aMZxGAX+0AWGK7o8xSDRhRfi0A7GKaqIyUc4+wTWTlyPwafyZeaQSjMQRj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500451; c=relaxed/simple;
	bh=q4F9Cgp7aiwSWJpJDH5Kj+dR/GjxdgoIvK3SWOHs/2U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IlbioVdTOT8aITJfIPAEsZSg3kmaTnLSOuh77IlPBFt1fF5A58WYpQfLilPmksyIqnelB0NyHdgKHrgfdcavevAmeMy5niy+2RkqAASkC4L6odRAAqMnslyGaUIjg0dDKZJwWcYCRPe2KuxeUeAW76dKDB4qjKu7Ci+SQUGHev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id C1957100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:47:27 +0100 (CET)
Message-ID: <4370d619-9567-d6e1-1d63-78f0a77ddbe6@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:47:27 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 11/12] fbdev: core: Use generic imageblit for as,
 cfb_imageblit
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
 <7f2cf3dc-ae1e-7b6c-9c71-717b6f4453ea@c64.rulez.org>
 <6c0e4997-8215-a249-20ed-d353ca476cd4@c64.rulez.org>
 <8ed1d74c-0757-6c6c-d619-9d9b4fea00c0@c64.rulez.org>
In-Reply-To: <8ed1d74c-0757-6c6c-d619-9d9b4fea00c0@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WgidptkMrtxlS5mb3cTj4KXl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WgidptkMrtxlS5mb3cTj4KXl
Content-Type: multipart/mixed; boundary="------------o0hJzQmRefh4AvADLEC77G8A";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <4370d619-9567-d6e1-1d63-78f0a77ddbe6@c64.rulez.org>
Subject: [RFC PATCH 11/12] fbdev: core: Use generic imageblit for as,
 cfb_imageblit
References: <f921492d-6c53-ce68-16b6-dc9c21f2b738@c64.rulez.org>
 <0e2eba19-bc83-fd23-c9ff-59299a738bcf@c64.rulez.org>
 <a3c00956-ee69-df58-9e1e-aca48a8a6367@c64.rulez.org>
 <50c335f3-d3c9-3f1d-dd3b-e78818425662@c64.rulez.org>
 <ff1f4d9f-a6eb-8ff8-d965-268722b43780@c64.rulez.org>
 <f1f041ad-3670-029e-7914-651729ea5062@c64.rulez.org>
 <65535c64-6f8e-95b4-e171-528176969983@c64.rulez.org>
 <15ae6780-b3a9-abad-047b-a650d193aba3@c64.rulez.org>
 <7f2cf3dc-ae1e-7b6c-9c71-717b6f4453ea@c64.rulez.org>
 <6c0e4997-8215-a249-20ed-d353ca476cd4@c64.rulez.org>
 <8ed1d74c-0757-6c6c-d619-9d9b4fea00c0@c64.rulez.org>
In-Reply-To: <8ed1d74c-0757-6c6c-d619-9d9b4fea00c0@c64.rulez.org>

--------------o0hJzQmRefh4AvADLEC77G8A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Use generic imageblit for as cfb_imageblit

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/cfbimgblt.c | 356 +--------------------------
 1 file changed, 8 insertions(+), 348 deletions(-)

diff --git a/drivers/video/fbdev/core/cfbimgblt.c b/drivers/video/fbdev/c=
ore/cfbimgblt.c
index 7d1d2f1a6..ff2eda62e 100644
--- a/drivers/video/fbdev/core/cfbimgblt.c
+++ b/drivers/video/fbdev/core/cfbimgblt.c
@@ -7,359 +7,19 @@
  *  License.  See the file COPYING in the main directory of this archive=
 for
  *  more details.
  *
- * NOTES:
- *
- *    This function copys a image from system memory to video memory. Th=
e
- *  image can be a bitmap where each 0 represents the background color a=
nd
- *  each 1 represents the foreground color. Great for font handling. It =
can
- *  also be a color image. This is determined by image_depth. The color =
image
- *  must be laid out exactly in the same format as the framebuffer. Yes =
I know
- *  their are cards with hardware that coverts images of various depths =
to the
- *  framebuffer depth. But not every card has this. All images must be r=
ounded
- *  up to the nearest byte. For example a bitmap 12 bits wide must be tw=
o
- *  bytes width.
- *
- *  Tony:
- *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This sp=
eeds
- *  up the code significantly.
- *
- *  Code for depths not multiples of BITS_PER_LONG is still kludgy, whic=
h is
- *  still processed a bit at a time.
- *
- *  Also need to add code to deal with cards endians that are different =
than
- *  the native cpu endians. I also need to deal with MSB position in the=
 word.
  */
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-#include "fb_draw.h"
-
-#define DEBUG
-
-#ifdef DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt,__func__,## a=
rgs)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-static const u32 cfb_tab8_be[] =3D {
-    0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
-    0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
-    0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
-    0xffff0000,0xffff00ff,0xffffff00,0xffffffff
-};
-
-static const u32 cfb_tab8_le[] =3D {
-    0x00000000,0xff000000,0x00ff0000,0xffff0000,
-    0x0000ff00,0xff00ff00,0x00ffff00,0xffffff00,
-    0x000000ff,0xff0000ff,0x00ff00ff,0xffff00ff,
-    0x0000ffff,0xff00ffff,0x00ffffff,0xffffffff
-};
-
-static const u32 cfb_tab16_be[] =3D {
-    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
-};
-
-static const u32 cfb_tab16_le[] =3D {
-    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
-};
-
-static const u32 cfb_tab32[] =3D {
-	0x00000000, 0xffffffff
-};
-
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-
-static inline void color_imageblit(const struct fb_image *image,
-				   struct fb_info *p, u8 __iomem *dst1,
-				   u32 start_index,
-				   u32 pitch_index)
-{
-	/* Draw the penguin */
-	u32 __iomem *dst, *dst2;
-	u32 color =3D 0, val, shift;
-	int i, n, bpp =3D p->var.bits_per_pixel;
-	u32 null_bits =3D 32 - bpp;
-	u32 *palette =3D (u32 *) p->pseudo_palette;
-	const u8 *src =3D image->data;
-	u32 bswapmask =3D fb_compute_bswapmask(p);
-
-	dst2 =3D (u32 __iomem *) dst1;
-	for (i =3D image->height; i--; ) {
-		n =3D image->width;
-		dst =3D (u32 __iomem *) dst1;
-		shift =3D 0;
-		val =3D 0;
-
-		if (start_index) {
-			u32 start_mask =3D ~fb_shifted_pixels_mask_u32(p,
-						start_index, bswapmask);
-			val =3D FB_READL(dst) & start_mask;
-			shift =3D start_index;
-		}
-		while (n--) {
-			if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
-			    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
-				color =3D palette[*src];
-			else
-				color =3D *src;
-			color <<=3D FB_LEFT_POS(p, bpp);
-			val |=3D FB_SHIFT_HIGH(p, color, shift ^ bswapmask);
-			if (shift >=3D null_bits) {
-				FB_WRITEL(val, dst++);
-
-				val =3D (shift =3D=3D null_bits) ? 0 :
-					FB_SHIFT_LOW(p, color, 32 - shift);
-			}
-			shift +=3D bpp;
-			shift &=3D (32 - 1);
-			src++;
-		}
-		if (shift) {
-			u32 end_mask =3D fb_shifted_pixels_mask_u32(p, shift,
-						bswapmask);
-
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
-		}
-		dst1 +=3D p->fix.line_length;
-		if (pitch_index) {
-			dst2 +=3D p->fix.line_length;
-			dst1 =3D (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
-
-			start_index +=3D pitch_index;
-			start_index &=3D 32 - 1;
-		}
-	}
-}
-
-static inline void slow_imageblit(const struct fb_image *image, struct f=
b_info *p,
-				  u8 __iomem *dst1, u32 fgcolor,
-				  u32 bgcolor,
-				  u32 start_index,
-				  u32 pitch_index)
-{
-	u32 shift, color =3D 0, bpp =3D p->var.bits_per_pixel;
-	u32 __iomem *dst, *dst2;
-	u32 val, pitch =3D p->fix.line_length;
-	u32 null_bits =3D 32 - bpp;
-	u32 spitch =3D (image->width+7)/8;
-	const u8 *src =3D image->data, *s;
-	u32 i, j, l;
-	u32 bswapmask =3D fb_compute_bswapmask(p);
-
-	dst2 =3D (u32 __iomem *) dst1;
-	fgcolor <<=3D FB_LEFT_POS(p, bpp);
-	bgcolor <<=3D FB_LEFT_POS(p, bpp);
-
-	for (i =3D image->height; i--; ) {
-		shift =3D val =3D 0;
-		l =3D 8;
-		j =3D image->width;
-		dst =3D (u32 __iomem *) dst1;
-		s =3D src;
-
-		/* write leading bits */
-		if (start_index) {
-			u32 start_mask =3D ~fb_shifted_pixels_mask_u32(p,
-						start_index, bswapmask);
-			val =3D FB_READL(dst) & start_mask;
-			shift =3D start_index;
-		}
-
-		while (j--) {
-			l--;
-			color =3D (*s & (1 << l)) ? fgcolor : bgcolor;
-			val |=3D FB_SHIFT_HIGH(p, color, shift ^ bswapmask);
-
-			/* Did the bitshift spill bits to the next long? */
-			if (shift >=3D null_bits) {
-				FB_WRITEL(val, dst++);
-				val =3D (shift =3D=3D null_bits) ? 0 :
-					FB_SHIFT_LOW(p, color, 32 - shift);
-			}
-			shift +=3D bpp;
-			shift &=3D (32 - 1);
-			if (!l) { l =3D 8; s++; }
-		}
-
-		/* write trailing bits */
- 		if (shift) {
-			u32 end_mask =3D fb_shifted_pixels_mask_u32(p, shift,
-						bswapmask);
-
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
-		}
-
-		dst1 +=3D pitch;
-		src +=3D spitch;
-		if (pitch_index) {
-			dst2 +=3D pitch;
-			dst1 =3D (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
-			start_index +=3D pitch_index;
-			start_index &=3D 32 - 1;
-		}
-
-	}
-}
-
-/*
- * fast_imageblit - optimized monochrome color expansion
- *
- * Only if:  bits_per_pixel =3D=3D 8, 16, or 32
- *           image->width is divisible by pixel/dword (ppw);
- *           fix->line_legth is divisible by 4;
- *           beginning and end of a scanline is dword aligned
- */
-static inline void fast_imageblit(const struct fb_image *image, struct f=
b_info *p,
-				  u8 __iomem *dst1, u32 fgcolor,
-				  u32 bgcolor)
-{
-	u32 fgx =3D fgcolor, bgx =3D bgcolor, bpp =3D p->var.bits_per_pixel;
-	u32 ppw =3D 32/bpp, spitch =3D (image->width + 7)/8;
-	u32 bit_mask, eorx, shift;
-	const char *s =3D image->data, *src;
-	u32 __iomem *dst;
-	const u32 *tab =3D NULL;
-	size_t tablen;
-	u32 colortab[16];
-	int i, j, k;
-
-	switch (bpp) {
-	case 8:
-		tab =3D fb_be_math(p) ? cfb_tab8_be : cfb_tab8_le;
-		tablen =3D 16;
-		break;
-	case 16:
-		tab =3D fb_be_math(p) ? cfb_tab16_be : cfb_tab16_le;
-		tablen =3D 4;
-		break;
-	case 32:
-		tab =3D cfb_tab32;
-		tablen =3D 2;
-		break;
-	default:
-		return;
-	}
-
-	for (i =3D ppw-1; i--; ) {
-		fgx <<=3D bpp;
-		bgx <<=3D bpp;
-		fgx |=3D fgcolor;
-		bgx |=3D bgcolor;
-	}
-
-	bit_mask =3D (1 << ppw) - 1;
-	eorx =3D fgx ^ bgx;
-	k =3D image->width/ppw;
-
-	for (i =3D 0; i < tablen; ++i)
-		colortab[i] =3D (tab[i] & eorx) ^ bgx;
-
-	for (i =3D image->height; i--; ) {
-		dst =3D (u32 __iomem *)dst1;
-		shift =3D 8;
-		src =3D s;
-
-		/*
-		 * Manually unroll the per-line copying loop for better
-		 * performance. This works until we processed the last
-		 * completely filled source byte (inclusive).
-		 */
-		switch (ppw) {
-		case 4: /* 8 bpp */
-			for (j =3D k; j >=3D 2; j -=3D 2, ++src) {
-				FB_WRITEL(colortab[(*src >> 4) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 0) & bit_mask], dst++);
-			}
-			break;
-		case 2: /* 16 bpp */
-			for (j =3D k; j >=3D 4; j -=3D 4, ++src) {
-				FB_WRITEL(colortab[(*src >> 6) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 4) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 2) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 0) & bit_mask], dst++);
-			}
-			break;
-		case 1: /* 32 bpp */
-			for (j =3D k; j >=3D 8; j -=3D 8, ++src) {
-				FB_WRITEL(colortab[(*src >> 7) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 6) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 5) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 4) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 3) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 2) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 1) & bit_mask], dst++);
-				FB_WRITEL(colortab[(*src >> 0) & bit_mask], dst++);
-			}
-			break;
-		}
-
-		/*
-		 * For image widths that are not a multiple of 8, there
-		 * are trailing pixels left on the current line. Print
-		 * them as well.
-		 */
-		for (; j--; ) {
-			shift -=3D ppw;
-			FB_WRITEL(colortab[(*src >> shift) & bit_mask], dst++);
-			if (!shift) {
-				shift =3D 8;
-				++src;
-			}
-		}
-
-		dst1 +=3D p->fix.line_length;
-		s +=3D spitch;
-	}
-}
-
-void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
-{
-	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index =3D 0;
-	u32 bpl =3D sizeof(u32), bpp =3D p->var.bits_per_pixel;
-	u32 width =3D image->width;
-	u32 dx =3D image->dx, dy =3D image->dy;
-	u8 __iomem *dst1;
-
-	if (p->state !=3D FBINFO_STATE_RUNNING)
-		return;
-
-	if (p->flags & FBINFO_VIRTFB)
-		fb_warn_once(p, "Framebuffer is not in I/O address space.");
-
-	bitstart =3D (dy * p->fix.line_length * 8) + (dx * bpp);
-	start_index =3D bitstart & (32 - 1);
-	pitch_index =3D (p->fix.line_length & (bpl - 1)) * 8;
-
-	bitstart /=3D 8;
-	bitstart &=3D ~(bpl - 1);
-	dst1 =3D p->screen_base + bitstart;
-
-	if (p->fbops->fb_sync)
-		p->fbops->fb_sync(p);
-
-	if (image->depth =3D=3D 1) {
-		if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
-		    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR) {
-			fgcolor =3D ((u32*)(p->pseudo_palette))[image->fg_color];
-			bgcolor =3D ((u32*)(p->pseudo_palette))[image->bg_color];
-		} else {
-			fgcolor =3D image->fg_color;
-			bgcolor =3D image->bg_color;
-		}
=20
-		if (32 % bpp =3D=3D 0 && !start_index && !pitch_index &&
-		    ((width & (32/bpp-1)) =3D=3D 0) &&
-		    bpp >=3D 8 && bpp <=3D 32)
-			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
-		else
-			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
-					start_index, pitch_index);
-	} else
-		color_imageblit(image, p, dst1, start_index, pitch_index);
-}
+#define FB_WRITEL         fb_writel
+#define FB_READL          fb_readl
+#define FB_MEM            __iomem
+#define FB_IMAGEBLIT      cfb_imageblit
+#define FB_SPACE          0
+#define FB_SPACE_NAME     "I/O"
+#define FB_SCREEN_BASE(a) ((a)->screen_base)
+#include "fb_imageblit.h"
=20
 EXPORT_SYMBOL(cfb_imageblit);
=20
--=20
2.30.2


--------------o0hJzQmRefh4AvADLEC77G8A--

--------------WgidptkMrtxlS5mb3cTj4KXl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaV8FAwAAAAAACgkQWOeEu4KftGvJ
FAgAvUkvJ46VlTwa+h5W//MIxGchfmGovE3/qLivMGQi8xoN2udUwzD+6Mh3heh6QhOhZWklWcMD
peMiqVXltF7hDz/rlryQp4sQq6LtI+7ZVW3Eyd07EZResHaiHNvP7viJL4IzWUGBJB+VJSC1NJDl
4ze4Lz9gpEoQTueSTmIwSiqjczM9LKuG6kyHFZ7whiKRRDHewEPcd9OKWz+dJe0qTMtdjK7AICAs
pjOTQdk+brN/saz3n21v8pxRQVZCF8YRk6iHKiuhwzjxmaCR5+YbqcMEBiXr9RDt8a/0wgB9nnDU
/meTckzQqCRBapCB74EXGg0R3zrXNdsghOcMS0Nz2A==
=lMPF
-----END PGP SIGNATURE-----

--------------WgidptkMrtxlS5mb3cTj4KXl--
