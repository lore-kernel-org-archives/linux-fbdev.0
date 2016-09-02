From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 02 Sep 2016 06:28:35 +0000
Subject: Re: [PATCH 4/6] ARM: sunxi: Support the Nextthing GR8
Message-Id: <20160902062835.GA6313@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-5-maxime.ripard@free-electrons.com>
 <CAGb2v66CDdSJMN4STHug1bGU2fnRK=Y24kwKS_8EtD6PZg3T-A@mail.gmail.com>
In-Reply-To: <CAGb2v66CDdSJMN4STHug1bGU2fnRK=Y24kwKS_8EtD6PZg3T-A@mail.gmail.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Alexander Kaplan <alex@nextthing.co>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chen-Yu,

On Wed, Aug 31, 2016 at 04:25:27PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The GR8 is an SoC made by Nextthing Co, loosely based on the sun5i fami=
ly.
> >
> > It has a number of new controllers compared to the A10s and A13 (SPDIF,=
 I2S),
> > but some controllers missing too (Ethernet, less I2C, less UARTs).
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
> >  MAINTAINERS                                     | 1 +
> >  arch/arm/mach-sunxi/sunxi.c                     | 1 +
>=20
> Please update Documentation/arm/sunxi/README as well.

I will.

> I don't suppose there's a datasheet available?

Not at the moment, unfortunately.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXyRwTAAoJEBx+YmzsjxAgx64QAIapya3+v9shCksr/8o0p3qc
RmhXjG6b+10sVc13iULISAlrZGr4iST4hwos52FlI3ETIRrp514/oxhebGbs8JT4
KZQRNcBZhRcIg3ySk3AJpmJ+2q2JtcLPWkPrr2WEuhoMJGg2o04KLbhve9f5booT
UueOIj8Ir82emdLyLPtN98P/2IWd3Cyu5eDrg0soiPMN2RkHW/cNfNtra7PPhfaR
CQmXof0PSRtLKqsba5drx9DFgmYwceYDb2YiR1t10WoTi+aIDI2zWjSsurzNFcW/
EBW2DsXt9JKBjYqW12kvqGHwE799UbwnkHvr8/J3NpqR4+EXQdMCsXWW9Pt2vW3+
TTcLhw0VQKlcH6ggihVTbIeb1VxsYIsibMdsSx4DNC9cZi+o6KcAcyzIzn+OOmHs
PgEcByvk8+hSdespRaWXZ35q8vLhyoAsWNl8EFyL35kUz6630QUxdv6JAa1ti4EY
0Zv1ojFpnSfhWbntfnjTFm4yg4xZ4ObdUACLB10K95RBkZomOiB0qT5VquBDt0kD
R2xtM+6lffKES3M7xup+/H5O2UZQVwJOg30PV9hi8uXu4EfQxb+3wXCLKrORXMoS
+xltPWAVUxz6FQ2BRc7fPaqXntlIvavl+3U2EDQ3QEt1/Fuk685h0AarEq/7n2vQ
NvgJr85q3eNbYvzKaPCp
=UG+G
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
