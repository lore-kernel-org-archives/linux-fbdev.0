From: Mike Gerow <gerow@google.com>
Date: Wed, 07 Jun 2017 21:42:55 +0000
Subject: [PATCH v2] video: fbdev: udlfb: drop log level for blanking
Message-Id: <20170607214255.GA37736@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drop log level for blanking from info to debug. Xorg likes to habitually
unblank when already unblanked and this can fill up logs over a long period
of time.

Signed-off-by: Mike Gerow <gerow@google.com>
---
 drivers/video/fbdev/udlfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 6a3c353de7c3..ca1f6fe2b1cb 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1105,8 +1105,8 @@ static int dlfb_ops_blank(int blank_mode, struct fb_i=
nfo *info)
 	char *bufptr;
 	struct urb *urb;
=20
-	pr_info("/dev/fb%d FB_BLANK mode %d --> %d\n",
-		info->node, dev->blank_mode, blank_mode);
+	pr_debug("/dev/fb%d FB_BLANK mode %d --> %d\n",
+		 info->node, dev->blank_mode, blank_mode);
=20
 	if ((dev->blank_mode =3D=3D FB_BLANK_POWERDOWN) &&
 	    (blank_mode !=3D FB_BLANK_POWERDOWN)) {
--=20
2.13.0.506.g27d5fe0cd-goog


--=20
Mike Gerow
gerow@google.com

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJZOHNYAAoJECb8JZRr34gjzc8H/1W3Rq3PGJQo8XmSjHQltHT4
uN45QWAd3tFtNBLHkwCdHkEHtk3cWYBznWNHXqC0D+lHyj0ZOHn9PJuP7tv/26UY
pN4FFmBHSq4/rIWw1iDD9DgLEwbUUzyYcTIfhfq5pkao+QZep7PgF+phaboSTwzM
BaWBLlr19mRIm+7pA/bU+B+1JAJ/u3n6S+ma8s03b3NIefNnMTvgZgcEJQdMAPdL
//eARJWM2Fw2TppjHhgM5ZM/Rw2Mn6bpenZfVKr95lz/TLJOdSLBUMymCmS7IcV2
C/l1O5wH9nD8csT/urYSFA3qG0dGbA0c6BtAHtnR0tjmpini22wIQk7de41riPg=
=fiiz
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
