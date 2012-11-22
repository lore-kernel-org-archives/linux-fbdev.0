From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 22 Nov 2012 14:50:35 +0000
Subject: Re: [GIT PULL FOR v3.8] SH Mobile LCDC patches
Message-Id: <50AE3BBB.8040600@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enigDE3758EE980A065A3DCB8936"
List-Id: <linux-fbdev.vger.kernel.org>
References: <2641878.cGkiV3BMeH@avalon>
In-Reply-To: <2641878.cGkiV3BMeH@avalon>
To: linux-fbdev@vger.kernel.org

--------------enigDE3758EE980A065A3DCB8936
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-22 16:39, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> Thank you for taking care of pull requests for the v3.8 merge window. H=
ere's=20
> one already :-)
>=20
> The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba6=
3681:
>=20
>   Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)
>=20
> are available in the git repository at:
>   git://linuxtv.org/pinchartl/fbdev.git lcdc-next
>=20
> Hideki EIRAKU (1):
>       fbdev: sh_mobile_lcdc: use dma_mmap_coherent
>=20
> Laurent Pinchart (19):
>       fbdev: sh_mobile_lcdc: Get display dimensions from the channel st=
ructure
>       fbdev: sh_mobile_lcdc: Rename mode argument to modes
>       fbdev: sh_mobile_lcdc: Remove priv argument from channel and over=
lay=20
> init
>       ARM: mach-shmobile: ag5evm: Add LCDC tx_dev field to platform dat=
a
>       fbdev: sh_mipi_dsi: Add channel field to platform data
>       ARM: mach-shmobile: Initiliaze the new sh_mipi_dsi_info channel f=
ield
>       fbdev: sh_mipi_dsi: Use the sh_mipi_dsi_info channel field
>       fbdev: sh_mipi_dsi: Use the LCDC entity default mode
>       fbdev: sh_mipi_dsi: Remove last reference to LCDC platform data
>       ARM: mach-shmobile: Remove the unused sh_mipi_dsi_info lcd_chan f=
ield
>       fbdev: sh_mipi_dsi: Remove the unused sh_mipi_dsi_info lcd_chan f=
ield
>       fbdev: sh_mobile_lcdc: Store the backlight brightness internally
>       ARM: mach-shmobile: mackerel: Removed unused get_brightness callb=
ack
>       sh: ap325rxa: Remove unused get_brightness LCDC callback
>       sh: ecovec24: Remove unused get_brightness LCDC callback
>       fbdev: sh_mobile_lcdc: Remove unused get_brightness pdata callbac=
k
>       ARM: mach-shmobile: ag5evm: Use the backlight API for brightness =
control
>       sh: kfr2r09: Use the backlight API for brightness control
>       fbdev: sh_mobile_lcdc: Make sh_mobile_lcdc_sys_bus_ops static
>=20
>  arch/arm/mach-shmobile/board-ag5evm.c       |  198 ++++++++++++++-----=
-------
>  arch/arm/mach-shmobile/board-ap4evb.c       |    4 +-
>  arch/arm/mach-shmobile/board-mackerel.c     |    6 -
>  arch/sh/boards/mach-ap325rxa/setup.c        |    6 -
>  arch/sh/boards/mach-ecovec24/setup.c        |    6 -
>  arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |   16 +--
>  arch/sh/boards/mach-kfr2r09/setup.c         |    7 +-
>  arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 +-
>  drivers/video/sh_mipi_dsi.c                 |   69 ++++------
>  drivers/video/sh_mobile_lcdcfb.c            |   74 +++++++----
>  drivers/video/sh_mobile_lcdcfb.h            |    1 +
>  include/video/sh_mipi_dsi.h                 |    4 +-
>  include/video/sh_mobile_lcdc.h              |    1 -
>  13 files changed, 192 insertions(+), 206 deletions(-)

Well, this does look a bit scary. It's more arch changes than fb
changes... But all the arch patches seem to be acked by somebody else,
presumably somebody maintaining the arch stuff, so I guess it's ok if
these cannot go separately through arm/sh tree.

 Tomi



--------------enigDE3758EE980A065A3DCB8936
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQrju7AAoJEPo9qoy8lh71BIQP/Az/j4rPSQYEYbpLbA6rT1AD
mtsnvv6MmrIj6eXnffubRP/RDcgY2Gfjf5dSRm5Jh1bLL7QWKS6jmfoXKdt80Kcf
u9O+IHdQEscKEQON2S47AqAVAKpo3grIu0C833TeNvPoxnch5GWnpoLY9P3Lbecg
Vtxv9FB7zLp2TlrVTWDQX+dPcsEpt69hUv6kteIiWOIb4moIMyCyiOBn+9MfGbGj
JkANC/frZWqeXd378CTEsOIaMrjTuZ9FeQdKZA2OAFtIgpH4SaurJzFiFlPGtObQ
Uq5PX7A+YeqVrlsjJ7mLR6FCIDqvQc+IS8/oChlaaRMutRSGHlX/9fStKa3iiZ0u
833qrx3+sH8/IbH2kj+1ZmPVCvxZTHZzjcaidXxnidftCXYOSorOXriOduhiUAhF
U3OGaW1Rj1G6daSn3NB/iGp8clMfEAbVGaB5gj8t6HQD3A44LuerSRdM8Qelo6oW
9bDFyT/9Y9juRiVFKKwpUkH337w9FhTK2FXpshf56bVdJRfDHVau014vMASBPH6B
dmge0/WWBuenamlakIcCQJzV/RdIfI1h8It3phxxwTFcx//AHcMtg3djlWAr7htu
qh/GnlnvIcSkZUKin8rrwXe//wstvH/gYWhpSmsGxHMm1ays63qhFY7ejWbfXDgO
rcnuIUy5/3gTFcUMMHcn
=W+MV
-----END PGP SIGNATURE-----

--------------enigDE3758EE980A065A3DCB8936--
