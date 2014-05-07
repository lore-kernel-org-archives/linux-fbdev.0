From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 May 2014 07:03:34 +0000
Subject: Re: [PATCH v2 2/3] ARM: dts: oma3-gta04: Add display support
Message-Id: <5369DAC6.6050608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TA9jFC3xdJ9vTBgTJIH9luDgDtdnihQ8l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398284120-4986-1-git-send-email-marek@goldelico.com>
 <1398284120-4986-3-git-send-email-marek@goldelico.com>
In-Reply-To: <1398284120-4986-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org

--TA9jFC3xdJ9vTBgTJIH9luDgDtdnihQ8l
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/04/14 23:15, Marek Belisko wrote:
> This patch add support for lcd display on gta04 board. Display control
> is connected on spi (used spi bitbang driver).
>=20
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dts | 86 +++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 86 insertions(+)

<snip>

> +&dss {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D < &dss_dpi_pins >;
> +
> +	status =3D "okay";
> +
> +	vdds_dsi-supply =3D <&vpll2>;
> +
> +	dpi_out: endpoint {
> +               remote-endpoint =3D <&lcd_in>;
> +               data-lines =3D <24>;
> +       };
> +
> +};
>=20

Did you try this on 3.15-rc? The above is not right, and I don't think
it works. You need 'port' node for the dpi_out endpoint.

 Tomi



--TA9jFC3xdJ9vTBgTJIH9luDgDtdnihQ8l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTadrGAAoJEPo9qoy8lh71v68QAI+/7OX3iR/NW7MTleTezIFX
6XTvjUJR3c0afx1CrqpdEBM59E75PwSCtwvwU78kCQswVSwEBRGfTd8g8l9GoUlD
+kLOnVskRen+o1ghoKLF0ICLReSSzGY3bplfLBGTF5zidvDiwHrCeJuCsvzE4vMQ
2Zg1kESfJWoQEAOTS6CmgqFJv6e5d22pyyDrzC9NrJRJITgWRlYDS2Q2K0VI+oV2
GbjhllR1+VQR+3e3YswsHw9kRk2pYvDeyC+ZMWAyfyfJntY8McFXZPP1IUi5oCVU
K4IkP+M7hvKeSSfecyxh9S4GHk8GBztrKWHnvGj94rXpulLwxSzIdSBnXDFYitAJ
F3i05Nq4AohD6oqZ6LJyA8kyzGG+YcjTdNvwHkh5kxttlNGEb2lbYpGTm7OnjBkp
5OVcTOCJUnqNDhV3RsyXSz2QhkeZZP2H7f6Qvc3w3RFwcOUFbWlQIYGcx4mKkRzh
BHbBxa8iywIPVK1rOu03XwMHanqWcaT4XpBt0cAgrbyfAbO6hMxo1+8bPLoCo6bP
uT8WOTWif1i7BMIk8XIbA8lWJZJuw8h9GBmrTHeW56NSTHdkLFGdqzqgiWRyG/UM
jIIBkPmnUDZbgEkjFhvzh4aNTitIrbWudD4Dd5AnXqdN556MlMZQMh4hFPB/bsTM
77e36kPMiAm8dIk7FJ/K
=OElA
-----END PGP SIGNATURE-----

--TA9jFC3xdJ9vTBgTJIH9luDgDtdnihQ8l--
