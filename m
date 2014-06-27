From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 27 Jun 2014 12:11:17 +0000
Subject: Re: [PATCH 04/12] OMAPDSS: hdmi_audio: Integrated ASoC DAI component driver implementation
Message-Id: <53AD5F65.2010107@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dN52q3dag2sw33AiGUOlnDsgAJG5P6iob"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1403807781.git.jsarha@ti.com> <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
In-Reply-To: <69f5b1481bd8b8a005b5d9142626f3529a0d71c7.1403807781.git.jsarha@ti.com>
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, jyri.sarha@iki.fi

--dN52q3dag2sw33AiGUOlnDsgAJG5P6iob
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/14 22:20, Jyri Sarha wrote:
> Integrate ASoC DAI component driver in to the OMAP hdmi driver. The
> patch also updates the relevant entry in ti,omap5-dss DT binding
> document. The driver registers a dummy hdmi codec driver and a
> simple-card driver to produce a fully functional ALSA device. The DAI
> driver is implemented in hdmi_audio.c, but it still needs to be
> registered from hdmi4.c or hdmi5.c.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---

<snip>

> +static const struct snd_soc_dai_ops hdmi_dai_ops =3D {
> +	.startup	=3D hdmi_dai_startup,
> +	.hw_params	=3D hdmi_dai_hw_params,
> +	.prepare	=3D hdmi_dai_prepare,
> +	.trigger	=3D hdmi_dai_trigger,
> +	.shutdown	=3D hdmi_dai_shutdown,
> +};
> +
> +static const struct snd_soc_component_driver omap_hdmi_component =3D {=

> +	.name =3D "omapdss_hdmi",
> +};
> +
> +static struct asoc_simple_card_info card_info =3D {
> +	.name =3D "HDMI",
> +	.card =3D "OMAPHDMI",
> +	.codec_dai.name =3D "hdmi-hifi",
> +};

The above is not const. That, and the contents of the struct make me
wonder, what happens if we have two HDMI instances?

I know the core driver doesn't work with multiple instances yet, but as
I mentioned, it has to be done sooner or later. And on the core driver
side it should be quite straightforward.

I'd rather not introduce new restrictions for that goal.

 Tomi



--dN52q3dag2sw33AiGUOlnDsgAJG5P6iob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrV9lAAoJEPo9qoy8lh717VQP/idkX8zIbo/ok+pYuGe6BN0C
2iIZnYvHkkF4MUY16X8lV2WnK2GYMh/RX2vYP5imhbPFHIDg5JAtTjjOa0n/t5sb
iH6lzBxPQou9kfg+uaseJ6GzJ1d21HYkblETS5KI3I8XfQA+YMU4YNE+l14P/gQe
XpdvG7MmHnNPeItDqBszgIw/smaLkDJ8acrQL5L5N/YheJoyx/4gZP9B4gAkbqjo
ig6houKGTbEzmYGtRVJbRjEySmqyFXtXqlbEmjl36Dp7JahEBOkzpBCnTXI6NfX1
72uSlFdz/h9hLFqv4OFpEVyW0uC+5WdMlYKFZQLQVu7pwrTuybi7o7mBlp7dN/kf
qf5dac5/Yap/zXb6Emejx+7ZuppJk7zp1JriscZBV1F3icEP5EoqQlBzJRxufXt9
yxJnuaAmaVfkLAHMsSaZiAY/6mCxStLpORWpF7Ih/xl9oR2/DLk47aI1fHAg0+Dh
06kJHj7jP6QKluah6x8WBuIqdwNFHfGNQqYghJTN+FOm6B8cl2yfpC2siWJYcE96
O5/shofXFDUGyR2fr/Mu7rk7w0fb+J4ixPYtEDi/CDBZB/Fn+y3pzteR1RdS4QXH
DjjFiEHiszFZJTvMoVpqWoSuLntFz3iNStOUtTip/0Nr2JE/k+qv1D+DTl/7k0RX
i/+kd/xG9Ef79l8K97Q6
=CrLI
-----END PGP SIGNATURE-----

--dN52q3dag2sw33AiGUOlnDsgAJG5P6iob--
