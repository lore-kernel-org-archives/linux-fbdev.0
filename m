From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 27 Jun 2014 11:49:31 +0000
Subject: Re: [PATCH 07/12] OMAPDSS: Kconfig: Select audio dependencies if OMAP5_DSS_HDMI_AUDIO=y
Message-Id: <53AD5A4B.5050308@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Bt4mDDp36HVECLUwfFVbwns1K6IKXtFeC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403807781.git.jsarha@ti.com> <67ea660311de39b8a35e90a9a7d3b345fdaaf895.1403807781.git.jsarha@ti.com>
In-Reply-To: <67ea660311de39b8a35e90a9a7d3b345fdaaf895.1403807781.git.jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--Bt4mDDp36HVECLUwfFVbwns1K6IKXtFeC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:20, Jyri Sarha wrote:
> Adds help section and SND_SOC dependency to OMAP4_DSS_HDMI_AUDIO.
> Selects SND_OMAP_SOC, SND_SOC_HDMI_CODEC, and SND_SIMPLE_CARD if
> OMAP4_DSS_HDMI_AUDIO is enabled.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  drivers/video/fbdev/omap2/dss/Kconfig |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/video/fbde=
v/omap2/dss/Kconfig
> index 871f722..1cce26c 100644
> --- a/drivers/video/fbdev/omap2/dss/Kconfig
> +++ b/drivers/video/fbdev/omap2/dss/Kconfig
> @@ -6,9 +6,9 @@ menuconfig OMAP2_DSS
>  	select VIDEOMODE_HELPERS
>  	select OMAP2_DSS_INIT
>  	select HDMI
> -	select SND_OMAP_SOC if OMAP4_DSS_HDMI_AUDIO
> -	select SND_SOC_HDMI_CODEC if OMAP4_DSS_HDMI_AUDIO
> -	select SND_SIMPLE_CARD if OMAP4_DSS_HDMI_AUDIO
> +	select SND_OMAP_SOC if OMAP4_DSS_HDMI_AUDIO || OMAP5_DSS_HDMI_AUDIO
> +	select SND_SOC_HDMI_CODEC if OMAP4_DSS_HDMI_AUDIO || OMAP5_DSS_HDMI_A=
UDIO
> +	select SND_SIMPLE_CARD if OMAP4_DSS_HDMI_AUDIO || OMAP5_DSS_HDMI_AUDI=
O
>          help
>  	  OMAP2+ Display Subsystem support.
> =20
> @@ -99,8 +99,16 @@ config OMAP5_DSS_HDMI
>  	  specification.
> =20
>  config OMAP5_DSS_HDMI_AUDIO
> +	bool "HDMI audio support for OMAP5"
>  	depends on OMAP5_DSS_HDMI
> -	bool
> +	depends on SND_SOC=3Dy || OMAP2_DSS =3D SND_SOC
> +	default y

These selects and depends ons make me feel a bit uneasy, but I don't
have any idea how to deal with it in a nicer way...

 Tomi



--Bt4mDDp36HVECLUwfFVbwns1K6IKXtFeC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrVpMAAoJEPo9qoy8lh71moMP/3R4hZ7iDGprmjxuZDFb5SE4
tPpPioNOPwbkFuhP65AZ/qdvZWl+fQyL4j5DnVi4bBMRQhwgj0kxZR1enKM1abBC
JRdgLmwS6FyIpWTjKYIZE50KEgrplUt23lX310Ik41vwprPWlA2WsC1mNjNSEkEQ
sL2FrRNL93bBkYeY/9B7hSO9ip/1+RgUFuOfeAflVJARAXe34fWU61wW0fgjMmPp
Y4Kwg5VPN0QcrOsbG/W8ATF4eZk8RB91VjrSaRHknfeKljiH5quUmXxA6zHtuId3
0A0qsoM9MgGauWw/zIX3FKaPD7waHo8TAcYDF4EzKu8mTbdWPr7t8PDtS3FkgRQc
B8jtnTf1kEpdtj+jkJ4u0KpV2dIq4lb4/b7PSbHLlcSpxBCiW0euLhcscVT3+yFn
66mAUKJVBlWDVKvliSiIInkmVHdZ2Wrbq9yraKuSy81Sr8DwzblPjMKV8mMN/Ore
q1QPZnh5Y7d2SmAmVNPEm2MljTHe4ctbtV/DiBHmUQBnuvkftDuqYogjZY4oIBqe
r/+yr863bJypcI5qF04mAGH6fB2DeRWpqyJXME1CzAxUhXvUQGyOvPxZIrw27vro
Y6BCtEzn5B5rdVxbLUZOFwwcNOqp40uMhpRGEVtTg4rqTAcdIgG09CaXvRboMGEk
OVmwmPrfd6ry+u5dUG92
=qBZK
-----END PGP SIGNATURE-----

--Bt4mDDp36HVECLUwfFVbwns1K6IKXtFeC--
