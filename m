From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 07 Feb 2015 11:20:43 +0000
Subject: Re: [PATCH 5/8] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <20150207112043.GO2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xexMVKTdXPhpRiVT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-6-git-send-email-niederp@physik.uni-kl.de>
To: niederp@physik.uni-kl.de
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--xexMVKTdXPhpRiVT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2015 at 11:28:11PM +0100, niederp@physik.uni-kl.de wrote:
> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>=20
> This patch adds a module parameter 'bitsperpixel' to adjust the colordepth
> of the framebuffer. All values >1 will result in memory map of the reques=
ted
> color depth. However only the MSB of each pixel will be sent to the devic=
e.
> The framebuffer identifies itself as a grayscale display with the specifi=
ed
> depth.

I'm not sure this is the right thing to do.

The bits per pixel for this display is rightfully defined, used and
reported to the userspace, why would you want to change that?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--xexMVKTdXPhpRiVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1fULAAoJEBx+YmzsjxAgPgYP/3UliHEtqHSoZrdE64XPmbeC
d964k87PyA1I3xoH8XiULUrz6osA8bKFcbCKZzp7nyMteZhlseqT+DW7wRuzn0WM
7LHkYf/KT4KC4xPkRrL+f4LxPr5tSxj+3yiRmFbfsb4gIhVLhDJmxzlnTZSTQyxg
ziqAZAsOhoumgRv1aAtEwDiUsxcOFjqumQPnD/Ng6JFV7VyJyJEEYeAW3sjG1uc9
AdkxTir7WCc0whdiGYuhKAheeP1S5jBykCfQl/IrLWgD7T437VHXn0ju6wurk8Ls
6Ne02KJ/DIDDGocdsd/VFU21XdoBjyVPc5RwcQWj8rVy4ccdnyCzyjz2Q0kIoENi
yiv3HPsjnXq1E7Au0+gKb/X+7o37W3ZOVW4I5p2TD/dBJjRtN2AX1IaHsOMhH0l9
2sd1m9M/1yECIeW0iQVb3VM+4LCjraLPjZMDQRFgdwNvc8ZIaYR8hXtTdVMsOB40
84bvpNGizNCxyTMsElBu+QX52Qr0gZJsXbSKAYlT4OxKiPkwasDCdXDfGKgCWSmX
QBkXluaYqdJtdZ2otRHGNBzJZfbkRwECnVAQZYsWHMql9TxQi1LViRPEnTFkSKQA
aAj7P2fNoO6KhQAcbvQjo0nqwZs5Z4AEUR5kcA1af07uYMqi1qbJdFNz+hjp2iMc
WQvAloOywA+IV0cPNMGI
=Ga0g
-----END PGP SIGNATURE-----

--xexMVKTdXPhpRiVT--
