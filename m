From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 Mar 2015 12:32:45 +0000
Subject: Re: [PATCH v2] video: fbdev: use msecs_to_jiffies for time conversions
Message-Id: <54FEE46D.5010706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="w78dhWWTUoFqVxikhQ3ARjsBkh671nFKJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424442841-25466-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1424442841-25466-1-git-send-email-hofrat@osadl.org>
To: Nicholas Mc Guire <hofrat@osadl.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Fabian Frederick <fabf@skynet.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--w78dhWWTUoFqVxikhQ3ARjsBkh671nFKJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/02/15 16:34, Nicholas Mc Guire wrote:
> This is only an API consolidation and should make things more readable =
by
> replacing  var * HZ / 1000  by msecs_to_jiffies(var).
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>=20
> v2: fixed missing closing parenthesis in pxafb_disable_controller.
>     Compile testing was missing part of the patched code due to
>     the missing CONFIG_FB_PXA_SMARTPANEL=3Dy, so the missing closing
>     parenthesis reported by Tomi Valkeinen <tomi.valkeinen@ti.com>
>     pxafb_disable_controller went unnoticed.
>=20
> Patch was only compile tested with viper_defconfig CONFIG_FB_PXA=3Dm,
> CONFIG_FB_PXA_SMARTPANEL=3Dy
>=20
> Patch is against 3.19.0 (localversion-next is -next-20150220)
>=20
>  drivers/video/fbdev/pxafb.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Thanks, queued for 4.1.

 Tomi



--w78dhWWTUoFqVxikhQ3ARjsBkh671nFKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/uRtAAoJEPo9qoy8lh71mbIQAI5jvqhb19S2TEX3utipW0wA
tW+m49nsBzebM+QRFCd3OYNbL5X6NHzxxGxWZf7OZoBa0BJp6POglFPhm/+mFl6H
j6eNdnRHurEdpEYGi20Jt5lbIG7WlIYuqRSgPYzkMtoIeBaOV2ZoFHKBmfy7YPzH
ALPWzwjybYqVwVeSZvu7DGw9Gp7eh3dj9OaDwWKBQ+uYYaUAIcukAUIAKaToCM35
goDxzYDKp9zb3w2EI9QF9hWdUh5H4blO58LwirTwaOzvPuWKjxdx6WdeJoeqBVbD
2xBU61grrBs2P0vRKILySy2vLgvUW+KkntnWFu9VPbRsY5Tt9wT9QK+Yf/RQ+DAK
8DQv4Now0S36p/xkqnC/VGCLr4oyBUOdl4UnHeXHsXUUqdLSklQr/gTe7XjuAWRz
NtQteVeD8xTunbMG2sqjXnUE+LtWOTm6p9Sjp+fP1NuFnmMDVBdiKkQSW/xgdozz
yWnDwtE0vV6olXLP23UvFYxOn/if6M6dPnjgvZvDIV67ttNg/x8AzMnTOwlTEgWD
x0AwLzyGacfixiEUjfic3k4xaMH/5PGkiuByhf34D/gotBCCZORw4x1tZKyhVN22
KwT1tMRm934bm4MAORzhB0ZBEvC4auDbxGHz7gCqNtPHqGpZ0x6Aol1pUI/AnkoL
N+VnWTboQDRw4e8D3Gx6
=GUm/
-----END PGP SIGNATURE-----

--w78dhWWTUoFqVxikhQ3ARjsBkh671nFKJ--
