From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 23 Oct 2015 06:05:45 +0000
Subject: Re: [PATCH v4 0/4] simplefb: Add regulator handling support
Message-Id: <20151023060545.GE10947@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tpXFRyzAyQ/GSAaD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445572241-13259-1-git-send-email-wens@csie.org>
In-Reply-To: <1445572241-13259-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org


--tpXFRyzAyQ/GSAaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2015 at 11:50:37AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This is v4 of the simplefb regulator support series. This series adds
> regulator claiming and enabling support for simplefb.
>=20
> Changes since v4:
>   - Fixed inverted logic when testing the property name.
>   - Fixed regulator supply name string copy length off by 1.
>   - Added real world user, MSI Primo 81 dts patches.
>=20
> Changes since v3:
>   - Dropped extra "if" which is always true, leftover from v1.
>   - Updated commit message of patch 1
>=20
> Sometimes the simplefb display output path consits of external conversion
> chips and/or LCD drivers and backlights. These devices normally have
> GPIOs to turn them on and/or bring them out of reset, and regulators
> supplying power to them.
>=20
> While the kernel does not touch unclaimed GPIOs, the regulator core
> happily disables unused regulators. Thus we need simplefb to claim
> and enable the regulators used throughout the display pipeline.
>=20
> The binding supports any named regulator supplies under its device
> node. The driver will look through its properties, and claim any
> regulators by matching "*-supply", as Mark suggested.
>=20
> I've not done a generic helper in the regulator core yet, instead doing
> the regulator property handling in the simplefb code for now.
>=20
>=20
> Patch 1 adds the regulator properties to the DT binding.
>=20
> Patch 2 adds code to the simplefb driver to claim and enable regulators.
> Hans, I dropped your Reviewed-by tag from this patch.
>=20
> Patch 3 adds labels to the simplefb device nodes in sun6i-a31.dtsi
> so we can reference them in the board dts files, like in the next
> patch.
>=20
> Patch 4 adds a dts file for MSI's Primo 81 tablet.

Applied 3 and 4.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--tpXFRyzAyQ/GSAaD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKc45AAoJEBx+YmzsjxAguikP/1rkc7+H/3E0XZTRo1GqEERc
iOdaJKIEhRD/OkCKkabSEiH7Yk9vAV0mgkGHHPsf58pdcUZlnlwwIJJs1/OzUGZX
sQvBpYAlAPKPxqrhQgFJv1vI4Z5gnWKVg7j+xK8GeuCmzflIBtHVFrfAi7D57SfT
zqtIHQPAgmBkZtiWh7VnQe//Lbd0OFqt6vv3Hhod2D3cgf4tNwkmbcDPqse+X09s
Bn4s5rgG8a9Vk/19Yz7h1rK60cY18H48UpphtuxTFP8Hx8ImCF1BxGCuH2lzJpll
5+xq2TzTWWsPWDKoGY0ZbwKkXIhpkkWhvBgkqgkQIildk+2XsmyjflWq51VzkAy3
BPC+BDbq71yUBDP1bqCW2+PWf/bNzdH750XHX3q4C3OrOmlxkMpvUeWoaolpOlcw
hCOmhs1wP0boAM9N/5voljuGEzhnNtemgAPa8Xz+5R63v4LXtaFLjmxrXIREi02Y
MQscfeJSFZ8IlnbrkNhE0bbYfPuAgsnfXrblNW7BCyeruAZj315jV3gVeMjadnXK
vbL3/udU7fmY1RYOyCAREDw8vTbAkIjHKBFEcQ6Xw5kicd0J9P6nyMVjVQ+3/8an
4sCXxAC/cGC2EZPN0hXjP6yWa692/MwSLopedt5yKrjMFaLgJcV2pMlOW4UwIvmp
8i1Acn0TsLp8G/63yoE5
=lFV4
-----END PGP SIGNATURE-----

--tpXFRyzAyQ/GSAaD--
