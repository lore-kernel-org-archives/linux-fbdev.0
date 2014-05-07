From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 May 2014 08:15:12 +0000
Subject: Re: [PATCH 2/4] OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
Message-Id: <5369EB90.8060007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-3-git-send-email-tony@atomide.com>
In-Reply-To: <1398815562-24113-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org

--01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/04/14 02:52, Tony Lindgren wrote:
> Using gpiod will make it easier to add device tree support
> for this panel in the following patches.
>=20
> Note that all the GPIOs for this panel are optional, any
> of the the GPIOs could be configured with external pulls
> instead of GPIOs, so let's not error out if GPIOs are not
> found to make the panel more generic.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 92 +++++++++-----=
--------
>  1 file changed, 38 insertions(+), 54 deletions(-)

<snip>

> +static struct gpio_desc *
> +sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
> +		  char *desc)
> +{
> +	int r;
> +
> +	r =3D devm_gpio_request_one(dev, gpio, flags, desc);
> +	if (r) {
> +		dev_err(dev, "no %s gpio\n", desc);

As it's fine to not have a gpio, I guess this error print should be remov=
ed.

Also, if the error is EPROBE_DEFER, the driver should fail and return
that. The same goes for the DT version in the next patch.

 Tomi



--01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaeuQAAoJEPo9qoy8lh711swP/0Z8usacElSZgblnBscYXQV+
abLMe+nOUiSyUJ9JRe5uVW7oRWIlulOJsAUAXMg85UGya12RhW8jmmfyqLoWAuN3
ym8794Hqy/CMLcgwhhybP3RZjxykk/WHQCTo5bOZ7/R+TpIZWyobd48aGYS7r0bU
dXpl4URUSy6MPkWAT9dG+GG7sZTnHjdJ6AeUxFTbey25rtobWIQ8WohFA2mOwt8W
WREGSRP5SS0P+r5vKneYyarETpYgtMbHV++RPnbQaOceOeo379q386wQ/u/C+Tc1
Sx/ED6QrYYduKf44f8fEq3GqsLi4HZ2pueNscXadKIrFBMnXcMP3TMW6KO4wbv9v
0+NgtXaiT17VhpySvIG+AroThzzQoY0yhf4OOlVMKPfgTklKFUC4AVgTpuEx1FjZ
vABIkYgI5JFPIrbXBG6hYenTtrk/LmgltKN9p/0vVoyfEr1bB6ks8ZxmF2EpRJwd
WMeXdjhId3epmTNATIWjaOyFx+8kEfQucOmmp0JDyKw/1zv/zrgUzc/AfxIckmEy
MioBAskQwk1ZxGwFxpL7u7FidNunjzHPW9/MIck9N3MoyF04XQMZ5j8x1ulqbNs/
yXRwkhartj6Zw08YXOD6XqnmBc2/uk0iQFgRlbI1MvTJ9bWa8ehmGDaPz3bxVVWX
5z3HSiylVq2XORKECNln
=Ns5W
-----END PGP SIGNATURE-----

--01KEpad7JTjQsvFkc0WExh7SPSGvkDhDE--
