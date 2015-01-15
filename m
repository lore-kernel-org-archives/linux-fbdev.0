From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Jan 2015 12:52:29 +0000
Subject: Re: [patch] fbdev: off by one test (harmless)
Message-Id: <54B7B80D.3030501@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8jK4CSDrfRns86F1KPVENPPOSuUq93PkH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20141226172657.GA14762@mwanda>
In-Reply-To: <20141226172657.GA14762@mwanda>
To: linux-fbdev@vger.kernel.org

--8jK4CSDrfRns86F1KPVENPPOSuUq93PkH
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/01/15 14:43, Dan Carpenter wrote:
> Sounds good to me.  :)  Could I get a Reported-by cookie?

Oh, sorry. I thought I had added that, but... seems I didn't. Well now it=
's
there. So updated patch below.

I'll queue it for 3.20 if there are no comments.

 Tomi


=46rom 80fa3aed6f89728e9003bb0bdbd0b4bac2bc2186 Mon Sep 17 00:00:00 2001
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
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/video/fbdev/core/fbmon.c  | 4 ++--
 drivers/video/fbdev/core/modedb.c | 2 +-
 include/linux/fb.h                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/=
fbmon.c
index 5b0e313849bd..1829fe34a1df 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1059,9 +1059,9 @@ void fb_edid_add_monspecs(unsigned char *edid, stru=
ct fb_monspecs *specs)
=20
 	for (i =3D specs->modedb_len + num; i < specs->modedb_len + num + svd_n=
; i++) {
 		int idx =3D svd[i - specs->modedb_len - num];
-		if (!idx || idx > 63) {
+		if (!idx || idx >=3D ARRAY_SIZE(cea_modes)) {
 			pr_warning("Reserved SVD code %d\n", idx);
-		} else if (idx > ARRAY_SIZE(cea_modes) || !cea_modes[idx].xres) {
+		} else if (!cea_modes[idx].xres) {
 			pr_warning("Unimplemented SVD code %d\n", idx);
 		} else {
 			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
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




--8jK4CSDrfRns86F1KPVENPPOSuUq93PkH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt7gNAAoJEPo9qoy8lh71fHAP/jMo2nXYlAoz/22baocZsilW
FKKACnQqMnPEz2PDkwwBaI4SV+tsSP07N0ucJb3GMnIXd6KRz3e9CW/czSXz6oeX
YjIymJxykQ65lGI8a+s+NflX7fGjfVhI8zrmXpqTHNHDAZVE9g539YDuHsGd0sI2
H97dolAsef3h1+Izxa8tmW1rf/VpuaQ5nWv8uw26PvkrOPCb8OVFjKEeIhiGGUEF
nNGXLiDbcErnGFGWlgd/LtGF4dJ+10J5Ejb7qWBAe22NiDV5lpXOU4LKjnfSKlg2
AXlYsbQFvUcreZVwx2+8qq8DSVATzQMQXdggCJlxM9Glj9ZgV2QleVbrjVsMQumw
+BJIfs6pjXG2M4LgLIUaPSUA04PrB4AzNrr3ZritEwF6nJ84Ee73iQX4wqJr0vsc
RMn8AKAmA9kJ5c0zuXmg6UWq45Hzmqsa4pEH8mqMNhWt/0S9Zfwvt/D53QTUxRPd
Z2kPTKXqGP7y5XKrIuMqA/r38PizaOod5S4Cy1HUkZgLgMJlCl2FldUZ5Esos7xC
uWIXNSLSY2jOsNz95TI1URlV8hHXTB6KtqYyCR5SBDRR2rbJQPcRgZqbUXEA24Sl
tNOWtNVgMdU/2voFt8peFla2Vc7xmYHPGvc3YfZqKi89ZLyqv+bOyrFrWdQy0wSL
tqKnDq8SxSn5H3PKDlSw
=Axd9
-----END PGP SIGNATURE-----

--8jK4CSDrfRns86F1KPVENPPOSuUq93PkH--
