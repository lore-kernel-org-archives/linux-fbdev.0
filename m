From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 21 Nov 2012 08:58:27 +0000
Subject: Re: [PATCH 2/2] ARM: dts: mxs: add oled support for the cfa-10036
Message-Id: <50AC97B3.5070709@free-electrons.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351674774-2891-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351674774-2891-3-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1351674774-2891-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Shawn,

Le 31/10/2012 10:12, Maxime Ripard a =E9crit :
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com> Cc:
> Brian Lilly <brian@crystalfontz.com> ---=20
> arch/arm/boot/dts/imx28-cfa10036.dts |   19 +++++++++++++++++++ 1
> file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts
> b/arch/arm/boot/dts/imx28-cfa10036.dts index c03a577..816cae9
> 100644 --- a/arch/arm/boot/dts/imx28-cfa10036.dts +++
> b/arch/arm/boot/dts/imx28-cfa10036.dts @@ -33,11 +33,30 @@ };
>=20
> apbx@80040000 { +			pwm: pwm@80064000 { +				pinctrl-names > "default"; +=
				pinctrl-0 =3D <&pwm4_pins_a>; +				status =3D "okay"; +
> }; + duart: serial@80074000 { pinctrl-names =3D "default"; pinctrl-0
> =3D <&duart_pins_b>; status =3D "okay"; }; + +			i2c0: i2c@80058000 { +
> pinctrl-names =3D "default"; +				pinctrl-0 =3D <&i2c0_pins_b>; +
> status =3D "okay"; + +				ssd1307: oled@3c { +					compatible > "solomon,=
ssd1307fb-i2c"; +					reg =3D <0x3c>; +					pwms =3D <&pwm 4
> 3000>; +					reset-gpios =3D <&gpio2 7 0>; +				}; +			}; }; };


Would you consider merging this patch?
Andrew Morton merged the driver into its tree
(http://marc.info/?l=3Dlinux-fbdev&m=135336761530731&w=3D2)

Thanks,
Maxime


- --=20
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCsl7MACgkQGxsu9jQV9nZtJwCfR9c2SnwK1hzAU2F+xptFqg9x
2+0An3YrhNMXSZaPwPcJwc3Bnwy+FSqe
=3DmjpV
-----END PGP SIGNATURE-----
