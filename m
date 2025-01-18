Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C279112EBEA
	for <linux-fbdev@vger.kernel.org>; Sat, 18 Jan 2025 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737196741; cv=none; b=dhXwHZLMdhzTImM+NptIkiBJwa/UrgGgR48AZFDrJR3oLgwZJFte/K/TVsEOxvb9VuN7HkPv3um+nFQUniUCaVkFngF7MoUymtpVzWkQA3Xo1jSzon5XRkndHk7rUqj6GF/og+qerCbBdhgsG/dIOOGZ1+Hxno3OEn5LApzeggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737196741; c=relaxed/simple;
	bh=sl471YsoOIbwV+NjW6c/AQ//0BNsaWSRjwK8/6ZZWaA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j4UTxKGnAGIE7VOe4uHyNaAwaisBOdwmM6qGEwnUPxRCjaTbYAhOvKkKT7bHFp0MI2SGDbR5LxrY1zAePcPCTecDsL7nl5IZDOx2PXPUOwGEqeNKHhn/42QthaxniCrqXDMNd5L47AZ5z7t67dIKv1SCYs8YuvhbiIEtgR361CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=singularcrew.hu; spf=pass smtp.mailfrom=singularcrew.hu; dkim=pass (2048-bit key) header.d=singularcrew.hu header.i=@singularcrew.hu header.b=Ge7ilcVd; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=singularcrew.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singularcrew.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=singularcrew.hu header.i=@singularcrew.hu header.b="Ge7ilcVd"
Message-ID: <b94a4fd7-f7fe-677a-4be5-b7a985b49523@singularcrew.hu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=singularcrew.hu;
	s=mail; t=1737196736;
	bh=sl471YsoOIbwV+NjW6c/AQ//0BNsaWSRjwK8/6ZZWaA=;
	h=Date:To:From:Subject:From;
	b=Ge7ilcVdVqamt4L0qRSc+rhYQwyXZgkl4c9smito4xLceiBafcqyKr8sboCsZPQEM
	 +pI5GytaKThnQfz75qqpYy39vPfP0F/d1wnjZpOL8FvuS4iX8okbzUoNlC2Qq7LNjE
	 x6zrK5O40GvSujZLvZFhlDYiis0QVnfzFafIxWFOJEQ7rTyTsbYBfI9VfUZS0AIW2b
	 +EajdlVD2Xt3lPvM6X51T51DjQ14PsTFbp8DvoD5Je8O2c6Qa/OUI/VyqLBBdv1clF
	 O9XwhvFFBP9MceDE3i9gpDakeAIsqjW6f3gYoJc0XqQwqlNJnD4XcK8YDEC1Kru1xf
	 c7xLINXtTkxCg==
Date: Sat, 18 Jan 2025 11:38:56 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: linux-fbdev@vger.kernel.org
From: Soci/Singular <soci@singularcrew.hu>
Subject: [PATCH] fbdev: vga16fb: fix orig_video_isVGA confusion
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------D6d5MOtRWloO12gANSnFRU69"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------D6d5MOtRWloO12gANSnFRU69
Content-Type: multipart/mixed; boundary="------------qlq3u0DYEPsUNwzkLuKI5bX5";
 protected-headers="v1"
From: Soci/Singular <soci@singularcrew.hu>
To: linux-fbdev@vger.kernel.org
Message-ID: <b94a4fd7-f7fe-677a-4be5-b7a985b49523@singularcrew.hu>
Subject: [PATCH] fbdev: vga16fb: fix orig_video_isVGA confusion

--------------qlq3u0DYEPsUNwzkLuKI5bX5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


At some point the orig_video_isVGA field of screen_info was repurposed
for video type. Using it directly for video type check is unsafe as it ca=
n
still mean yes (1) or no-output (0) in certain configurations. I had one =
of those.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/vga16fb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.=
c
index fce0f5db7..eedab14c7 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -185,9 +185,10 @@ static inline void setindex(int index)
 /* Check if the video mode is supported by the driver */
 static inline int check_mode_supported(const struct screen_info *si)
 {
+	unsigned int type =3D screen_info_video_type(si);
+
 	/* only EGA and VGA in 16 color graphic mode are supported */
-	if (si->orig_video_isVGA !=3D VIDEO_TYPE_EGAC &&
-	    si->orig_video_isVGA !=3D VIDEO_TYPE_VGAC)
+	if (type !=3D VIDEO_TYPE_EGAC && type !=3D VIDEO_TYPE_VGAC)
 		return -ENODEV;

 	if (si->orig_video_mode !=3D 0x0D &&	/* 320x200/4 (EGA) */
@@ -1338,7 +1339,7 @@ static int vga16fb_probe(struct platform_device *de=
v)
 	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
 	par =3D info->par;

-	par->isVGA =3D si->orig_video_isVGA =3D=3D VIDEO_TYPE_VGAC;
+	par->isVGA =3D screen_info_video_type(si) =3D=3D VIDEO_TYPE_VGAC;
 	par->palette_blanked =3D 0;
 	par->vesa_blanked =3D 0;


--------------qlq3u0DYEPsUNwzkLuKI5bX5--

--------------D6d5MOtRWloO12gANSnFRU69
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEE8WlaH4v4aHNT2Bn0WOeEu4KftGsFAmeLhMAFAwAAAAAACgkQWOeEu4KftGs3
6wf/YI1vnrWhSJhvVYMxd8IqN7vX4yNKy+X3XUfDu+CmAWFhPcOouIMzCc8DFWlbKCgjfmGXXgMf
Z/6ydMzsbil1Smq8cnHElBHIOOd2tql99vHQJa6GHvqL43AeP00b+5OZ3SXl+E5jJnldQGgONEvG
20QC+eXQgsu+KJpgcDnQ4HwMdCrp1XzXwv+doCVYgYpOelMFhWi30WV9uVzvEf6B07+b4s7Bx4on
q4e39nanFmQIRubMG8tcwnZvvZMt+ecpl5jx/Hu4Pta/IAraQUIm1gE289ZZnUmuvz2uOvFtm9H0
RVtnazDJRvchKjiU7QMvbP11XP7LSll5RR35iTzo1A==
=4CgC
-----END PGP SIGNATURE-----

--------------D6d5MOtRWloO12gANSnFRU69--
