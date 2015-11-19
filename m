From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Thu, 19 Nov 2015 20:10:06 +0000
Subject: [PATCH] nvidia/noveau: Fix color mask
Message-Id: <20151119211006.75c1d924@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/qCmxywae_StwrZ/CjoJqX6B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150617190508.5205e8af@wiggum>
In-Reply-To: <20150617190508.5205e8af@wiggum>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

--Sig_/qCmxywae_StwrZ/CjoJqX6B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The expression (~0 >> x) will always yield all-ones, because the right
shift is an arithmetic right shift that will always shift ones in.
Accordingly ~(~0 >> x) will always be zero.
Hence 'mask' will always be zero in this case.

Fix this by forcing a logical right shift instead of an arithmetic
right shift by using an unsigned int constant.

Signed-off-by: Michael Buesch <m@bues.ch>

---

This patch is untested, because I do not have the hardware.

Resend: Patch was originally sent on Wed, 17 Jun 2015.


Index: linux/drivers/gpu/drm/nouveau/nv50_fbcon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/gpu/drm/nouveau/nv50_fbcon.c
+++ linux/drivers/gpu/drm/nouveau/nv50_fbcon.c
@@ -96,7 +96,7 @@ nv50_fbcon_imageblit(struct fb_info *inf
 	struct nouveau_drm *drm =3D nouveau_drm(nfbdev->dev);
 	struct nouveau_channel *chan =3D drm->channel;
 	uint32_t width, dwords, *data =3D (uint32_t *)image->data;
-	uint32_t mask =3D ~(~0 >> (32 - info->var.bits_per_pixel));
+	uint32_t mask =3D ~(~0U >> (32 - info->var.bits_per_pixel));
 	uint32_t *palette =3D info->pseudo_palette;
 	int ret;
=20
Index: linux/drivers/gpu/drm/nouveau/nvc0_fbcon.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/gpu/drm/nouveau/nvc0_fbcon.c
+++ linux/drivers/gpu/drm/nouveau/nvc0_fbcon.c
@@ -96,7 +96,7 @@ nvc0_fbcon_imageblit(struct fb_info *inf
 	struct nouveau_drm *drm =3D nouveau_drm(nfbdev->dev);
 	struct nouveau_channel *chan =3D drm->channel;
 	uint32_t width, dwords, *data =3D (uint32_t *)image->data;
-	uint32_t mask =3D ~(~0 >> (32 - info->var.bits_per_pixel));
+	uint32_t mask =3D ~(~0U >> (32 - info->var.bits_per_pixel));
 	uint32_t *palette =3D info->pseudo_palette;
 	int ret;
=20
Index: linux/drivers/video/fbdev/nvidia/nv_accel.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/video/fbdev/nvidia/nv_accel.c
+++ linux/drivers/video/fbdev/nvidia/nv_accel.c
@@ -351,7 +351,7 @@ static void nvidiafb_mono_color_expand(s
 				       const struct fb_image *image)
 {
 	struct nvidia_par *par =3D info->par;
-	u32 fg, bg, mask =3D ~(~0 >> (32 - info->var.bits_per_pixel));
+	u32 fg, bg, mask =3D ~(~0U >> (32 - info->var.bits_per_pixel));
 	u32 dsize, width, *data =3D (u32 *) image->data, tmp;
 	int j, k =3D 0;
=20

--Sig_/qCmxywae_StwrZ/CjoJqX6B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWTiyeAAoJEPUyvh2QjYsOJzsP/1k1EQkgvf4Tj0KW/KryJz67
N52haBVDAvcYqExhLaBkl4ok7GGZFJ6MBiwHwNTRuBAl4Enr7K6wgiNKl209bGLS
qTpqTpgTmZ5a4fiTMhGUr9VE74wX5JX1TyclVSl7kBr+6RlgXSxKCvAPlTsie/4y
j9jQIPqpTNluASCF5rXUZdyPeLZD5yb9IetfUQWrxkGY+4E0xSC/C2V67mHrxbbh
ySJ0KeI28lhsOaT6siEEs5ObrmBE5aotvqcGtDw0rTq8/c+kaGvIpMeyPph8SJfP
aVCdUbjTqknXmZWrCYGbRL/hDtxjM594UDZZ++/aeT74XH0Qa5tMXXQfp3qegO41
0kTU41kwns/6qLO7UFFo6gU7/r4wAH6ECz93BxHc8m98VxEPFeOzVkuVyxlnda3A
4PXdmerS58dca7p8dukRvb0hK+7waMauOmXku2yoK/mZQM1YNpzZj7/ohDWVjAlH
NEskTUMXIyLRJtR3T2gfyAJ19fMnLIfsaVM8xLsxaGtUNVzQ2vQz/KLglkbqXj0x
HGWikADSitO/LCme4lqLjRBlIKQVLg0wesFiI2iDF2ywaahTUuMJO69qwq4gZAbg
b5fiLij4VE5cmoqCqpmo41iwk/ttMv8kXTihZ8tfxe95lsoE5LpVCa2Rt6C0I+zf
317GZe8G4+yrl3Yzhe7L
=mlRF
-----END PGP SIGNATURE-----

--Sig_/qCmxywae_StwrZ/CjoJqX6B--
