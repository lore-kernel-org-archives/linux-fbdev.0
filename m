From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Jan 2015 11:56:58 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <54B7AB0A.3020708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jehMvMO5Pj0LnBa3N2LBoQMBgDEELFd7n"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
To: linux-fbdev@vger.kernel.org

--jehMvMO5Pj0LnBa3N2LBoQMBgDEELFd7n
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/01/15 13:19, Tomi Valkeinen wrote:
> On 29/12/14 23:51, David Ung wrote:
>>
>>>> test is really a no-op.  But it's still off by one and upsets the
>>>> static checkers so we may as well correct it.
>>>
>>> 'idx' should be 0~63, because cea_modes array is defined as
>>> 'cea_modes[64]'.
>>
>> According to CEA/EIA-861E, there are 64 defined modes, but idx is vali=
d for 1-64, 0 is reserved hence the check for=20
>>
>>         If (!idx || idx > 63) {
>>
>> Think idx check really should be !idx || idx > 64 if following CEA/EIA=
-861E
>=20
> In that case there's something funny with the code. The code indexes
> 'cea_modes' using 'idx', and I _think_ cea_modes is already offset
> properly, i.e. there's no entry at 0. But its length is 64, which is no=
t
> right, as there's the empty item in the beginning.
>=20
> So maybe the correct fix is to increase the length of cea_modes to 65,
> and change the idx check as you mention above?

Here's a fix for the cea_array size. Does it silence the static checker?

 Tomi


=46rom ec1edd4683ca3cc0b3b6e5feffae861e404d16d2 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Jan 2015 13:47:19 +0200
Subject: [PATCH] fbdev: fix cea_modes array size

CEA defines 64 modes, indexed from 1 to 64. modedb has cea_modes arrays,
which contains 64 entries. However, the code uses the CEA indices
directly, i.e. the first mode is at cea_modes[1]. This means the array
is one too short.

This does not cause references to uninitialized memory as the code in
fbmon only allows indexes up to 63, and the cea_modes does not contain
an entry for the mode 64 so it could not be used in any case.

However, the code contains a check 'if (idx > ARRAY_SIZE(cea_modes)',
and while that check is a no-op as at that point idx cannot be >=3D 63, i=
t
upsets static checkers.

Fix this by increasing the cea_array size to be 65, and change the code
to allow mode 64.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/core/fbmon.c  | 2 +-
 drivers/video/fbdev/core/modedb.c | 2 +-
 include/linux/fb.h                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/=
fbmon.c
index 5b0e313849bd..0fea923c3cb6 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1059,7 +1059,7 @@ void fb_edid_add_monspecs(unsigned char *edid, stru=
ct fb_monspecs *specs)
=20
 	for (i =3D specs->modedb_len + num; i < specs->modedb_len + num + svd_n=
; i++) {
 		int idx =3D svd[i - specs->modedb_len - num];
-		if (!idx || idx > 63) {
+		if (!idx || idx > 64) {
 			pr_warning("Reserved SVD code %d\n", idx);
 		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
 			pr_warning("Unimplemented SVD code %d\n", idx);
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core=
/modedb.c
index 388f7971494b..b2aba4e3150a 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -289,7 +289,7 @@ static const struct fb_videomode modedb[] =3D {
 };
=20
 #ifdef CONFIG_FB_MODE_HELPERS
-const struct fb_videomode cea_modes[64] =3D {
+const struct fb_videomode cea_modes[65] =3D {
 	/* #1: 640x480p@59.94/60Hz */
 	[1] =3D {
 		NULL, 60, 640, 480, 39722, 48, 16, 33, 10, 96, 2, 0,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 09bb7a18d287..024260687698 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -779,7 +779,7 @@ struct fb_videomode {
=20
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
-extern const struct fb_videomode cea_modes[64];
+extern const struct fb_videomode cea_modes[65];
=20
 struct fb_modelist {
 	struct list_head list;
--=20
2.2.2




--jehMvMO5Pj0LnBa3N2LBoQMBgDEELFd7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt6sKAAoJEPo9qoy8lh71EGoQAKj7tpmxUgqQA1K0zP05xHBy
uZMnOFXQkg9/M2j5ZQChUSWClW4OHIfqj9DhMIbDl3YG9lKX5hxN/+k8Hkpgb7ba
1thoWY4kcyKLRedZeASdhQWYSC7wu4MKIP1wx8b2tgSjsYM6ks0N27lrXhtfAqCZ
Oz0X/dVkrT3EnoL+5iHyV/Zh7kDlx+33uH1GDLEC7pbM/XvrNXx/kvN+1p+YvGXO
gX8DlS3Qf5qyRxYO+OUUCm5jw2nAqL4b5xLInG8DbPIz6qtv55hkpQz9ukqqXJW7
CQpENo4b3lO23UW1UlsgUvPXG6a7FpToN1FsHy9RywI5D9uIrv02mqaCiX+EvRZh
TZiDz1nrbfaiYA62YTtQ50sV0WE3x9FGLqCaU+R1DALsHsJxrAFbN0DB2lLCRwwB
LDiBdQdYSaKkhITXDB/wsJALGLAFY0ivsPMt/OtAS5hLWcEsksQ+OC6hcYp1ssMB
WxKgWtRnTaDVXHVZljQEQCUbzC69RoOlK3PQhKrd+9oxH4E5ciqdLzEFf44HxDd3
7vrYVoG0fi3uhrJyGwbhUpRK9kE5y+T8eEePiUrlsZyBxhoEne9yp0sQnZ/XDK5s
fVWbq+VDKl2HTon3QC/DLff1KslwYZdd83X9Cie4Z/UWh3ROLLuQjuehWP1jd6zI
Vvhhq5CIdCrbIpc4Hr4/
=1Omb
-----END PGP SIGNATURE-----

--jehMvMO5Pj0LnBa3N2LBoQMBgDEELFd7n--
