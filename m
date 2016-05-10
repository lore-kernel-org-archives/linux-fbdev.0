From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2016 09:06:20 +0000
Subject: Re: [PATCH 24/41] Documentation: fb: fix spelling mistakes
Message-Id: <5731A48C.4070004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LPl8b7mvm2vRM6sRG9NqjNEUaROgjtMSo"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-25-git-send-email-eric@engestrom.ch>
In-Reply-To: <1461543878-3639-25-git-send-email-eric@engestrom.ch>
To: Eric Engestrom <eric@engestrom.ch>, linux-kernel@vger.kernel.org
Cc: Bernie Thompson <bernie@plugable.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org

--LPl8b7mvm2vRM6sRG9NqjNEUaROgjtMSo
Content-Type: multipart/mixed; boundary="O4xu5XBImUkRqhFR9JLFE5jJV5JiUekKB"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Eric Engestrom <eric@engestrom.ch>, linux-kernel@vger.kernel.org
Cc: Bernie Thompson <bernie@plugable.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <5731A48C.4070004@ti.com>
Subject: Re: [PATCH 24/41] Documentation: fb: fix spelling mistakes
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-25-git-send-email-eric@engestrom.ch>
In-Reply-To: <1461543878-3639-25-git-send-email-eric@engestrom.ch>

--O4xu5XBImUkRqhFR9JLFE5jJV5JiUekKB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25/04/16 03:24, Eric Engestrom wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>
> ---
>  Documentation/fb/udlfb.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/fb/udlfb.txt b/Documentation/fb/udlfb.txt
> index 57d2f29..c985cb6 100644
> --- a/Documentation/fb/udlfb.txt
> +++ b/Documentation/fb/udlfb.txt
> @@ -9,7 +9,7 @@ pairing that with a hardware framebuffer (16MB) on the =
other end of the
>  USB wire.  That hardware framebuffer is able to drive the VGA, DVI, or=
 HDMI
>  monitor with no CPU involvement until a pixel has to change.
> =20
> -The CPU or other local resource does all the rendering; optinally comp=
ares the
> +The CPU or other local resource does all the rendering; optionally com=
pares the
>  result with a local shadow of the remote hardware framebuffer to ident=
ify
>  the minimal set of pixels that have changed; and compresses and sends =
those
>  pixels line-by-line via USB bulk transfers.
> @@ -66,10 +66,10 @@ means that from a hardware and fbdev software persp=
ective, everything is good.
>  At that point, a /dev/fb? interface will be present for user-mode appl=
ications
>  to open and begin writing to the framebuffer of the DisplayLink device=
 using
>  standard fbdev calls.  Note that if mmap() is used, by default the use=
r mode
> -application must send down damage notifcations to trigger repaints of =
the
> +application must send down damage notifications to trigger repaints of=
 the
>  changed regions.  Alternatively, udlfb can be recompiled with experime=
ntal
>  defio support enabled, to support a page-fault based detection mechani=
sm
> -that can work without explicit notifcation.
> +that can work without explicit notification.
> =20
>  The most common client of udlfb is xf86-video-displaylink or a modifie=
d
>  xf86-video-fbdev X server. These servers have no real DisplayLink spec=
ific
>=20

Thanks, queued for 4.7.

 Tomi


--O4xu5XBImUkRqhFR9JLFE5jJV5JiUekKB--

--LPl8b7mvm2vRM6sRG9NqjNEUaROgjtMSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMaSMAAoJEPo9qoy8lh71GzIP/05EoHj+GoAr9paiHdJIrAWa
ovqsjU3bNXDcUBuLbQRlRemZYCi44/wQefaQD/PgVi440tyjzIVejno7bq3cb/k8
wsM3cflLSd+1K3odjsE0HyfJBIVGrIw224gCwO53WPUsgR5wyIFDizF0M7GSU4ui
3szGttjpIUX/sepOzlRLE2s+2hXTwQ+0hSR05k/yl/t0Q8vT6aTD6+uBtPKY4C0x
d+tyW7f+yBIAaMwmqfIHCfuxzNaxhNL24MoY1JsNCN5lN+rgW2SxFtCz9TWEfpN3
3HZ2FVZb8t50d9AZqj7S+be6KQesD1pRgvU0NXj7EHs2bm4QVMRFB3JhRX3QGfvH
AuiO1STC6J/Mi5zQGMjJgxx2FCUB2wbSde+dRqSlqfAmSe4K4K5sZlwqQH5xxZ7g
SXadqxSLFMP9NP9rcYQeTcYmKeZPiD7vloEIJ+nc/zPC6ANom7oxod9SL4FVJlKB
wgqzKciIkoxwr9Ddq4VBm+LR52NEXhm3o+knMHTYlj8AGIW3B9nMNhSP4+mWSU1+
tl9b+9NgeRi8/BTTIqKFU6dUVzgr5BbtmIZpLbC0H7uJlLhjLVsTf19kHBF1oz+3
8fXwynNGw/3q1uV+xIk+LliC/K2GbCdHh3hYMk5w8MkB04bCddh116z+bTz7Wo1z
x03oJNDxm6+F+ZAGcK4o
=sjvd
-----END PGP SIGNATURE-----

--LPl8b7mvm2vRM6sRG9NqjNEUaROgjtMSo--
