From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Sep 2015 11:30:11 +0000
Subject: Re: [PATCH 4/4] [resend #2] tridentfb: Add DDC support
Message-Id: <55E6DDC3.3030709@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qOHnNs2FODo5hTBm44lEr3hELhRrnaIpV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
 <1440445048-24694-4-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1440445048-24694-4-git-send-email-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>, Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--qOHnNs2FODo5hTBm44lEr3hELhRrnaIpV
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/08/15 22:37, Ondrej Zary wrote:
> Add DDC support for Trident cards.
>=20
> Tested on TGUI9440, TGUI9680, 3DImage 9750, Blade3D 9880 and Blade XP.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
>  drivers/video/fbdev/Kconfig     |    9 ++
>  drivers/video/fbdev/tridentfb.c |  192 +++++++++++++++++++++++++++++++=
+++++++-
>  2 files changed, 196 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 2d98de5..e2531b8 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1680,6 +1680,15 @@ config FB_TRIDENT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tridentfb.
> =20
> +config FB_TRIDENT_DDC
> +	bool "DDC for Trident support"
> +	depends on FB_TRIDENT
> +	select FB_DDC
> +	select FB_MODE_HELPERS
> +	default y
> +	help
> +	  Say Y here if you want DDC support for your Trident graphics card.
> +

Why would somebody not want this enabled? Is there some drawback if it's
enabled?

 Tomi


--qOHnNs2FODo5hTBm44lEr3hELhRrnaIpV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5t3DAAoJEPo9qoy8lh71JoIP/0HtV11wNLfVkVsdQxt3t+5l
72kxApw22N/ci7olOVODt7Qf06XKv6Mp7Bnl9SSmUNRA6DZBSkhHaMRGlKeMY1YK
6zvf8tQ4+XJ1qeFh8GDgzHHjHeZCwOQIz3/x6Lg/VqQdKS3m9XS+HklcJf5d7X/R
Z4X5Kd3F31rRFg/r/xgfDL3V/lvmC6aP6uHgkz5mq74XwfaoUVkQolTLh4qTw+pT
vgsTZRjyhvADqNViXCmFgyg5h2J+KtbZezlSoiQV0/ajJbpKyRtZivFO7C7wT9wI
x7nOp3Qc28+Y1wk1SWRcFyPVc/oDYN/OoK9cNV4oGaMBs7Jq+185sJDLgjBIdhP5
mTmpWLyGHcPmwiBQ3mkDHJaJ9lU+I+2Oq8TfyBm/1lspOIJfUN5IzMnqYdoLCR0v
rro2Cc8DdhemFUtPRFj3wn+XGMApKHt6Xnqq417m8u5R9tQi8757XYoCch+tOxBq
I2Xe/88CxNJ8Nx/WFIA5fNk5GpbcIGcIBkRZe/B9Ks60woRkk9w/EUPZX0tEtWQA
GxpoNe62uNRkhAt8WY/sXODEof9TdQUNIr7wZfGJ9nAMLHRu0iqyP2OfDc2wB4zX
KN7zg64gaY92MaelEiEoLUKGec+ACY8JdrH8XsjVNFVljEYf3oPffE0LN5K9u1Vh
fL9Ka43kejzQCo1p6za4
=p5t7
-----END PGP SIGNATURE-----

--qOHnNs2FODo5hTBm44lEr3hELhRrnaIpV--
