From: Mike Gerow <gerow@google.com>
Date: Thu, 01 Jun 2017 20:25:59 +0000
Subject: [PATCH] video: fbdev: udlfb: drop log level for blanking
Message-Id: <20170601202559.GA96809@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Log blanking that goes from FB_BLANK_UNBLANK to itself at debug. It turns
out Xorg likes to habitually unblank when already unblanked and this can
fill up logs over a long period of time.

Signed-off-by: Mike Gerow <gerow@google.com>
---
 drivers/video/fbdev/udlfb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 6a3c353de7c3..611de916abcf 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1105,8 +1105,17 @@ static int dlfb_ops_blank(int blank_mode, struct fb_=
info *info)
 	char *bufptr;
 	struct urb *urb;
=20
-	pr_info("/dev/fb%d FB_BLANK mode %d --> %d\n",
-		info->node, dev->blank_mode, blank_mode);
+	/*
+	 * Xorg likes to habitually unblank when already unblanked so log these
+	 * kinds of events at debug.
+	 */
+	if (dev->blank_mode =3D=3D FB_BLANK_UNBLANK &&
+	    blank_mode =3D=3D FB_BLANK_UNBLANK)
+		pr_debug("/dev/fb%d FB_BLANK mode %d --> %d (FB_BLANK_UNBLANK --> FB_BLA=
NK_UNBLANK)\n",
+			 info->node, FB_BLANK_UNBLANK, FB_BLANK_UNBLANK);
+	else
+		pr_info("/dev/fb%d FB_BLANK mode %d --> %d\n",
+			info->node, dev->blank_mode, blank_mode);
=20
 	if ((dev->blank_mode =3D=3D FB_BLANK_POWERDOWN) &&
 	    (blank_mode !=3D FB_BLANK_POWERDOWN)) {
--=20
2.13.0.219.gdb65acc882-goog


--=20
Mike Gerow
gerow@google.com

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZMHhXAAoJECb8JZRr34gjY4EIAM617SUKDue9gb2M9g+4f0mh
6HJsNJJB5QuCg9qX0zgVeLABSO0pNOgWZ80ETNRUUXi9QmYoG/n6fZWiemaLD29K
IxRCPXkUk9tnXaIFo5z5MrD7d5aDoxSKN4Ha2CABtoctWXW9EH5EapKpEDPV4jMy
oQfdQDu4zlH+4PHT6FL71B64beGDZ9FgtJaJ3cdRFIJwn7ObQXN6Fk3pU/ErY4jy
ErYja9xrWHYxu5odP7IVzndO8AgU79CdfREKsqAKFj3if1/AfFnMFnfR+IuFRI5O
Zd35yTmqFIiCkMHtssrx+579gQx4gykMQa9fy0HdSmMT52yTTFwdyleVjzuqXFo=
=asdm
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
