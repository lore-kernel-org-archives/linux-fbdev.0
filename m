Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11D1D6DB6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738500416; cv=none; b=jwai5Spf4S5G88sqyamKf4YVfMorPnX3ANGGc4As5z7jjNWFClpn3qyF8wpYdSVoJqdYqrJMZl6kAyZOfCCmpwxcukA8/jU9CWMfdL9G7/xvHZyverorGylRt4NBoTAuXqB4kBe8fAbJwD8WXiB+tTjCsNo3bkmKHRAyrOM1NFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738500416; c=relaxed/simple;
	bh=UySuaKMdF+qDuWLBJcChIir92Q/vfWkpJw9YlW6ziNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qaPV0e00hFEut5oKZPcV69JbO3i5rsSecycgn6OZlI3jZMHIX9lOYIKsEiqqUCcrFtDiQHgxTwvIa2nXYrLla3FJww8i7dUbxwgWXxeSP71+AEQgPF7UQG7cp0HRBYrDy7sdCJQthQ5vfjtkcKOYczHU9MUa2KWE3Oin0E4LlLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: from [192.168.0.59] (unknown [89.134.12.53])
	by c64.rulez.org (Postfix) with ESMTPSA id AA605100F6
	for <linux-fbdev@vger.kernel.org>; Sun,  2 Feb 2025 13:46:52 +0100 (CET)
Message-ID: <8ed1d74c-0757-6c6c-d619-9d9b4fea00c0@c64.rulez.org>
Date: Sun, 2 Feb 2025 13:46:52 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: [RFC PATCH 10/12] fbdev: core: Make fb_imageblit generic
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
In-Reply-To: <6c0e4997-8215-a249-20ed-d353ca476cd4@c64.rulez.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------e0NFS8o4n40tVXe0nQZezLBz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------e0NFS8o4n40tVXe0nQZezLBz
Content-Type: multipart/mixed; boundary="------------bb0mnSeRpUDa7AcgJvr3VKn0";
 protected-headers="v1"
From: =?UTF-8?Q?Kajt=c3=a1r_Zsolt?= <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Message-ID: <8ed1d74c-0757-6c6c-d619-9d9b4fea00c0@c64.rulez.org>
Subject: [RFC PATCH 10/12] fbdev: core: Make fb_imageblit generic
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
In-Reply-To: <6c0e4997-8215-a249-20ed-d353ca476cd4@c64.rulez.org>

--------------bb0mnSeRpUDa7AcgJvr3VKn0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fbdev: core: Make fb_imageblit generic

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fb_imageblit.h | 53 ++++++++++---------------
 1 file changed, 20 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_imageblit.h b/drivers/video/fbde=
v/core/fb_imageblit.h
index 7d1d2f1a6..d0308135e 100644
--- a/drivers/video/fbdev/core/fb_imageblit.h
+++ b/drivers/video/fbdev/core/fb_imageblit.h
@@ -29,10 +29,6 @@
  *  Also need to add code to deal with cards endians that are different =
than
  *  the native cpu endians. I also need to deal with MSB position in the=
 word.
  */
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/fb.h>
-#include <asm/types.h>
 #include "fb_draw.h"
=20
 #define DEBUG
@@ -69,16 +65,13 @@ static const u32 cfb_tab32[] =3D {
 	0x00000000, 0xffffffff
 };
=20
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-
 static inline void color_imageblit(const struct fb_image *image,
-				   struct fb_info *p, u8 __iomem *dst1,
+				   struct fb_info *p, u8 FB_MEM *dst1,
 				   u32 start_index,
 				   u32 pitch_index)
 {
 	/* Draw the penguin */
-	u32 __iomem *dst, *dst2;
+	u32 FB_MEM *dst, *dst2;
 	u32 color =3D 0, val, shift;
 	int i, n, bpp =3D p->var.bits_per_pixel;
 	u32 null_bits =3D 32 - bpp;
@@ -86,10 +79,10 @@ static inline void color_imageblit(const struct fb_im=
age *image,
 	const u8 *src =3D image->data;
 	u32 bswapmask =3D fb_compute_bswapmask(p);
=20
-	dst2 =3D (u32 __iomem *) dst1;
+	dst2 =3D (u32 FB_MEM *) dst1;
 	for (i =3D image->height; i--; ) {
 		n =3D image->width;
-		dst =3D (u32 __iomem *) dst1;
+		dst =3D (u32 FB_MEM *) dst1;
 		shift =3D 0;
 		val =3D 0;
=20
@@ -126,7 +119,7 @@ static inline void color_imageblit(const struct fb_im=
age *image,
 		dst1 +=3D p->fix.line_length;
 		if (pitch_index) {
 			dst2 +=3D p->fix.line_length;
-			dst1 =3D (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+			dst1 =3D (u8 FB_MEM *)((long __force)dst2 & ~(sizeof(u32) - 1));
=20
 			start_index +=3D pitch_index;
 			start_index &=3D 32 - 1;
@@ -135,13 +128,13 @@ static inline void color_imageblit(const struct fb_=
image *image,
 }
=20
 static inline void slow_imageblit(const struct fb_image *image, struct f=
b_info *p,
-				  u8 __iomem *dst1, u32 fgcolor,
+				  u8 FB_MEM *dst1, u32 fgcolor,
 				  u32 bgcolor,
 				  u32 start_index,
 				  u32 pitch_index)
 {
 	u32 shift, color =3D 0, bpp =3D p->var.bits_per_pixel;
-	u32 __iomem *dst, *dst2;
+	u32 FB_MEM *dst, *dst2;
 	u32 val, pitch =3D p->fix.line_length;
 	u32 null_bits =3D 32 - bpp;
 	u32 spitch =3D (image->width+7)/8;
@@ -149,7 +142,7 @@ static inline void slow_imageblit(const struct fb_ima=
ge *image, struct fb_info *
 	u32 i, j, l;
 	u32 bswapmask =3D fb_compute_bswapmask(p);
=20
-	dst2 =3D (u32 __iomem *) dst1;
+	dst2 =3D (u32 FB_MEM *) dst1;
 	fgcolor <<=3D FB_LEFT_POS(p, bpp);
 	bgcolor <<=3D FB_LEFT_POS(p, bpp);
=20
@@ -157,7 +150,7 @@ static inline void slow_imageblit(const struct fb_ima=
ge *image, struct fb_info *
 		shift =3D val =3D 0;
 		l =3D 8;
 		j =3D image->width;
-		dst =3D (u32 __iomem *) dst1;
+		dst =3D (u32 FB_MEM *) dst1;
 		s =3D src;
=20
 		/* write leading bits */
@@ -196,7 +189,7 @@ static inline void slow_imageblit(const struct fb_ima=
ge *image, struct fb_info *
 		src +=3D spitch;
 		if (pitch_index) {
 			dst2 +=3D pitch;
-			dst1 =3D (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+			dst1 =3D (u8 FB_MEM *)((long __force)dst2 & ~(sizeof(u32) - 1));
 			start_index +=3D pitch_index;
 			start_index &=3D 32 - 1;
 		}
@@ -213,14 +206,14 @@ static inline void slow_imageblit(const struct fb_i=
mage *image, struct fb_info *
  *           beginning and end of a scanline is dword aligned
  */
 static inline void fast_imageblit(const struct fb_image *image, struct f=
b_info *p,
-				  u8 __iomem *dst1, u32 fgcolor,
+				  u8 FB_MEM *dst1, u32 fgcolor,
 				  u32 bgcolor)
 {
 	u32 fgx =3D fgcolor, bgx =3D bgcolor, bpp =3D p->var.bits_per_pixel;
 	u32 ppw =3D 32/bpp, spitch =3D (image->width + 7)/8;
 	u32 bit_mask, eorx, shift;
-	const char *s =3D image->data, *src;
-	u32 __iomem *dst;
+	const u8 *s =3D image->data, *src;
+	u32 FB_MEM *dst;
 	const u32 *tab =3D NULL;
 	size_t tablen;
 	u32 colortab[16];
@@ -258,7 +251,7 @@ static inline void fast_imageblit(const struct fb_ima=
ge *image, struct fb_info *
 		colortab[i] =3D (tab[i] & eorx) ^ bgx;
=20
 	for (i =3D image->height; i--; ) {
-		dst =3D (u32 __iomem *)dst1;
+		dst =3D (u32 FB_MEM *)dst1;
 		shift =3D 8;
 		src =3D s;
=20
@@ -315,19 +308,20 @@ static inline void fast_imageblit(const struct fb_i=
mage *image, struct fb_info *
 	}
 }
=20
-void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
+void FB_IMAGEBLIT (struct fb_info *p, const struct fb_image *image)
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index =3D 0;
 	u32 bpl =3D sizeof(u32), bpp =3D p->var.bits_per_pixel;
 	u32 width =3D image->width;
 	u32 dx =3D image->dx, dy =3D image->dy;
-	u8 __iomem *dst1;
+	u8 FB_MEM *dst1;
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
 	bitstart =3D (dy * p->fix.line_length * 8) + (dx * bpp);
 	start_index =3D bitstart & (32 - 1);
@@ -335,7 +329,7 @@ void cfb_imageblit(struct fb_info *p, const struct fb=
_image *image)
=20
 	bitstart /=3D 8;
 	bitstart &=3D ~(bpl - 1);
-	dst1 =3D p->screen_base + bitstart;
+	dst1 =3D (void __force *)FB_SCREEN_BASE(p) + bitstart;
=20
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
@@ -360,10 +354,3 @@ void cfb_imageblit(struct fb_info *p, const struct f=
b_image *image)
 	} else
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
-
-EXPORT_SYMBOL(cfb_imageblit);
-
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-MODULE_DESCRIPTION("Generic software accelerated imaging drawing");
-MODULE_LICENSE("GPL");
-
--=20
2.30.2


--------------bb0mnSeRpUDa7AcgJvr3VKn0--

--------------e0NFS8o4n40tVXe0nQZezLBz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmefaTwFAwAAAAAACgkQWOeEu4KftGuS
oQgAwS1rMA3MwL/EqDLp01jzOa+EvaS4xvzg8X0plPTjOwrt+JMgxV4xj96txhg8Rh/AlJJ+pUuL
XuvMy+zmHxcFUvTKVuMi5DzDive6aYVMPQnoQVmhh64zLJGCFyMl0sAciJmFsGfUN9lUpaHZHc2b
3osPGk+OEts/mpO+I3cjFLpYqqot9I4rMW7bUnaSCq97lpt48rne2+kfDi6woiQpvQ1F8YOyfu53
NdDHSVZ4kOu4IGlXNYTN8v7CuzWjP3K13OtfM/73WnyxHxm9u5ffJBro6Ure2QH27Swady1RGgl9
bENcbJx5PIi96iZalkatKE1JDt/eJys99/2fs1lrbA==
=10z4
-----END PGP SIGNATURE-----

--------------e0NFS8o4n40tVXe0nQZezLBz--
