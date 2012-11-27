From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Nov 2012 09:58:24 +0000
Subject: Re: [GIT PULL] Exynos DP for v3.8
Message-Id: <50B48EC0.9060406@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig842D0F56ACA98A365C74D2E2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <28517517.77811353652672706.JavaMail.weblogic@epml06>
In-Reply-To: <28517517.77811353652672706.JavaMail.weblogic@epml06>
To: linux-fbdev@vger.kernel.org

--------------enig842D0F56ACA98A365C74D2E2
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable

On 2012-11-23 08:37, Jingoo Han wrote:
> Hi Tomi,
>=20
> Thank you for taking care of pull requests for the v3.8 merge window.
> These patches have been submitted for more than one month,
> and tested with Exynos5250.
>=20
> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba6=
3681:
>=20
>   Linux 3.7-rc6 (Fri Nov 16 17:42:40 2012 -0800)
>=20
> are available in the git repository at:
>   git://github.com/jingoo/linux.git exynos-dp-next
>=20
> ----------------------------------------------------------------
> Exynos DP changes for the 3.8 merge window.
>=20
> - Device Tree support for Samsung Exynos DP
> - SW Link training is cleaned up.
> - HPD interrupt is supported.
> ----------------------------------------------------------------
>=20
> Ajay Kumar (5):
>       video: exynos_dp: Add device tree support to DP driver
>       video: exynos_dp: device tree documentation
>       video: exynos_dp: Reset and initialize DP before requesting irq
>       video: exynos_dp: Fix incorrect setting for INT_CTL
>       video: exynos_dp: remove redundant parameters
>=20
> Sean Paul (8):
>       video: exynos_dp: Check DPCD return codes
>       video: exynos_dp: Clean up SW link training
>       video: exynos_dp: Get pll lock before pattern set
>       video: exynos_dp: Improve EDID error handling
>       video: exynos_dp: Fix bug when checking dp->irq
>       video: exynos_dp: Remove sink control to D0
>       video: exynos_dp: Move hotplug into a workqueue
>       video: exynos_dp: Enable hotplug interrupts
>=20
>  .../devicetree/bindings/video/exynos_dp.txt        |   80 +++
>  drivers/video/exynos/exynos_dp_core.c              |  697 ++++++++++++=
--------
>  drivers/video/exynos/exynos_dp_core.h              |   21 +-
>  drivers/video/exynos/exynos_dp_reg.c               |   77 ++-
>  drivers/video/exynos/exynos_dp_reg.h               |    3 +-
>  5 files changed, 583 insertions(+), 295 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/video/exynos_dp.t=
xt

Has the DT bindings been reviewed by the device tree people? It would
good to have an ack from them.

 Tomi



--------------enig842D0F56ACA98A365C74D2E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQtI7DAAoJEPo9qoy8lh71GlwP/RPvlBiuoVa4QrBGITU7F1Dx
TvOYBREvmuQVzE29yxEoxUES7VtG2hBNN8CR5rD8XP5uvxGFEMsOCow1BU9Kwhpg
cs497i2hpFMgY6/k9F/SszUtl+E7bj+hUK9afno0pmiGmQgSUBdNnLGQYyw45qDs
y66BZx6tUh9DoR2GbHpTvwIIM95ucCKNhn2NP9Bezb4n8CUyiCNUKq2TmLDlsrwE
FMK5WYHPDPd2DvdM7bgJLbSL7bm0WfmaCb4MiB6a59kyTbrHx3eeknm2hC2SFxfn
7y4QpcURc/3I2w+IIiv0r/5O7m5y5Kp45WciJ+4NbOQf/4NCOFfDle23D8G1MM8i
YUcFKZ7AMcn/NYLKQhEWMy+ZP/lTQ3LUHsHOZmdM9Us1ANvSCV7bPSx45Py94DSE
2tDwWByNEGjS3r+lI8enPsPn6t86JPpzhOIMnnkJzEr6YBX8tFDELqFLznx2jMwC
KRah9EC8eFceTzv5UESWc+EMJJicKetGSjDd7JB0cN4jY82jbjpFgcuXtWu6iP8W
NA+DD4lYX8SlYMZlwC7mYrCfFwd2Aqp78JTevc/0jnYR/aIXhuRMriaHIyC2w+Bo
BmloOb9uF3alYkhvcdFWbhcygKkKISXofjafqcgyZ7pKouyySfj2BqLViVZ/tyta
jovbKO7f2PFzk1LaOKAP
=nFvl
-----END PGP SIGNATURE-----

--------------enig842D0F56ACA98A365C74D2E2--
