From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Date: Wed, 17 Jun 2015 17:05:08 +0000
Subject: [PATCH] nvidia/noveau: Fix color mask
Message-Id: <20150617190508.5205e8af@wiggum>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/vky.iT0JwGtjH9+soLGz1Q0"
List-Id: <linux-fbdev.vger.kernel.org>
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Antonino Daplas <adaplas@gmail.com>, linux-fbdev@vger.kernel.org

--Sig_/vky.iT0JwGtjH9+soLGz1Q0
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

--Sig_/vky.iT0JwGtjH9+soLGz1Q0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgajEAAoJEPUyvh2QjYsOUu8QAICngem2AlG3p5c9Zp9gWEfa
uNhDHUn9y9q9NjpuMVzMRDz+BmliP0vHdQbchVKIlw2xGb5cFeJwSPoMy0vy2OKj
MYUiI528DDG6PeQRr7mFgbKfLUi1p9Y3xLLu7VJM+oWBp7//4G/L+lkcDGoltWOX
JMZwKXPVgprGD2jR9L4Z1ESks4/aQx+a6wVesDSg1wisfixY/Oxq3SGke15LAw+1
aUj7jJew8AQn2C8n4L07mvhETb0d0CzvtqSFdqauH0hUN75KhxdF5Wh4kYV52Ecq
PMiwtwT0xGJRzdsbu4cxsO01FYYn3hjzoAB/Xo3XJx442uSbZkGusYCQFer/6EjR
xYsV6oCp4B47H3HAvJPxNjnGVdNrFUg5dqLU5oKB8+NoEgMQgqeRcS8K/0+YiEgJ
CxM3Jez+xrxeGz9kxtw1+ynlDiOKF190z7lPfWVpUyTqwgxGteWmI5vCZ8wxAgDJ
AXRAPc+stW5J3ur2tgLfjHrHbPHdLiKYWUiEPoQtA+GOpHGl0rsiC2aLvIO1G+dm
gpW688+eji/B+YilXNtl3mdNtAQaVkBVz1EmfbRWXgZO0OHLaVchomfISnQ9bBG4
sxaRNbFlG3pP/ms65hWFEUBSvZQPTC8yV9N+61CA0pu8H7pytbuuFWElS/dkv/i2
91QEdA3yn5L5y4jTzGJr
=zIwj
-----END PGP SIGNATURE-----

--Sig_/vky.iT0JwGtjH9+soLGz1Q0--
