Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D97C1D6DB6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500481; cv=none; b=LdTyhbn5kkXNXBW04R7Df+h6jFtNAXGlDTEY0x2GSJpydS9BaWQVjqT3xDpruqAkcNaCM1peSIAfZs5cssUb1tEWso+i7g/fpSHAMUXrra3T9TdTvnzJ5ImD8xgrqoSdtAkcxLD0HRLgunig4mvMUqM0drCNYXqG6LZdTF9pMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500481; c=relaxed/simple;
	bh=UMNAbTf1e+EUuZPrM9+ArkBgL5HaIWMYQZf4V5/RMUA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=sZK2NWqDZikMRVWfmsOD8QUPcIJcW4Y7sNlYUmOFJsF2NVrEAu0Z+/qfWMH3PkjGjxTptmZkeoiR/x7fNzDn+AHl5qlvlG0eTHzK1/94f1uqnHn9EHR6GP+v3SzH3vdCZf4FJr5JCK6b0PMjK/1wcKtbDYlgBF0sXwUb/Bb1T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id 54D40100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:47:57 +0100 (CET)
Message-ID: <858519d3-c4ad-8514-20cd-36eb635459d2@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:47:57 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 12/12] fbdev: core: Use generic imageblit for as,
 sys_imageblit
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
 <4370d619-9567-d6e1-1d63-78f0a77ddbe6@c64.rulez.org>
In-Reply-To: <4370d619-9567-d6e1-1d63-78f0a77ddbe6@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------H0Vm3XQc1sdrGCMFwtWoC5bd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------H0Vm3XQc1sdrGCMFwtWoC5bd
Content-Type: multipart/mixed; boundary="------------kr0Y0hMUDTKmdIGlzT6Lh0nC";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <858519d3-c4ad-8514-20cd-36eb635459d2@c64.rulez.org>
Subject: [RFC PATCH 12/12] fbdev: core: Use generic imageblit for as,
 sys_imageblit
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
 <4370d619-9567-d6e1-1d63-78f0a77ddbe6@c64.rulez.org>
In-Reply-To: <4370d619-9567-d6e1-1d63-78f0a77ddbe6@c64.rulez.org>

--------------kr0Y0hMUDTKmdIGlzT6Lh0nC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Use generic imageblit for as sys_imageblit

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/sysimgblt.c | 324 +--------------------------
 1 file changed, 8 insertions(+), 316 deletions(-)

diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/c=
ore/sysimgblt.c
index 6949bbd51..b62e66280 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -11,325 +11,17 @@
  *  more details.
  */
 #include <linux/module.h>
-#include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
=20
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
-static void color_imageblit(const struct fb_image *image, struct fb_info=
 *p,
-			    void *dst1, u32 start_index, u32 pitch_index)
-{
-	/* Draw the penguin */
-	u32 *dst, *dst2;
-	u32 color =3D 0, val, shift;
-	int i, n, bpp =3D p->var.bits_per_pixel;
-	u32 null_bits =3D 32 - bpp;
-	u32 *palette =3D (u32 *) p->pseudo_palette;
-	const u8 *src =3D image->data;
-
-	dst2 =3D dst1;
-	for (i =3D image->height; i--; ) {
-		n =3D image->width;
-		dst =3D dst1;
-		shift =3D 0;
-		val =3D 0;
-
-		if (start_index) {
-			u32 start_mask =3D ~(FB_SHIFT_HIGH(p, ~(u32)0,
-							 start_index));
-			val =3D *dst & start_mask;
-			shift =3D start_index;
-		}
-		while (n--) {
-			if (p->fix.visual =3D=3D FB_VISUAL_TRUECOLOR ||
-			    p->fix.visual =3D=3D FB_VISUAL_DIRECTCOLOR )
-				color =3D palette[*src];
-			else
-				color =3D *src;
-			color <<=3D FB_LEFT_POS(p, bpp);
-			val |=3D FB_SHIFT_HIGH(p, color, shift);
-			if (shift >=3D null_bits) {
-				*dst++ =3D val;
-
-				val =3D (shift =3D=3D null_bits) ? 0 :
-					FB_SHIFT_LOW(p, color, 32 - shift);
-			}
-			shift +=3D bpp;
-			shift &=3D (32 - 1);
-			src++;
-		}
-		if (shift) {
-			u32 end_mask =3D FB_SHIFT_HIGH(p, ~(u32)0, shift);
-
-			*dst &=3D end_mask;
-			*dst |=3D val;
-		}
-		dst1 +=3D p->fix.line_length;
-		if (pitch_index) {
-			dst2 +=3D p->fix.line_length;
-			dst1 =3D (u8 *)((long)dst2 & ~(sizeof(u32) - 1));
-
-			start_index +=3D pitch_index;
-			start_index &=3D 32 - 1;
-		}
-	}
-}
-
-static void slow_imageblit(const struct fb_image *image, struct fb_info =
*p,
-				  void *dst1, u32 fgcolor, u32 bgcolor,
-				  u32 start_index, u32 pitch_index)
-{
-	u32 shift, color =3D 0, bpp =3D p->var.bits_per_pixel;
-	u32 *dst, *dst2;
-	u32 val, pitch =3D p->fix.line_length;
-	u32 null_bits =3D 32 - bpp;
-	u32 spitch =3D (image->width+7)/8;
-	const u8 *src =3D image->data, *s;
-	u32 i, j, l;
-
-	dst2 =3D dst1;
-	fgcolor <<=3D FB_LEFT_POS(p, bpp);
-	bgcolor <<=3D FB_LEFT_POS(p, bpp);
-
-	for (i =3D image->height; i--; ) {
-		shift =3D val =3D 0;
-		l =3D 8;
-		j =3D image->width;
-		dst =3D dst1;
-		s =3D src;
-
-		/* write leading bits */
-		if (start_index) {
-			u32 start_mask =3D ~(FB_SHIFT_HIGH(p, ~(u32)0,
-							 start_index));
-			val =3D *dst & start_mask;
-			shift =3D start_index;
-		}
-
-		while (j--) {
-			l--;
-			color =3D (*s & (1 << l)) ? fgcolor : bgcolor;
-			val |=3D FB_SHIFT_HIGH(p, color, shift);
-
-			/* Did the bitshift spill bits to the next long? */
-			if (shift >=3D null_bits) {
-				*dst++ =3D val;
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
-			u32 end_mask =3D FB_SHIFT_HIGH(p, ~(u32)0, shift);
-
-			*dst &=3D end_mask;
-			*dst |=3D val;
-		}
-
-		dst1 +=3D pitch;
-		src +=3D spitch;
-		if (pitch_index) {
-			dst2 +=3D pitch;
-			dst1 =3D (u8 *)((long)dst2 & ~(sizeof(u32) - 1));
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
-static void fast_imageblit(const struct fb_image *image, struct fb_info =
*p,
-				  void *dst1, u32 fgcolor, u32 bgcolor)
-{
-	u32 fgx =3D fgcolor, bgx =3D bgcolor, bpp =3D p->var.bits_per_pixel;
-	u32 ppw =3D 32/bpp, spitch =3D (image->width + 7)/8;
-	u32 bit_mask, eorx, shift;
-	const u8 *s =3D image->data, *src;
-	u32 *dst;
-	const u32 *tab;
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
-		dst =3D dst1;
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
-				*dst++ =3D colortab[(*src >> 4) & bit_mask];
-				*dst++ =3D colortab[(*src >> 0) & bit_mask];
-			}
-			break;
-		case 2: /* 16 bpp */
-			for (j =3D k; j >=3D 4; j -=3D 4, ++src) {
-				*dst++ =3D colortab[(*src >> 6) & bit_mask];
-				*dst++ =3D colortab[(*src >> 4) & bit_mask];
-				*dst++ =3D colortab[(*src >> 2) & bit_mask];
-				*dst++ =3D colortab[(*src >> 0) & bit_mask];
-			}
-			break;
-		case 1: /* 32 bpp */
-			for (j =3D k; j >=3D 8; j -=3D 8, ++src) {
-				*dst++ =3D colortab[(*src >> 7) & bit_mask];
-				*dst++ =3D colortab[(*src >> 6) & bit_mask];
-				*dst++ =3D colortab[(*src >> 5) & bit_mask];
-				*dst++ =3D colortab[(*src >> 4) & bit_mask];
-				*dst++ =3D colortab[(*src >> 3) & bit_mask];
-				*dst++ =3D colortab[(*src >> 2) & bit_mask];
-				*dst++ =3D colortab[(*src >> 1) & bit_mask];
-				*dst++ =3D colortab[(*src >> 0) & bit_mask];
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
-			*dst++ =3D colortab[(*src >> shift) & bit_mask];
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
-void sys_imageblit(struct fb_info *p, const struct fb_image *image)
-{
-	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index =3D 0;
-	u32 bpl =3D sizeof(u32), bpp =3D p->var.bits_per_pixel;
-	u32 width =3D image->width;
-	u32 dx =3D image->dx, dy =3D image->dy;
-	void *dst1;
-
-	if (p->state !=3D FBINFO_STATE_RUNNING)
-		return;
-
-	if (!(p->flags & FBINFO_VIRTFB))
-		fb_warn_once(p, "Framebuffer is not in virtual address space.");
-
-	bitstart =3D (dy * p->fix.line_length * 8) + (dx * bpp);
-	start_index =3D bitstart & (32 - 1);
-	pitch_index =3D (p->fix.line_length & (bpl - 1)) * 8;
-
-	bitstart /=3D 8;
-	bitstart &=3D ~(bpl - 1);
-	dst1 =3D (void __force *)p->screen_base + bitstart;
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
-
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
+#define FB_READL(a)       (*a)
+#define FB_WRITEL(a,b)    do { *(b) =3D (a); } while (false)
+#define FB_MEM            /* nothing */
+#define FB_IMAGEBLIT      sys_imageblit
+#define FB_SPACE          FBINFO_VIRTFB
+#define FB_SPACE_NAME     "virtual"
+#define FB_SCREEN_BASE(a) ((a)->screen_buffer)
+#include "fb_imageblit.h"
=20
 EXPORT_SYMBOL(sys_imageblit);
=20
--=20
2.30.2


--------------kr0Y0hMUDTKmdIGlzT6Lh0nC--

--------------H0Vm3XQc1sdrGCMFwtWoC5bd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaX0FAwAAAAAACgkQWOeEu4KftGsX
EggAnH7Wgqt2eV7ahWdPHLT6qzEcCtm8AC9n6y4Xb29V8EGYO7SsC7vzBm/1fz4dt9T/j1SZNq6i
Eoj7oaSx15dA3HOq4OklaEGob+LBgUo5umw2KG0PTOHkTLK3S0+r8xo+zGhQ5Wwg0NBmJvqmvZBC
E+E0Kl32yrw970ZKtJKD+IHf/AdAjN+9kb3v4USHpujWMMnrTMTa7J0h1nvwlv9LoXv6kEkH8nJU
d36YQYgVQYHc0Z39mVB+wbnNeGGaXvBIhLNogeKEYdMS0c1gIOPXUDU91ZvMakwmmhxwbUpbRCvg
6OtjVazZZsNIPM08wgwqf3J5k7qKjBtABe36wT3V/w==
=qTZu
-----END PGP SIGNATURE-----

--------------H0Vm3XQc1sdrGCMFwtWoC5bd--
