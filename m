Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EBF9C1
	for <linux-fbdev@vger.kernel.org>; Sat,  1 Feb 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738397911; cv=none; b=pCJ+ABIt6FEAFg8C9GykYDywJh+1rZl7fY7tMtTqImh01a93+LCOs2usREn/9JOjM3tsFYJLkZ+gsSrAkK4DsvPiBA4iIYJpuTBkmQahTEu4iPDonMx0XjKzPyN4xDSAzHJ9jU0j4ob8Gck0xWu3omMtwr1CN7vsSui2xVGleGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738397911; c=relaxed/simple;
	bh=MgaEeQqTcmCMXd0kTznXrOhPRXr7Qzx8lJTs+oFsxJg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=UjHIJUJJjHQRvpqs0KExmm2r7pEyTYnBGfm4/0HIvF3Z0mIW3EvNH5VJSW3nWWbOAEJTtRvyEePohBCij4GwE/YO8b7sEaOA4G6MjSTpFxQXuxRU7pTkRp5pGk3e5DD1UZ6ue9aA6PkpdqHbR8WWlaR+LYjYvK5w3bBcPg0HNMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=singularcrew.hu; spf=pass smtp.mailfrom=singularcrew.hu; dkim=pass (2048-bit key) header.d=singularcrew.hu header.i=@singularcrew.hu header.b=d3nw1RZh; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=singularcrew.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singularcrew.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=singularcrew.hu header.i=@singularcrew.hu header.b="d3nw1RZh"
Message-ID: <c8cc27ea-05a8-14b7-0047-4f1fa6d73f93@singularcrew.hu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=singularcrew.hu;
	s=mail; t=1738397889;
	bh=MgaEeQqTcmCMXd0kTznXrOhPRXr7Qzx8lJTs+oFsxJg=;
	h=Date:To:From:Subject:From;
	b=d3nw1RZhmlCx41JIw6zy6MpI+R2KcqtAAZQ+v0guA/96D+InLqPiPdRjnG7lu2flh
	 jW/j4+JVNxAGoirrg+pxaKZUNxjfPicfwmE4uYwLtPaIHTFIvvzQoim/bWXpUCODIN
	 kkNlBZ+9FaHvwbhRT7nDi8lf3Mxht7UrL4eprrrdk1euyv+/dyXZu3otrpp9qhRmm2
	 DH+neHLn/yatPBglggLjIJESq+TP9nNYGFBHxxR7h1bBFgCqjOavjw0S4rq9sT9u42
	 j8D+UmAl7UXBzRFlSWUE3MFa+XqmlR0bh7flnpzFZddM2c2LgzMu15xAxB4Hw9XBkP
	 N3g6HMEJPWz2A==
Date: Sat, 1 Feb 2025 09:18:09 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: linux-fbdev@vger.kernel.org
From: Soci/Singular <soci@singularcrew.hu>
Subject: [PATCH] fbdev: core: tileblit: Implement missing margin clearing for
 tileblit
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2DvNiFSOLoNzlLbKAFNH0BG1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2DvNiFSOLoNzlLbKAFNH0BG1
Content-Type: multipart/mixed; boundary="------------Lufi7EdwRrlzu7vZJARIMt0s";
 protected-headers="v1"
From: Soci/Singular <soci@singularcrew.hu>
To: linux-fbdev@vger.kernel.org
Message-ID: <c8cc27ea-05a8-14b7-0047-4f1fa6d73f93@singularcrew.hu>
Subject: [PATCH] fbdev: core: tileblit: Implement missing margin clearing for
 tileblit

--------------Lufi7EdwRrlzu7vZJARIMt0s
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I was wondering why there's garbage at the bottom of the screen when
tile blitting is used with an odd mode like 1080, 600 or 200. Sure there'=
s
only space for half a tile but the same area is clean when the buffer
is bitmap.

Then later I found that it's supposed to be cleaned but that's not
implemented. So I took what's in bitblit and adapted it for tileblit.

This implementation was tested for both the horizontal and vertical case,=

and now does the same as what's done for bitmap buffers.

If anyone is interested to reproduce the problem then I could bet that'd
be on a S3 or Ark. Just set up a mode with an odd line count and make
sure that the virtual size covers the complete tile at the bottom. E.g.
for 600 lines that's 608 virtual lines for a 16 tall tile. Then the
bottom area should be cleaned.

For the right side it's more difficult as there the drivers won't let an
odd size happen, unless the code is modified. But once it reports back a
few pixel columns short then fbcon won't use the last column. With the
patch that column is now clean.

Btw. the virtual size should be rounded up by the driver for both axes
(not only the horizontal) so that it's dividable by the tile size.
That's a driver bug but correcting it is not in scope for this patch.

Implement missing margin clearing for tileblit

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/tileblit.c | 37 ++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/co=
re/tileblit.c
index eff7ec4da..98e528d38 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -76,7 +76,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_i=
nfo *info,
 static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,=

 			       int color, int bottom_only)
 {
-	return;
+	unsigned int cw =3D vc->vc_font.width;
+	unsigned int ch =3D vc->vc_font.height;
+	unsigned int rw =3D info->var.xres - (vc->vc_cols*cw);
+	unsigned int bh =3D info->var.yres - (vc->vc_rows*ch);
+	unsigned int rs =3D info->var.xres - rw;
+	unsigned int bs =3D info->var.yres - bh;
+	unsigned int vwt =3D info->var.xres_virtual / cw;
+	unsigned int vht =3D info->var.yres_virtual / ch;
+	struct fb_tilerect rect;
+
+	rect.index =3D vc->vc_video_erase_char &
+		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
+	rect.fg =3D color;
+	rect.bg =3D color;
+
+	if ((int) rw > 0 && !bottom_only) {
+		rect.sx =3D (info->var.xoffset + rs + cw - 1) / cw;
+		rect.sy =3D 0;
+		rect.width =3D (rw + cw - 1) / cw;
+		rect.height =3D vht;
+		if (rect.width + rect.sx > vwt)
+			rect.width =3D vwt - rect.sx;
+		if (rect.sx < vwt)
+			info->tileops->fb_tilefill(info, &rect);
+	}
+
+	if ((int) bh > 0) {
+		rect.sx =3D info->var.xoffset / cw;
+		rect.sy =3D (info->var.yoffset + bs) / ch;
+		rect.width =3D rs / cw;
+		rect.height =3D (bh + ch - 1) / ch;
+		if (rect.height + rect.sy > vht)
+			rect.height =3D vht - rect.sy;
+		if (rect.sy < vht)
+			info->tileops->fb_tilefill(info, &rect);
+	}
 }
=20
 static void tile_cursor(struct vc_data *vc, struct fb_info *info, bool e=
nable,
--=20
2.30.2


--------------Lufi7EdwRrlzu7vZJARIMt0s--

--------------2DvNiFSOLoNzlLbKAFNH0BG1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmed2MEFAwAAAAAACgkQWOeEu4KftGuS
wAf/aSrOrI99Yeo1iTw+nYHL3fxWcy4031vjIRXsj4ZdxsGJWsLEFrLyCwl5M2KhB+DAvs3MIXhn
RZsWzxq4YmQ+MSWUNAg5B+hHj8e3jR4oNdJBt/KhId7/hskjCcVbIhIsnNAZH4f4ZODngNfL/Ki3
XfKClIUVV/LrdCtCnKxupTYylG/CRlpjpO+fe0iNDYScxaTTD56SgQOXqGbwHuK6cYZJEBgykgpJ
7uVO5ysQwZc/HCJdIq34lBsgyRBenSdOj9rftIFFcsTZaWsCKNufmiQJOJRUlCrJfjnu1HX8ItOk
PmvfwqmRrEJGaKTy/YN0eVmvnJ9O9CERjiuh1i/Myg==
=nPwi
-----END PGP SIGNATURE-----

--------------2DvNiFSOLoNzlLbKAFNH0BG1--
